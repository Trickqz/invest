<?php
    // liberar personal_income bloqueado
    // liberar 0.5 rendimento diario fixo
    
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/Encoder.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/Flags.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/Context.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/Token.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/Parser.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/Validator.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/Partial.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/Expression.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/Exporter.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/Compiler.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/SafeString.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/LightnCandy.php';
    require_once str_replace("/routes", "", dirname(__FILE__)) . '/vendor/lightncandy/src/Runtime.php';
    use LightnCandy\LightnCandy;
    use LightnCandy\Runtime;
    use LightnCandy\SafeString;
    
    $router->map('GET','/v1/cron/[:f]/[:sec]', function($_f, $_sec){
        $sec_code = "ABX59F";
        $logs = "";
        
        if ($_sec == $sec_code) {
            switch($_f){
                case "coinbase--check-charges":
                    $allCharges = (new Coinbase_ins)->findAllWaiting();
                    
                    for ($i1 = 0; $i1 < count($allCharges); $i1++) {
                        $code = $allCharges[$i1]['_coinbase_code'];
                        
                        /** COINBASE **/
                        $client = new \WPDMPP\Coinbase\Commerce\Client();
                        $client->setApiKey((new Settings)->findValue('coinbase__api_key'));  //{your API Key}
                        
                        try {
                            $response = $client->showCharge($code);
                        } catch(\Exception $ex) {
                            echo $ex->getMessage();
                        }
                        
                        $responseJson = json_decode($response);
                        /** **/
                        
                        $timeline = $responseJson->data->timeline;
                        $completed = false;
                        $expired = false;
                        for ($i = 0; $i < count($timeline); $i++) {
                            if ($timeline[$i]->status == "EXPIRED") {
                                $expired = true;
                            }
                            if ($timeline[$i]->status == "COMPLETED") {
                                $completed = true;
                            }
                            if ($timeline[$i]->status == "RESOLVED") {
                                $completed = true;
                            }
                        }
                        /** **/
                        
                        if ($expired == true) {
                            $coinbase_ins = (new Coinbase_ins)->findCoinbase_code($code);
                            (new Coinbase_ins)->update(
                                    $coinbase_ins['_id'],
                                    null,
                                    'expired'
                                );
                            
                            //(new Json)->echoJson(array("success" => true, "expired" => true));
                        } else if ($completed == true) {
                            $coinbase_ins = (new Coinbase_ins)->findCoinbase_code($code);
                            if ($coinbase_ins['_status'] == 'waiting') { // && $coinbase_ins['_coinbase_code'] == $data['event']['data']['code']) {
                                (new Coinbase_ins)->update(
                                        $coinbase_ins['_id'],
                                        $response,
                                        'confirmed'
                                    );
                                
                                //$insertCredit = (new Wallet)->create(
                                (new Wallet)->create(
                                        'insertion',
                                        $coinbase_ins['_accounts__id'],
                                        'Money insertion',
                                        null,
                                        $coinbase_ins['_amount'],
                                        0,
                                        0,
                                        'Money insertion to personal account',
                                        '',
                                        'effected'
                                    );
                                
                                /** **/
                                $accounts_data = (new Accounts)->find($coinbase_ins['_accounts__id']);
                                
                                $system_emails_data = (new System_emails)->findObject('wallet__usd_added');
                                $template = $system_emails_data['_content'];
                                $phpStr = LightnCandy::compile($template);
                                $renderer = LightnCandy::prepare($phpStr);
                                $content = $renderer(array(
                                        'username' => $accounts_data['_username'],
                                        'date' => date("d/m/Y h:i:s"),
                                        'name' => $accounts_data['_name'],
                                        'amount' => 'USD '. number_format($coinbase_ins['_amount'], 2),
                                        'description' => 'Money insertion value of <b>' . 'USD '. number_format($coinbase_ins['_amount'], 2) . '</b> to personal account [username: ' . $accounts_data['_username'] . '] with Coinbase.',
                                        //'code' => $code,
                                        'telegram' => (new Settings)->findValue('social__telegram'),
                                        'whatsapp' => (new Settings)->findValue('social__whatsapp'),
                                        'instagram' => (new Settings)->findValue('social__instagram'),
                                        'facebook' => (new Settings)->findValue('social__facebook'),
                                        'youtube' => (new Settings)->findValue('social__youtube'),
                                        'twitter' => (new Settings)->findValue('social__twitter')
                                    ));
                                
                                
                                (new Mailer)->send($accounts_data['_email'], $accounts_data['_name'], $system_emails_data['_subject'], $content, $content);
                                /** **/
                                
                                //if ($insertCredit) {
                                //    (new Json)->echoJson(array("success" => true, "completed" => $completed));
                                //} else {
                                //    (new Json)->echoJson(array("success" => false));
                                //}
                            } // else {
                            //    (new Json)->echoJson(array("success" => false));
                            //}
                        } // else {
                        //    (new Json)->echoJson(array("success" => false));
                        //}
                        /** **/
                    }
                break;
                case "donations--set-receiving":
                    $donations = (new Donations)->findWaitingFor48h();
                    if (sizeof($donations) > 0) {
                        for ($i=0;$i<sizeof($donations);$i++){
                            (new Donations)->setStatus($donations[$i]['_id'], 'receiving');
                        }
                    }
                break;
                case "donations--free-blocked":
                    (new Donations)->processWaiting();
                break;
                case "income--free-blocked":
                    (new Personal_income)->processPending();
                break;
                case "income--gen-day":
                    $accounts = (new Accounts)->find();
                    if (sizeof($accounts) > 0) {
                        for ($i=0;$i<sizeof($accounts);$i++){
                            if ($accounts[$i]['_joker_account'] == false) {
                                $account__id = $accounts[$i]['_id'];
                                $genProcess = true;
                                
                                // CHECK DAY SPOON
                                $personalIncome = (new Personal_income)->getForCurrentDay($account__id);
                                if ($personalIncome != null) {
                                    $genProcess = false;
                                }
                                
                                if ($genProcess == true) {
                                    // INCOME
                                    $bid = 0.5;
                                    
                                    //$lastIncome = (new Income)->findLast();
                                    $lastIncome = (new Income)->getForCurrentDay();
                                    if ($lastIncome) {
                                        $bid = $lastIncome['_bid'];
                                    }
                                    // INCOME
                                    
                                    // DONATIONS
                                    $dataDonations = (new Donations)->find(null, '('.$account__id.')');
                                    if (sizeof($dataDonations) > 0) {
                                        $countContracts = 0;
                                        $received = 0;
                                        foreach ($dataDonations as $row)
                                        {
                                            if ($row['_status'] == 'receiving') {
                                                $to_receive = (((float)$row['_amount'])/100.0) * (float)$bid;
                                                if (($to_receive+((float)$row['_received'])) > (float)$row['_income']) {
                                                    $to_receive = (float)$row['_income'] - (float)$row['_received'];
                                                }
                                                
                                                if ($to_receive > 0) {
                                                    (new Donations)->setReceived($row['_id'], $to_receive+(float)$row['_received']);
                                                }
                                                
                                                $received += $to_receive;
                                                $countContracts += $row['_contracts'];
                                            }
                                        }
                                        
                                        (new Personal_income)->create($account__id, $countContracts, (float)$bid, $received);
                                    }
                                }
                            }
                        }
                    }
                break;
                case "binary--pay":
                    $binaryIndicationPercentage = 10.0;
                    $binaryPercentage = 5.0;
                    
                    $accounts = (new Accounts)->find();
                    if (sizeof($accounts) > 0) {
                        for ($i=0;$i<sizeof($accounts);$i++){
                            $account__id = $accounts[$i]['_id'];
                            $account = (new Accounts)->find($account__id);
                            
                            $MESSAGE = "";
                            
                            $MESSAGE .= "ID: ".$account__id." | Usuário: ".$account['_username']."<br />";
                            $SHOW_MESSAGE = false;
                            
                            //if ($accounts[$i]['_joker_account'] == false) {
                                /** **/
                                // points
                                //$binary_upline = (new Accounts)->network__gen_binary_upLine($account__id, null);
                                
                                //if (sizeof($binary_upline) > 0) {
                                //    for ($i=0;$i<sizeof($binary_upline);$i++){
                                        //if (($i+1) <= 20) {
                                            
                                            // CONDIÇÕES || REGRAS ATIVAÇÃO
                                            $isOK = true;  //false;
                                            
                                            // ATIVO - Adquiriu licenças
                                            if ($isOK == true) {
                                                //$isOK = (new Accounts)->isActive($binary_upline[$i]['_id']);
                                                $isOK = (new Accounts)->isActive($account__id);
                                                
                                                if ($isOK == false) {
                                                    $MESSAGE .= "- not active<br />";
                                                }
                                            }
                                            
                                            // QUALIFICADO - colocou duas contas ativas e diretas (lado esquerdo e direito)
                                            if ($isOK == true) {
                                                //$isOK = (new Accounts)->binaryReceiving($binary_upline[$i]['_id']);
                                                $isOK = (new Accounts)->binaryReceiving($account__id);
                                                
                                                if ($isOK == false) {
                                                    $MESSAGE .= "- not binary qualified<br />";
                                                }
                                            }
                                            
                                            // CONTA CORINGA / JOKER [NÃO GERA BINÁRIO MAS RECEBE DA REDE]
                                            /**if ($isOK == true) {
                                                //$isOK = (new Accounts)->isJokerAccount($binary_upline[$i]['_id']);
                                                $isOK = (new Accounts)->isJokerAccount($account__id);
                                                
                                                if ($isOK == false) {
                                                    echo "- not jocker account<br />";
                                                }
                                            }*/
                                            
                                            if ($isOK == true) {
                                                $MESSAGE .= "PAY<br />";
                                                
                                                // create binary points
                                                /**$aa = (new Points)->create(
                                                        $binary_upline[$i]['_id'],
                                                        'binary',
                                                        $binary_upline[$i]['_side'],
                                                        $amount,
                                                        null,
                                                        $account__id,
                                                        $i,
                                                        'false'
                                                    );**/
                                                
                                                // pay binary to current user
                                                $bytes = openssl_random_pseudo_bytes(32);
                                                $hash = base64_encode($bytes);
                                                
                                                //$points_l = (new Points)->getBinaryBalanceFromAccountsID($binary_upline[$i]['_id'], 'left');
                                                $points_l = (new Points)->getBinaryBalanceFromAccountsID($account__id, 'left');
                                                //$points_r = (new Points)->getBinaryBalanceFromAccountsID($binary_upline[$i]['_id'], 'right');
                                                $points_r = (new Points)->getBinaryBalanceFromAccountsID($account__id, 'right');
                                                
                                                $MESSAGE .= "Points Left: ".$points_l.", Right: ".$points_r."<br />";
                                                
                                                if ($points_l > 0 && $points_r > 0) {
                                                    if ($points_l > $points_r) {
                                                        // paid right
                                                        (new Wallet)->createProfitBinary(
                                                                'profit',
                                                                $account__id,
                                                                'Binary',
                                                                null,
                                                                ($points_r/100.0)*$binaryPercentage,
                                                                0,
                                                                0,
                                                                ('Binary receivement of ' . $points_r . ' points [right]'),
                                                                $hash,
                                                                'right',
                                                                $points_r,
                                                                'effected'
                                                            );
                                                        
                                                        // set paid >> OLD
                                                        //(new Points)->setPaid($binary_upline[$i]['_id'], 'binary', 'right');
                                                        
                                                        $MESSAGE .= "Pay Right<br />";
                                                    } else {
                                                        // paid left
                                                        (new Wallet)->createProfitBinary(
                                                                'profit',
                                                                $account__id,
                                                                'Binary',
                                                                null,
                                                                ($points_l/100.0)*$binaryPercentage,
                                                                0,
                                                                0,
                                                                ('Binary receivement of ' . $points_l . ' points [left]'),
                                                                $hash,
                                                                'left',
                                                                $points_l,
                                                                'effected'
                                                            );
                                                        
                                                        // set paid >> OLD
                                                        //(new Points)->setPaid($binary_upline[$i]['_id'], 'binary', 'left');
                                                        
                                                        $MESSAGE .= "Pay Left<br />";
                                                    }
                                                    
                                                    $SHOW_MESSAGE = true;
                                                }
                                            } else {
                                                $MESSAGE .= "NOT PAY<br />";
                                            }
                                        //}
                                //    }
                                //}
                                /** **/
                            /*} else {
                                echo "Jocker account, not pay!<br />";
                            }*/
                            
                            $MESSAGE .= "<br /><br />";
                            
                            if ($SHOW_MESSAGE == true) {
                                echo $MESSAGE;
                            }
                        }
                    }
                break;
                
                /**
                case "profit":
                    // donations
                    /*
                    $settings__daily_income_pay = (new Settings)->findValue('daily_income_pay');
                    $settings__daily_income = (float)str_replace(",",".",(new Settings)->findValue('daily_income'));
                    
                    if ($settings__daily_income_pay == "true") {
                        $data = (new Donations)->find(null, null, null, null, null, 'RECEBENDO', null, 999999);
                        
                        // pay profit
                        foreach ($data as $item) {
                            if ((float)$item['_received'] < (float)$item['_income']) {
                                $hash = newMD5Hash();
                                
                                // pay day
                                $amount_pay = (((float)$item['_amount']/100)*$settings__daily_income);
                                $current_received = (float)$item['_received'];
                                $new_received = $current_received + $amount_pay;
                                
                                $endReceivedTxt = '';
                                if ($new_received > (float)$item['_income']) {
                                    $new_received = (float)$item['_income'];
                                    $amount_pay2 = (float)$item['_income'] - $current_received;
                                    
                                    if ($amount_pay2 < $amount_pay) {
                                        $amount_pay = $amount_pay2;
                                    }
                                }
                                
                                if ($new_received >= (float)$item['_income']) {
                                    $endReceivedTxt = ' [FINALIZADO]';
                                }
                                
                                (new Donations)->setReceived($item['_id'], $new_received);
                                (new Wallet)->create('profit', $item['_accounts__id'], 'RENDIMENTO CONTRATO', null, $amount_pay, 'RENDIMENTO PLANO/CONTRATO' . $endReceivedTxt . ' #'.$item['_seq'].' DE '.$settings__daily_income.'%', $hash, 'LIBERADO');
                                
                                $logs .= $item['_accounts__id'] . ' | RENDIMENTO PLANO/CONTRATO' . $endReceivedTxt . ' #' . $item['_seq'] . ' DE ' . $amount_pay . ' [' . $settings__daily_income . '%], total ' . $new_received . '<br />';
                                
                                if ($new_received >= (float)$item['_income']) {
                                    (new Donations)->setStatus($item['_id'], 'FINALIZADO');
                                }
                            } else if ((float)$item['_income'] >= (float)$item['_income']) {
                                // close
                                (new Donations)->setStatus($item['_id'], 'FINALIZADO');
                            }
                        }
                    } else {
                        $logs = 'PAGAMENTO DE RENDIMENTO INATIVO<br />';
                    }
                    */
                /**   
                    // donations_up
                    $settings__daily_income_pay = (new Settings)->findValue('daily_income_pay');
                    $settings__daily_income = (float)str_replace(",",".",(new Settings)->findValue('daily_income'));
                    
                    if ($settings__daily_income_pay == "true") {
                        $data = (new Donations_up)->find(null, null, null, null, null, 'RECEBENDO', null, 999999);
                        
                        // pay profit
                        foreach ($data as $item) {
                            // inc received, to tariff
                            $inc_received = 0;
                            
                            // pagamento | check new donation pending
                            $data__newDonations = (new Donations_up)->find(null, $item['_accounts__id'], null, null, null, null, null, 500, true);
                            if (sizeof($data__newDonations) == 0) {
                                if ((float)$item['_received'] < (float)$item['_income']) {
                                    $hash = newMD5Hash();
                                    
                                    // pay day
                                    $amount_pay = (((float)$item['_amount']/100)*$settings__daily_income);
                                    $current_received = (float)$item['_received'];
                                    $new_received = $current_received + $amount_pay;
                                    
                                    // to tariff
                                    $inc_received = $amount_pay;
                                    
                                    $endReceivedTxt = '';
                                    if ($new_received > (float)$item['_income']) {
                                        $new_received = (float)$item['_income'];
                                        $amount_pay2 = (float)$item['_income'] - $current_received;
                                        
                                        if ($amount_pay2 < $amount_pay) {
                                            $amount_pay = $amount_pay2;
                                        }
                                    }
                                    
                                    if ($new_received >= (float)$item['_income']) {
                                        $endReceivedTxt = ' [FINALIZADO]';
                                    }
                                    
                                    (new Donations_up)->setReceived($item['_id'], $new_received);
                                    (new Wallet)->create('profit', $item['_accounts__id'], 'RENDIMENTO CONTRATO', null, $amount_pay, 0, 0, 'RENDIMENTO PLANO/CONTRATO' . $endReceivedTxt . ' #'.$item['_seq'].' DE '.$settings__daily_income.'%', $hash, 'effected');
                                    
                                    $logs .= $item['_accounts__id'] . ' | RENDIMENTO PLANO/CONTRATO' . $endReceivedTxt . ' #' . $item['_seq'] . ' DE ' . $amount_pay . ' [' . $settings__daily_income . '%], total ' . $new_received . '<br />';
                                    
                                    if ($new_received >= (float)$item['_income']) {
                                        (new Donations_up)->setStatus($item['_id'], 'FINALIZADO');
                                    }
                                } else if ((float)$item['_income'] >= (float)$item['_income']) {
                                    // close
                                    (new Donations_up)->setStatus($item['_id'], 'FINALIZADO');
                                }
                            }
                            
                            
                            // taxa 10% sobre 100% retorno e novo contrato
                            if (((float)$item['_received'] + $inc_received) >= (float)$item['_amount'] && $item['_rate_100perc'] == 'pending') {
                                $hash_c = newMD5Hash();
                                
                                (new Wallet)->create(
                                        'tariff',
                                        $item['_accounts__id'],
                                        'TAXA RENDIMENTO CONTRATO',
                                        null,
                                        -((float)$item['_amount']/100)*10,
                                        0,
                                        0,
                                        'TAXA RENDIMENTO PLANO/CONTRATO #'.$item['_seq'].' DE 10%',
                                        $hash_c,
                                        'effected'
                                    );
                                
                                (new Donations_up)->setTaxAndNewDonationStatus($item['_id'], 'discounted', 'pending');
                                
                                $logs .= 'RECEBIDO: ' . $item['_received'] . ' | VAL. CONTRATO: ' . $item['_amount'] . ' | ST TAXA: ' . $item['_rate_100perc'];
                                $logs .= '<br />';
                            }
                        }
                    } else {
                        $logs = 'PAGAMENTO DE RENDIMENTO INATIVO<br />';
                    }
                break;
                **/
            }
        } else {
            $logs = 'INVALID SECURITY CODE<br />';
        }
        
        /*
        $data = (new BankOn)->bankonUsernameVerify((new Settings)->findValue('bankon__token_query'), $_username);
        $dataJson = json_decode($data, true);
        
        if ($dataJson['sucesso'] == true) {
            (new Json)->echoJson(array("success" => true, "data" => $dataJson['Dados']));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => $dataJson['message']));
        }*/
        
        echo $logs;
    });
?>
