<?php
    $router->map('POST','/v1/accounts/check-username-available', function(){
        $success = (new Accounts)->usernameExists($_POST['username']);
        if (!$success) {
            (new Json)->echoJson(array("success" => true, "is_available" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "is_available" => false, "message" => "The entered username is already in use."));
        }
    });
    $router->map('POST','/v1/accounts/check-email-available', function(){
        if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
            (new Json)->echoJson(array("success" => false, "message" => "The email provided is invalid."));
        } else {
            $success = (new Accounts)->emailExists($_POST['email']);
            if (!$success) {
                (new Json)->echoJson(array("success" => true, "is_available" => true));
            } else {
                (new Json)->echoJson(array("success" => false, "is_available" => false, "message" => "The email provided is already in use."));
            }
        }
    });
    $router->map('POST','/v1/accounts/check-indicator', function(){
        $username_exists = (new Accounts)->usernameExists($_POST['username']);
        if ($username_exists) {
            $data = (new Accounts)->accountsFromUsername($_POST['username']);
            
            $dataResponse = array(
                '_about_me' => $data['_about_me'],
                '_email' => $data['_email'],
                '_name' => $data['_name'],
                '_username' => $data['_username'],
                '_whatsapp' => $data['_whatsapp'],
                '_binary_key' => $data['_binary_key']
            );
            
            (new Json)->echoJson(array("success" => true, "data" => $dataResponse));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The reported indicator is invalid."));
        }
    });
    $router->map('POST','/v1/accounts/check-cpf-available', function(){
        if (!(new Validate)->isValidCPF($_POST['cpf'])) {
            (new Json)->echoJson(array("success" => false, "message" => "The CPF entered is invalid."));
        } else {
            $success = (new Accounts)->cpfExists(htmlspecialchars(strip_tags(preg_replace('/[^0-9]/', '', $_POST['cpf']))));
            if (!$success) {
                (new Json)->echoJson(array("success" => true));
            } else {
                (new Json)->echoJson(array("success" => false, "message" => "The CPF entered is already in use."));
            }
        }
    });
    $router->map('POST','/v1/accounts/check-cnpj-available', function(){
        if (!(new Validate)->isValidCNPJ($_POST['cnpj'])) {
            (new Json)->echoJson(array("success" => false, "message" => "The CNPJ entered is invalid."));
        } else {
            $success = (new Accounts)->cnpjExists(htmlspecialchars(strip_tags(preg_replace('/[^0-9]/', '', $_POST['cnpj']))));
            if (!$success) {
                (new Json)->echoJson(array("success" => true));
            } else {
                (new Json)->echoJson(array("success" => false, "message" => "The CNPJ informed is already in use."));
            }
        }
    });
    $router->map('GET','/v1/accounts', function(){
        $limit = (int)(new Format)->clearNumber($_GET['limit']);
        $after = (int)(new Format)->clearNumber($_GET['after']);
        
        
        ///$data = (new Accounts)->find(null, $_GET['q'], $_GET['status'], $_GET['limit'], $_GET['after']);
        $data = (new Accounts)->find(null, $_GET['q'], $_GET['status'], null);
        $dataReturn = array();
        $i = 0;
        foreach ($data as $item) {
            //if ($after <= 0 || (int)$item['_id'] >= $after) {
            if ($i >= $after) {
                $dataItem = $item;
                $dataItem["extra__data"] = array(
                    "binary" => array(
                        "active" => (new Accounts)->isActive($item['_id']),
                        "receiving" => (new Accounts)->binaryReceiving($item['_id']),
                    ),
                );
                
                if ($limit <= 0) {
                    array_push($dataReturn, $dataItem);
                } else {
                    if (sizeof($dataReturn) < $limit) {
                        array_push($dataReturn, $dataItem);
                    }
                }
            }
            
            $i++;
        }
        
        (new Json)->echoJson(array("success" => true, "data" => $dataReturn, "count" => sizeof($data)));
    });
    $router->map('GET','/v1/accounts/[i:id]', function($_id){
        $data = (new Accounts)->find($_id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('POST','/v1/accounts/get-username', function(){
        $username_exists = (new Accounts)->usernameExists($_POST['username']);
        if ($username_exists) {
            $data = (new Accounts)->accountsFromUsername($_POST['username']);
            
            $dataResponse = array(
                '_about_me' => $data['_about_me'],
                '_email' => $data['_email'],
                '_name' => $data['_name'],
                '_username' => $data['_username'],
                '_whatsapp' => $data['_whatsapp']
            );
            
            (new Json)->echoJson(array("success" => true, "data" => $dataResponse));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The reported indicator is invalid."));
        }
    });
    $router->map('POST','/v1/accounts', function(){
        $maintenance_mode = (new Settings)->findValue('maintenance_mode');
        $block_register = (new Settings)->findValue('block_register');
        
        if ($maintenance_mode == 'true' || $block_register == 'true') {
            (new Logs)->create('Access log', null, USER_AGENT, CLIENT_IP, "Unauthorized access (email: " . $_POST['email'] . ")");
            (new Json)->echoJson(array("success" => false, "message" => "New entries are currently blocked.<br />Check back later."), 401);
        } else {
            // Check CPF
            /* if (!(new Validate)->isValidCPF($_POST['cpf'])) {
                (new Json)->echoJson(array("success" => false, "message" => "O CPF informado é inválido."));
                return;
            } else {
                $success_cpf = (new Accounts)->cpfExists(htmlspecialchars(strip_tags(preg_replace('/[^0-9]/', '', $_POST['cpf']))));
                if ($success_cpf) {
                    (new Json)->echoJson(array("success" => false, "message" => "O CPF informado já está em uso."));
                    return;
                }
            } */
            
            /**
                type: natural_person
                name: Teste 1
                sex: masc
                birthdate: 1988-03-12
                cpf: 857.224.790-47
                cnpj: 
                mobile_phone: (27) 99506-2056
                email: iurybraun@hotmail.com
                username: teste1
                password: 123456
                sponsor: presidente
            */
            
            // Check E-mail
            if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
                (new Json)->echoJson(array("success" => false, "message" => "The email provided is invalid."));
                return;
            } else {
                $success_email = (new Accounts)->emailExists($_POST['email']);
                if ($success_email) {
                    (new Json)->echoJson(array("success" => false, "message" => "The email provided is already in use."));
                    return;
                }
            }
            
            $success_username = (new Accounts)->usernameExists($_POST['username']);
            if ($success_username) {
                (new Json)->echoJson(array("success" => false, "message" => "The username entered is already in use."));
                return;
            }
            
            
            // Next
            // $data_success = (new Accounts)->create($_POST['name'], $_POST['email'], $_POST['cpf'], $_POST['mobile_phone'], $_POST['password']);
            $dataIndicator = (new Accounts)->accountsFromUsername($_POST['sponsor']);
            if (!$dataIndicator) {
                (new Json)->echoJson(array("success" => false, "message" => "We didn't find your indicator and your account was not created."));
                return;
            }
            
            $data_success = (new Accounts)->create($dataIndicator['_id'], $_POST['type'], $_POST['name'], $_POST['sex'], $_POST['birthdate'], $_POST['cpf'], $_POST['cnpj'], $_POST['country_dial_code'], $_POST['country_phone_mask'], $_POST['country_iso2'], $_POST['country_name'], $_POST['mobile_phone'], $_POST['email'], $_POST['username'], $_POST['password']);
            if ($data_success) {
                
                /** **/
                if (OPENSUPPORTS_ENABLED == true) {
                    $url = OPENSUPPORTS_API_URL . '/user/signup';
                    
                    $fields = array(
                        'csrf_token' => '',
                        'csrf_userid' => '',
                        'captcha' => 'valid',
                        'name' => $_POST['name'],
                        'email' => $_POST['email'],
                        'password' => $_POST['password'],
                        'repeated-password' => $_POST['password']
                    );
                    
                    //$data_string = json_encode( $fields );
                    $curl = curl_init();
                    curl_setopt_array($curl, array(
                        CURLOPT_URL => $url,
                        CURLOPT_RETURNTRANSFER => true,
                        CURLOPT_ENCODING => "",
                        CURLOPT_MAXREDIRS => 10,
                        CURLOPT_TIMEOUT => 0,
                        CURLOPT_FOLLOWLOCATION => false,
                        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                        CURLOPT_CUSTOMREQUEST => "POST",
                        //CURLOPT_POSTFIELDS =>$data_string,
                        CURLOPT_POSTFIELDS =>$fields,
                        CURLOPT_HTTPHEADER => array(
                            //"Content-Type: application/json",
                            //'Content-Length: ' . strlen( $data_string ),
                            //"Authentication: " . $authentication__transaction
                        ),
                    ));
                    
                    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
                    curl_setopt($curl,CURLOPT_SSL_VERIFYHOST, FALSE);
                    
                    $response = curl_exec($curl);
                    $err = curl_error($curl);
                    
                    curl_close($curl);
                    
                    //return $response;
                }
                /** **/
                
                $accounts_data = (new Accounts)->accountsFromEmail($_POST['email']);
                (new Logs)->create('Registration log', $accounts_data['_id'], USER_AGENT, CLIENT_IP, "New user registration (username: " . $_POST['username'] . ")");
                (new Json)->echoJson(array("success" => true, "message" => null, "data" => array("token" => $data_success)));
            } else {
                (new Logs)->create('Error log', null, USER_AGENT, CLIENT_IP, "New user registration (username: " . $_POST['username'] . ")");
                (new Json)->echoJson(array("success" => false, "message" => "Your account cannot be created."));
            }
        }
    });
    
    $router->map('POST', '/v1/accounts/[i:id]', function($id){
        $success = (new Accounts)->updateCustomerProfile($id, $_POST['type'], $_POST['name'], $_POST['cpf'], $_POST['cnpj'], $_POST['birthdate'], $_POST['sex'], $_POST['email'], $_POST['country_dial_code'], $_POST['country_phone_mask'], $_POST['country_iso2'], $_POST['country_name'], $_POST['mobile_phone'], $_POST['coinbase_email'], $_POST['about_me']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Registration cannot be changed.."));
        }
    });
    $router->map('POST', '/v1/accounts/[i:id]/address', function($id){
        $success = (new Accounts)->updateCustomerAddress($id, $_POST['street'], $_POST['number'], $_POST['district'], $_POST['city'], $_POST['state'], $_POST['postal_code'], $_POST['complement']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Registration cannot be changed."));
        }
    });
    $router->map('POST', '/v1/accounts/[i:id]/bank', function($id){
        $success = (new Accounts)->updateCustomerBank($id, $_POST['bank_number'], $_POST['bank_name'], $_POST['agency_number'], $_POST['agency_digit'], $_POST['account_number'], $_POST['account_digit'], $_POST['operation'], $_POST['account_type'], $_POST['holder_doc'], $_POST['holder_name']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Registration cannot be changed."));
        }
    });
    $router->map('POST', '/v1/accounts/[i:id]/crypto-wallet', function($id){
        $success = (new Accounts)->updateCustomerCryptoWallet($id, $_POST['crypto_wallet']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Registration cannot be changed."));
        }
    });
    
    $router->map('GET', '/v1/accounts/profile', function(){
        $data = (new Accounts)->accountsFromEmail(authGetUserId());
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('POST','/v1/accounts/setStatus/[i:_id]', function($_id){
        $success = (new Accounts)->setStatus($_id, $_POST['status']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false));
        }
    });
    $router->map('POST','/v1/accounts/setChatBanned/[i:_id]', function($_id){
        $success = (new Accounts)->setChatBanned($_id, $_POST['chat_banned']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false));
        }
    });
    $router->map('POST', '/v1/account/joker/[i:_id]', function($_id){
        $accountData = (new Accounts)->find(authGetUserId());
        
        $_key = false;
        if ($_POST['key'] == 'true') {
            $_key = true;
        }
        
        $success = (new Accounts)->updateJoker($_id, $_key);
        if ($success) {
            $userData = (new Accounts)->find($_id);
            
            if ($_key == true) {
                (new Logs)->create('Alter joker account', $accountData['_id'], USER_AGENT, CLIENT_IP, "Setled joker account to user (username: " . $userData['_username'] . ")");
            } else {
                (new Logs)->create('Alter joker account', $accountData['_id'], USER_AGENT, CLIENT_IP, "Setled normal account to user (username: " . $userData['_username'] . ")");
            }
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Update not accomplished."));
        }
    });
    $router->map('POST', '/v1/account/validation/status/[i:_id]', function($_id){
        $success = (new Accounts)->updateAdminValidationStatus($_id, $_POST['status']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Update not accomplished."));
        }
    });
    $router->map('DELETE', '/v1/accounts/[i:id]', function($id){
        $uploadPathFile = str_replace("/api/v1/routes", "", str_replace('\\',  '/', dirname(__FILE__))) . '/uploads/accounts/img';
        
        unlink("$uploadPathFile/".$id);
        
        $success = (new Accounts)->delete($id);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "User account cannot be deleted."));
        }
    });
    
    
    /**
     * SESSION
     */
