<?php
    $router->map('GET', '/v1/donations_model', function(){
        /*$account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        $data = (new Donations_model)->find(null, $_GET['type'], $_GET['status'], 'ASC ', 500);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/donations_model/[i:id]', function($_id){
        $data = (new Donations_model)->find($_id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    /*$router->map('GET', '/v1/donations_model1', function(){
        /*
        if (ob_get_level() == 0) ob_start();
        
        $x = 10;
        while($x <= 23) {
            (new Donations_model)->create(
                    'CONTRATO<br />#'.$x,
                    $x*100,
                    0,
                    '<div>Contrato de 10 meses</div>',
                    $x,
                    ($x*100)*2,
                    'plan',
                    'true'
                );
            $x++;
            
            ob_flush();
            flush();
            sleep(1);
        }
        
        ob_end_flush();
        */
        
    /*    $success = (new Donations_model)->create($_POST['name'], $_POST['amount'], $_POST['fee'], $_POST['description'], $_POST['donations'], $_POST['income'], $_POST['type'], $_POST['active']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "O modelo não pode ser adicionado."));
        }
    });*/
    
    $router->map('POST', '/v1/donations_model', function(){
        $amount = (new Format)->clearNumber($_POST['amount']);
        if ($amount != "") {
            $amount = (float)((int)$amount)/100;
        }
        
        $fee = (new Format)->clearNumber($_POST['fee']);
        if ($fee != "") {
            $fee = (float)((int)$fee)/100;
        }
        
        $income = (new Format)->clearNumber($_POST['income']);
        if ($income != "") {
            $income = (float)((int)$income)/100;
        }
        
        $success = (new Donations_model)->create($_POST['name'], $_POST['description'], $_POST['contracts'], $amount, $fee, $income);  //$_POST['type']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Template cannot be added."));
        }
    });
    $router->map('POST', '/v1/donations_model/[i:id]', function($id){
        $amount = (new Format)->clearNumber($_POST['amount']);
        if ($amount != "") {
            $amount = (float)((int)$amount)/100;
        }
        
        $fee = (new Format)->clearNumber($_POST['fee']);
        if ($fee != "") {
            $fee = (float)((int)$fee)/100;
        }
        
        $income = (new Format)->clearNumber($_POST['income']);
        if ($income != "") {
            $income = (float)((int)$income)/100;
        }
        
        $success = (new Donations_model)->update($id, $_POST['name'], $_POST['description'], $_POST['contracts'], $amount, $fee, $income);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The model cannot be changed."));
        }
    });
    $router->map('POST', '/v1/donations_model/[i:_id]/setStatus', function($_id){
        $success = (new Donations_model)->setStatus($_id, $_POST['status']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false));
        }
    });
    $router->map('DELETE', '/v1/donations_model/[i:id]', function($id){
        $success = (new Donations_model)->delete($id);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The package cannot be deleted."));
        }
    });
?>
