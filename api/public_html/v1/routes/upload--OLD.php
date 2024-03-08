<?php
    /**
    $router->map('POST','/v1/upload/gen-key', function(){
        //$data = (new Settings)->findAllAsJson();
        
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        /*if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        //if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
        //    (new Json)->echoJson(array("success" => false));
        //} else {
    /**
        if ($accountData != null) {
            $data = (new Neo7i__spaces)->genKey($accountData['_username'], $_POST['path'], $_POST['permission'], $accountData['_role']);
            (new Json)->echoJson(array("success" => true, "data" => $data));
        }
    });
    */
?>