$router->map('GET', '/v1/session/account', function () {

        $data = (new Accounts)->find(authGetUserId());
        (new Accounts)->setLastAccess($data['_id']);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('POST', '/v1/session/account', function(){
        $data = (new Accounts)->find(authGetUserId());
        
        $success = (new Accounts)->session__update($data['_id'], $_POST['name'], $_POST['type'], $_POST['cnpj'], $_POST['cpf'], $_POST['birthdate'], $_POST['sex'], $_POST['coinbase_email'], $_POST['country_dial_code'], $_POST['country_phone_mask'], $_POST['country_iso2'], $_POST['country_name'], $_POST['mobile_phone'], $_POST['about_me']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The registration cannot be changed."));
        }
    });
    $router->map('POST', '/v1/session/account/address', function(){
        $data = (new Accounts)->find(authGetUserId());
        
        $success = (new Accounts)->updateAddress($data['_id'], $_POST['street'], $_POST['number'], $_POST['district'], $_POST['city'], $_POST['state'], $_POST['postal_code'], $_POST['complement']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The registration cannot be changed."));
        }
    });
    $router->map('POST', '/v1/session/account/bank', function(){
        $data = (new Accounts)->find(authGetUserId());
        
        $success = (new Accounts)->updateBank($data['_id'], $_POST['bank_number'], $_POST['bank_name'], $_POST['agency_number'], $_POST['agency_digit'], $_POST['account_number'], $_POST['account_digit'], $_POST['operation'], $_POST['account_type'], $_POST['holder__name'], $_POST['holder__doc']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The registration cannot be changed."));
        }
    });
    $router->map('POST', '/v1/session/account/crypto-wallet', function(){
        $data = (new Accounts)->find(authGetUserId());
        
        $success = (new Accounts)->updateCryptoWallet($data['_id'], $_POST['crypto_wallet'], $_POST['crypto_wallet_network']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The registration cannot be changed."));
        }
    });
    $router->map('POST', '/v1/session/account/profile/picture', function(){
        $data = (new Accounts)->find(authGetUserId());
        
        $success = (new Accounts)->updateProfilePicture($data['_id'], $_POST['picture_src']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Profile picture cannot be changed."));
        }
    });
    $router->map('POST', '/v1/session/account/terms/accept', function(){
        $data = (new Accounts)->find(authGetUserId());
        
        $_accept_terms = 'false';
        if ($_POST['accept'] == 'true') {
            $_accept_terms = 'true';
        }
        
        $success = (new Accounts)->updateTerms($data['_id'], $_accept_terms);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Acceptance of the term cannot be changed."));
        }
    });
    $router->map('POST', '/v1/session/account/setCashout_day', function(){
        $data = (new Accounts)->find(authGetUserId());
        
        $success = (new Accounts)->updateCashout_day($data['_id'], $_POST['cashout_day']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The withdrawal day cannot be changed."));
        }
    });
    $router->map('POST', '/v1/session/account/profileImage', function(){
        $data = (new Accounts)->find(authGetUserId());
        $id = $data['_id'];
        
        $_files_filename = $_FILES['_files']['name'];
        $uploadPathFile = str_replace("/api/v1/routes", "", str_replace('\\',  '/', dirname(__FILE__))) . '/uploads/accounts/img';
        
        unlink("$uploadPathFile/$id.jpg");
        move_uploaded_file($_FILES['_files']['tmp_name'], "$uploadPathFile/$id.jpg");
        
        (new Json)->echoJson(array("success" => true));
    });
    
    $router->map('GET','/v1/session/account/indicated', function(){
        $data = (new Accounts)->find(authGetUserId());
        $id = $data['_id'];
        
        $data = (new Accounts)->findIndicated($id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    
    $router->map('GET','/v1/session/account/unilevel/[*:username]/info', function($_username){
        $account = (new Accounts)->accountsFromUsername($_username);
        
        $data = (new Accounts)->findUnilevelInfo($account['_id']);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/session/account/binary/[*:username]/downline', function($_username){
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        /*if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        if (($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') && $_username == $accountData['_username']) {
            $account__id = 2;
        } else {
            $account = (new Accounts)->accountsFromUsername($_username);
            $account__id = $account['_id'];
        }
        
        $data = (new Accounts)->findBinary($account__id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/session/account/unilevel/[*:username]/downline', function($_username){
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        /*if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        if (($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') && $_username == $accountData['_username']) {
            $account__id = 2;
        } else {
            $account = (new Accounts)->accountsFromUsername($_username);
            $account__id = $account['_id'];
        }
        
        $data = (new Accounts)->findDirect($account__id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/session/account/unilevel/[*:username]/downline/grid', function($_username){
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        /*if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        if (($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') && $_username == $accountData['_username']) {
            $account__id = 2;
        } else {
            $account = (new Accounts)->accountsFromUsername($_username);
            $account__id = $account['_id'];
        }
        
        $accountsGrid = (new Accounts)->network__list($account__id, (new Settings)->findValue('network_downline_level'));
        $data = (new Accounts)->network__gen_grid($accountsGrid);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('POST', '/v1/session/account/binary/key', function(){
        $data = (new Accounts)->find(authGetUserId());
        
        $_key = 'left';
        if ($_POST['key'] == 'right') {
            $_key = 'right';
        }
        
        $success = (new Accounts)->updateBinaryKey($data['_id'], $_key);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Update not accomplished."));
        }
    });
    $router->map('POST', '/v1/session/account/validation/status', function(){
        $data = (new Accounts)->find(authGetUserId());
        $success = (new Accounts)->updateValidationStatus($data['_id'], $_POST['filename'], $_POST['status']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Update not accomplished."));
        }
    });
    
    
    $router->map('GET', '/v1/session/account/resume', function(){
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
        
        // accounts
        /**$dataAccounts = (new Accounts)->findOrderAndLimit(20, "DESC");
        $export_dataAccounts = array();
        
        $iAccounts = 0;
        foreach ($dataAccounts as $row)
        {
            if ($iAccounts < 20) {
                $export_dataAccounts[] = array(
                    "_name" => $row['_name'],
                    "_created_at" => $row['_created_at']
                );
            }
            
            $iAccounts++;
        }**/
        
        /**$dataDonations__count = (new Donations)->countFromAccountsID($id);
        $dataDonations__last = (new Donations)->findLast($id);
        if (!$dataDonations__last && $dataDonations__last['_status'] == 'paid') {
            $dataDonations__last = null;
        }
        
        $dataReceivements__count = (new Donations_queue)->countReceivementsFromAccountsID($id);
        $dataReceivements__last = (new Donations_queue)->lastQueueReceivementFromAccountsID($id);
        if (!$dataReceivements__last && $dataReceivements__last['_status'] == 'paid') {
            $dataReceivements__last = null;
        }*/
        
        /** **/
        $dataGrid = array();
        $break = false;
        $nextId = $row['_id'];
        while($break == false){
            $account = (new Accounts)->find($nextId);
            if ($account['_id'] > 0) {
                array_push($dataGrid, $account['_unilevel_id_master']);
                $nextId = $account['_unilevel_id_master'];
            } else {
                $break = true;
            }
        }
        
        $level = count($dataGrid);
        foreach ($dataGrid as $row2) {
            (new Network_grid)->create($level, $row2, $row['_indicator__accounts_id'], $row['_id']);
            $level--;
        }
        /** **/
        
        $lastQuotation = (new Quotations)->findLast();
        $lastIncome = (new Income)->getForCurrentDay();
        
        $data = array(
            "count" => array(
                "charges" => (new Coinbase_ins)->countAllWaiting($account__id),
                "accounts" => array(
                    "total" => (new Accounts)->countIndications($account__id),
                    "in_month" => (new Accounts)->countIndicationsLastMonth($account__id)
                ),
                "donations" => array(
                    "total" => (new Donations)->countTotalFromAccountsID($account__id),
                    "receiving" => (new Donations)->countTotalFromAccountsID($account__id, null, 'receiving')
                ),
                ///"donations" => $dataDonations__count,
                ///"receivements" => $dataReceivements__count
            ),
            /*"access" => array(
                "in_month" => (new Accounts)->countLastAccessInLastMonth(),
                "perc_in_month" => round(((new Accounts)->countLastAccessInLastMonth() / ((new Accounts)->count() / 100)), 2)
            ),*/
            "last" => array(
                "accounts" => $export_dataAccounts,
                ///"donation" => $dataDonations__last,
                ///"receivement" => $dataReceivements__last
            ),
            "wallet" => array(
                "balance" => array(
                    "total" => (new Wallet)->getBalanceFromAccountsID($account__id),
                    "blocked" => (new Wallet)->getBlockedBalanceFromAccountsID($account__id),
                    "month" => (new Wallet)->getBalanceInMonthFromAccountsID($account__id),
                ),
                "gain" => array(
                    "total" => (new Wallet)->getGainBalanceFromAccountsID($account__id),
                    "month" => (new Wallet)->getGainBalanceInMonthFromAccountsID($account__id)
                ),
                "reentry" => array(
                    "current_balance" => (new Wallet)->getBalanceFromAccountsID($account__id)
                ),
                "sponsorship" => array(
                    "current_balance" => (new Wallet)->getBalanceFromAccountsID($account__id)
                ),
                //"pending_withdrawals" => (new Cashout)->getAllWaitingBalance(),
                //OLD "total_entries" => (new Wallet)->getTotalBalance()
            ),
            "personal_income" => array(
                "available" => (new Personal_income)->getAvailableBalanceFromAccountsID($account__id),
                "blocked" => (new Personal_income)->getBlockedBalanceFromAccountsID($account__id)
            ),
            "chart" => array(
                //"created_at" => (new Accounts)->countChartCreatedAtLast15Days(),
                //"last_access" => (new Accounts)->countChartAccessLast15Days()
                //"indications_last15days" => (new Accounts)->countChartIndicationsLast15Days($id)
                "donations" => array(
                    "balance" => array(
                        "last30" => (new Donations)->new__countChartLast30($account__id),
                    ),
                ),
                "indications" => array(
                    "direct" => array(
                        "last30" => (new Accounts)->new__chartDirectLast30($account__id),
                    ),
                    "indirect" => array(
                        "in_yesterday" => (new Accounts)->new__countIndirectLast1Day($account__id),
                        "in_day" => (new Accounts)->new__countIndirectDay($account__id),
                        "last30" => (new Accounts)->new__chartIndirectLast30($account__id),
                    ),
                    "last15" => (new Accounts)->last15Accounts(),
                ),
                "income" => array(
                    "last30" => (new Income)->new__countChartLast30(),
                ),
                "quotations" => array(
                    "balance" => array(
                        "last30" => (new Quotations)->new__countChartLast30(),
                    ),
                ),
                "wallet" => array(
                    "balance" => array(
                        "last30" => (new Wallet)->new__sumChartLast30($account__id),
                    ),
                ),
            ),
            "quotations" => array(
                "open" => $lastQuotation['_open'],
                "bid" => $lastQuotation['_bid']
            ),
            "income" => array(
                "open" => $lastIncome['_open'],
                "bid" => $lastIncome['_bid']
            ),
            "donations" => array(
                "amount" => (New Donations)->sumReceivingTotalAmountFromAccountsID($account__id),
                "income" => (New Donations)->sumReceivingTotalAmountIncomeFromAccountsID($account__id),
                "received" => (New Donations)->sumReceivingTotalAmountReceivedFromAccountsID($account__id)
            ),
            "binary" => array(
                "left" => (new Points)->getBinaryBalanceFromAccountsID($account__id, 'left'),
                "right" => (new Points)->getBinaryBalanceFromAccountsID($account__id, 'right'),
                "gain" => (new Wallet)->getBinaryGainBalanceFromAccountsID($account__id),
                "active" => (new Accounts)->isActive($account__id),
                "receiving" => (new Accounts)->binaryReceiving($account__id),
                "totalLeft" => (new Points)->getBinaryBalanceFromAccountsID($account__id, 'left', false),
                "totalRight" => (new Points)->getBinaryBalanceFromAccountsID($account__id, 'right', false),
                "paid_pts" => (new Points)->sumBinaryPaidFromAccountsID($account__id),
            ),
        );
        
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    
    /*$router->map('GET','/v1/accounts/json', function(){
        $data = (new Accounts)->find();
        $dataReturn = array();
        foreach ($data as $item) {
            $name = '<a href="./usuario/' . $item['_id'] . '">' . $item['_name'] . '</a>';
            
            if ($item['_status'] == 'active') {
                $_status = '<span class="label label-xl label-rounded label-success">Ativo</span>';
            } else {
                $_status = '<span class="label label-xl label-rounded label-danger">Inativo</span>';
            }
            
            array_push($dataReturn, array($item['_id'], $name, (new Date)->formatDate($item['_created_at']), $_status));
        }
        
        (new Json)->echoJson(array("data" => $dataReturn));
    });*/
    
    /**
     * Logs
     */
    /*$router->map('GET','/v1/accounts/logs/[i:user__id]', function($user__id){
        if (CFG__ROLE == 'administrator') {
            $user__id = $user__id;
        } else {
            $user__id = CFG__ID;
        }
        
        $data = (new Logs)->find(null, $user__id, false);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    $router->map('GET','/v1/accounts/logs/json', function(){
        if (CFG__ROLE == 'administrator') {
            $user__id = null;
        } else {
            $user__id = CFG__ID;
        }
        
        $data = (new Logs)->findLikeAccounts(null, $user__id, 10000);
        $dataReturn = array();
        foreach ($data as $item) {
            array_push($dataReturn, array($item['_id'], $item['_type'], $item['accounts__name'], $item['_description'], (new Date)->formatDate($item['_created_at'])));
        }
        
        (new Json)->echoJson(array("data" => $dataReturn));
    });
    $router->map('GET','/v1/export/logs/csv', function(){
        (new Logs)->exportCsv();
    });
    $router->map('GET','/v1/export/logs/xls', function(){
        (new Logs)->exportXls();
    });*/
    
    $router->map('GET','/v1/export/accounts/csv', function(){
        (new Accounts)->exportCsv();
    });
    $router->map('GET','/v1/export/accounts/xls', function(){
        (new Accounts)->exportXls();
    });
?>
