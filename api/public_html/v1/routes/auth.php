<?php
    $router->map('POST','/v1/auth', function(){
        $maintenance_mode = (new Settings)->findValue('maintenance_mode');
        $block_register = (new Settings)->findValue('block_register');
        $accounts_data = (new Accounts)->accountsFromUsername($_POST['username']);
        
        /*if ($accounts_data['_role'] == 'user') {
            (new Logs)->create('Access log', null, USER_AGENT, CLIENT_IP, "Unauthorized access (username: " . $_POST['username'] . ")");
            (new Json)->echoJson(array("success" => false, "message" => "O acesso aos usuários não está liberado no momento. Estamos posicionando as doações já realizadas, estará disponível em breve!"), 401);
            return;
        }*/
        
        
        if ($maintenance_mode == 'true' && $accounts_data['_role'] != 'developer' && $accounts_data['_role'] != 'administrator') {
            (new Logs)->create('Access log', null, USER_AGENT, CLIENT_IP, "Unauthorized access (username: " . $_POST['username'] . ")");
            (new Json)->echoJson(array("success" => false, "message" => "The system is in maintenance mode. come back later."), 401);
        } else {
            $data_success = (new Accounts)->auth($_POST['username'], $_POST['password']);
            if ($data_success) {
                $accounts_data = (new Accounts)->accountsFromUsername($_POST['username']);
                (new Logs)->create('Access log', $accounts_data['_id'], USER_AGENT, CLIENT_IP, "System access (username: " . $_POST['username'] . ")");
                (new Json)->echoJson(array("success" => true, "message" => null, "data" => array("role" => $accounts_data['_role'], "token" => $data_success)));
            } else {
                (new Logs)->create('Access log', null, USER_AGENT, CLIENT_IP, "Unauthorized access (username: " . $_POST['username'] . ")");
                (new Json)->echoJson(array("success" => false, "message" => "The username and password you entered do not match our records. Check and try again."), 401);
            }
        }
    });
    $router->map('POST','/v1/auth/token', function(){
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            (new Json)->echoJson(array("success" => false, "message" => "You do not have permission to perform the action!"));
            return;
        }
        
        $accounts_data = (new Accounts)->accountsFromUsername($_POST['username']);
        
        $data_success = (new Accounts)->authToken($_POST['username']);
        if ($data_success) {
            $accounts_data = (new Accounts)->accountsFromUsername($_POST['username']);
            (new Logs)->create('Access log', $accounts_data['_id'], USER_AGENT, CLIENT_IP, "System access (username: " . $_POST['username'] . ")");
            (new Json)->echoJson(array("success" => true, "message" => null, "data" => array("role" => $accounts_data['_role'], "token" => $data_success)));
        } else {
            (new Logs)->create('Access log', null, USER_AGENT, CLIENT_IP, "Unauthorized access (username: " . $_POST['username'] . ")");
            (new Json)->echoJson(array("success" => false, "message" => "   ."), 401);
        }
    });
    $router->map('POST','/v1/auth/password/reset', function(){
        $username_exists = (new Accounts)->usernameExists($_POST['username']);
        if ($username_exists){
            $success = (new Accounts)->passwordReset($_POST['username']);
            if ($success) {
                (new Json)->echoJson(array("success" => true));
            } else {
                (new Json)->echoJson(array("success" => false, "message" => "Unable to send recovery code to your user."));
            }
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The user entered does not exist or is invalid."));
        }
    });
    $router->map('POST','/v1/auth/password/check-code', function(){
        $success = (new Accounts)->isValidRecoverCode($_POST['username'], $_POST['recover_code']);
        if ($success) {
            (new Json)->echoJson(array("success" => true));
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "The code entered is invalid.<br />Check the last code sent to your username and try again."));
        }
    });
    $router->map('POST','/v1/auth/password', function(){
        if ($_POST['recover_code']) {
            if ($_POST['password'] && $_POST['new_password']) {
                /* Recover code */
                $data = (new Accounts)->find(authGetUserId());
                
                $data_success = (new Accounts)->auth($data['_username'], $_POST['password']);
                if ($data_success) {
                    $accounts_data = (new Accounts)->accountsFromUsername($data['_username']);
                    $success = (new Accounts)->passwordUpdateNoRecoverCode($data['_username'], $_POST['new_password']);
                    if ($success) {
                        (new Logs)->create('Registration log', null, USER_AGENT, CLIENT_IP, "New password registration (username: " . $data['_username'] . ")");
                        (new Json)->echoJson(array("success" => true));
                    } else {
                        (new Logs)->create('Error log', null, USER_AGENT, CLIENT_IP, "Password change failed (username: " . $data['_username'] . ")");
                        (new Json)->echoJson(array("success" => false, "message" => "Unable to change your password."));
                    }
                } else {
                    (new Logs)->create('Error log', null, USER_AGENT, CLIENT_IP, "Password change failed (username: " . $data['_username'] . ")");
                    (new Json)->echoJson(array("success" => false, "message" => "Unable to change your password."));
                }
                /* End recover code */
            } else {
                $success = (new Accounts)->isValidRecoverCode($_POST['username'], $_POST['recover_code']);
                if ($success) {
                    $success = (new Accounts)->passwordUpdate($_POST['username'], $_POST['recover_code'], $_POST['password']);
                    if ($success) {
                        (new Logs)->create('Registration log', null, USER_AGENT, CLIENT_IP, "New password registration (username: " . $_POST['username'] . ")");
                        (new Json)->echoJson(array("success" => true));
                    } else {
                        (new Logs)->create('Error log', null, USER_AGENT, CLIENT_IP, "Password change failed (username: " . $_POST['username'] . ")");
                        (new Json)->echoJson(array("success" => false, "message" => "Unable to change your password."));
                    }
                } else {
                    (new Logs)->create('Error log', null, USER_AGENT, CLIENT_IP, "Password change failed (username: " . $_POST['username'] . ")");
                    (new Json)->echoJson(array("success" => false, "message" => "The code or username entered is invalid.<br />Check your username and the last code sent and try again."));
                }
            }
        } else {
            $accountData = (new Accounts)->find(authGetUserId());
            if ($_POST['username']) {
                if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
                    (new Json)->echoJson(array("success" => false, "message" => "You don't have access to perform the action!"));
                    return;
                }
                
                $success = (new Accounts)->passwordUpdate($_POST['username'], null, $_POST['new_password']);
                if ($success) {
                    (new Logs)->create('Registration log', null, USER_AGENT, CLIENT_IP, "New password registration (username: " . $_POST['username'] . ")");
                    (new Json)->echoJson(array("success" => true));
                } else {
                    (new Logs)->create('Error log', null, USER_AGENT, CLIENT_IP, "Password change failed (username: " . $_POST['username'] . ")");
                    (new Json)->echoJson(array("success" => false, "message" => "Unable to change your password."));
                }
            } else {
                $authOk = (new Accounts)->auth($accountData['_username'], $_POST['password']);
                if ($authOk) {
                    $success = (new Accounts)->passwordUpdate($accountData['_username'], null, $_POST['new_password']);
                    if ($success) {
                        (new Logs)->create('Registration log', null, USER_AGENT, CLIENT_IP, "New password registration (username: " . $_POST['username'] . ")");
                        (new Json)->echoJson(array("success" => true));
                    } else {
                        (new Logs)->create('Error log', null, USER_AGENT, CLIENT_IP, "Password change failed (username: " . $_POST['username'] . ")");
                        (new Json)->echoJson(array("success" => false, "message" => "Unable to change your password."));
                    }
                } else {
                    (new Logs)->create('Error log', null, USER_AGENT, CLIENT_IP, "Old password does not match (username: " . $_POST['username'] . ")");
                    (new Json)->echoJson(array("success" => false, "message" => "Old password does not match."));
                }
            }
        }
    });
?>
