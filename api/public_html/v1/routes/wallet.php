<?php
    // https://../content/donations/donationsController.php?acao=pay&id=1&fpgto=bankon&transacao=05480af28ad20765
    
    // API
    // https://commerce.coinbase.com/docs/api/#webhooks
    // 
    // https://github.com/codename065/coinbase-commerce
    // https://github.com/thephpleague/omnipay-coinbase
    // https://github.com/thephpleague/omnipay
    // https://stackoverflow.com/questions/50922042/integrate-coinbase-commerce-in-php
    
    
    $router->map('GET', '/v1/wallet', function(){
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
        
        $data = (new Wallet)->find(null, $account__id, $_GET['date_of'], $_GET['date_until'], $_GET['type'], $_GET['status'], 'DESC', 500);
        if ($data) {
            (new Json)->echoJson(array("success" => true, "data" => $data));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The query cannot be performed."));
        }
    });
    
    $router->map('GET','/v1/wallet/[i:id]', function($_id){
        $data = (new Wallet)->find($_id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    $router->map('POST','/v1/wallet/coinbase/add-usd', function(){
        $accountData = (new Accounts)->find(authGetUserId());
        
        $money_add_service_enabled = (new Settings)->findValue('money_add_service_enabled');
        if ($money_add_service_enabled == 'false') {
            (new Json)->echoJson(array("success" => false, "message" => "It is currently not possible to add balance."));
            return;
        }
        
        
        if ($_POST['amount'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a value to add!"));
            return;
        }
        $amount = (new Format)->clearNumber($_POST['amount']);
        if ($amount != "") {
            $amount = (float)((int)$amount)/100;
        }
        
        $originalAmount = $amount;
        
        
        /**
         * ACRÈSCIMO TAXA COINBASE
         * 100 USD + 1,01% = 101,01 USD / - TAXA 1% = 99,99 USD
         */
        ///$amount = ($amount*101.01)/100.0;
        /** **/
        
        
        /** **/
        // Create a client
        $client = new \WPDMPP\Coinbase\Commerce\Client();
        //$client->setApiKey('bb3eca50-a560-4afb-9ca5-5edfbc407343');  //{your API Key}
        $client->setApiKey((new Settings)->findValue('coinbase__api_key'));  //{your API Key}
        
        // Prepare the charge
        $charge = new \WPDMPP\Coinbase\Commerce\Model\Charge();
        
        // Create local price
        $money = new \WPDMPP\Coinbase\Commerce\Model\Money();
        $money->SetAmount(number_format($amount,2,'.',''));
        $money->SetCurrency('USD');
        
        $charge->setName('Value insertion');  //Talk Credits
        $charge->setDescription('Value insertion to ' . (new Settings)->findValue('site__name'));  //Talk to Anyone, Anytime!
        $charge->setPricingType('fixed_price');
        $charge->setLocalPrice($money);
        
        $bytes = openssl_random_pseudo_bytes(32);
        $hash = base64_encode($bytes);
        //$charge->setRedirectUrl('https://api.unityglobal.club/v1/wallet/coinbase/'.$hash.'/event');  //{https://your.site.com}
        $charge->setRedirectUrl('http://app.invest.local');  //{https://your.site.com}
        
        try {
            // Create the request and get back Coinbase Commerce response
            $response = $client->createCharge($charge);
        } catch(\Exception $ex) {
            echo $ex->getMessage();
        }
        
        // Print response
        //echo ($response);
        /** **/
        
        $responseJson = json_decode($response);
        
        /**
        //header("Access-Control-Allow-Origin: http://localhost/REST API AUTHENTICATION/");
        header("Content-Type: application/json; charset=UTF-8");
        header("Access-Control-Allow-Credentials: true");
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Max-Age: 3600");
        header("Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD");
        header("Access-Control-Allow-Headers: Content-Type, Accept, Access-Control-Allow-Headers, Authorization, Origin, X-Requested-With");
        //header('Access-Control-Allow-Credentials: true');
        
        var_dump($responseJson);
        **/
        
        (new Coinbase_ins)->create(
                $hash,
                $accountData['_id'],
                $originalAmount,
                $responseJson->data->id,
                $responseJson->data->code,
                $responseJson->data->hosted_url,
                $responseJson->data->expires_at,
                $response,
                null,
                'waiting'
            );
        
        (new Json)->echoJson(array("success" => true, "data" => $responseJson));
    });
    
    $router->map('GET','/v1/wallet/coinbase/charge/[:code]', function($code){
        
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
        }
        /** **/
        
        if ($expired == true) {
            $coinbase_ins = (new Coinbase_ins)->findCoinbase_code($code);
            (new Coinbase_ins)->update(
                    $coinbase_ins['_id'],
                    json_encode($data),
                    'expired'
                );
            
            (new Json)->echoJson(array("success" => true, "expired" => true));
        } else if ($completed == true) {
            $coinbase_ins = (new Coinbase_ins)->findCoinbase_code($code);
            if ($coinbase_ins['_status'] == 'waiting') { // && $coinbase_ins['_coinbase_code'] == $data['event']['data']['code']) {
                (new Coinbase_ins)->update(
                        $coinbase_ins['_id'],
                        $response,
                        'confirmed'
                    );
                
                $insertCredit = (new Wallet)->create(
                        'insertion',
                        $coinbase_ins['_accounts__id'],
                        'Value insertion',
                        null,
                        $coinbase_ins['_amount'],
                        0,
                        0,
                        'Value insertion to personal account',
                        '',
                        'effected'
                    );
                
                if ($insertCredit) {
                    (new Json)->echoJson(array("success" => true, "completed" => $completed));
                } else {
                    (new Json)->echoJson(array("success" => false));
                }
            } else {
                (new Json)->echoJson(array("success" => false));
            }
        } else {
            (new Json)->echoJson(array("success" => false));
        }
    });
    
    /*$router->map('POST','/v1/wallet/coinbase/[:hash]/event', function($hash){
        $coinbase_ins = (new Coinbase_ins)->findHash($hash);
        
        $data = json_decode(file_get_contents('php://input'), true);
        if ($data['event']['type'] == "charge:confirmed") {
            if ($coinbase_ins['_status'] == 'waiting' && $coinbase_ins['_coinbase_code'] == $data['event']['data']['code']) {
                (new Coinbase_ins)->update(
                        $coinbase_ins['_id'],
                        json_encode($data),
                        'processed'
                    );
                
                $insertCredit = (new Wallet)->create(
                        'insertion',
                        $coinbase_ins['_accounts__id'],
                        'INSERÇÃO DE SALDO',
                        null,
                        $coinbase_ins['_amount'],
                        0,
                        0,
                        'INSERÇÃO DE SALDO PARA CONTA PESSOAL',
                        '',
                        'effected'
                    );
                
                if ($insertCredit) {
                    (new Json)->echoJson(array("success" => true));
                } else {
                    (new Json)->echoJson(array("success" => false));
                }
            }
        } else {
            (new Json)->echoJson(array("success" => false));
        }
    });*/
    
    $router->map('GET', '/v1/wallet/cashout', function(){
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
        
        $data = (new Wallet)->find(null, $account__id, $_GET['date_of'], $_GET['date_until'], 'withdraw', $_GET['status'], 'DESC', 500);
        if ($data) {
            (new Json)->echoJson(array("success" => true, "data" => $data));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The query cannot be performed."));
        }
    });
    
    $router->map('GET', '/v1/wallet/resume', function(){
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
        
        $data = array(
            "_total_credit" => (new Wallet)->getTotalCreditBalanceFromAccountsID($account__id),
            "_total_debit" => (new Wallet)->getTotalDebitBalanceFromAccountsID($account__id),
            "_total" => (new Wallet)->getTotalBalanceFromAccountsID($account__id)
        );
        
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    
    $router->map('GET', '/v1/wallet/cashout/resume', function(){
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
        
        $data = array(
            "_pending" => (new Wallet)->getTotalCashoutPendingBalanceFromAccountsID($account__id),
            "_total" => (new Wallet)->getTotalCashoutBalanceFromAccountsID($account__id)
        );
        
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    
    /**
    $router->map('GET','/v1/ext/bankon/query/username/verify/[*:username]', function($_username){
        //$data = (new Categories)->find($_id, authGetUserId(), null);
        $data = (new BankOn)->bankonUsernameVerify((new Settings)->findValue('bankon__token_query'), $_username);
        $dataJson = json_decode($data, true);
        
        if ($dataJson['sucesso'] == true) {
            (new Json)->echoJson(array("success" => true, "data" => $dataJson['Dados']));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => $dataJson['message']));
        }
    });
    $router->map('GET','/v1/ext/bankon/query/transaction/[:transaction]', function($_transaction){
        //$data = (new Categories)->find($_id, authGetUserId(), null);
        $data = (new BankOn)->bankonQueryTransaction((new Settings)->findValue('bankon__token_query'), $_transaction);
        $dataJson = json_decode($data, true);
        
        if ($dataJson['sucesso'] == true) {
            (new Json)->echoJson(array("success" => true, "data" => $dataJson['Dados']));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => $dataJson['message']));
        }
    });
    $router->map('GET','/v1/ext/bankon/query/balance', function(){
        //$data = (new Categories)->find($_id, authGetUserId(), null);
        $data = (new BankOn)->bankonQueryBalance((new Settings)->findValue('bankon__token_query'));
        $dataJson = json_decode($data, true);
        
        if ($dataJson['sucesso'] == true) {
            (new Json)->echoJson(array("success" => true, "data" => $dataJson['Dados']));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => $dataJson['message']));
        }
    });*/
    
    $router->map('POST', '/v1/wallet/withdraw-request', function(){
        $accountData = (new Accounts)->find(authGetUserId());
        
        $cashout_service_enabled = (new Settings)->findValue('cashout_service_enabled');
        if ($cashout_service_enabled == 'false') {
            (new Json)->echoJson(array("success" => false, "message" => "Withdrawal is currently unavailable. Wait for the financier to release the withdrawal again."));
            return;
        }
        
        
        if ($_POST['coinbase_email'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must provide a Coinbase account email for withdrawal!"));
            return;
        }
        
        if ($_POST['amount'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a withdrawal amount!"));
            return;
        }
        
        
        // check saldo
        //$walletTotal = (float)(new Wallet)->getBalanceFromAccountsID($accountData['_id']);
        $walletTotal = (float)(new Wallet)->getTotalBalanceFromAccountsID($accountData['_id']);
        $amount = (new Format)->clearNumber($_POST['amount']);
        if ($amount != "") {
            $amount = (float)((int)$amount)/100;
        }
        
        if ($walletTotal < $amount) {
            (new Json)->echoJson(array("success" => false, "message" => "Balance unavailable for requested withdrawal amount!"));
            return;
        }
        
        
        
        //
        /**$multiple = $amount;
        if ((float)$multiple != 100.00) {
            $mult = (float)$multiple / 100.00;
            if (!(floor($mult) != $mult)) {
                //
            } else {
                (new Json)->echoJson(array("success" => false, "message" => "O valor para saque deve ser multiplo de 100!"));
                return;
            }
        }*/
        
        
        ///$service_fee = (float)str_replace(",",".",(new Settings)->findValue('cashout_service_fee'));
        ///$net_amount = $amount - $service_fee;
        
        /**
         * 11,99% dia  5, 10, 15, 20, 25, 30
         *  9,99% dia 10, 20, 30
         *  7,99% dia 15, 30
         *  4,99% dia 30
         */
        
        $fee_percent = 0.00;
        $cfg__service_fee_perc = (float)str_replace(",",".",(new Settings)->findValue('cashout_service_fee_perc'));
        if ($cfg__service_fee_perc > 0) {
            $fee_percent = $cfg__service_fee_perc;
        }
        
        $cfg__service_fee = (float)str_replace(",",".",(new Settings)->findValue('cashout_service_fee'));
        if ($cfg__service_fee > 0) {
            $fee_percent += $cfg__service_fee;
        }
        
        $t = date('d-m-Y');
        $currDay = date("d",strtotime($t));
        $isCashoutDay = false;
        $_cashout_days = '';
        /**switch($accountData['_cashout_day']){
            case 5:
                $fee_percent = 11.99;
                $_cashout_days = '5, 10, 15, 20, 25 e 30';
                
                if ($currDay == 5 || $currDay == 10 || $currDay == 15 || $currDay == 20 || $currDay == 25 || $currDay == 30) {
                    $isCashoutDay = true;
                }
            break;
            case 10:
                $fee_percent = 9.99;
                $_cashout_days = '10, 20 e 30';
                
                if ($currDay == 10 || $currDay == 20 || $currDay == 30) {
                    $isCashoutDay = true;
                }
            break;
            case 15:
                $fee_percent = 7.99;
                $_cashout_days = '15 e 30';
                
                if ($currDay == 15 || $currDay == 30) {
                    $isCashoutDay = true;
                }
            break;
            case 30:
                $fee_percent = 4.99;
                $_cashout_days = '30';
                
                if ($currDay == 30) {
                    $isCashoutDay = true;
                }
            break;
        }
        */
        
        
        /*if (!$isCashoutDay) {
            (new Json)->echoJson(array("success" => false, "message" => "O seu dia de saque é: dia(s) $_cashout_days. Você só pode sacar nesses dias!"));
            return;
        }*/
        
        /**$diasemana_numero = date('w', time());
        if ($diasemana_numero != 4) {
            (new Json)->echoJson(array("success" => false, "message" => "O dia de saque é: quinta-feira. Você só pode sacar nesse dia!"));
            return;
        }*/
        
        // new donation pending
        /**$data__newDonations = (new Donations_up)->find(null, $accountData['_id'], null, null, null, null, null, 500, true);
        if (sizeof($data__newDonations) > 0) {
            (new Json)->echoJson(array("success" => false, "message" => "Você tem contrato pendente a fazer ou a pagar! O saque só é liberado após o pagamento dos contratos pendentes."));
            return;
        }*/
        
        /* if ($fee_percent <= 0.0) {
            (new Json)->echoJson(array("success" => false, "message" => "A taxa e dia de saque não esta definida para sua conta."));
            return;
        } */
        //$settings__daily_income = (float)str_replace(",",".",(new Settings)->findValue('daily_income'));
        //$fee_percent = 0.0;
        
        $service_fee = ($amount / 100) * $fee_percent;
        $net_amount = $amount - $service_fee;
        
        
        // (string)((float)((new Format)->clearNumber($_POST['amount']) / 100)),
        //$success = (new Cashout)->create($accountData['_id'], 'withdraw', $_POST['bank'], $amount, $service_fee, $net_amount, $_POST['history']);
        //$success = (new Cashout)->create($accountData['_id'], 'withdraw', '', $_POST['usd'], $amount, $service_fee, $net_amount, $_POST['history']);
        
        $insertDebit = (new Wallet)->create(
                'withdraw',
                $accountData['_id'],
                'WITHDRAWAL TO PERSONAL ACCOUNT',
                null,
                -$amount,
                $service_fee,
                $net_amount,
                ('USD WITHDRAWAL REQUEST TO COINBASE ACCOUNT: ' . $_POST['coinbase_email']),
                '',
                'pending'
            );
        
        if ($insertDebit) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Withdrawal request cannot be made."));
        }
    });
    
    $router->map('POST', '/v1/wallet/cancel', function(){
        $accountData = (new Accounts)->find(authGetUserId());
        $cashoutData = (new Cashout)->find($_POST['id']);
        if ($cashoutData['_accounts__id'] != $accountData['_id']) {
            if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
                (new Json)->echoJson(array("success" => false, "message" => "You do not have access to cancel!"));
                return;
            }
        }
        
        if ($_POST['id'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a request to be able to cancel!"));
            return;
        }
        
        // (string)((float)((new Format)->clearNumber($_POST['amount']) / 100)),
        $success = (new Cashout)->cancel($_POST['id']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Withdrawal request cannot be canceled."));
        }
    });
    
    $router->map('POST', '/v1/wallet/confirm', function(){
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            (new Json)->echoJson(array("success" => false, "message" => "You do not have access to confirm withdrawal request!"));
            return;
        }
        
        if ($_POST['id'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a request to be able to confirm!"));
            return;
        }
        
        // (string)((float)((new Format)->clearNumber($_POST['amount']) / 100)),
        $success = (new Cashout)->confirm($_POST['id'], $_POST['history']);
        if ($success) {
            $cashoutData = (new Cashout)->find($_POST['id']);
            $amount = $cashoutData['_amount'];
            
            $insert = (new Wallet)->create(
                    'withdraw',
                    $cashoutData['_accounts__id'],
                    'Withdrawal confirmation [ADMINISTRATOR]',
                    null,
                    -$amount,
                    0,
                    0,
                    $_POST['history_reply'],
                    '',
                    'effected'
                );
            
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Withdrawal confirmation cannot be performed."));
        }
    });
    
    /**
    $router->map('POST','/v1/accounts/setStatus/[i:_id]', function($_id){
        $success = (new Accounts)->setStatus($_id, $_POST['status']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false));
        }
    });
    **/
    
    $router->map('POST', '/v1/wallet/cashout/[i:id]/cancel', function($id){
        $accountData = (new Accounts)->find(authGetUserId());
        $cashoutData = (new Wallet)->find($id);
        if ($cashoutData['_accounts__id'] != $accountData['_id']) {
            if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
                (new Json)->echoJson(array("success" => false, "message" => "You do not have access to cancel!"));
                return;
            }
        }
        
        if ($id == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a request to be able to cancel!"));
            return;
        }
        
        $success = (new Wallet)->setStatus($id, 'canceled');
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Withdrawal request cannot be canceled."));
        }
    });
    
    $router->map('POST', '/v1/wallet/cashout/[i:id]/confirm', function($id){
        $accountData = (new Accounts)->find(authGetUserId());
        $cashoutData = (new Wallet)->find($id);
        
        if ($cashoutData['_accounts__id'] != $accountData['_id']) {
            if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
                (new Json)->echoJson(array("success" => false, "message" => "You do not have access to confirm withdrawals!"));
                return;
            }
        }
        
        if ($id == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a request in order to be confirmed!"));
            return;
        }
        
        $success = (new Wallet)->setConfirmed($id, $_POST['transaction_code']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Withdrawal request cannot be confirmed."));
        }
    });
    
    $router->map('DELETE', '/v1/wallet/cashout/[i:id]', function($id){
        $success = (new Wallet)->delete($id);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Withdrawal request cannot be deleted."));
        }
    });
    
    $router->map('POST','/v1/wallet/credit', function(){
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            (new Json)->echoJson(array("success" => false, "message" => "You do not have access to credit balance!"));
            return;
        }
        
        if ($_POST['id'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must inform a user to receive the value!"));
            return;
        }
        
        if ($_POST['type'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a type to be credited!"));
            return;
        }
        
        $_type = $_POST['type'];
        if ($_type != 'insertion' && $_type != 'credit' && $_type != 'bonus' && $_type != 'profit') {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a valid type to be credited!"));
            return;
        }
        
        if ($_POST['amount'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter an amount to be credited!"));
            return;
        }
        
        if ($_POST['description'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must report the history!"));
            return;
        }
        
        $accountReceiveData = (new Accounts)->find($_POST['id']);
        
        $amount = (new Format)->clearNumber($_POST['amount']);
        if ($amount != "") {
            $amount = (float)((int)$amount)/100;
        }
        
        $insert = (new Wallet)->create(
                $_type,
                $accountReceiveData['_id'],
                'Value [ADMINISTRATOR]',
                null,
                $amount,
                0,
                0,
                $_POST['description'],
                '',
                'effected'
            );
        
        (new Json)->echoJson(array("success" => true));
    });
    
    $router->map('POST','/v1/wallet/debit', function(){
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            (new Json)->echoJson(array("success" => false, "message" => "You do not have access to debit balance!"));
            return;
        }
        
        if ($_POST['id'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must inform a user to debit the amount!"));
            return;
        }
        
        if ($_POST['type'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a type to be debited!"));
            return;
        }
        
        $_type = $_POST['type'];
        if ($_type != 'withdraw' && $_type != 'tariff' && $_type != 'purchase' && $_type != 'debit') {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a valid type to be credited!"));
            return;
        }
        
        if ($_POST['amount'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter an amount to be debited!"));
            return;
        }
        
        if ($_POST['description'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must report the history!"));
            return;
        }
        
        $accountReceiveData = (new Accounts)->find($_POST['id']);
        
        $amount = (new Format)->clearNumber($_POST['amount']);
        if ($amount != "") {
            $amount = (float)((int)$amount)/100;
        }
        
        $insert = (new Wallet)->create(
                $_type,
                $accountReceiveData['_id'],
                'Value [ADMINISTRATOR]',
                null,
                -$amount,
                0,
                0,
                $_POST['description'],
                '',
                'effected'
            );
        
        (new Json)->echoJson(array("success" => true));
    });
    
    $router->map('POST','/v1/wallet/transfer', function(){
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
        
        
        if ($_POST['amount'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter an amount to transfer!"));
            return;
        }
        
        // check saldo
        //$walletTotal = (float)(new Wallet)->getBalanceFromAccountsID($account__id);
        $walletTotal = (float)(new Wallet)->getTotalBalanceFromAccountsID($account__id);
        $amount = (new Format)->clearNumber($_POST['amount']);
        if ($amount != "") {
            $amount = (float)((int)$amount)/100;
        }
        
        if ($walletTotal < $amount) {
            (new Json)->echoJson(array("success" => false, "message" => "Balance unavailable for requested transfer amount!"));
            return;
        }
        
        
        if ($_POST['to_username'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must inform a user to receive the value!"));
            return;
        }
        
        $accountReceiveData = (new Accounts)->accountsFromUsername($_POST['to_username']);
        if ($accountReceiveData['_username'] != $_POST['to_username']) {
            (new Json)->echoJson(array("success" => false, "message" => "The specified user was not found!"));
            return;
        }
        
        
        $amount = (new Format)->clearNumber($_POST['amount']);
        if ($amount != "") {
            $amount = (float)((int)$amount)/100;
        }
        
        $insertDebit = (new Wallet)->create(
                'debit',
                $account__id,
                'Tranference debit',
                null,
                -$amount,
                0,
                0,
                ('Transference to ' . $accountData['_name']),
                '',
                'effected'
            );
        
        $insertCredit = (new Wallet)->create(
                'credit',
                $accountReceiveData['_id'],
                'Transferece credit',
                null,
                $amount,
                0,
                0,
                ('Transference of ' . $accountReceiveData['_name']),
                '',
                'effected'
            );
        
        (new Json)->echoJson(array("success" => true));
    });
    
    /*
    $router->map('GET','/v1/ext/bankon/payment-process', function(){
        //$data = (new Categories)->find($_id, authGetUserId(), null);
        $data = (new BankOn)->bankonQueryTransaction((new Settings)->findValue('bankon__token_query'), trim($_GET['transacao']));
        $dataJson = json_decode($data, true);
        
        if ($dataJson['sucesso'] == true) {
            $transfer_to = $dataJson['Dados']['destino']['usuario'];
            
            // check receiver username
            if ($transfer_to != (new Settings)->findValue('bankon__main_username')) {
                (new Json)->echoJson(array("success" => false, "message" => 'Conta destino da transação informada não é válida: ' . $transfer_to));
            } else {
                // add transfer value to wallet
                if ((new Wallet)->transactionCheckCodeWasUsed($_GET['transacao']) == true) {
                    (new Json)->echoJson(array("success" => false, "message" => 'Código da transação já foi utilizado: ' . $_GET['transacao']));
                } else {
                    $accountData = (new Accounts)->find(authGetUserId());
                    $transactionData = $dataJson['Dados'];
                    
                    $insert = (new Wallet)->create(
                            'insertion',
                            $accountData['_id'],
                            'INSERÇÃO DE SALDO VIA BANKON',
                            null,
                            $transactionData['valor'],
                            'INSERÇÃO DE SALDO EM CONTA VIA BANKON || USUÁRIO ' . $transactionData['origem']['nome'] . ' [' . $transactionData['origem']['usuario'] . ']',
                            $_GET['transacao'],
                            'LIBERADO'
                        );
                    
                    (new Json)->echoJson(array("success" => true, "data" => $dataJson['Dados']));
                }
            }
        } else {
            (new Json)->echoJson(array("success" => false, "message" => $dataJson['message']));
        }
    });
    */
?>
