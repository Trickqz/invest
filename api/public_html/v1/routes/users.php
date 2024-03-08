<?php
    $router->map('GET','/v1/users', function(){
        $data = (new Users)->find(null, $_GET['q'], $_GET['status']);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('GET','/v1/users/[i:id]', function($_id){
        $data = (new Users)->find($_id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    
    $router->map('POST','/v1/users', function(){
        // Check E-mail
        if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
            (new Json)->echoJson(array("success" => false, "message" => "The email provided is invalid."));
            return;
        } else {
            $success_email = (new Accounts)->emailExists($_POST['email']);
            if ($success_email) {
                (new Json)->echoJson(array("success" => false, "message" => "The email provided is already in use."));
                return;
            }
        }
        
        $success_username = (new Accounts)->usernameExists($_POST['username']);
        if ($success_username) {
            (new Json)->echoJson(array("success" => false, "message" => "The username entered is already in use."));
            return;
        }
        
        
        $data_success = (new Users)->create($_POST['name'], $_POST['email'], $_POST['username'], $_POST['password'], $_POST['role']);
        if ($data_success) {
            $accounts_data = (new Accounts)->accountsFromEmail($_POST['email']);
            (new Logs)->create('Registration log', $accounts_data['_id'], USER_AGENT, CLIENT_IP, "New user registration (username: " . $_POST['username'] . ")");
            (new Json)->echoJson(array("success" => true, "message" => null, "data" => array("token" => $data_success)));
        } else {
            (new Logs)->create('Error log', null, USER_AGENT, CLIENT_IP, "New user registration (username: " . $_POST['username'] . ")");
            (new Json)->echoJson(array("success" => false, "message" => "Your account cannot be created."));
        }
    });
    
    $router->map('POST','/v1/users/[i:_id]/setStatus', function($_id){
        $success = (new Users)->setStatus($_id, $_POST['status']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false));
        }
    });
    $router->map('POST', '/v1/users/[i:id]', function($id){
        $success = (new Users)->updateUsers($id, $_POST['role'], $_POST['name'], $_POST['email'], $_POST['password']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "User update cannot be changed.."));
        }
    });
    
    $router->map('DELETE', '/v1/users/[i:id]', function($id){
        $uploadPathFile = str_replace("/api/v1/routes", "", dirname(__FILE__)) . '/uploads/accounts/img';
        
        unlink("$uploadPathFile/".$id);
        
        $success = (new Users)->delete($id);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "User account cannot be deleted."));
        }
    });
?>
