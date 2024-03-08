<?php
    $router->map('GET', '/v1/bonification', function(){
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') {
            $accounts = (new Accounts)->findByUsername($_GET['q']);
            if ($accounts) {
                $data = (new Wallet)->find(null, $accounts['_id'], $_GET['date_of'], $_GET['date_until'], 'profit', $_GET['status'], 'DESC', 200);
                (new Json)->echoJson(array("success" => true, "data" => $data));
            } else {
                $data = (new Wallet)->find(null, '*', $_GET['date_of'], $_GET['date_until'], 'profit', $_GET['status'], 'DESC', 200);
                (new Json)->echoJson(array("success" => true, "data" => $data));
            }
        } else {
            $data = (new Wallet)->find(null, $accountData['_id'], $_GET['date_of'], $_GET['date_until'], 'profit', $_GET['status'], 'DESC', 200);
            (new Json)->echoJson(array("success" => true, "data" => $data));
        }
    });
?>
