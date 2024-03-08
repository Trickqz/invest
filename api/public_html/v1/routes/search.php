<?php
    $router->map('GET','/v1/search', function(){
        $data = (new Accounts)->findPublic(null, $_GET['q']);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
?>
