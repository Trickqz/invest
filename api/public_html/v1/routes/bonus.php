<?php
    $router->map('GET', '/v1/bonus', function(){
        /*$account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        $data = (new Bonus)->find(null, $_GET['date_of'], $_GET['date_until'], 'ASC ', 80);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/bonus/[i:id]', function($_id){
        $data = (new Bonus)->find($_id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    $router->map('POST', '/v1/bonus/[i:id]', function($id){
        $bid = (float)number_format(str_replace(",",".",(new Format)->clearNumberToFloat($_POST['bid'])), 2);
        
        $success = (new Bonus)->create($id, $bid);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Bonus cannot be changed."));
        }
    });
    
    $router->map('DELETE', '/v1/bonus/[i:id]', function($id){
        $success = (new Bonus)->delete($id);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Bonus cannot be deleted."));
        }
    });
?>
