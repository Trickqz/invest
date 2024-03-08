<?php
    $router->map('GET', '/v1/income', function(){
        /*$account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        $data = (new Income)->find(null, $_GET['date_of'], $_GET['date_until'], 'DESC ', 50);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET', '/v1/income/requests', function(){
        /*$account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        $data = (new Personal_income_requests)->findLastPub($_GET['account_id']);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/income/[i:id]', function($_id){
        $data = (new Income)->find($_id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    $router->map('GET','/v1/income/spoon', function(){
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
        
        
        // DONATIONS
        $dataDonations = (new Donations)->find(null, '('.$account__id.')');
        $export_dataDonations = array();
        
        //$iDonations = 0;
        $countContracts = 0;
        $amount = 0;
        $income = 0;
        $received = 0;
        foreach ($dataDonations as $row)
        {
            if ($row['_status'] == 'receiving') {
                $export_dataDonations[] = array(
                    "_amount" => $row['_amount'],
                    "_income" => $row['_income'],
                    "_received" => $row['_received']
                );
                
                  $amount += $row['_amount'];
                  $income += $row['_income'];
                  $received += $row['_received'];
                  
                  $countContracts += $row['_contracts'];
            }
            
            //$iDonations++;
        }
        
        $lastIncome = (new Income)->findLastLimitTime();
        if ($lastIncome) {
            $lastValue = $lastIncome['_bid'];
        } else {
            $lastValue = 0;
        }
        
        $data = array(
            "income" => $lastValue,
            "donations" => array(
                "count" => $countContracts,
                "amount" => $amount,
                "income" => $income,
                "received" => $received
            ),
            "to_receive" => ($amount/100.0)*$lastValue
        );
        
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    $router->map('POST','/v1/income/spoon', function(){
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        /*if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        //if ($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') {
        //    $account__id = 0;
        //} else {
            $account__id = $accountData['_id'];
        //}
        
        
        // CHECK JOKER ACCOUNT
        if ($accountData['_joker_account'] == true) {
            (new Json)->echoJson(array("success" => false, "message" => "Your account cannot generate income."));
            return;
        }
        
        
        // CHECK DAY SPOON
        $personalIncome = (new Personal_income)->getForCurrentDay($account__id);
        if ($personalIncome != null) {
            (new Json)->echoJson(array("success" => false, "message" => "Have you generated your income for today."));
            return;
        }
        
        // INCOME
        $lastIncome = (new Income)->findLastLimitTime();
        if ($lastIncome) {
            $bid = $lastIncome['_bid'];
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "There is no percentage released for income generation!"));
            return;
        }
        
        // DONATIONS
        $dataDonations = (new Donations)->find(null, '('.$account__id.')');
        
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
        
        if ($received == 0) {
            (new Json)->echoJson(array("success" => false, "message" => "There is no value in income to generate today."));
            return;
        }
        
        (new Personal_income)->create($account__id, $countContracts, (float)$bid, $received);
        
        
        /*$bytes = openssl_random_pseudo_bytes(32);
        $hash = base64_encode($bytes);
        (new Wallet)->create(
                'profit',
                $account__id,
                'RENDIMENTO',
                $donationData['_id'],
                $received,
                0,
                0,
                'GERAÇÃO DE RENDIMENTO PACOTE/COTAS',
                $hash,
                'blocked'
            );*/
        
        $data = array(
            "income" => (float)$bid,
            "received" => $received
        );
        
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    $router->map('GET', '/v1/income/spoon/requests', function(){
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
        
        
        $blocked = (new Personal_income)->getBlockedBalanceFromAccountsID($account__id);
        $available = (new Personal_income)->getAvailableBalanceFromAccountsID($account__id);
        
        $data = array(
            "blocked" => $blocked,
            "available" => $available,
            "total" => $blocked + $available
        );
        
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    $router->map('POST','/v1/income/spoon/requests', function(){
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        /*if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        //if ($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') {
        //    $account__id = 0;
        //} else {
            $account__id = $accountData['_id'];
        //}
        
        
        //$blocked = (new Personal_income)->getBlockedBalanceFromAccountsID($account__id);
        $available = (new Personal_income)->getAvailableBalanceFromAccountsID($account__id);
        
        if ($available <= 0) {
            (new Json)->echoJson(array("success" => false, "message" => "There is no value to be released for help request!"));
            return;
        }
        
        (new Personal_income_requests)->create($account__id, $available);
        (new Personal_income)->setEffected($account__id);
        
        $data = array(
            "value" => $available
        );
        
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    $router->map('GET', '/v1/income/spoon/resume', function(){
        /*$account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            (new Json)->echoJson(array("success" => false));
            return;
        }*/
        
        $personal_income_requests_value = (new Personal_income_requests)->findPendingValue();
        //(new Json)->echoJson(array("success" => true, "data" => array("value" => (int)((float)$personal_income_requests_value*100))));
        (new Json)->echoJson(array("success" => true, "data" => array("value" => $personal_income_requests_value)));
    });
    
    $router->map('POST', '/v1/income/spoon/pay', function(){
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            (new Json)->echoJson(array("success" => false));
            return;
        }
        
        if ($_POST['amount'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter an amount to be credited!"));
            return;
        }
        
        $amount = (new Format)->clearNumber($_POST['amount']);
        if ($amount != "") {
            $amount = (float)((int)$amount)/100;
        }
        
        if ($_POST['amount'] == "") {
            (new Json)->echoJson(array("success" => false, "message" => "You must enter a valid amount to be credited!"));
            return;
        }
        
        
        $totalValue = $amount;
        $accountDataOrigin = (new Accounts)->find(5);
        
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
                    (new Wallet)->create('purchase', $accountDataOrigin['_id'], 'Balance generated', null, -$amountToPay, 0, 0, ('Balance generated from gain, to ' . $accountData['_name'] . ' [' . $accountData['_username'] . ']'), $hash, 'effected');
                    (new Wallet)->create('credit', $personal_income_requests[$i]['_accounts__id'], 'Balance generated', null, $amountToPay, 0, 0, ('Balance generated from gain, from ' . $accountDataOrigin['_name'] . ' [' . $accountDataOrigin['_username'] . ']'), $hash, 'effected');
                    
                    (new Personal_income_requests)->setReceived($personal_income_requests[$i]['_id'], $amountToPay);
                    
                    $totalValue -= $amountToPay;
                }
            }
        }
            
        (new Json)->echoJson(array("success" => true));
    });
    
    $router->map('POST','/v1/income', function(){
        $lastIncome = (new Income)->findLast();
        if ($lastIncome) {
            $lastValue = $lastIncome['_bid'];
        } else {
            $lastValue = 0;
        }
        
        $bid = (float)number_format(str_replace(",",".",(new Format)->clearNumberToFloat($_POST['bid'])), 2);
        
        $success = (new Income)->create($lastValue, $bid, $_POST['date']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Quote cannot be added."));
        }
    });
    
    $router->map('POST', '/v1/income/[i:id]', function($id){
        $bid = (float)number_format(str_replace(",",".",(new Format)->clearNumberToFloat($_POST['bid'])), 2);
        
        $success = (new Income)->create($id, $bid);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The quote cannot be changed."));
        }
    });
    
    $router->map('DELETE', '/v1/income/[i:id]', function($id){
        $success = (new Income)->delete($id);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Quote cannot be deleted."));
        }
    });
?>
