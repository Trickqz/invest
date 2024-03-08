<?php
    $router->map('GET', '/v1/logs', function(){
        $accounts_data = (new Accounts)->accountsFromEmail($_GET['q']);
        if ($accounts_data) {
            $users__id = $accounts_data['_id'];
        } else {
            $users__id = null;
        }
        
        $data = (new Logs)->findLikeUsers(null, $users__id, $_GET['q'], $_GET['date_of'], $_GET['date_until']);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
?>
