<?php
    $router->map('GET','/v1/points', function(){
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
        
        $data = (new Points)->find(null, $account__id, $_GET['date_of'], $_GET['date_until']);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/points/[i:id]', function($_id){
        $data = (new Points)->find($_id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('POST', '/v1/points', function(){
        $accounts = (new Accounts)->findByUsername($_POST['username']);
        if ($accounts) {
            $value = (new Format)->clearNumber($_POST['value']);
            if ($value != "") {
                $value = (float)((int)$value)/100;
            }
            
            $success2 = (new Points)->create($accounts['_id'], $_POST['type'], $_POST['binary_side'], $value, null, null, null, 'true');
            if ($success2) {
                (new Json)->echoJson(array("success" => true));
            } else {
                (new Json)->echoJson(array("success" => false, "message" => "Points cannot be added."));
            }
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Invalid username."));
        }
    });
    $router->map('DELETE', '/v1/points/[i:id]', function($id){
        $success = (new Points)->delete($id);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Points cannot be deleted."));
        }
    });
?>
