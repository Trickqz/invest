<?php
    $router->map('GET', '/v1/personal_income', function(){
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') {
            $accounts = (new Accounts)->findByUsername($_GET['q']);
            if ($accounts) {
                $data = (new Personal_income)->find(null, $accounts['_id'], $_GET['date_of'], $_GET['date_until'], $_GET['status'], 'DESC ', 150);
                (new Json)->echoJson(array("success" => true, "data" => $data));
            } else {
                $data = (new Personal_income)->find(null, null, $_GET['date_of'], $_GET['date_until'], $_GET['status'], 'DESC ', 150);
                (new Json)->echoJson(array("success" => true, "data" => $data));
            }
        } else {
            $data = (new Personal_income)->find(null, $accountData['_id'], $_GET['date_of'], $_GET['date_until'], $_GET['status'], 'DESC ', 150);
            (new Json)->echoJson(array("success" => true, "data" => $data));
        }
    });
?>
