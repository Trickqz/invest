<?php
    $router->map('GET', '/v1/donations', function(){
        /*$account__id = null;
        if ($_GET['username'] != '') {
            $accountData = (new Accounts)->accountsFromUsername($_GET['username']);
            $account__id = $accountData['_id'];
        } else {
            $accountData = (new Accounts)->find(authGetUserId());
            if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
                $account__id = $accountData['_id'];
            }
        }*/
        
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }
        
        if ($_GET['q'] != "") {
            $dataAccounts = (new Accounts)->find(null, $_GET['q']);
            
            if (sizeof($dataAccounts) > 0) {
                $accountsArrList = '';
                foreach ($dataAccounts as $row)
                {
                    $accountsArrList .= $row['_id'].',';
                }
                $accountsArrList = substr($accountsArrList, 0, -1);
                $accountsArr = "($accountsArrList)";
                
                $data = (new Donations)->find(null, $accountsArr, $_GET['date_of'], $_GET['date_until'], $_GET['type'], $_GET['status'], null, 'DESC', 100);
            } else {
                if ($account__id == null) {
                    $data = (new Donations)->find(null, null, $_GET['date_of'], $_GET['date_until'], $_GET['type'], $_GET['status'], null, 'DESC', 100);
                } else {
                    $data = (new Donations)->find(null, '('.$account__id.')', $_GET['date_of'], $_GET['date_until'], $_GET['type'], $_GET['status'], null, 'DESC', 100);
                }
            }
        } else {
            if ($account__id == null) {
                $data = (new Donations)->find(null, null, $_GET['date_of'], $_GET['date_until'], $_GET['type'], $_GET['status'], null, 'DESC', 100);
            } else {
                $data = (new Donations)->find(null, '('.$account__id.')', $_GET['date_of'], $_GET['date_until'], $_GET['type'], $_GET['status'], null, 'DESC', 100);
            }
        }
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/donations/[i:id]', function($_id){
        $data = (new Donations)->find($_id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('POST', '/v1/donations', function(){
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        /*if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        if ($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') {
            $account__id = 0;
        } else {
            $account__id = $accountData['_id'];
        }
        
        if ($_POST['contracts'] < 1) {
            (new Json)->echoJson(array("success" => false, "message" => "You must choose a minimum amount of shares!"));
            return;
        }
        
        $donationsActive = (new Donations)->countTotalFromAccountsID($account__id, null, 'receiving');
        if ($donationsActive >= (new Settings)->findValue('__accounts_max_contracts_active')) {
            (new Json)->echoJson(array("success" => false, "message" => "You have reached the limit of active quotas!"));
            return;
        }
        if (($donationsActive + $_POST['contracts']) >= (new Settings)->findValue('__accounts_max_contracts_active')) {
            (new Json)->echoJson(array("success" => false, "message" => "You cannot purchase quotas greater than the active quota limit!"));
            return;
        }
        
        // check saldo
        $walletTotal = (float)(new Wallet)->getBalanceFromAccountsID($account__id);
        $amount = $_POST['contracts']*(new Settings)->findValue('contracts_value_usd');  //$dataDonations['_amount'];
        
        if ($walletTotal < $amount) {
            (new Json)->echoJson(array("success" => false, "message" => "Balance unavailable for the acquisition of shares."));
            return;
        }
        
        $data = (new Donations)->create($account__id, $_POST['contracts']);
        if ($data) {
            $next__seq = (new Donations)->getNextSeqFromAccountsID($account__id);
            $donationData = (new Donations)->findByAccountAndSeq($account__id, $next__seq-1);
            
            // debit
            $bytes = openssl_random_pseudo_bytes(32);
            $hash = base64_encode($bytes);
            
            (new Wallet)->create(
                    'purchase',
                    $account__id,
                    'Purchase '.STRNAME__LICENSE,
                    $donationData['_id'],
                    -$amount,
                    0,
                    0,
                    ('Purchase '.STRNAME__LICENSE.' #' . $donationData['_id']),
                    $hash,
                    'effected'
                );
            
            
            /**
             * *SEGURO*
             *  - 10% DAS DOAÇÕES
             * 
             * *MANUTENÇÃO*
             *  - 10% DAS DOAÇÕES
             */
            $accountDataOrigin = (new Accounts)->find($account__id);
            /**
            $bytes = openssl_random_pseudo_bytes(32);
            $hash = base64_encode($bytes);
            $accountData = (new Accounts)->find(3);
            (new Wallet)->create('purchase', $account__id, 'Donation', $donationData['_id'], -(($amount/100.0)*10), 0, 0, ('Pack/license #' . $donationData['_id'] . ' PARA ' . $accountData['_name'] . ' [' . $accountData['_username'] . ']'), $hash, 'effected');
            (new Wallet)->create('credit', 3, 'Provisioning', $donationData['_id'], ($amount/100.0)*10, 0, 0, ('Pack/license #' . $donationData['_id'] . ' of ' . $accountDataOrigin['_name'] . ' [' . $accountDataOrigin['_username'] . ']'), $hash, 'effected');
            
            $bytes = openssl_random_pseudo_bytes(32);
            $hash = base64_encode($bytes);
            $accountData = (new Accounts)->find(4);
            (new Wallet)->create('purchase', $account__id, 'Donation', $donationData['_id'], -(($amount/100.0)*10), 0, 0, ('Pack/license #' . $donationData['_id'] . ' PARA ' . $accountData['_name'] . ' [' . $accountData['_username'] . ']'), $hash, 'effected');
            (new Wallet)->create('credit', 4, 'Provisioning', $donationData['_id'], ($amount/100.0)*10, 0, 0, ('Pack/license #' . $donationData['_id'] . ' of ' . $accountDataOrigin['_name'] . ' [' . $accountDataOrigin['_username'] . ']'), $hash, 'effected');
            **/
            
            
            /**
             * UNILEVEL
             * 
             * - INDICAÇÃO DIRETA
             *      - 10% NA AQUISIÇÃO, REGRA: 2 COTAS NO MÊS
             * - UNILEVEL
             *      - 2% NÍVEIS: 3, 5, 7, 9, 20
             *      - 1% NÍVEIS: 2, 4, 6, 8, 10, 19
             *      - 0,5% NÍVEIS: 11, 12, 13, 14, 15, 16, 17, 18
             * 
             *      REGRA: CADA DIRETO COM MÍNIMO DE 10 COTAS E NÚMERO DE DIRETOS
             *      :: 4º NÍVEL: 4 DIRETOS, 40 COTAS (MÍNIMO DE 10 POR DIRETO)
             * 
             *      INATIVA O BÔNUS COM MAIS DE 30 DIAS SEM CADASTRO ATIVO
             * 
             */
            /**
            $upline = (new Accounts)->network__gen_upLine($account__id, null);
            $totalValue = ($amount/100.0)*80;
            if (sizeof($upline) > 0) {
                for ($i=0;$i<sizeof($upline);$i++){
                    if (($i+1) <= 20) {
                        $currPercentage = 0.0;
                        $level = $i+1;
                        
                        switch($level){
                            case 1:
                                $currPercentage = 10.0;
                            break;
                            case 3:
                            case 5:
                            case 7:
                            case 9:
                            case 20:
                                $currPercentage = 2.0;
                            break;
                            case 2:
                            case 3:
                            case 4:
                            case 5:
                            case 10:
                            case 19:
                                $currPercentage = 1.0;
                            break;
                            case 11:
                            case 12:
                            case 13:
                            case 14:
                            case 15:
                            case 16:
                            case 17:
                            case 18:
                                $currPercentage = 0.5;
                            break;
                        }
                        
                        // CONDIÇÕES || REGRAS ATIVAÇÃO
                        $isOk = false;
                        
                        // CONTAS: admin, unityglobal não recebem!
                        if ($upline[$i]['_id'] == 2 || $upline[$i]['_id'] == 6) {
                            $isOk = false;
                        }
                        
                        if ($level == 1) {
                            $countContractsInMonth = (new Donations)->countTotalInMonthFromAccountsID($upline[$i]['_id']);
                            if ($countContractsInMonth >= 2) {
                                $isOk = true;
                            }
                        } else {
                            //$isOk = (new Accounts)->findLevelActive($upline[$i]['_id'], $level);
                            $isOk = (new Accounts)->findActiveForLevelV2($upline[$i]['_id'], $level);
                        }
                        // END
                        
                        if ($isOk == true) {
                            $bytes = openssl_random_pseudo_bytes(32);
                            $hash = base64_encode($bytes);
                            if ($level == 1 && $isOk == true) {
                                $accountData = (new Accounts)->find($upline[$i]['_id']);
                                (new Wallet)->create('purchase', $account__id, 'Donation', $donationData['_id'], -(($amount/100.0)*$currPercentage), 0, 0, ('Pack/license #' . $donationData['_id'] . ' to ' . $accountData['_name'] . ' [' . $accountData['_username'] . ']'), $hash, 'effected');
                                (new Wallet)->create('credit', $upline[$i]['_id'], 'Direct indication', $donationData['_id'], ($amount/100.0)*$currPercentage, 0, 0, ('Pack/license #' . $donationData['_id'] . ' of ' . $accountDataOrigin['_name'] . ' [' . $accountDataOrigin['_username'] . ']'), $hash, 'effected');
                            } else if ($level > 1 && $isOk == true) {
                                $accountData = (new Accounts)->find($upline[$i]['_id']);
                                (new Wallet)->create('purchase', $account__id, 'Donation', $donationData['_id'], -(($amount/100.0)*$currPercentage), 0, 0, ('Pack/license #' . $donationData['_id'] . ' to ' . $accountData['_name'] . ' [' . $accountData['_username'] . ']'), $hash, 'effected');
                                (new Wallet)->create('credit', $upline[$i]['_id'], 'Indirect indication, level: '.$level, $donationData['_id'], ($amount/100.0)*$currPercentage, 0, 0, ('Pack/license #' . $donationData['_id'] . ' of ' . $accountDataOrigin['_name'] . ' [' . $accountDataOrigin['_username'] . ']'), $hash, 'effected');
                            }
                            
                            $totalValue -= ($amount/100.0)*$currPercentage;
                        }
                    }
                }
            }**/
            
            
            
            /**
             * BINARY
             * 
             * - INDICAÇÃO DIRETA
             *      - 10% NA AQUISIÇÃO
             * 
             * CORINGA recebe indicação e binário de conta normal;
             */
            $binaryIndicationPercentage = 10.0;
            $binaryPercentage = 5.0;
            //(new Wallet)->create('purchase', $account__id, 'License purchase', $donationData['_id'], -(($amount/100.0)*$binaryIndicationPercentage), 0, 0, ('Pack/license #' . $donationData['_id'] . ' to ' . $accountData['_name'] . ' [' . $accountData['_username'] . ']'), $hash, 'effected');
            
            // CONTA CORINGA / JOKER
            $isJoker = (new Accounts)->isJokerAccount($accountDataOrigin['_id']);
            
            if ($isJoker == false) {
                (new Wallet)->create(
                        'credit',
                        $accountDataOrigin['_unilevel_id_master'],
                        'Direct indication',
                        $donationData['_id'],
                        ($amount/100.0)*$binaryIndicationPercentage,
                        0,
                        0,
                        ('Pack/'.STRNAME__LICENSE.' #' . $donationData['_id'] . ' of ' . $accountDataOrigin['_name'] . ' [' . $accountDataOrigin['_username'] . ']'),
                        $hash,
                        'effected'
                    );
            }
            
            if (BINARY__PAYMENT == true && $isJoker == false) {
                // points
                $binary_upline = (new Accounts)->network__gen_binary_upLine($accountDataOrigin['_id'], null);
                
                if (sizeof($binary_upline) > 0) {
                    for ($i=0;$i<sizeof($binary_upline);$i++){
                        //if (($i+1) <= 20) {
                            
                            // CONDIÇÕES || REGRAS ATIVAÇÃO
                            $isOK = true;  //false;
                            
                            // ATIVO - Adquiriu licenças
                            if ($isOK == true) {
                                $isOK = (new Accounts)->isActive($binary_upline[$i]['_id']);
                            }
                            
                            // QUALIFICADO - colocou duas contas ativas e diretas (lado esquerdo e direito)
                            if ($isOK == true) {
                                $isOK = (new Accounts)->binaryReceiving($binary_upline[$i]['_id']);
                            }
                            
                            // CONTA CORINGA / JOKER [NÃO GERA BINÁRIO MAS RECEBE DA REDE]
                            if ($isOK == false) {
                                $isOK = (new Accounts)->isJokerAccount($binary_upline[$i]['_id']);
                            }
                            
                            if ($isOK == true) {
                                // create binary points
                                $aa = (new Points)->create(
                                        $binary_upline[$i]['_id'],
                                        'binary',
                                        $binary_upline[$i]['_side'],
                                        $amount,
                                        null,
                                        $account__id,
                                        $i,
                                        'false'
                                    );
                                
                                // pay binary to current user
                                $bytes = openssl_random_pseudo_bytes(32);
                                $hash = base64_encode($bytes);
                                
                                $points_l = (new Points)->getBinaryBalanceFromAccountsID($binary_upline[$i]['_id'], 'left');
                                $points_r = (new Points)->getBinaryBalanceFromAccountsID($binary_upline[$i]['_id'], 'right');
                                
                                if ($points_l > 0 && $points_r > 0) {
                                    if ($points_l > $points_r) {
                                        // paid right
                                        (new Wallet)->createProfitBinary(
                                                'profit',
                                                $binary_upline[$i]['_id'],
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
                                    } else {
                                        // paid left
                                        (new Wallet)->createProfitBinary(
                                                'profit',
                                                $binary_upline[$i]['_id'],
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
                                    }
                                }
                            }
                        //}
                    }
                }
            }
            
            
            
            // INCOME REQUESTS
            $personal_income_requests = (new Personal_income_requests)->findPending();
            if (sizeof($personal_income_requests) > 0) {
                for ($i=0;$i<sizeof($personal_income_requests);$i++){
                    $amountToPay = $personal_income_requests[$i]['_amount'] - $personal_income_requests[$i]['_received'];
                    if ($amountToPay > $totalValue) {
                        $amountToPay = $totalValue;
                    }
                    
                    if ($totalValue > 0 && $totalValue >= $amountToPay) {
                        $bytes = openssl_random_pseudo_bytes(32);
                        $hash = base64_encode($bytes);
                        
                        $accountData = (new Accounts)->find($personal_income_requests[$i]['_accounts__id']);
                        (new Wallet)->create('purchase', $account__id, 'Donation', $donationData['_id'], -$amountToPay, 0, 0, ('Pack/'.STRNAME__LICENSE.' #' . $donationData['_id'] . ' to ' . $accountData['_name'] . ' [' . $accountData['_username'] . ']'), $hash, 'effected');
                        (new Wallet)->create('credit', $personal_income_requests[$i]['_accounts__id'], 'Donation', $donationData['_id'], $amountToPay, 0, 0, ('Pack/'.STRNAME__LICENSE.' #' . $donationData['_id'] . ' of ' . $accountDataOrigin['_name'] . ' [' . $accountDataOrigin['_username'] . ']'), $hash, 'effected');
                        
                        (new Personal_income_requests)->setReceived($personal_income_requests[$i]['_id'], $amountToPay);
                        
                        $totalValue -= $amountToPay;
                    }
                }
            }
            
            if ($totalValue > 0) {
                $bytes = openssl_random_pseudo_bytes(32);
                $hash = base64_encode($bytes);
                
                $accountData = (new Accounts)->find(5);
                (new Wallet)->create('purchase', $account__id, 'Donation', $donationData['_id'], -$totalValue, 0, 0, ('Pack/'.STRNAME__LICENSE.' #' . $donationData['_id'] . ' to ' . $accountData['_name'] . ' [' . $accountData['_username'] . ']'), $hash, 'effected');
                (new Wallet)->create('credit', 5, 'Provisioning', $donationData['_id'], $totalValue, 0, 0, ('Pack/'.STRNAME__LICENSE.' #' . $donationData['_id'] . ' of ' . $accountDataOrigin['_name'] . ' [' . $accountDataOrigin['_username'] . ']'), $hash, 'effected');
            }
            
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "A aquisição das cotas não pode ser realizada."));
        }
    });
    
    $router->map('GET', '/v1/donations/resume', function(){
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        /*if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        if ($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') {
            $account__id = 0;
        } else {
            $account__id = $accountData['_id'];
        }
        
        /*$data = (new Wallet)->find(null, $account__id, $_GET['date_of'], $_GET['date_until'], $_GET['status'], 'DESC', 500);
        if ($data) {
            (new Json)->echoJson(array("success" => true, "data" => $data));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "A consulta não pode ser realizada."));
        }*/
        
        /*
        $walletTotal = (float)(new Wallet)->getBalanceFromAccountsID($data['_id']);
        $data['_wallet__ballance'] = number_format($walletTotal, 2, "." ,"");
        */
        
        $totalIncome = (New Donations)->sumTotalAmountIncomeFromAccountsID($account__id);
        $totalReceived = (New Donations)->sumTotalAmountReceivedFromAccountsID($account__id);
        /*$toReceive = 0;
        
        if ($totalIncome > 0) {  // && $totalIncome >= $totalReceived) {
            $toReceive = $totalIncome - $totalReceived;
        }*/
        
        $data = array(
            "_count_receiving_contracts" => (New Donations)->countTotalFromAccountsID($account__id, null, 'receiving'),
            "_count_total_contracts" => (New Donations)->countTotalFromAccountsID($account__id),
            "_total_amount_income" => $totalIncome,
            "_total_amount_received" => $totalReceived
        );
        
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    $router->map('POST', '/v1/donations/pay', function(){
        $bytes = openssl_random_pseudo_bytes(32);
        $hash = base64_encode($bytes);
        
        // fight closed
        $dataDonations = (new Donations)->find($_POST['id']);
        if ($dataDonations['_status'] != 'AGUARDANDO' && $dataDonations['_status'] != 'AGUARDANDO RECOMPROMISSO') {
            (new Json)->echoJson(array("success" => false, "message" => "The plan or contract is terminated and can no longer be paid!"));
            return;
        }
        
        
        $data = (new Accounts)->find(authGetUserId());
        
        if ($_POST['id'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a plan or contract in order to pay!"));
            return;
        }
        if ($_POST['provider'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must provide a payment method!"));
            return;
        }
        if ($_POST['provider'] != "wallet" && $_POST['provider'] != "bankon") {
            (new Json)->echoJson(array("success" => false, "message" => "You must provide a valid payment method!"));
            return;
        }
        
        // check saldo
        if ($_POST['provider'] == 'wallet') {
            $walletTotal = (float)(new Wallet)->getBalanceFromAccountsID($data['_id']);
            $amount = $dataDonations['_amount'];
            
            if ($walletTotal < $amount) {
                (new Json)->echoJson(array("success" => false, "message" => "Balance unavailable for payment amount."));
                return;
            }
        }
        
        /*
        $tariff = (float)$dataFights['_tariff'];
        $tariff_amount = 0;
        if ($tariff > 0) {
            $tariff_amount = ($amount / 100) * $tariff;
            $bet_amount = ($amount - $tariff_amount) * 100;
        }
        */
        
        
        if ($dataDonations['_1th_pgto'] == null) {
            //_1th_payment_date
            //_1th_pgto
            //_1th_payment_transaction
            //_status
            
            $success = (new Donations)->update1thPayment($dataDonations['_id'], $_POST['provider'], $hash, 'AGUARDANDO RECOMPROMISSO');
            if ($success) {
                // debit from wallet
                (new Wallet)->create('purchase', $data['_id'], 'Payment', $dataDonations['_id'], -$amount, 0, 0, 'Payment pack/'.STRNAME__LICENSE.' #' . $dataDonations['_id'], $hash, 'effected');
                /*if ($tariff_amount > 0) {
                    (new Wallet)->create('tariff', 1, 'TARIFA DE PAGAMENTO', $dataDonations['_id'], $tariff_amount, 'PAGAMENTO PLANO/CONTRATO #' . $dataDonations['_id'], $hash, 'LIBERADO');
                }*/
                
                (new Json)->echoJson(array("success" => true));
            } else {
                (new Json)->echoJson(array("success" => false, "message" => "Payment cannot be processed."));
            }
        } else {
            if ($dataDonations['_2th_pgto'] == null) {
                //_2th_payment_date
                //_2th_pgto
                //_2th_payment_transaction
                //_validated
                //_status
                
                $success = (new Donations)->update2thPayment($dataDonations['_id'], $_POST['provider'], $hash, 'RECEBENDO');
                if ($success) {
                    // debit from wallet
                    (new Wallet)->create('purchase', $data['_id'], 'Payment', $dataDonations['_id'], -$amount, 0, 0, 'Payment pack/'.STRNAME__LICENSE.' #' . $dataDonations['_id'], $hash, 'effected');
                    /*if ($tariff_amount > 0) {
                        (new Wallet)->create('tariff', 1, 'TARIFA DE PAGAMENTO', $dataDonations['_id'], $tariff_amount, 'PAGAMENTO PLANO/CONTRATO #' . $dataDonations['_id'], $hash, 'LIBERADO');
                    }*/
                    
                    (new Json)->echoJson(array("success" => true));
                } else {
                    (new Json)->echoJson(array("success" => false, "message" => "Payment cannot be processed."));
                }
            } else {
                (new Json)->echoJson(array("success" => false, "message" => "Payment cannot be processed."));
            }
        }
    });
    
    $router->map('POST', '/v1/donations/[:id]/setStatus', function($id){
        /*$account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        // donation
        /*$dataDonations = (new Donations)->find($id);
        if ($dataDonations['_status'] != 'AGUARDANDO') {
            (new Json)->echoJson(array("success" => false, "message" => "O plano ou contrato está em andamento e não pode ser cancelado no momento!"));
            return;
        }
        if ($dataDonations['_accounts__id'] != $account__id && ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator')) {
            (new Json)->echoJson(array("success" => false, "message" => "Você não pode cancelar o plano ou contrato informado!"));
            return;
        }*/
        /**
        $received = (new Format)->clearNumber($_POST['received']);
        if ($received != "") {
            $received = (float)((int)$received)/100;
        }
        
        $data = (new Donations)->setReceived($id, $received);
        (new Json)->echoJson(array("success" => true, "data" => $data));*/
        
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') {
            $status = $_POST['status'];
            if ($status != "") {
                $data = (new Donations)->setStatus($id, $status);
                (new Json)->echoJson(array("success" => true, "data" => $data));
            }
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "You cannot change the status of the given quota package!"));
            return;
        }
    });
    
    $router->map('POST', '/v1/donations/[:id]/cancel', function($id){
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') {
            // donation
            $dataDonations = (new Donations)->find($id);
            if ($dataDonations['_status'] == 'waiting' || $dataDonations['_status'] == 'receiving') {
                $data = (new Donations)->cancel($id);
                
                //chargeback
                $bytes = openssl_random_pseudo_bytes(32);
                $hash = base64_encode($bytes);
                
                $amount_chargeback = $dataDonations['_amount'];
                if ($dataDonations['_status'] == 'waiting') {
                    $amount_chargeback = 0;
                } else if ($dataDonations['_status'] == 'receiving') {
                    $amount_chargeback = $amount_chargeback * 2;
                }
                
                if ($amount_chargeback > 0) {
                    (new Wallet)->create('credit', $dataDonations['_accounts__id'], 'Reversal', $dataDonations['_id'], $amount_chargeback, 0, 0, 'Cancelation reversal pack/'.STRNAME__LICENSE.' #' . $dataDonations['_id'], $hash, 'effected');
                }
                
                (new Json)->echoJson(array("success" => true));
            } else {
                (new Json)->echoJson(array("success" => false, "message" => "You cannot cancel the given quota package!"));
                return;
            }
        } else {
            $account__id = $accountData['_id'];
            
            // donation
            $dataDonations = (new Donations)->find($id);
            if ($dataDonations['_status'] != 'waiting') {
                (new Json)->echoJson(array("success" => false, "message" => "The quota package cannot be canceled at this time!"));
                return;
            }
            if ($dataDonations['_accounts__id'] != $account__id && ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator')) {
                (new Json)->echoJson(array("success" => false, "message" => "You cannot cancel the given quota package!"));
                return;
            }
            
            $data = (new Donations)->cancel($id);
            (new Json)->echoJson(array("success" => true, "data" => $data));
        }
    });
?>
