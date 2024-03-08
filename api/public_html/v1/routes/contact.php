<?php
    $router->map('GET','/v1/contact', function(){
        $data = (new Contact)->find();
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/contact/[i:id]', function($_id){
        $data = (new Contact)->find($_id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('POST', '/v1/contact', function(){
        $success = (new Contact)->create($_POST['name'], $_POST['birthdate'], $_POST['sex'], $_POST['biography'], $_POST['participation'], $_POST['featured']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Contact cannot be added."));
        }
    });
    $router->map('POST','/v1/contact/setReaded/[i:_id]', function($_id){
        $success = (new Contact)->setReaded($_id, false);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false));
        }
    });
    $router->map('POST','/v1/contact/setAllReaded', function(){
        $success = (new Contact)->setReaded(null, true);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false));
        }
    });
    $router->map('DELETE', '/v1/contact/[i:id]', function($id){
        $success = (new Contact)->delete($id);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Contact cannot be deleted."));
        }
    });
    
    
    $router->map('GET','/v1/export/contact/csv', function(){
        (new Contact)->exportCsv();
    });
    $router->map('GET','/v1/export/contact/xls', function(){
        (new Contact)->exportXls();
    });
?>
