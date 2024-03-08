<?php
    $router->map('GET','/v1/quotations/[i:id]', function($_id){
        $data = (new Quotation)->find($_id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
?>
