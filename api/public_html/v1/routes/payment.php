<?php
    $router->map('GET','/v1/categories', function(){
        $data = (new Categories)->find();
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/categories/[i:id]', function($_id){
        $data = (new Categories)->find($_id, authGetUserId(), null);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('POST', '/v1/categories', function(){
        $success = (new Categories)->create($_POST['name']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Category cannot be added."));
        }
    });
    $router->map('POST', '/v1/categories/[i:id]', function($id){
        $success = (new Categories)->update($id, $_POST['name']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Category cannot be changed."));
        }
    });
    $router->map('DELETE', '/v1/categories/[i:id]', function($id){
        $success = (new Categories)->delete($id);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "Category cannot be deleted."));
        }
    });
    
    
    /*$router->map('GET','/v1/export/categories/csv', function(){
        (new Categories)->exportCsv();
    });
    $router->map('GET','/v1/export/categories/xls', function(){
        (new Categories)->exportXls();
    });*/
?>
