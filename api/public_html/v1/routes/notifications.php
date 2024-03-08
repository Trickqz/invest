<?php
    $router->map('GET','/v1/accounts/notifications', function(){
        $data = (new Notifications)->find(null, authGetUserId(), $_GET['read'], $_GET['order']);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/accounts/notifications/[i:id]', function($_id){
        $data = (new Notifications)->find($_id, authGetUserId(), null);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('POST','/v1/accounts/notifications/[i:_id]/setRead', function($_id){
        $success = (new Notifications)->setRead($_id, authGetUserId(), false);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false));
        }
    });
    $router->map('POST','/v1/accounts/notifications/setAllRead', function(){
        $success = (new Notifications)->setRead(null, authGetUserId(), true);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false));
        }
    });
    
    
    $router->map('POST', '/v1/notifications', function(){
        //(new Notifications)->create('info', $_POST['_subject'], $_POST['_message']);
        
        if ($_POST['to'] != '*') {
            $accounts = (new Accounts)->findByUsername($_POST['to']);
            if ($accounts) {
                if ($_POST['content'] == "" && $_POST['img_src'] == "") {
                    (new Json)->echoJson(array("success" => true, "message" => "Content or image is empty."));
                }
                
                (new Notifications)->create($accounts['_id'], $_POST['type'], $_POST['display_type'], $_POST['subject'], $_POST['content'], $_POST['img_src']);
            } else {
                (new Json)->echoJson(array("success" => false, "message" => "Notifications cannot be sent."));
            }
        } else {
            if ($_POST['content'] == "" && $_POST['img_src'] == "") {
                (new Json)->echoJson(array("success" => true, "message" => "Content or image is empty."));
            }
            
            $accounts = (new Accounts)->find();
            foreach ($accounts as $item) {
                (new Notifications)->create($item['_id'], $_POST['type'], $_POST['display_type'], $_POST['subject'], $_POST['content'], $_POST['img_src']);
            }
        }
        
        (new Json)->echoJson(array("success" => true, "message" => "Notifications sent."));
    });
?>
