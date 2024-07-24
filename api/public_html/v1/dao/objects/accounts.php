<?php
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/php-jwt/src/BeforeValidException.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/php-jwt/src/ExpiredException.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/php-jwt/src/SignatureInvalidException.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/php-jwt/src/JWT.php';
use \Firebase\JWT\JWT;

require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/Encoder.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/Flags.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/Context.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/Token.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/Parser.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/Validator.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/Partial.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/Expression.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/Exporter.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/Compiler.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/SafeString.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/LightnCandy.php';
require_once str_replace("/dao/objects", "", str_replace('\\',  '/', dirname(__FILE__))) . '/vendor/lightncandy/src/Runtime.php';
use LightnCandy\LightnCandy;
use LightnCandy\Runtime;
use LightnCandy\SafeString;

//require_once './class/class.string.validate.php';


class Accounts {
    private $conn;
    private $table_name = "accounts";
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    // emailExists() method will be here
    // check if given email exist in the database
    public function emailExists($args_email){
        $qry = "SELECT *
                FROM " . $this->table_name . " 
                WHERE _email = :args_email 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_email', htmlspecialchars(strip_tags($args_email)));
        $data = $this->conn->resultSet();
        
        if (count($data) > 0){
            return true;
        }
        
        return false;
    }
    
    public function usernameExists($args_username){
        $qry = "SELECT *
                FROM " . $this->table_name . " 
                WHERE _username = :args_username
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_username', $args_username);
        $data = $this->conn->resultSet();
        
        if (count($data) > 0){
            return true;
        }
        
        return false;
    }
    
    public function cpfExists($args_cpf){
        $qry = "SELECT *
                FROM " . $this->table_name . " 
                WHERE _cpf = :args_cpf
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_cpf', htmlspecialchars(strip_tags(preg_replace('/[^0-9]/', '', $args_cpf))));
        $data = $this->conn->resultSet();
        
        if (count($data) > 0){
            return true;
        }
        
        return false;
    }
    
    public function cnpjExists($args_cnpj){
        $qry = "SELECT *
                FROM " . $this->table_name . " 
                WHERE _cnpj = :args_cnpj
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_cnpj', htmlspecialchars(strip_tags(preg_replace('/[^0-9]/', '', $args_cnpj))));
        $data = $this->conn->resultSet();
        
        if (count($data) > 0){
            return true;
        }
        
        return false;
    }
    
    public function isValidRecoverCode($args_username, $args_recover_code){
        $qry = "SELECT *
                FROM " . $this->table_name . " 
                WHERE _username = :args_username AND _recover_code = :args_recover_code 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_username', htmlspecialchars(strip_tags($args_username)));
        $this->conn->bind(':args_recover_code', htmlspecialchars(strip_tags($args_recover_code)));
        $data = $this->conn->resultSet();
        
        if (count($data) > 0){
            return true;
        }
        
        return false;
    }
    
    public function accountsFromEmail($args_email){
        $qry = "SELECT *
                FROM " . $this->table_name . " 
                WHERE _email = :args_email 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_email', $args_email);
        return $this->conn->single();
    }
    
    public function accountsFromUsername($args_username){
        // $qry = "SELECT *
        //         FROM " . $this->table_name . " 
        //         WHERE _username = :args_username 
        //         LIMIT 0,1";

        $qry = "SELECT
            a.*,
            a._id,
            a.`_name`,
            a.`_username`,
            a._indicator__accounts_id,
            s._username as _sponsorname
        FROM " . $this->table_name . " a
        LEFT JOIN " . $this->table_name . " s
        ON a._indicator__accounts_id = s.`_id` 
        WHERE a._username = :args_username
        LIMIT 0,1";  
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_username', $args_username);
        return $this->conn->single();
    }
    
    public function accountsIdFromEmail($args_email){
        $qry = "SELECT *
                FROM " . $this->table_name . " 
                WHERE _email = :args_email 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_email', $args_email);
        $data = $this->conn->single();
        return $data['_id'];
    }
    
    
    
    
    
    // create() method will be here
    // create new user record
    public function create($args_indicator_id, $args_type, $args_name, $args_sex, $args_birthdate, $args_cpf, $args_cnpj, $args_country_dial_code, $args_country_phone_mask, $args_country_iso2, $args_country_name, $args_mobile_phone, $args_email, $args_username, $args_password, $args_role = "user", $args_status = "active"){
        // Validate
        /*if (!isValidCPF($args_cpf)) {
            return_json(array("success" => false, "message" => "O CPF informado é inválido."));
            return;
        }
        if ($this->cpfExists($this->_cpf)) {
            return_json(array("success" => false, "message" => "O CPF informado já está em uso."));
            return;
        }
        if ($this->emailExists($this->_email)) {
            return_json(array("success" => false, "message" => "O e-mail informado já está em uso."));
            return;
        }*/
        
        
        // query
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _hash = :args_hash, 
                    _type = :args_type, 
                    _binary_id_master = :args_binary_id_master, 
                    _binary_side = :args_binary_side, 
                    _unilevel_id_master = :args_indicator_id, 
                    _indicator__accounts_id = :args_indicator_id, 
                    _name = :args_name, 
                    _sex = :args_sex, 
                    _birthdate = :args_birthdate, 
                    _cpf = :args_cpf, 
                    _cnpj = :args_cnpj, 
                    _country_dial_code = :args_country_dial_code, 
                    _country_phone_mask = :args_country_phone_mask, 
                    _country_iso2 = :args_country_iso2, 
                    _country_name = :args_country_name, 
                    _mobile_phone = :args_mobile_phone, 
                    _email = :args_email, 
                    _username = :args_username, 
                    _password = :args_password, 
                    _role = :args_role, 
                    _status = :args_status";
        
        /** **/
        $binary_key = 'left';
        $accounts = (new Accounts)->find($args_indicator_id);
        if ($accounts) {
            $binary_key = $accounts['_binary_key'];
        }
        
        //$accountsGrid = (new Accounts)->network_binary__find_bin_ind($accounts['_id'], $binary_key, 9999);
        //$binary_id_master = $accountsGrid[1];
        $newBinaryMasterId = (new Accounts)->network_binary__upline_by_side($accounts['_id'], $binary_key);
        $binary_id_master = $newBinaryMasterId;
        if ($binary_id_master <= 0) {
            return null;
        }
        /** **/
        
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_hash', newMD5Hash());
        $this->conn->bind(':args_type', $args_type);
        $this->conn->bind(':args_binary_id_master', $binary_id_master);
        $this->conn->bind(':args_binary_side', $binary_key);
        $this->conn->bind(':args_indicator_id', $args_indicator_id);
        $this->conn->bind(':args_name', $args_name);
        $this->conn->bind(':args_sex', $args_sex);
        $this->conn->bind(':args_birthdate', date("Y-m-d H:i:s",strtotime(str_replace('/','-',$args_birthdate))));
        $this->conn->bind(':args_cpf', htmlspecialchars(strip_tags(preg_replace('/[^0-9]/', '', (new Format)->clearNumber($args_cpf)))));
        $this->conn->bind(':args_cnpj', htmlspecialchars(strip_tags(preg_replace('/[^0-9]/', '', (new Format)->clearNumber($args_cnpj)))));
        $this->conn->bind(':args_country_dial_code', $args_country_dial_code);
        $this->conn->bind(':args_country_phone_mask', $args_country_phone_mask);
        $this->conn->bind(':args_country_iso2', $args_country_iso2);
        $this->conn->bind(':args_country_name', $args_country_name);
        $this->conn->bind(':args_mobile_phone', (new Format)->clearNumber($args_mobile_phone));
        $this->conn->bind(':args_email', $args_email);
        $this->conn->bind(':args_username', $args_username);
        $this->conn->bind(':args_role', $args_role);
        $this->conn->bind(':args_status', $args_status);
        
        // hash the password before saving to database
        $password_hash = password_hash($args_password, PASSWORD_BCRYPT);
        $this->conn->bind(':args_password', $password_hash);
        
        // execute the query, also check if query was successful
        if ($this->conn->execute()) {
            $system_emails_data = (new System_emails)->findObject('accounts__register_completed');
            $template = $system_emails_data['_content'];
            $phpStr = LightnCandy::compile($template);
            $renderer = LightnCandy::prepare($phpStr);
            $content = $renderer(array(
                    'username' => $args_username,
                    'date' => date("d/m/Y h:i:s"),
                    'name' => $args_name,
                    'telegram' => (new Settings)->findValue('social__telegram'),
                    'whatsapp' => (new Settings)->findValue('social__whatsapp'),
                    'instagram' => (new Settings)->findValue('social__instagram'),
                    'facebook' => (new Settings)->findValue('social__facebook'),
                    'youtube' => (new Settings)->findValue('social__youtube'),
                    'twitter' => (new Settings)->findValue('social__twitter')
                ));
            
            (new Mailer)->send($args_email, $args_name, $system_emails_data['_subject'], $content, $content);
            
            // auto login
            $accounts_data = $this->accountsFromUsername($args_username);
            
            // Generate jwt will be here
            // Check if email exists and if password is correct
            if (password_verify($args_password, $accounts_data['_password'])){
                /*$token = array(
                   "iss" => JWT_ISS,
                   "aud" => JWT_AUD,
                   "iat" => JWT_IAT,
                   "nbf" => JWT_NBF,
                   "data" => array(
                       "_id" => $accounts_data['_id'],
                       "name" => $accounts_data['_name'],
                       "username" => $accounts_data['_username'],
                       "email" => $accounts_data['_email'],
                       "role" => $accounts_data['_role']
                   )
                );*/
                
                $my_date_time = date('Y-m-d H:i:s', strtotime('now +3 hour'));
                $datetime = new DateTime($my_date_time);
                
                $token = array(
                    "username" => $accounts_data['_username'],
                    "sub" => $accounts_data['_username'],
                    "role" => $accounts_data['_role'],
                    "droplet" => "",
                    "exp" => $datetime->getTimestamp()
                );
                
                $jwt = JWT::encode($token, (new Settings)->findValue('jwt__key'));
                //return_json(array("success" => true, "message" => null, "data" => array("jwt" => $jwt)));
                return $jwt;
            } else {
                //return_json(array("success" => false, "message" => "O email e a senha que você digitou não correspondem aos nossos registros. Verifique e tente novamente."), 401);
                return null;
            }
        } else {
            //return_json(array("success" => false, "message" => "Sua conta não pode ser criada."), 401);
            return null;
        }
    }
     
    // usernameExists() method will be here
    // check if given username exist in the database
    public function auth($args_username, $args_password){
        $username_exists = $this->usernameExists($args_username);
        $accounts_data = $this->accountsFromUsername($args_username);
        
        // Generate jwt will be here
        // Check if username exists and if password is correct
        if ($username_exists && password_verify($args_password, $accounts_data['_password'])){
            /*$token = array(
               "iss" => (new Settings)->findValue('jwt__iss'),
               "aud" => (new Settings)->findValue('jwt__aud'),
               "iat" => (new Settings)->findValue('jwt__iat'),
               "nbf" => (new Settings)->findValue('jwt__nbf'),
               "data" => array(
                   "_id" => $accounts_data['_id'],
                   "name" => $accounts_data['_name'],
                   "username" => $accounts_data['_username'],
                   "email" => $accounts_data['_email'],
                   "role" => $accounts_data['_role']
               )
            );*/
            
            $my_date_time = date('Y-m-d H:i:s', strtotime('now +3 hour'));
            $datetime = new DateTime($my_date_time);
            
            $token = array(
                "username" => $accounts_data['_username'],
                "sub" => $accounts_data['_username'],
                "role" => $accounts_data['_role'],
                "droplet" => "",
                "exp" => $datetime->getTimestamp()
            );
            
            $jwt = JWT::encode($token, (new Settings)->findValue('jwt__key'));
            return $jwt;
        } else {
            // OLD PASSWORD
            if (sha1(md5($args_password)) == $accounts_data['_password']) {
                /*$token = array(
                   "iss" => (new Settings)->findValue('jwt__iss'),
                   "aud" => (new Settings)->findValue('jwt__aud'),
                   "iat" => (new Settings)->findValue('jwt__iat'),
                   "nbf" => (new Settings)->findValue('jwt__nbf'),
                   "data" => array(
                       "_id" => $accounts_data['_id'],
                       "name" => $accounts_data['_name'],
                       "username" => $accounts_data['_username'],
                       "email" => $accounts_data['_email'],
                       "role" => $accounts_data['_role']
                   )
                );*/
                
                $my_date_time = date('Y-m-d H:i:s', strtotime('now +3 hour'));
                $datetime = new DateTime($my_date_time);
                
                $token = array(
                    "username" => $accounts_data['_username'],
                    "sub" => $accounts_data['_username'],
                    "role" => $accounts_data['_role'],
                    "droplet" => "",
                    "exp" => $datetime->getTimestamp()
                );
                
                $jwt = JWT::encode($token, (new Settings)->findValue('jwt__key'));
                return $jwt;
            } else {
                return null;
            }
        }
    }
    
    public function authToken($args_username){
        $username_exists = $this->usernameExists($args_username);
        $accounts_data = $this->accountsFromUsername($args_username);
        
        // Generate jwt will be here
        // Check if username exists and if password is correct
        if ($username_exists){
            /*$token = array(
               "iss" => (new Settings)->findValue('jwt__iss'),
               "aud" => (new Settings)->findValue('jwt__aud'),
               "iat" => (new Settings)->findValue('jwt__iat'),
               "nbf" => (new Settings)->findValue('jwt__nbf'),
               "data" => array(
                   "_id" => $accounts_data['_id'],
                   "name" => $accounts_data['_name'],
                   "email" => $accounts_data['_email'],
                   "role" => $accounts_data['_role']
               )
            );*/
            
            $my_date_time = date('Y-m-d H:i:s', strtotime('now +3 hour'));
            $datetime = new DateTime($my_date_time);
            
            $token = array(
                "username" => $accounts_data['_username'],
                "sub" => $accounts_data['_username'],
                "role" => $accounts_data['_role'],
                "droplet" => "",
                "exp" => $datetime->getTimestamp()
            );
            
            $jwt = JWT::encode($token, (new Settings)->findValue('jwt__key'));
            return $jwt;
        } else {
            return null;
        }
    }
    
    public function passwordReset($args_username){
        $username_exists = $this->usernameExists($args_username);
        $accounts_data = $this->accountsFromUsername($args_username);
        
        // Check if email exists and if password is correct
        if ($username_exists){
            // Generate and update _recover_code
            $code = str_pad(mt_rand(1, 999999), 6, 0, STR_PAD_LEFT);
            $qry_up = "UPDATE " . $this->table_name . "
                    SET
                        _recover_code = :args_recover_code 
                    WHERE _id = :args_id";
         
            $this->data = $this->conn->query($qry_up);
            $this->conn->bind(':args_recover_code', $code);
            $this->conn->bind(':args_id', $accounts_data['_id']);
            
            if ($this->conn->execute()){
                $system_emails_data = (new System_emails)->findObject('accounts__password_reset');
                $template = $system_emails_data['_content'];
                $phpStr = LightnCandy::compile($template);
                $renderer = LightnCandy::prepare($phpStr);
                $content = $renderer(array(
                        'name' => $accounts_data['_name'],
                        'code' => $code,
                        'telegram' => (new Settings)->findValue('social__telegram'),
                        'whatsapp' => (new Settings)->findValue('social__whatsapp'),
                        'instagram' => (new Settings)->findValue('social__instagram'),
                        'facebook' => (new Settings)->findValue('social__facebook'),
                        'youtube' => (new Settings)->findValue('social__youtube'),
                        'twitter' => (new Settings)->findValue('social__twitter')
                    ));
                
                
                (new Mailer)->send($accounts_data['_email'], $accounts_data['_name'], $system_emails_data['_subject'], $content, $content);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    
    public function passwordUpdate($args_username, $args_recover_code, $args_password){
        $username_exists = $this->usernameExists($args_username);
        $accounts_data = $this->accountsFromUsername($args_username);
        
        // Check if username exists and if password is correct
        if ($username_exists){
            $accountData = (new Accounts)->find(authGetUserId());
            if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
                if ($accountData['_username'] != $args_username && $this->isValidRecoverCode($args_username, $args_recover_code) == false) {
                    return false;
                }
            }
            
            
            $qry_up = "UPDATE " . $this->table_name . "
                    SET
                        _recover_code = :args_recover_code, 
                        _password = :args_password 
                    WHERE _id = :args_id";
            
            // hash the password before saving to database
            $password_hash = password_hash($args_password, PASSWORD_BCRYPT);
            
            $this->data = $this->conn->query($qry_up);
            $this->conn->bind(':args_recover_code', null);
            $this->conn->bind(':args_password', $password_hash);
            $this->conn->bind(':args_id', $accounts_data['_id']);
            
            if ($this->conn->execute()){
                /*$system_emails_data = (new System_emails)->findObject('accounts__password_changed');
                $template = $system_emails_data['_content'];
                $phpStr = LightnCandy::compile($template);
                $renderer = LightnCandy::prepare($phpStr);
                $content = $renderer(array(
                        'username' => $accounts_data['_username'],
                        'date' => date("d/m/Y h:i:s"),
                        'name' => $accounts_data['_name'],
                        //'code' => $code,
                        'telegram' => (new Settings)->findValue('social__telegram'),
                        'whatsapp' => (new Settings)->findValue('social__whatsapp'),
                        'instagram' => (new Settings)->findValue('social__instagram'),
                        'facebook' => (new Settings)->findValue('social__facebook'),
                        'youtube' => (new Settings)->findValue('social__youtube'),
                        'twitter' => (new Settings)->findValue('social__twitter')
                    ));
                
                (new Mailer)->send($accounts_data['_email'], $accounts_data['_name'], $system_emails_data['_subject'], $content, $content);
                return true;*/
                
                
                $system_emails_data = (new System_emails)->findObject('accounts__password_changed');
                $template = $system_emails_data['_content'];
                $phpStr = LightnCandy::compile($template);
                $renderer = LightnCandy::prepare($phpStr);
                $content = $renderer(array(
                        'username' => $accounts_data['_username'],
                        'date' => (string)date("d/m/Y h:i:s"),
                        'name' => $accounts_data['_name'],
                        //'code' => $code,
                        'telegram' => (new Settings)->findValue('social__telegram'),
                        'whatsapp' => (new Settings)->findValue('social__whatsapp'),
                        'instagram' => (new Settings)->findValue('social__instagram'),
                        'facebook' => (new Settings)->findValue('social__facebook'),
                        'youtube' => (new Settings)->findValue('social__youtube'),
                        'twitter' => (new Settings)->findValue('social__twitter')
                    ));
                
                (new Mailer)->send($accounts_data['_email'], $accounts_data['_name'], $system_emails_data['_subject'], $content, $content);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    
    public function passwordUpdateNoRecoverCode($args_username, $args_password){
        $username_exists = $this->usernameExists($args_username);
        $accounts_data = $this->accountsFromUsername($args_username);
        
        // Check if username exists and if password is correct
        if ($username_exists){
            $qry_up = "UPDATE " . $this->table_name . "
                    SET
                        _password = :args_password 
                    WHERE _id = :args_id";
            
            // hash the password before saving to database
            $password_hash = password_hash($args_password, PASSWORD_BCRYPT);
            
            $this->data = $this->conn->query($qry_up);
            $this->conn->bind(':args_password', $password_hash);
            $this->conn->bind(':args_id', $accounts_data['_id']);
            
            if ($this->conn->execute()){
                $system_emails_data = (new System_emails)->findObject('accounts__password_changed');
                $template = $system_emails_data['_content'];
                $phpStr = LightnCandy::compile($template);
                $renderer = LightnCandy::prepare($phpStr);
                $content = $renderer(array(
                        'username' => $accounts_data['_username'],
                        'date' => date("d/m/Y h:i:s"),
                        'name' => $accounts_data['_name'],
                        //'code' => $code,
                        'telegram' => (new Settings)->findValue('social__telegram'),
                        'whatsapp' => (new Settings)->findValue('social__whatsapp'),
                        'instagram' => (new Settings)->findValue('social__instagram'),
                        'facebook' => (new Settings)->findValue('social__facebook'),
                        'youtube' => (new Settings)->findValue('social__youtube'),
                        'twitter' => (new Settings)->findValue('social__twitter')
                    ));
                
                
                (new Mailer)->send($accounts_data['_email'], $accounts_data['_name'], $system_emails_data['_subject'], $content, $content);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    
    
    
    
    
    public function find($args_id = null, $args_q = null, $args_status = '', $args_limit = 9999, $args_after = null)
    {
        if ($args_id) {
            // $qry = "SELECT * 
            //     FROM " . $this->table_name . " 
            //     WHERE 
            //         _id = :args_id 
            //     LIMIT 0,1";

            $qry = "SELECT";
            $qry.= " a.*,";
            $qry.= " a._id,";
            $qry.= " a.`_name`,";
            $qry.= " a.`_username`,";
            $qry.= " a._indicator__accounts_id,";
            $qry.= " s._username as _sponsorname";
            $qry.= " FROM " . $this->table_name . " a";
            $qry.= " LEFT JOIN " . $this->table_name . " s";
            $qry.= " ON";
            $qry.= " a._indicator__accounts_id = s.`_id`"; 
            $qry.= " WHERE";
            $qry.= " a._id = :args_id";
            $qry.= " LIMIT 0,1";  

        } else if ($args_q) {
            $qry = "SELECT * 
                FROM " . $this->table_name . "
                WHERE 
                    _role != 'developer' AND 
                    (_name LIKE '%$args_q%' OR _username LIKE '%$args_q%' OR _email LIKE '%$args_q%')";
            
            if ($args_status != '*' && $args_status != '') {

                var_dump($args_status);

                if($args_status === 'kyc') {
                    $qry .= " AND _verification_status = 'validating'";
                }else{
                    $qry .= " AND _status = :args_status";
                }
               
            }

            $qry .= " AND (_role = 'user' OR _role = 'customer')";
            
            if ($args_after != null) {
                $qry .= " AND _id > :args_after";
            }
            
            if ($args_limit != null) {
                $qry .= " LIMIT 0,$args_limit";
            }
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name . "
                WHERE
                    _role != 'developer'";
            
            if ($args_status != '*' && $args_status != '') {

                if($args_status === 'kyc') {
                    $qry .= " AND _verification_status = 'validating'";
                }else{
                    $qry .= " AND _status = :args_status";
                }
            }
            
            $qry .= " AND (_role = 'user' OR _role = 'customer')";
            
            if ($args_after != null) {
                $qry .= " AND _id > :args_after";
            }
            
            if ($args_limit != null) {
                $qry .= " LIMIT 0,$args_limit";
            }

            // $qry = "SELECT";
            //     $qry.= " a.*,";
            //     $qry.= " a._id,";
            //     $qry.= " a.`_name`,";
            //     $qry.= " a.`_username`,";
            //     $qry.= " a._indicator__accounts_id,";
            //     $qry.= " s._username as _sponsorname";
            //     $qry.= " FROM accounts a";
            //     $qry.= " LEFT JOIN accounts s";
            //     $qry.= " ON";
            //     $qry.= " a._indicator__accounts_id = s.`_id`"; 
        }
        
        /* $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            return $this->conn->single();
        } else {
            return $this->conn->resultSet();
        } */
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            
            $data = $this->conn->single();
            
            $walletTotal = (float)(new Wallet)->getBalanceFromAccountsID($data['_id']);
            $data['_wallet__ballance'] = number_format($walletTotal, 2, "." ,"");
            
            if ($data['_accept_terms'] == "true") {
                $data['_accept_terms'] = true;
            } else {
                $data['_accept_terms'] = false;
            }
            
            if ($data['_verified'] == "true") {
                $data['_verified'] = true;
            } else {
                $data['_verified'] = false;
            }
            
            if ($data['_joker_account'] == "true") {
                $data['_joker_account'] = true;
            } else {
                $data['_joker_account'] = false;
            }
            
            //$receivedTotal = (float)(new Donations)->getReceivedFromAccountsID($data['_id']);
            //$data['_received__ballance'] = number_format($receivedTotal, 2, "." ,"");
            
            $data['_contracts__ballance'] = (new Donations)->countTotalFromAccountsID($data['_id'], false);
            //$data['_contracts__ballance_extra'] = (new Donations)->countTotalFromAccountsID($data['_id'], true);
            
            return $data;
        } else {
            if ($args_status != '*' && $args_status != '') {
                $this->conn->bind(':args_status', $args_status);
            }
            if ($args_after != null) {
                $this->conn->bind(':args_after', $args_after);
            }
            $data = $this->conn->resultSet();
            $dataReturn = array();
            foreach ($data as $item) {
                $walletTotal = (float)(new Wallet)->getBalanceFromAccountsID($item['_id']);
                $item['_wallet__ballance'] = number_format($walletTotal, 2, "." ,"");
                
                //$receivedTotal = (float)(new Donations)->getReceivedFromAccountsID($item['_id']);
                //$item['_received__ballance'] = number_format($receivedTotal, 2, "." ,"");
                
                $_contracts__ballance = (new Donations)->countTotalFromAccountsID($item['_id'], 'false');
                if ($_contracts__ballance == null) {
                    $_contracts__ballance = 0;
                }
                //$_contracts__ballance_extra = (new Donations)->countTotalFromAccountsID($item['_id'], 'true');
                //if ($_contracts__ballance_extra == null) {
                //    $_contracts__ballance_extra = '*';
                //}
                
                $item['_contracts__ballance'] = $_contracts__ballance;
                //$item['_contracts__ballance_extra'] = $_contracts__ballance_extra;
                
                if ($item['_accept_terms'] == "true") {
                    $item['_accept_terms'] = true;
                } else {
                    $item['_accept_terms'] = false;
                }
                
                if ($item['_verified'] == "true") {
                    $item['_verified'] = true;
                } else {
                    $item['_verified'] = false;
                }
                
                if ($item['_joker_account'] == "true") {
                    $item['_joker_account'] = true;
                } else {
                    $item['_joker_account'] = false;
                }
                
                array_push($dataReturn, $item);
            }
            
            return $dataReturn;
        }
    }
    
    public function findByUsername($args_username = null)
    {
        $qry = "SELECT * 
            FROM " . $this->table_name . " 
            WHERE 
                _username = :args_username 
            LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_username', $args_username);
        $data = $this->conn->single();
        return $data;
    }
    
    public function findPublic($args_id = null, $args_q = null, $args_limit = 50)
    {
        if ($args_id) {
            $qry = "SELECT _id, _type, _username, _name, _email, _sex, _phone, _mobile_phone, _address_city, _address_state, _picture_src, _created_at, _status 
                FROM " . $this->table_name . " 
                WHERE 
                    _id = :args_id 
                LIMIT 0,1";
        } else if ($args_q) {
            $qry = "SELECT _id, _type, _username, _name, _email, _sex, _phone, _mobile_phone, _address_city, _address_state, _picture_src, _created_at, _status 
                FROM " . $this->table_name . "
                WHERE 
                    (_role != 'developer' AND _role != 'administrator') AND 
                    (_name LIKE '%$args_q%' OR _username LIKE '%$args_q%' OR _email LIKE '%$args_q%')";
            
            if ($args_limit != null) {
                $qry .= " LIMIT 0,$args_limit";
            }
        } else {
            $qry = "SELECT _id, _type, _username, _name, _email, _sex, _phone, _mobile_phone, _address_city, _address_state, _picture_src, _created_at, _status 
                FROM " . $this->table_name . "
                WHERE
                    (_role != 'developer' AND _role != 'administrator')";
            
            if ($args_limit != null) {
                $qry .= " LIMIT 0,$args_limit";
            }
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            return $this->conn->single();
        } else {
            return $this->conn->resultSet();
        }
    }
    
    public function bonificate($args_contracts_up_id = null, $args_unilevel_id_master = null, $arrUpLine = array())
    {
        // array upline
        $arr1 = $arrUpLine;
        
        // get donation_up
        $donation_up = (new Donations_up)->find($args_contracts_up_id);
        $account_donation_up = (new Accounts)->find($donation_up['_accounts__id']);
        
        
        // get user
        $qry = "SELECT * 
            FROM " . $this->table_name . " 
            WHERE 
                _id = :args_id 
            LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        if ($args_unilevel_id_master != null) {
            $this->conn->bind(':args_id', $args_unilevel_id_master);
        } else {
            $this->conn->bind(':args_id', $donation_up['_accounts__id']);
        }
        $data = $this->conn->single();
        
        if ($data['_unilevel_id_master'] != null && (int)$data['_unilevel_id_master'] > 0) {
            array_push($arr1, (int)$data['_unilevel_id_master']);
            $this->bonificate($args_contracts_up_id, $data['_unilevel_id_master'], $arr1);
        } else {
            /**
             * BONIFICATE
             * 
             * Indicação direta 6% - Para ter direito, a pessoa tem que ter no mínimo 5 contratos ativos ou um plano de 500 reais
             * Unilevel  - Para receber 2 nível tem que ter 2 diretos e a soma dos 2 tem que dar 10 contratos
             * 
             * 2º ao 5º nivel recebe 2%
             * 6º ao 7º nivel recebe 1%
             * 8º ao 11º nivel recebe 0,5%
             * 12º++ nivel recebe 0,01%
             * 
             * 
             * trava 2º ao 8º nivel:
             * 2º nível - 2 diretos, 10 contratos (nível * 5)
             * 
             * após 6º nível requer 1 contrato a mais por nível, até o 12º nível, participa infinito
             * 
             */
            
            //$userData1 = (new Accounts)->find($donation_up['_accounts__id']);
            //$upLineArr = (new Accounts)->findUpLine($donation_up['_accounts__id']);
            
            for($i = 0; $i <= sizeof($arrUpLine); $i++){
                if ($arrUpLine[$i] != null && $arrUpLine[$i] > 1 ) {
                    $hash = newMD5Hash();
                    
                    $account = (new Accounts)->find($arrUpLine[$i]);
                    $donations_sum = (new Donations_up)->countTotalAndTotalAmount($arrUpLine[$i]);
                    $directs_contracts_sum = (new Donations_up)->countDirectsTotalAndTotalAmount($arrUpLine[$i]);
                    $account_directs = (new Accounts)->findDirect($arrUpLine[$i]);
                    
                    $level = $i+1;
                    if ($level == 1) {
                        // 5 contratos ou plano de 500
                        if ($donations_sum[2] >= 500) {
                            $perc_gain = 6.0;
                            
                            if ($account['_status'] == 'active') {
                                (new Wallet)->create(
                                        'bonus',
                                        $account['_id'],
                                        'BÔNUS INDICAÇÃO DIRETA',
                                        null,
                                        ($donation_up['_amount'] / 100)*$perc_gain,
                                        0,
                                        0,
                                        'INDICAÇÃO DIRETA - CONTRATO #'.$donation_up['_id'].' DE '.$account_donation_up['_name'],
                                        $hash,
                                        'effected'
                                    );
                            }
                        }
                    }
                    if ($level >= 2 && $level <= 5) {
                        if (sizeof($account_directs) >= $level && $donations_sum[2] >= 500 && $directs_contracts_sum[1] >= ($level*2)) {
                            $perc_gain = 2.0;
                            
                            if ($account['_status'] == 'active') {
                                (new Wallet)->create(
                                        'bonus',
                                        $account['_id'],
                                        'BÔNUS INDICAÇÃO INDIRETA, NÍVEL '.$level,
                                        null,
                                        ($donation_up['_amount'] / 100)*$perc_gain,
                                        0,
                                        0,
                                        'INDICAÇÃO INDIRETA - CONTRATO #'.$donation_up['_id'].' DE '.$account_donation_up['_name'],
                                        $hash,
                                        'effected'
                                    );
                            }
                        }
                    }
                    if ($level == 6 || $level == 7) {
                        if ($level == 6) {
                            $inc_donation_amount = 100;
                        } else if ($level == 7) {
                            $inc_donation_amount = 200;
                        }
                        
                        if (sizeof($account_directs) >= $level && $donations_sum[2] >= (500+$inc_donation_amount) && $directs_contracts_sum[1] >= ($level*2)) {
                            $perc_gain = 1.0;
                            
                            if ($account['_status'] == 'active') {
                                (new Wallet)->create(
                                        'bonus',
                                        $account['_id'],
                                        'BÔNUS INDICAÇÃO INDIRETA, NÍVEL '.$level,
                                        null,
                                        ($donation_up['_amount'] / 100)*$perc_gain,
                                        0,
                                        0,
                                        'INDICAÇÃO INDIRETA - CONTRATO #'.$donation_up['_id'].' DE '.$account_donation_up['_name'],
                                        $hash,
                                        'effected'
                                    );
                            }
                        }
                    }
                    if ($level == 8 || $level == 11) {
                        if ($level == 8) {
                            $inc_donation_amount = 300;
                        } else if ($level == 9) {
                            $inc_donation_amount = 400;
                        } else if ($level == 10) {
                            $inc_donation_amount = 500;
                        } else if ($level == 11) {
                            $inc_donation_amount = 600;
                        }
                        
                        if (sizeof($account_directs) >= $level && $donations_sum[2] >= (500+$inc_donation_amount) && $directs_contracts_sum[1] >= ($level*2)) {
                            $perc_gain = 0.5;
                            
                            if ($account['_status'] == 'active') {
                                (new Wallet)->create(
                                        'bonus',
                                        $account['_id'],
                                        'BÔNUS INDICAÇÃO INDIRETA, NÍVEL '.$level,
                                        null,
                                        ($donation_up['_amount'] / 100)*$perc_gain,
                                        0,
                                        0,
                                        'INDICAÇÃO INDIRETA - CONTRATO #'.$donation_up['_id'].' DE '.$account_donation_up['_name'],
                                        $hash,
                                        'effected'
                                    );
                            }
                        }
                    }
                    if ($level >= 12) {
                        // 12 contratos ou plano de 1200
                        if ($donations_sum[2] >= 1200) {
                            $perc_gain = 0.01;
                            
                            if ($account['_status'] == 'active') {
                                (new Wallet)->create(
                                        'bonus',
                                        $account['_id'],
                                        'BÔNUS INDICAÇÃO INDIRETA, NÍVEL '.$level,
                                        null,
                                        ($donation_up['_amount'] / 100)*$perc_gain,
                                        0,
                                        0,
                                        'INDICAÇÃO INDIRETA - CONTRATO #'.$donation_up['_id'].' DE '.$account_donation_up['_name'],
                                        $hash,
                                        'effected'
                                    );
                            }
                        }
                    }
                    
                    //var_dump(array($account['_id'], $i+1));
                }
            }
            
            // test:
            // 10 -> 3 -> 2 -> 1 end
        }
    }
    
    public function findIndicated($args_indicator__accounts_id = null, $args_limit = 1000)
    {
        $qry = "SELECT * 
            FROM " . $this->table_name . "
            WHERE
                _indicator__accounts_id = :args_indicator__accounts_id";
        
        if ($args_limit != null) {
            $qry .= " LIMIT 0,$args_limit";
        }
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        $data = $this->conn->resultSet();
        /*$dataReturn = array();
        foreach ($data as $item) {
            //$walletTotal = (float)(new Wallet)->getBalanceFromAccountsID($item['_id']);
            //$item['_wallet__ballance'] = $walletTotal;
            $item['_contracts__balance'] = "*";
            
            array_push($dataReturn, $item);
        }*/
        
        return $data;
    }
    
    
    public function findUnilevelInfo($args_accounts_id = null)
    {
        $qry = "SELECT * 
            FROM " . $this->table_name . "
            WHERE
                _id = :args_id 
                AND _id != 0";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_accounts_id);
        $data = $this->conn->single();
        
        $dataReturn = array(
            '_id' => $data['_id'],
            '_name' => $data['_name'],
            '_username' => $data['_username'],
            '_count_direct' => $this->countDirect($data['_id'])
        );
        
        return $dataReturn;
    }
    
    public function findDirect($args_indicator__accounts_id = null)
    {
        $qry = "SELECT * 
            FROM " . $this->table_name . "
            WHERE
                _unilevel_id_master = :args_unilevel_id_master 
                AND _unilevel_id_master != 0";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_unilevel_id_master', $args_indicator__accounts_id);
        $data = $this->conn->resultSet();
        
        $dataReturn = array();
        foreach ($data as $item) {
            $item_return = array(
                '_id' => $item['_id'],
                '_name' => $item['_name'],
                '_username' => $item['_username'],
                '_mobile_phone' => $item['_mobile_phone'],
                '_email' => $item['_email'],
                '_address_state' => $item['_address_state'],
                '_address_city' => $item['_address_city'],
                '_count_direct' => $this->countDirect($item['_id']),
                '_count_contracts' => (new Donations)->countTotalFromAccountsID($item['_id'], false),
                '_active' => (new Accounts)->isActive($item['_id']),
                '_receiving' => (new Accounts)->binaryReceiving($item['_id']),
                '_picture_src' => $item['_picture_src'],
                '_created_at' => $item['_created_at']
            );
            
            array_push($dataReturn, $item_return);
        }
        
        return $dataReturn;
    }
    
    public function findBinary($args_indicator__accounts_id = null)
    {
        $qry = "SELECT * 
            FROM " . $this->table_name . "
            WHERE
                _binary_id_master = :args_binary_id_master 
                AND _binary_id_master != 0 
                ORDER BY _binary_side";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_binary_id_master', $args_indicator__accounts_id);
        $data = $this->conn->resultSet();
        
        $dataReturn = array();
        foreach ($data as $item) {
            $item_return = array(
                '_id' => $item['_id'],
                '_binary_side' => $item['_binary_side'],
                '_name' => $item['_name'],
                '_username' => $item['_username'],
                '_mobile_phone' => $item['_mobile_phone'],
                '_email' => $item['_email'],
                '_address_state' => $item['_address_state'],
                '_address_city' => $item['_address_city'],
                '_count_direct' => $this->countBinary($item['_id']),
                '_count_contracts' => (new Donations)->countTotalFromAccountsID($item['_id'], false),
                '_active' => (new Accounts)->isActive($item['_id']),
                '_receiving' => (new Accounts)->binaryReceiving($item['_id']),
                '_picture_src' => $item['_picture_src'],
                '_created_at' => $item['_created_at']
            );
            
            array_push($dataReturn, $item_return);
        }
        
        return $dataReturn;
    }
    
    public function countDirect($args_unilevel_id_master)
    {
        $qry = "SELECT COUNT(*) AS count 
                FROM " . $this->table_name . " 
                WHERE 
                    _unilevel_id_master = :args_unilevel_id_master 
                    AND _unilevel_id_master != 0";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_unilevel_id_master', $args_unilevel_id_master);
        $result = $this->conn->single();
        return (int)$result['count'];
    }
    
    public function countBinary($args_binary_id_master)
    {
        $qry = "SELECT COUNT(*) AS count 
                FROM " . $this->table_name . " 
                WHERE 
                    _binary_id_master = :args_binary_id_master 
                    AND _binary_id_master != 0";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_binary_id_master', $args_binary_id_master);
        $result = $this->conn->single();
        return (int)$result['count'];
    }
    
    
    /**public function findFreeBinaryPOS($args_binary_id_master, $binary_side)
    {
        $binary_side = 'left';
        $accounts = (new Accounts)->findByUsername($args_indicator_id);
        if ($accounts) {
            $binary_side = $accounts['_binary_side'];
        }
        
        
        
        
        $qry = "SELECT COUNT(*) AS count 
                FROM " . $this->table_name . " 
                WHERE 
                    _binary_id_master = :args_binary_id_master 
                    AND _binary_id_master != 0";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_binary_id_master', $args_binary_id_master);
        $result = $this->conn->single();
        return (int)$result['count'];
    }*/
    
    
    /*
     * Network
     */
    public function network_binary__list($args_indicator__accounts_id, $args_limit) {
        $list = array();
        $qry = "SELECT _id, _username, _binary_side FROM accounts WHERE _binary_id_master = :args_indicator__accounts_id ORDER BY _binary_id_master ASC";
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        $data = $this->conn->resultSet();
        
        if (count($data) > 0 ) {
            $list = $data;
            
            foreach($data as $chave => $usuario) {
                $list[$chave]['childs'] = array();
                
                if ($args_limit > 0) {
                    $list[$chave]['childs'] = (new Accounts)->network_binary__list($usuario['_id'], $args_limit-1);
                }
            }
        }
        
        return $list;
    }
    
    public function network_binary__find_bin_ind($args_indicator__accounts_id, $args_binary_side, $args_limit) {
        $list = [array(), 0];
        if ($args_binary_side != null) {
            $qry = "SELECT _id, _username, _binary_side FROM accounts WHERE _binary_id_master = :args_indicator__accounts_id AND _binary_side = '$args_binary_side' ORDER BY _binary_id_master ASC";
        } else {
            $qry = "SELECT _id, _username, _binary_side FROM accounts WHERE _binary_id_master = :args_indicator__accounts_id ORDER BY _binary_id_master ASC";
        }
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        $data = $this->conn->resultSet();
        
        if (count($data) > 0 ) {
            $list[0] = $data;
            
            foreach($data as $chave => $usuario) {
                $list[0][$chave]['childs'] = array();
                
                if ($args_limit > 0) {
                    $childs = (new Accounts)->network_binary__find_bin_ind($usuario['_id'], null, $args_limit-1);
                    $list[0][$chave]['childs'] = $childs[0];
                    $list[1] = $childs[1];
                    
                    if (count($childs[0]) < 2) {
                        $list[1] = $usuario['_id'];
                    } else {
                        if (count($childs[0]) == 1) {
                            if ($childs[0] != null && $list[1] == 0) {
                                $list[1] = $childs[0][0]['_id'];
                            }
                        }
                    }
                }
            }
        } else {
            if ($list[1] == 0) {
                $list[1] = $args_indicator__accounts_id;
            }
        }
        
        return $list;
    }
    
    public function network_binary__upline_by_side($args_indicator__accounts_id, $args_binary_side) {
        $newBinaryMasterId = 0;
        $qry = "SELECT _id, _username FROM accounts WHERE _binary_id_master = :args_indicator__accounts_id AND _binary_side = '$args_binary_side'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        $data = $this->conn->resultSet();
        
        if (count($data) > 0 ) {
            $subdata = (new Accounts)->network_binary__upline_by_side($data[0]['_id'], $args_binary_side);
            $newBinaryMasterId = $subdata;
        } else {
            if ($newBinaryMasterId == 0) {
                $newBinaryMasterId = $args_indicator__accounts_id;
            }
        }
        
        return $newBinaryMasterId;
    }
    /** **/
    
    
    public function findOrderAndLimit($limit, $order = "DESC")
    {
        $qry = "SELECT *
                FROM " . $this->table_name . " 
                ORDER BY _created_at $order 
                LIMIT 0,:limit";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':limit', $limit);
        return $this->conn->resultSet();
    }
    
    public function countChartLast15Days()
    {
        $this->data = $this->conn->query("SELECT EXTRACT(DAY FROM `_created_at`) AS pDay, COUNT(`_created_at`) AS pCount FROM accounts WHERE `_created_at` BETWEEN CURRENT_DATE()-15 AND CURRENT_DATE()+1 GROUP BY pDay");
        return $this->conn->resultSet();
    }
    
    public function update($args_id, $args_name, $args_email, $args_phone, $args_country_dial_code, $args_country_phone_mask, $args_country_iso2, $args_country_name, $args_mobile_phone, $args_address, $args_address_number, $args_address_neighborhood, $args_address_city, $args_address_uf, $args_address_postal_code, $args_about)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _name = :args_name, 
                    _email = :args_email, 
                    _phone = :args_phone, 
                    _country_dial_code = :args_country_dial_code, 
                    _country_phone_mask = :args_country_phone_mask, 
                    _country_iso2 = :args_country_iso2, 
                    _country_name = :args_country_name, 
                    _mobile_phone = :args_mobile_phone, 
                    _address = :args_address, 
                    _address_number = :args_address_number, 
                    _address_neighborhood = :args_address_neighborhood, 
                    _address_city = :args_address_city, 
                    _address_uf = :args_address_uf, 
                    _address_postal_code = :args_address_postal_code, 
                    _about = :args_about, 
                    _updated_at = NOW() 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        $this->conn->bind(':args_name', $args_name);
        $this->conn->bind(':args_email', $args_email);
        $this->conn->bind(':args_phone', (new Format)->clearNumber($args_phone));
        $this->conn->bind(':args_country_dial_code', $args_country_dial_code);
        $this->conn->bind(':args_country_phone_mask', $args_country_phone_mask);
        $this->conn->bind(':args_country_iso2', $args_country_iso2);
        $this->conn->bind(':args_country_name', $args_country_name);
        $this->conn->bind(':args_mobile_phone', (new Format)->clearNumber($args_mobile_phone));
        $this->conn->bind(':args_address', $args_address);
        $this->conn->bind(':args_address_number', $args_address_number);
        $this->conn->bind(':args_address_neighborhood', $args_address_neighborhood);
        $this->conn->bind(':args_address_city', $args_address_city);
        $this->conn->bind(':args_address_uf', $args_address_uf);
        $this->conn->bind(':args_address_postal_code', (new Format)->clearNumber($args_address_postal_code));
        $this->conn->bind(':args_about', $args_about);
        
        return $this->conn->execute();
    }
    
    
    public function updateCustomerProfile($_id, $_type, $_name, $_cpf, $_cnpj, $_birthdate, $_sex, $_email, $args_country_dial_code, $args_country_phone_mask, $args_country_iso2, $args_country_name, $_mobile_phone, $_coinbase_email, $_about_me)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _type = :_type, 
                    _name = :_name, 
                    _cpf = :_cpf, 
                    _cnpj = :_cnpj, 
                    _birthdate = :_birthdate, 
                    _sex = :_sex, 
                    _email = :_email, 
                    _coinbase_email = :_coinbase_email, 
                    _country_dial_code = :args_country_dial_code, 
                    _country_phone_mask = :args_country_phone_mask, 
                    _country_iso2 = :args_country_iso2, 
                    _country_name = :args_country_name, 
                    _mobile_phone = :_mobile_phone, 
                    _about_me = :_about_me, 
                    _updated_at = NOW() 
                WHERE 
                    _id = :_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':_id', $_id);
        $this->conn->bind(':_type', $_type);
        $this->conn->bind(':_name', $_name);
        $this->conn->bind(':_cpf', (new Format)->clearNumber($_cpf));
        $this->conn->bind(':_cnpj', (new Format)->clearNumber($_cnpj));
        $this->conn->bind(':_birthdate', $_birthdate);
        $this->conn->bind(':_sex', $_sex);
        $this->conn->bind(':_email', $_email);
        $this->conn->bind(':_coinbase_email', $_coinbase_email);
        $this->conn->bind(':args_country_dial_code', $args_country_dial_code);
        $this->conn->bind(':args_country_phone_mask', $args_country_phone_mask);
        $this->conn->bind(':args_country_iso2', $args_country_iso2);
        $this->conn->bind(':args_country_name', $args_country_name);
        $this->conn->bind(':_mobile_phone', (new Format)->clearNumber($_mobile_phone));
        $this->conn->bind(':_about_me', $_about_me);
        
        return $this->conn->execute();
    }
    
    public function updateCustomerAddress($_id, $_address_street, $_address_number, $_address_district, $_address_city, $_address_state, $_address_postal_code, $_address_complement)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _address_street = :_address_street, 
                    _address_number = :_address_number, 
                    _address_district = :_address_district, 
                    _address_city = :_address_city, 
                    _address_state = :_address_state, 
                    _address_postal_code = :_address_postal_code, 
                    _address_complement = :_address_complement, 
                    _updated_at = NOW() 
                WHERE 
                    _id = :_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':_id', $_id);
        $this->conn->bind(':_address_street', $_address_street);
        $this->conn->bind(':_address_number', $_address_number);
        $this->conn->bind(':_address_district', $_address_district);
        $this->conn->bind(':_address_city', $_address_city);
        $this->conn->bind(':_address_state', $_address_state);
        $this->conn->bind(':_address_postal_code', (new Format)->clearNumber($_address_postal_code));
        $this->conn->bind(':_address_complement', $_address_complement);
        
        return $this->conn->execute();
    }
    
    public function updateCustomerBank($_id, $_bank_bank_number, $_bank_bank_name, $_bank_agency_number, $_bank_agency_digit, $_bank_account_number, $_bank_account_digit, $_bank_operation, $_bank_account_type, $_bank_holder_doc, $_bank_holder_name)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _bank_bank_number = :_bank_bank_number, 
                    _bank_bank_name = :_bank_bank_name, 
                    _bank_agency_number = :_bank_agency_number, 
                    _bank_agency_digit = :_bank_agency_digit, 
                    _bank_account_number = :_bank_account_number, 
                    _bank_account_digit = :_bank_account_digit, 
                    _bank_operation = :_bank_operation, 
                    _bank_account_type = :_bank_account_type, 
                    _bank_holder_doc = :_bank_holder_doc, 
                    _bank_holder_name = :_bank_holder_name, 
                    _updated_at = NOW() 
                WHERE 
                    _id = :_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':_id', $_id);
        $this->conn->bind(':_bank_bank_number', $_bank_bank_number);
        $this->conn->bind(':_bank_bank_name', $_bank_bank_name);
        $this->conn->bind(':_bank_agency_number', $_bank_agency_number);
        $this->conn->bind(':_bank_agency_digit', $_bank_agency_digit);
        $this->conn->bind(':_bank_account_number', $_bank_account_number);
        $this->conn->bind(':_bank_account_digit', $_bank_account_digit);
        $this->conn->bind(':_bank_operation', $_bank_operation);
        $this->conn->bind(':_bank_account_type', $_bank_account_type);
        $this->conn->bind(':_bank_holder_doc', $_bank_holder_doc);
        $this->conn->bind(':_bank_holder_name', $_bank_holder_name);
        
        return $this->conn->execute();
    }
    
    public function updateCustomerCryptoWallet($_id, $_crypto_wallet)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _crypto_wallet = :_crypto_wallet, 
                    _updated_at = NOW() 
                WHERE 
                    _id = :_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':_id', $_id);
        $this->conn->bind(':_crypto_wallet', $_crypto_wallet);
        
        return $this->conn->execute();
    }
    
    public function updateProfilePicture($_id, $_picture_src)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _picture_src = :_picture_src, 
                    _updated_at = NOW() 
                WHERE 
                    _id = :_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':_id', $_id);
        $this->conn->bind(':_picture_src', $_picture_src);
        
        return $this->conn->execute();
    }
    
    public function session__update($id, $name, $type, $cnpj, $cpf, $birthdate, $sex, $coinbase_email, $args_country_dial_code, $args_country_phone_mask, $args_country_iso2, $args_country_name, $mobile_phone, $about_me)
    {
        //_email = :email, 
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _name = :name, 
                    _type = :type, 
                    _cnpj = :cnpj, 
                    _cpf = :cpf, 
                    _birthdate = :birthdate, 
                    _sex = :sex, 
                    _coinbase_email = :coinbase_email, 
                    _country_dial_code = :args_country_dial_code, 
                    _country_phone_mask = :args_country_phone_mask, 
                    _country_iso2 = :args_country_iso2, 
                    _country_name = :args_country_name, 
                    _mobile_phone = :mobile_phone, 
                    _about_me = :about_me, 
                    _updated_at = NOW() 
                WHERE 
                    _id = :id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':id', $id);
        $this->conn->bind(':name', $name);
        $this->conn->bind(':type', $type);
        $this->conn->bind(':cnpj', (new Format)->clearNumber($cnpj));
        $this->conn->bind(':cpf', (new Format)->clearNumber($cpf));
        $this->conn->bind(':birthdate', $birthdate);
        $this->conn->bind(':sex', $sex);
        //$this->conn->bind(':email', $email);
        $this->conn->bind(':coinbase_email', $coinbase_email);
        $this->conn->bind(':args_country_dial_code', $args_country_dial_code);
        $this->conn->bind(':args_country_phone_mask', $args_country_phone_mask);
        $this->conn->bind(':args_country_iso2', $args_country_iso2);
        $this->conn->bind(':args_country_name', $args_country_name);
        $this->conn->bind(':mobile_phone', (new Format)->clearNumber($mobile_phone));
        $this->conn->bind(':about_me', $about_me);
        
        return $this->conn->execute();
    }
    
    public function updateAddress($args_id, $args_address_street, $args_address_number, $args_address_district, $args_address_city, $args_address_state, $args_address_postal_code, $args_address_complement)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _address_street = :args_address_street, 
                    _address_number = :args_address_number, 
                    _address_district = :args_address_district, 
                    _address_city = :args_address_city, 
                    _address_state = :args_address_state, 
                    _address_postal_code = :args_address_postal_code, 
                    _address_complement = :args_address_complement, 
                    _updated_at = NOW() 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        $this->conn->bind(':args_address_street', $args_address_street);
        $this->conn->bind(':args_address_number', $args_address_number);
        $this->conn->bind(':args_address_district', $args_address_district);
        $this->conn->bind(':args_address_city', $args_address_city);
        $this->conn->bind(':args_address_state', $args_address_state);
        $this->conn->bind(':args_address_postal_code', (new Format)->clearNumber($args_address_postal_code));
        $this->conn->bind(':args_address_complement', $args_address_complement);
        
        return $this->conn->execute();
    }
    
    public function updateBank($args_id, $args_bank_bank_number, $args_bank_bank_name, $args_bank_agency_number, $args_bank_agency_digit, $args_bank_account_number, $args_bank_account_digit, $args_bank_operation, $args_bank_account_type, $args_bank_holder_doc, $args_bank_holder_name)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _bank_bank_number = :args_bank_bank_number, 
                    _bank_bank_name = :args_bank_bank_name, 
                    _bank_agency_number = :args_bank_agency_number, 
                    _bank_agency_digit = :args_bank_agency_digit, 
                    _bank_account_number = :args_bank_account_number, 
                    _bank_account_digit = :args_bank_account_digit, 
                    _bank_operation = :args_bank_operation, 
                    _bank_account_type = :args_bank_account_type, 
                    _bank_holder_doc = :args_bank_holder_doc, 
                    _bank_holder_name = :args_bank_holder_name, 
                    _updated_at = NOW() 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        $this->conn->bind(':args_bank_bank_number', $args_bank_bank_number);
        $this->conn->bind(':args_bank_bank_name', $args_bank_bank_name);
        $this->conn->bind(':args_bank_agency_number', $args_bank_agency_number);
        $this->conn->bind(':args_bank_agency_digit', $args_bank_agency_digit);
        $this->conn->bind(':args_bank_account_number', $args_bank_account_number);
        $this->conn->bind(':args_bank_account_digit', $args_bank_account_digit);
        $this->conn->bind(':args_bank_operation', $args_bank_operation);
        $this->conn->bind(':args_bank_account_type', $args_bank_account_type);
        $this->conn->bind(':args_bank_holder_doc', $args_bank_holder_doc);
        $this->conn->bind(':args_bank_holder_name', $args_bank_holder_name);
        
        return $this->conn->execute();
    }
    
    public function updateCryptoWallet($args_id, $args_crypto_wallet, $args_crypto_wallet_network)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _crypto_wallet = :args_crypto_wallet, 
                    _crypto_wallet_network = :args_crypto_wallet_network,
                    _updated_at = NOW() 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        $this->conn->bind(':args_crypto_wallet', $args_crypto_wallet);
        $this->conn->bind(':args_crypto_wallet_network', $args_crypto_wallet_network);
        
        return $this->conn->execute();
    }
    
    public function updateTerms($args_id = null, $args_accept_terms)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _accept_terms = :args_accept_terms 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accept_terms', $args_accept_terms);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function updateBinaryKey($args_id = null, $args_binary_key)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _binary_key = :args_binary_key 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_binary_key', $args_binary_key);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function updateValidationStatus($args_id = null, $args_verification_file, $args_verification_status)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _verification_file = :args_verification_file, 
                    _verification_status = :args_verification_status 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_verification_file', $args_verification_file);
        $this->conn->bind(':args_verification_status', $args_verification_status);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function updateAdminValidationStatus($args_id = null, $args_verification_status)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _verification_status = :args_verification_status 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_verification_status', $args_verification_status);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function updateJoker($args_id, $args_key)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _joker_account = :args_key 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        if ($args_key == true) {
            $this->conn->bind(':args_key', 'true');
        } else {
            $this->conn->bind(':args_key', 'false');
        }
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function updateCashout_day($args_id = null, $args_cashout_day)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _cashout_day = :args_cashout_day 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_cashout_day', $args_cashout_day);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function setLastAccess($args_id = null)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _last_access = NOW() 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function setStatus($args_id = null, $args_status)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _status = :args_status 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_status', $args_status);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function setChatBanned($args_id = null, $args_chat_banned)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _chat_banned = :args_chat_banned 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_chat_banned', $args_chat_banned);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function delete($args_id)
    {
        $qry = "DELETE 
                FROM " . $this->table_name . " 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function count()
    {
        $qry = "SELECT COUNT(*) AS count 
                FROM " . $this->table_name;
        
        $this->data = $this->conn->query($qry);
        $result     = $this->conn->single();
        return $result['count'];
    }
    
    public function countIndications($args_indicator__accounts_id)
    {
        if ($args_indicator__accounts_id != 0) {
            $qry = "SELECT COUNT(*) AS count 
                    FROM " . $this->table_name . " 
                    WHERE _indicator__accounts_id = :args_indicator__accounts_id";
        } else {
            $qry = "SELECT COUNT(*) AS count 
                    FROM " . $this->table_name;
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_indicator__accounts_id != 0) {
            $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        }
        $result = $this->conn->single();
        return $result['count'];
    }
    
    public function countBinaryIndications($args_indicator__accounts_id)
    {
        $qry = "SELECT COUNT(*) AS count 
                FROM " . $this->table_name . " 
                    WHERE _binary_id_master = :args_indicator__accounts_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        $result = $this->conn->single();
        return $result['count'];
    }
    
    public function binaryIndications($args_indicator__accounts_id)
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                    WHERE _binary_id_master = :args_indicator__accounts_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        return $this->conn->resultSet();
    }
    
    public function isActive($args_accounts_id)
    {
        $count = (new Donations)->countTotalReceiving($args_accounts_id);
        if ($count > 0) {
            return true;
        } else {
            return false;
        }
    }
    
    public function binaryReceiving($args_indicator__accounts_id)
    {
        $count = (new Accounts)->countBinaryIndications($args_indicator__accounts_id);
        if ($count >= 2) {
            $binaryIndications = (new Accounts)->binaryIndications($args_indicator__accounts_id);
            $activeAccountsCount = 0;
            for ($i=0;$i<sizeof($binaryIndications);$i++){
                $isActive = (new Accounts)->isActive($binaryIndications[$i]['_id']);
                if ($isActive == true) {
                    $activeAccountsCount++;
                }
            }
            
            if ($activeAccountsCount >= 2) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
    
    public function isJokerAccount($args_accounts_id)
    {
        $qry = "SELECT *
                FROM " . $this->table_name . " 
                WHERE _id = :args_accounts_id 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts_id', $args_accounts_id);
        $data = $this->conn->single();
        
        if ($data['_joker_account'] == 'true') {
            return true;
        } else {
            return false;
        }
    }
    
    public function countIndicationsLastMonth($args_indicator__accounts_id)
    {
        if ($args_indicator__accounts_id != 0) {
            $qry = "SELECT COUNT(*) AS count 
                    FROM " . $this->table_name . " 
                    WHERE _indicator__accounts_id = :args_indicator__accounts_id AND YEAR(`_created_at`) = YEAR(CURRENT_DATE) AND MONTH(`_created_at`) = MONTH(CURRENT_DATE)";
        } else {
            $qry = "SELECT COUNT(*) AS count 
                    FROM " . $this->table_name . " 
                    WHERE YEAR(`_created_at`) = YEAR(CURRENT_DATE) AND MONTH(`_created_at`) = MONTH(CURRENT_DATE)";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_indicator__accounts_id != 0) {
            $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        }
        $result = $this->conn->single();
        return $result['count'];
    }
    
    public function countLastMonth()
    {
        $qry = "SELECT COUNT(*) AS count 
                FROM " . $this->table_name . " 
                WHERE YEAR(`_created_at`) = YEAR(CURRENT_DATE) AND MONTH(`_created_at`) = MONTH(CURRENT_DATE)";
        
        $this->data = $this->conn->query($qry);
        $result = $this->conn->single();
        return $result['count'];
    }
    
    public function countLast7Days()
    {
        $qry = "SELECT COUNT(*) AS count 
                FROM " . $this->table_name . " 
                WHERE `_created_at` BETWEEN CURRENT_DATE()-7 AND CURRENT_DATE()+1";
        
        $this->data = $this->conn->query($qry);
        $result = $this->conn->single();
        return $result['count'];
    }
    
    public function countLastAccessInLastMonth()
    {
        $qry = "SELECT COUNT(*) AS count 
                FROM " . $this->table_name . " 
                WHERE YEAR(`_last_access`) = YEAR(CURRENT_DATE) AND MONTH(`_last_access`) = MONTH(CURRENT_DATE)";
        
        $this->data = $this->conn->query($qry);
        $result = $this->conn->single();
        return $result['count'];
    }
    
    
    public function countChartCreatedAtLast15Days()
    {
        $qry = "SELECT EXTRACT(DAY FROM `_created_at`) AS pDay, COUNT(`_created_at`) AS pCount FROM accounts WHERE `_created_at` BETWEEN CURRENT_DATE()-15 AND CURRENT_DATE()+1 GROUP BY pDay";
        $this->data = $this->conn->query($qry);
        return $this->conn->resultSet();
    }
    
    public function countChartAccessLast15Days()
    {
        $qry = "SELECT EXTRACT(DAY FROM `_last_access`) AS pDay, COUNT(`_last_access`) AS pCount FROM accounts WHERE `_last_access` BETWEEN CURRENT_DATE()-15 AND CURRENT_DATE()+1 GROUP BY pDay";
        $this->data = $this->conn->query($qry);
        return $this->conn->resultSet();
    }
    
    public function countChartIndicationsLast15Days($args_indicator__accounts_id)
    {
        $qry = "SELECT EXTRACT(DAY FROM `_created_at`) AS pDay, COUNT(`_created_at`) AS pCount FROM accounts WHERE `_indicator__accounts_id` = :args_indicator__accounts_id AND `_created_at` BETWEEN CURRENT_DATE()-15 AND CURRENT_DATE()+1 GROUP BY pDay";
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        return $this->conn->resultSet();
    }
    
    public function last15Accounts()
    {
        $qry = "SELECT _id, _type, _username, _name, _email, _sex, _phone, _mobile_phone, _address_city, _address_state, _picture_src, _created_at, _status  FROM accounts ORDER BY _id DESC LIMIT 0,15";
        $this->data = $this->conn->query($qry);
        return $this->conn->resultSet();
    }
    
    public function countIndicationsLast7Days($args_indicator__accounts_id)
    {
        /*$qry = "SELECT EXTRACT(MONTH FROM `_created_at`) AS pDay, COUNT(`_created_at`) AS pCount FROM accounts WHERE `_indicator__accounts_id` = :args_indicator__accounts_id AND `_created_at` BETWEEN CURRENT_DATE()-7 AND CURRENT_DATE()+1 GROUP BY pDay";
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        $result = $this->conn->single();
        return $result['count'];*/
        
        $qry = "SELECT COUNT(*) AS count 
                FROM " . $this->table_name . " 
                WHERE `_indicator__accounts_id` = :args_indicator__accounts_id AND `_created_at` BETWEEN CURRENT_DATE()-7 AND CURRENT_DATE()+1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        $result = $this->conn->single();
        return $result['count'];
    }
    
    public function countChartIndicationsYear($args_indicator__accounts_id)
    {
        $qry = "SELECT EXTRACT(MONTH FROM `_created_at`) AS pMonth, COUNT(`_created_at`) AS pCount FROM accounts WHERE `_indicator__accounts_id` = :args_indicator__accounts_id AND `_created_at` BETWEEN CONCAT(YEAR(CURDATE()),'-01-01') AND CONCAT(YEAR(CURDATE())+1,'-12-31') GROUP BY pMonth";
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        return $this->conn->resultSet();
    }
    
    
    /** **/
    public function new__chartDirectLast30($args_indicator__accounts_id)
    {
        if ($args_indicator__accounts_id != 0) {
            $qry = "SELECT DATE_FORMAT(_created_at, \"%d/%m/%Y\") AS _date, COUNT(_created_at) AS _count FROM `accounts` WHERE `_indicator__accounts_id` = :args_indicator__accounts_id GROUP BY DATE_FORMAT(_created_at, \"%d-%m-%Y\") ORDER BY YEAR(_created_at) DESC, MONTH(_created_at) DESC, DAY(_created_at) DESC LIMIT 0,30";
        } else {
            $qry = "SELECT DATE_FORMAT(_created_at, \"%d/%m/%Y\") AS _date, COUNT(_created_at) AS _count FROM `accounts` GROUP BY DATE_FORMAT(_created_at, \"%d-%m-%Y\") ORDER BY YEAR(_created_at) DESC, MONTH(_created_at) DESC, DAY(_created_at) DESC LIMIT 0,30";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_indicator__accounts_id != 0) {
            $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        }
        return $this->conn->resultSet();
    }
    
    public function new__chartIndirectLast30($args_indicator__accounts_id)
    {
        if ($args_indicator__accounts_id != 0) {
            $accountsGrid = (new Accounts)->network__list($args_indicator__accounts_id, (new Settings)->findValue('network_downline_level'));
            $dataAccountsListId = (new Accounts)->network__gen_list_id($accountsGrid);
            $accountsArrList = substr($dataAccountsListId, 0, -1);
            $accountsArr = "($accountsArrList)";
            
            $qry = "SELECT DATE_FORMAT(_created_at, \"%d/%m/%Y\") AS _date, COUNT(_created_at) AS _count FROM `accounts` WHERE _id IN $accountsArr GROUP BY DATE_FORMAT(_created_at, \"%d-%m-%Y\") ORDER BY YEAR(_created_at) DESC, MONTH(_created_at) DESC, DAY(_created_at) DESC LIMIT 0,30";
        } else {
            $qry = "SELECT DATE_FORMAT(_created_at, \"%d/%m/%Y\") AS _date, COUNT(_created_at) AS _count FROM `accounts` GROUP BY DATE_FORMAT(_created_at, \"%d-%m-%Y\") ORDER BY YEAR(_created_at) DESC, MONTH(_created_at) DESC, DAY(_created_at) DESC LIMIT 0,30";
        }
        
        $this->data = $this->conn->query($qry);
        /*if ($args_indicator__accounts_id != 0) {
            $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        }*/
        return $this->conn->resultSet();
    }
    
    public function new__countIndirectLast1Day($args_indicator__accounts_id)
    {
        if ($args_indicator__accounts_id != 0) {
            $accountsGrid = (new Accounts)->network__list($args_indicator__accounts_id, (new Settings)->findValue('network_downline_level'));
            $dataAccountsListId = (new Accounts)->network__gen_list_id($accountsGrid);
            $accountsArrList = substr($dataAccountsListId, 0, -1);
            $accountsArr = "($accountsArrList)";
            
            $qry = "SELECT DATE_FORMAT(_created_at, '%Y-%m-%d'), COUNT(*) AS _count FROM `accounts` WHERE _id IN $accountsArr AND DATE(_created_at) = CURDATE()-1";
        } else {
            $qry = "SELECT DATE_FORMAT(_created_at, '%Y-%m-%d'), COUNT(*) AS _count FROM `accounts` WHERE DATE(_created_at) = CURDATE()-1";
        }
        
        $this->data = $this->conn->query($qry);
        $result = $this->conn->single();
        return $result['_count'];
    }
    
    public function new__countIndirectDay($args_indicator__accounts_id)
    {
        if ($args_indicator__accounts_id != 0) {
            $accountsGrid = (new Accounts)->network__list($args_indicator__accounts_id, (new Settings)->findValue('network_downline_level'));
            $dataAccountsListId = (new Accounts)->network__gen_list_id($accountsGrid);
            $accountsArrList = substr($dataAccountsListId, 0, -1);
            $accountsArr = "($accountsArrList)";
            
            $qry = "SELECT DATE_FORMAT(_created_at, '%Y-%m-%d'), COUNT(*) AS _count FROM `accounts` WHERE _id IN $accountsArr AND DATE(_created_at) = CURDATE()";
        } else {
            $qry = "SELECT DATE_FORMAT(_created_at, '%Y-%m-%d'), COUNT(*) AS _count FROM `accounts` WHERE DATE(_created_at) = CURDATE()";
        }
        
        $this->data = $this->conn->query($qry);
        $result = $this->conn->single();
        return $result['_count'];
    }
    /** **/
    
    /*
     * Network
     */
    public function network__list($args_indicator__accounts_id, $args_limit) {
        $list = array();
        $qry = "SELECT _id, _name, _username FROM accounts WHERE _unilevel_id_master = :args_indicator__accounts_id ORDER BY _unilevel_id_master ASC";
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_indicator__accounts_id', $args_indicator__accounts_id);
        $data = $this->conn->resultSet();
        
        if (count($data) > 0 ) {
            $list = $data;
            
            foreach($data as $chave => $usuario) {
                $list[$chave]['childs'] = array();
                $list[$chave]['contracts'] = (new Donations)->countTotalInMonthFromAccountsID($usuario['_id']);
                
                if ($args_limit > 0) {
                    $list[$chave]['childs'] = (new Accounts)->network__list($usuario['_id'], $args_limit-1);
                }
            }
        }
        
        return $list;
    }
    
    public function network__gen_grid($array, $grid = null, $level = 1) {
        if (!isset($grid)) {
            $grid = array();
            $maxLevel = (int)(new Settings)->findValue('network_downline_level');
            for ($i=0;$i<$maxLevel;$i++){
                array_push($grid, array(($i+1) => 0));
            }
        }
        
        //echo '<ul>';
        foreach($array as $usuario) {
            //echo'<li>';
            $grid[$level-1][$level] = $grid[$level-1][$level] + 1;
            //echo $usuario['_username'] . '&nbsp;&nbsp;level :: <b>' . $level . '</b>&nbsp;&nbsp;count :: <b>' . $grid[$level-1][$level] . '</b>';
            
            if (count($usuario['childs']) > 0) {
                $grid = $this->network__gen_grid($usuario['childs'], $grid, $level + 1);
            }
            //echo '</li>';
        }
        //echo '</ul>';
        
        return $grid;
    }
    
    public function network__gen_grid_act($array, $grid = null, $level = 1) {
        if (!isset($grid)) {
            $grid = array();
            $maxLevel = (int)(new Settings)->findValue('network_downline_level');
            for ($i=0;$i<$maxLevel;$i++){
                array_push($grid, array("level" => ($i+1), "count" => 0, "contracts" => 0));
            }
        }
        
        foreach($array as $usuario) {
            //$grid[$level-1][$level][0] = $grid[$level-1][$level] + 1;
            $grid[$level-1]['count'] = $grid[$level-1][$level] + 1;
            if ($usuario['contracts'] >= 10) {
                $grid[$level-1]['contracts'] = $grid[$level-1]['contracts'] + 10;
            }
            
            if (count($usuario['childs']) > 0) {
                $grid = $this->network__gen_grid_act($usuario['childs'], $grid, $level + 1);
            }
        }
        
        return $grid;
    }
    
    public function findActiveForLevelV2($accounts__id, $level) {
        $accountsDirect = $this->findDirect($accounts__id, null, '', 9999);
        $totalContracts = 0;
        if (sizeof($accountsDirect) > 0) {
            for ($i=0;$i<sizeof($accountsDirect);$i++){
                $countContractsInMonth = (new Donations)->countTotalInMonthFromAccountsID($accountsDirect[$i]['_id']);
                if ($countContractsInMonth >= 10) {
                    $totalContracts += 10;  //$countContractsInMonth;
                }
            }
        }
        
        if (sizeof($accountsDirect) >= $level && $totalContracts >= $level*10) {
            return true;
        }
        
        return false;
    }
    
    public function findLevelActive($accounts__id, $level) {
        $accountsGrid = (new Accounts)->network__list($accounts__id, 20);
        $grid = (new Accounts)->network__gen_grid_act($accountsGrid);
        
        if (sizeof($grid) > 0) {
            for ($i=0;$i<sizeof($grid);$i++){
                if ($level == $grid[$i]['level'] && $grid[$i]['contracts'] == $level*10) {
                    return true;
                }
            }
        }
        
        return false;
    }
    
    public function network__gen_upLine($accounts__id, $grid = null) {
        if (!isset($grid)) {
            $grid = array();
        }
        
        $accountData = (new Accounts)->find($accounts__id);
        if ($accountData != null) {
            if ($accountData['_unilevel_id_master'] >= 2) {
                array_push($grid, array("_id" => (int)$accountData['_unilevel_id_master']));
                $grid = $this->network__gen_upLine($accountData['_unilevel_id_master'], $grid);
            }
        }
        
        return $grid;
    }
    
    public function network__gen_binary_upLine($accounts__id, $grid = null) {
        if (!isset($grid)) {
            $grid = array();
        }
        
        $accountData = (new Accounts)->find($accounts__id);
        if ($accountData != null) {
            if ($accountData['_binary_id_master'] >= 2) {
                array_push($grid, array("_id" => (int)$accountData['_binary_id_master'], "_side" => $accountData['_binary_side']));
                $grid = $this->network__gen_binary_upLine($accountData['_binary_id_master'], $grid);
            }
        }
        
        return $grid;
    }
    
    public function network__gen_list_id($array, $accountsArrList = null, $level = 1) {
        if (!isset($accountsArrList)) {
            $accountsArrList = '';
        }
        
        foreach($array as $usuario) {
            $accountsArrList .= $usuario['_id'].',';
            
            if (count($usuario['childs']) > 0) {
                $accountsArrList = $this->network__gen_list_id($usuario['childs'], $accountsArrList, $level + 1);
            }
        }
        
        return $accountsArrList;
    }
    
    /*
    // funcao vai receber um array e as listas direto
    public function network__exibir($array, $level = 1) {
        echo '<ul>';
        foreach($array as $usuario) {
            echo'<li>';
            $levelGanho = 0;
            $maxPacote = 0;
            $totalDoacoes = '';
            
            if ($_SESSION['investor_id'] == 1 || $_SESSION['investor_id'] == 2) {
                $levelGanho = getNivelGanhoIndicacao($usuario['investor_id']);
                $maxPacote = getMaxPacoteModelID($usuario['investor_id']);
                
                $totalDoacoes = '&nbsp;&nbsp;Nível:&nbsp;' . $level . '&nbsp;&nbsp;|&nbsp;&nbsp;Nível ganho: ' . $levelGanho . '&nbsp;&nbsp;|&nbsp;&nbsp;Doações: ' . getTotalDoacoesSingle($usuario['investor_id']);
            }
            
            $levelPin = '';
            if ($levelGanho > 0) {
                $levelPin = '<span style="display: block;position: absolute;top: -64px;left: 42px;background: #47633f;width: fit-content;padding: 0 4px;border-radius: 25px;color: #fff;height: 17px;min-width: 17px;">' . $levelGanho . '</span>';
            }
            if ($maxPacote > 0) {
                $maxPacoteVal = number_format( getPacoteValor($maxPacote), 2, ',', '' );
                $levelPin .= '<span style="display: block;position: absolute;top: -44px;left: 42px;background: #adb536;width: fit-content;padding: 0 4px;border-radius: 25px;color: #fff;height: 17px;min-width: 17px;">' . $maxPacoteVal . '</span>';
            }
            
            //echo $usuario['nome'].'('.$usuario["p_nome"].')';
            /* echo $usuario['nome'].'(<span style="color:red">'.$usuario["p_nome"].'</span>)'; */
    /*
            echo '<a href="/rede?id=' . $usuario['investor_id'] . '" title="' . $usuario['investor_name'] . $totalDoacoes . '" style="background-image: url(\'' . $usuario['investor_avatar'] . '\');background-position: top center;background-size: 60px;"><span>' . $usuario['investor_login'] . '</span>' . $levelPin . '</a>';
            
            if (count($usuario['filhos']) > 0) {
                network__exibir($usuario['filhos'], $level + 1);
            }
            
            echo '</li>';
        }
        
        echo '</ul>';
    }
    */
    
    
    
    /*
     * Export Data from MySQL to CSV Script
     * Version: 1.0.0
     * Page: Export
     */
    public function exportCsv() {
        $array_accounts = $this->find();
        
        $export_data = array();
        foreach ($array_accounts as $row)
        {
            //$export_data[] = $row;
            $export_data[] = array(
                "id" => $row['_id'],
                "name" => $row['_name'],
                "email" => $row['_email'],
                "cpf" => $row['_cpf'],
                "phone" => $row['_phone'],
                "created_at" => date( "m/d/Y \à\s h:i:s A", strtotime($row['_created_at'])),
                "enabled" => $row['_status']=='active' ? 'Ativo' : 'Inativo'
            );
        }
        
        
        $filename = 'Contas de Usuário.csv';
        header ("Expires: ".gmdate('D, d M Y H:i:s')." GMT");
        header ("Last-Modified: " . gmdate("D,d M YH:i:s") . " GMT");
        header ("Cache-Control: no-cache, must-revalidate");
        header ("Pragma: no-cache");
        header ("Content-Type: text/csv; charset=utf-8");
        header ("Content-Disposition: attachment; filename={$filename}");
        header ("Content-Description: PHP Generated Data");
        
        $output = fopen('php://output', 'w');
        fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF));
        fputcsv($output, array('ID', 'Nome', 'E-mail', 'CPF', 'Telefone', 'Data Cadastro', 'Status'));

        if (count($export_data) > 0) {
            foreach ($export_data as $row) {
                fputcsv($output, $row);
            }
        }
    }
    
    /*
     * Export Data from MySQL to XLS Script
     * Version: 1.0.0
     * Page: Export
     */
    public function exportXls()
    {
        $array_accounts = $this->find();
        $count = count($array_accounts);
        
        for ($i=0;$i<1;$i++){
            $html[$i] = "";
            $html[$i] .= "<table>";
            $html[$i] .= "<tr>";
            $html[$i] .= "<td><b>ID</b></td>";
            $html[$i] .= "<td><b>Name</b></td>";
            $html[$i] .= "<td><b>E-mail</b></td>";
            $html[$i] .= "<td><b>DOC</b></td>";
            $html[$i] .= "<td><b>Phoen</b></td>";
            $html[$i] .= "<td><b>Registration date</b></td>";
            $html[$i] .= "<td><b>Status</b></td>";
            $html[$i] .= "</tr>";
            $html[$i] .= "</table>";
        }
        
        $i = 1;
        foreach ($array_accounts as $row)
        {
            $row_id         = $row['_id'];
            $row_name       = $row['_name'];
            $row_cpf        = $row['_cpf'];
            $row_email      = $row['_email'];
            $row_phone      = $row['_phone'];
            $row_created_at = date( "m/d/Y \à\s h:i:s A", strtotime($row['_created_at']));
            $row_enabled    = $row['_status']=='active' ? 'Ativo' : 'Inativo';
            
            $html[$i] = "<table>";
            $html[$i] .= "<tr>";
            $html[$i] .= "<td>$row_id</td>";
            $html[$i] .= "<td>$row_name</td>";
            $html[$i] .= "<td>$row_email</td>";
            $html[$i] .= "<td>$row_cpf</td>";
            $html[$i] .= "<td>$row_phone</td>";
            $html[$i] .= "<td>$row_created_at</td>";
            $html[$i] .= "<td>$row_enabled</td>";
            $html[$i] .= "</tr>";
            $html[$i] .= "</table>";
            $i++;
        }
        
        
        $filename = 'Members.xls';
        header ("Expires: ".gmdate('D, d M Y H:i:s')." GMT");
        header ("Last-Modified: " . gmdate("D,d M YH:i:s") . " GMT");
        header ("Cache-Control: no-cache, must-revalidate");
        header ("Pragma: no-cache");
        header ("Content-Type: application/x-msexcel");
        header ("Content-Disposition: attachment; filename={$filename}");
        header ("Content-Transfer-Encoding: binary");
        header ("Content-Description: PHP Generated Data");
        
        for ($i=0;$i<=$count;$i++)
        {  
            echo utf8_decode($html[$i]);
        }
    }
    
    
    
    /*
     * Export Data from MySQL to PDF Script
     * Version: 1.0.0
     * Page: Export
     */
    public function exportPdf($args_type) {
        //setlocale(LC_ALL, 'pt_BR', 'pt_BR.iso-8859-1', 'pt_BR.utf-8', 'portuguese');
        //date_default_timezone_set('America/Sao_Paulo');
        
        /*
         * PDF
         */
        $pdf = new FPDF();
        //$pdf->AliasNbPages();
        $pdf->SetAuthor(utf8_decode((new Settings)->findValue('site__name')));
        $pdf->SetTitle('Report generated of ' . utf8_decode((new Settings)->findValue('site__copyright')));
        //$pdf->SetAutoPageBreak(false);
        
        if ($args_type == 'wallet__ballance__details') {
            $pdf->AddPage('L');
        } else {
            $pdf->AddPage();
        }
        
        switch($args_type){
            case "accounts__single_list":
                $array_data = $this->find(null, null, '', 9999);
                
                //set font to arial, bold, 14pt
                $pdf->SetFont('Arial','B',14);

                //Cell(width , height , text , border , end line , [align] )

                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(69 ,5,'',0,1);//end of line

                //set font to arial, regular, 12pt
                $pdf->SetFont('Arial','',12);
                
                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(25 ,5,utf8_decode('Date:'),0,0);
                $pdf->Cell(44 ,5,date('d/m/Y H:i:s', time()),0,1);//end of line

                //make a dummy empty cell as a vertical spacer
                $pdf->Cell(189 ,10,'',0,1);//end of line
                
                
                /*
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(35 ,5,utf8_decode('Listagem:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->MultiCell(154, 5, utf8_decode('Contas de usuário'), 0, 'L', false);//end of line
                
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(35 ,5,utf8_decode('Ano:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->Cell(154 ,5,utf8_decode('2020'),0,1);//end of line
                $pdf->SetFont('Arial','B',12);
                */
                
                $pdf->Cell(189, 4, '', 0, 1);
                
                
                $pdf->SetFont('Arial','B',12);
                //$pdf->Cell(189 ,5,utf8_decode($array_ticket['dozens']),0,0,'C', false);
                $pdf->MultiCell(189, 5, utf8_decode('Members report'),0,'C', false);
                $pdf->Cell(189, 6, '', 0, 1);
                
                
                $pdf->SetFont('Arial','B',9);
                $pdf->SetFillColor(230,230,230);
                $pdf->Cell(10,6,utf8_decode('ID'),0,0,'C',1);
                $pdf->Cell(65,6,utf8_decode('NAME'),0,0,'L',1);
                $pdf->Cell(32,6,utf8_decode('PHONE'),0,0,'C',1);
                $pdf->Cell(56,6,utf8_decode('EMAIL'),0,0,'L',1);
                $pdf->Cell(26,6,utf8_decode('STATUS'),0,1,'C',1);
                
                //$pdf->MultiCell(154, 5, utf8_decode('NOME'), 0, 'L', false);//end of line
                
                $pdf->SetFont('Arial','',9);
                
                $i = 1;
                $array_data__count = 0;
                $asColor = 0;
                foreach ($array_data as $row)
                {
                    if ($row['_id'] > 1) {
                        $pdf->Cell(10,6,utf8_decode($row['_id']),0,0,'C',$asColor);
                        $pdf->Cell(65,6,utf8_decode($row['_name']),0,0,'L',$asColor);
                        
                        $mobile_phone = '';
                        if ($row['_mobile_phone'] != "") {
                            $mobile_phone = (New Format)->phone($row['_mobile_phone']);
                        }
                        $pdf->Cell(32,6,utf8_decode($mobile_phone),0,0,'C',$asColor);
                        
                        $pdf->Cell(56,6,utf8_decode($row['_email']),0,0,'L',$asColor);
                        
                        if ($row['_status'] == "pending_approval") {
                            $accountStatus = 'Pending approval';
                        } else if ($row['_status'] == "active") {
                            $accountStatus = 'Active';
                        } else if ($row['_status'] == "suspended_by_admin" || $row['_status'] == "automatically_suspended") {
                            $accountStatus = 'Suspended';
                        }
                        $pdf->Cell(26,6,utf8_decode($accountStatus),0,1,'C',$asColor);
                        
                        if ($asColor == 0) {
                            $asColor = 1;
                        } else {
                            $asColor = 0;
                        }
                        
                        $array_data__count++;
                    }
                    
                    $i++;
                }
                
                $pdf->Cell(189, 5, '', 0, 1);
                $pdf->Cell(80 , 5,'', 0, 0);
                
                $pdf->SetFont('Arial','B',9);
                $pdf->Cell(75 ,5,utf8_decode('Total:'),0,0,'R');
                $pdf->SetFont('Arial','',9);
                $pdf->Cell(34, 5, $array_data__count . utf8_decode(' members'),0,1,'L');//end of line
            break;
            case "accounts__details":
                $array_data = $this->find(null, null, '', 9999);
                
                //set font to arial, bold, 14pt
                $pdf->SetFont('Arial','B',14);

                //Cell(width , height , text , border , end line , [align] )

                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(69 ,5,'',0,1);//end of line

                //set font to arial, regular, 12pt
                $pdf->SetFont('Arial','',12);
                
                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(25 ,5,utf8_decode('Date:'),0,0);
                $pdf->Cell(44 ,5,date('d/m/Y H:i:s', time()),0,1);//end of line

                //make a dummy empty cell as a vertical spacer
                $pdf->Cell(189 ,10,'',0,1);//end of line
                
                
                /*
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(35 ,5,utf8_decode('Listagem:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->MultiCell(154, 5, utf8_decode('Contas de usuário'), 0, 'L', false);//end of line
                
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(35 ,5,utf8_decode('Ano:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->Cell(154 ,5,utf8_decode('2020'),0,1);//end of line
                $pdf->SetFont('Arial','B',12);
                */
                
                $pdf->Cell(189, 4, '', 0, 1);
                
                
                $pdf->SetFont('Arial','B',12);
                //$pdf->Cell(189 ,5,utf8_decode($array_ticket['dozens']),0,0,'C', false);
                $pdf->MultiCell(189, 5, utf8_decode('Members report'),0,'C', false);
                $pdf->Cell(189, 6, '', 0, 1);
                
                $i = 1;
                $array_data__count = 0;
                foreach ($array_data as $row)
                {
                    if ($row['_id'] > 1) {
                        $pdf->SetFont('Arial','B',9);
                        $pdf->Cell(35 ,4,utf8_decode('ID / Username:'),0,0,'R');
                        $pdf->SetFont('Arial','',9);
                        $pdf->MultiCell(154, 4, utf8_decode($row['_id'] . ' - ' . $row['_username']), 0, 'L', false);//end of line
                        
                        $pdf->SetFont('Arial','B',9);
                        $pdf->Cell(35 ,4,utf8_decode('Name:'),0,0,'R');
                        $pdf->SetFont('Arial','',9);
                        $pdf->MultiCell(154, 4, utf8_decode($row['_name']), 0, 'L', false);//end of line
                        
                        $pdf->SetFont('Arial','B',9);
                        $pdf->Cell(35 ,4,utf8_decode('Phone:'),0,0,'R');
                        $pdf->SetFont('Arial','',9);
                        
                        $mobile_phone = '';
                        if ($row['_mobile_phone'] != "") {
                            $mobile_phone = (New Format)->phone($row['_mobile_phone']);
                        }
                        $pdf->MultiCell(154, 4, utf8_decode($mobile_phone), 0, 'L', false);//end of line
                        
                        $pdf->SetFont('Arial','B',9);
                        $pdf->Cell(35 ,4,utf8_decode('Email:'),0,0,'R');
                        $pdf->SetFont('Arial','',9);
                        $pdf->MultiCell(154, 4, utf8_decode($row['_email']), 0, 'L', false);//end of line
                        
                        $pdf->SetFont('Arial','B',9);
                        $pdf->Cell(35 ,4,utf8_decode('Status:'),0,0,'R');
                        $pdf->SetFont('Arial','',9);
                        
                        if ($row['_status'] == "pending_approval") {
                            $accountStatus = 'Pending approval';
                        } else if ($row['_status'] == "active") {
                            $accountStatus = 'Active';
                        } else if ($row['_status'] == "suspended_by_admin" || $row['_status'] == "automatically_suspended") {
                            $accountStatus = 'Suspended';
                        }
                        $pdf->MultiCell(154, 4, utf8_decode($accountStatus), 0, 'L', false);//end of line
                        
                        $pdf->Cell(189, 5, '', 0, 1);
                        
                        $array_data__count++;
                    }
                    
                    $i++;
                }
                
                $pdf->Cell(189, 5, '', 0, 1);
                $pdf->Cell(80 , 5,'', 0, 0);
                
                $pdf->SetFont('Arial','B',9);
                $pdf->Cell(75 ,5,utf8_decode('Total:'),0,0,'R');
                $pdf->SetFont('Arial','',9);
                $pdf->Cell(34, 5, $array_data__count . utf8_decode(' members'),0,1,'L');//end of line
            break;
            case "accounts__indicated__direct":
                $accountData = $this->accountsFromUsername($_GET['username']);
                $array_data = $this->findDirect($accountData['_id'], null, '', 9999);
                
                //set font to arial, bold, 14pt
                $pdf->SetFont('Arial','B',14);

                //Cell(width , height , text , border , end line , [align] )

                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(69 ,5,'',0,1);//end of line

                //set font to arial, regular, 12pt
                $pdf->SetFont('Arial','',12);
                
                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(25 ,5,utf8_decode('Date:'),0,0);
                $pdf->Cell(44 ,5,date('d/m/Y H:i:s', time()),0,1);//end of line

                //make a dummy empty cell as a vertical spacer
                $pdf->Cell(189 ,10,'',0,1);//end of line
                
                
                /*
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(35 ,5,utf8_decode('Listagem:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->MultiCell(154, 5, utf8_decode('Contas de usuário'), 0, 'L', false);//end of line
                
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(35 ,5,utf8_decode('Ano:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->Cell(154 ,5,utf8_decode('2020'),0,1);//end of line
                $pdf->SetFont('Arial','B',12);
                */
                
                $pdf->Cell(189, 4, '', 0, 1);
                
                
                $pdf->SetFont('Arial','B',12);
                //$pdf->Cell(189 ,5,utf8_decode($array_ticket['dozens']),0,0,'C', false);
                $pdf->MultiCell(189, 5, utf8_decode('Members report'),0,'C', false);
                $pdf->Cell(189, 6, '', 0, 1);
                
                
                $pdf->SetFont('Arial','B',9);
                $pdf->SetFillColor(230,230,230);
                $pdf->Cell(10,6,utf8_decode('ID'),0,0,'C',1);
                $pdf->Cell(65,6,utf8_decode('NAME'),0,0,'L',1);
                $pdf->Cell(32,6,utf8_decode('PHONE'),0,0,'C',1);
                $pdf->Cell(56,6,utf8_decode('EMAIL'),0,0,'L',1);
                $pdf->Cell(26,6,utf8_decode('STATUS'),0,1,'C',1);
                
                //$pdf->MultiCell(154, 5, utf8_decode('NOME'), 0, 'L', false);//end of line
                
                $pdf->SetFont('Arial','',9);
                
                $i = 1;
                $array_data__count = 0;
                $asColor = 0;
                foreach ($array_data as $row)
                {
                    if ($row['_id'] > 1) {
                        $pdf->Cell(10,6,utf8_decode($row['_id']),0,0,'C',$asColor);
                        $pdf->Cell(65,6,utf8_decode($row['_name']),0,0,'L',$asColor);
                        
                        $mobile_phone = '';
                        if ($row['_mobile_phone'] != "") {
                            $mobile_phone = (New Format)->phone($row['_mobile_phone']);
                        }
                        $pdf->Cell(32,6,utf8_decode($mobile_phone),0,0,'C',$asColor);
                        
                        $pdf->Cell(56,6,utf8_decode($row['_email']),0,0,'L',$asColor);
                        
                        if ($row['_status'] == "pending_approval") {
                            $accountStatus = 'Pending approval';
                        } else if ($row['_status'] == "active") {
                            $accountStatus = 'Active';
                        } else if ($row['_status'] == "suspended_by_admin" || $row['_status'] == "automatically_suspended") {
                            $accountStatus = 'Suspended';
                        }
                        $pdf->Cell(26,6,utf8_decode($accountStatus),0,1,'C',$asColor);
                        
                        if ($asColor == 0) {
                            $asColor = 1;
                        } else {
                            $asColor = 0;
                        }
                        
                        $array_data__count++;
                    }
                    
                    $i++;
                }
                
                $pdf->Cell(189, 5, '', 0, 1);
                $pdf->Cell(80 , 10,'', 0, 0);
                
                $pdf->SetFont('Arial','B',9);
                $pdf->Cell(75 ,5,utf8_decode('Total:'),0,0,'R');
                $pdf->SetFont('Arial','',9);
                $pdf->Cell(34, 5, $array_data__count . utf8_decode(' members'),0,1,'L');//end of line
            break;
            
            case "wallet__accounts__balance":
                $array_data = $this->find(null, null, '', 9999);
                
                //set font to arial, bold, 14pt
                $pdf->SetFont('Arial','B',14);

                //Cell(width , height , text , border , end line , [align] )

                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(69 ,5,'',0,1);//end of line

                //set font to arial, regular, 12pt
                $pdf->SetFont('Arial','',12);
                
                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(25 ,5,utf8_decode('Date:'),0,0);
                $pdf->Cell(44 ,5,date('d/m/Y H:i:s', time()),0,1);//end of line

                //make a dummy empty cell as a vertical spacer
                $pdf->Cell(189, 10, '', 0, 1);//end of line
                
                
                $pdf->SetFont('Arial','B',12);
                //$pdf->Cell(189 ,5,utf8_decode($array_ticket['dozens']),0,0,'C', false);
                $pdf->MultiCell(189, 5, utf8_decode('Members balance report'),0,'C', false);
                $pdf->Cell(189, 5, '', 0, 1);
                
                $pdf->SetFont('Arial','B',9);
                $pdf->SetFillColor(230,230,230);
                $pdf->Cell(40,6,utf8_decode('USERNAME'),0,0,'L',1);
                $pdf->Cell(115,6,utf8_decode('NAME'),0,0,'L',1);
                $pdf->Cell(34,6,utf8_decode('BALANCE'),0,1,'C',1);
                
                $pdf->SetFont('Arial','',9);
                
                $i = 1;
                $array_data__count = 0;
                $array_data__sumWalletTotal = 0.0;
                $asColor = 0;
                foreach ($array_data as $row)
                {
                    if ($row['_id'] > 1) {
                        $walletTotal = (float)(new Wallet)->getBalanceFromAccountsID($row['_id']);
                        
                        if ($walletTotal > 0) {
                            $pdf->Cell(40,6,utf8_decode($row['_username']),0,0,'L',$asColor);
                            $pdf->Cell(115,6,utf8_decode($row['_name']),0,0,'L',$asColor);
                            $pdf->Cell(34,6,utf8_decode("USD " . number_format($walletTotal, 2, ',', '.')),0,1,'C',$asColor);
                            
                            if ($asColor == 0) {
                                $asColor = 1;
                            } else {
                                $asColor = 0;
                            }
                            
                            $array_data__sumWalletTotal += $walletTotal;
                            $array_data__count++;
                        }
                    }
                    
                    $i++;
                }
                
                
                $pdf->Cell(189 , 5,'', 0, 1);
                $pdf->Cell(80 , 5,'', 0, 0);
                $pdf->SetFont('Arial','B',9);
                $pdf->Cell(75 ,5,utf8_decode('Member(s) with balance:'),0,0,'R');
                $pdf->SetFont('Arial','',9);
                $pdf->Cell(34, 5, $array_data__count,0,1,'L');//end of line
                
                $pdf->Cell(80 , 5,'', 0, 0);
                $pdf->SetFont('Arial','B',9);
                $pdf->Cell(75 ,5,utf8_decode('Total balance:'),0,0,'R');
                $pdf->SetFont('Arial','',9);
                $pdf->Cell(34, 5, "USD " . number_format($array_data__sumWalletTotal, 2, ',', '.'),0,1,'L');//end of line
            break;
            case "wallet__ballance":
                //set font to arial, bold, 14pt
                $pdf->SetFont('Arial','B',14);

                //Cell(width , height , text , border , end line , [align] )

                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(69 ,5,'',0,1);//end of line

                //set font to arial, regular, 12pt
                $pdf->SetFont('Arial','',12);
                
                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(25 ,5,utf8_decode('Date:'),0,0);
                $pdf->Cell(44 ,5,date('d/m/Y H:i:s', time()),0,1);//end of line

                //make a dummy empty cell as a vertical spacer
                $pdf->Cell(189, 10, '', 0, 1);//end of line
                
                
                $pdf->SetFont('Arial','B',12);
                //$pdf->Cell(189 ,5,utf8_decode($array_ticket['dozens']),0,0,'C', false);
                $pdf->MultiCell(189, 5, utf8_decode('Balance report'),0,'C', false);
                $pdf->Cell(189, 5, '', 0, 1);
                
                $pdf->SetFont('Arial','B',9);
                $pdf->SetFillColor(230,230,230);
                $pdf->Cell(40,6,utf8_decode('USERNAME'),0,0,'L',1);
                $pdf->Cell(115,6,utf8_decode('NAME'),0,0,'L',1);
                $pdf->Cell(34,6,utf8_decode('BALANCE'),0,1,'C',1);
                
                $pdf->SetFont('Arial','',9);
                
                if ($_GET['username'] != "") {
                    $accountData = $this->accountsFromUsername($_GET['username']);
                    $walletTotal = (float)(new Wallet)->getBalanceFromAccountsID($accountData['_id']);
                    
                    $pdf->Cell(40,6,utf8_decode($accountData['_username']),0,0,'L',0);
                    $pdf->Cell(115,6,utf8_decode($accountData['_name']),0,0,'L',0);
                    $pdf->Cell(34,6,utf8_decode("USD " . number_format($walletTotal, 2, ',', '.')),0,1,'C',0);
                } else {
                    $walletTotal = (float)(new Wallet)->getBalanceFromAccountsID(0);
                    
                    $pdf->Cell(40,6,utf8_decode('Financial'),0,0,'L',0);
                    $pdf->Cell(115,6,utf8_decode('Financial'),0,0,'L',0);
                    $pdf->Cell(34,6,utf8_decode("USD " . number_format($walletTotal, 2, ',', '.')),0,1,'C',0);
                }
            break;
            case "wallet__ballance__details":
                //set font to arial, bold, 14pt
                $pdf->SetFont('Arial','B',14);

                //Cell(width , height , text , border , end line , [align] )

                $pdf->Cell(207 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(69 ,5,'',0,1);//end of line

                //set font to arial, regular, 12pt
                $pdf->SetFont('Arial','',12);
                
                $pdf->Cell(207 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(25 ,5,utf8_decode('Date:'),0,0);
                $pdf->Cell(44 ,5,date('d/m/Y H:i:s', time()),0,1);//end of line

                //make a dummy empty cell as a vertical spacer
                $pdf->Cell(276, 10, '', 0, 1);//end of line
                
                
                $pdf->SetFont('Arial','B',12);
                //$pdf->Cell(189 ,5,utf8_decode($array_ticket['dozens']),0,0,'C', false);
                if ($_GET['username'] != "") {
                    $pdf->MultiCell(276, 5, utf8_decode('Balance details [username: '.$_GET['username'].']'),0,'C', false);
                } else {
                    $pdf->MultiCell(276, 5, utf8_decode('Balance details'),0,'C', false);
                }
                
                $pdf->Cell(276, 5, '', 0, 1);
                
                $pdf->SetFont('Arial','B',9);
                $pdf->SetFillColor(230,230,230);
                $pdf->Cell(60,6,utf8_decode('REFERENCE'),0,0,'L',1);
                $pdf->Cell(111,6,utf8_decode('DESCRIPTION'),0,0,'L',1);
                $pdf->Cell(25,6,utf8_decode('TYPE'),0,0,'C',1);
                $pdf->Cell(25,6,utf8_decode('AMOUNT'),0,0,'C',1);
                $pdf->Cell(25,6,utf8_decode('DATE'),0,0,'C',1);
                $pdf->Cell(30,6,utf8_decode('STATUS'),0,1,'C',1);
                
                $pdf->SetFont('Arial','',9);
                
                $accountId = 0;
                if ($_GET['username'] != "") {
                    $accountData = $this->accountsFromUsername($_GET['username']);
                    $accountId = $accountData['_id'];
                }
                
                $array_data = (New Wallet)->find(null, $accountId, $_GET['date_of'], $_GET['date_until'], null, null, null, 9999);
                
                $i = 1;
                $array_data__sumWalletTotal = 0.0;
                $array_data__sumWalletTotalCredit = 0.0;
                $array_data__sumWalletTotalDebit = 0.0;
                $asColor = 0;
                foreach ($array_data as $row)
                {
                    $pdf->Cell(60,6,utf8_decode($row['_reference']),0,0,'L',$asColor);
                    $pdf->Cell(111,6,utf8_decode($row['_description']),0,0,'L',$asColor);
                    
                    $type = '';
                    switch($row['_type']){
                        case 'withdraw':
                            $type = 'Withdraw';
                        break;
                        case 'tariff':
                            $type = 'Tariff';
                        break;
                        case 'insertion':
                            $type = 'Insertion';
                        break;
                        case 'purchase':
                            $type = 'Purchase';
                        break;
                        case 'credit':
                            $type = 'Credit';
                        break;
                        case 'debit':
                            $type = 'Debit';
                        break;
                        case 'bonus':
                            $type = 'Bonus';
                        break;
                        case 'profit':
                            $type = 'Profit';
                        break;
                    }
                    $pdf->Cell(25,6,utf8_decode($type),0,0,'C',$asColor);
                    
                    if ($row['_amount'] < 0) {
                        $pdf->SetTextColor(222,0,0);
                    }
                    
                    $pdf->Cell(25,6,utf8_decode("USD " . number_format($row['_amount'], 2, ',', '.')),0,0,'C',$asColor);
                    $pdf->SetTextColor(0,0,0);
                    
                    //$pdf->Cell(25,6,utf8_decode(date( "m/d/Y \à\s h:i:s A", strtotime($row['_created_at']))),0,0,'C',$asColor);
                    $pdf->Cell(25,6,utf8_decode(date( "m/d/Y", strtotime($row['_created_at']))),0,0,'C',$asColor);
                    
                    $status = '';
                    switch($row['_status']){
                        case 'pending':
                            $status = 'Pending';
                        break;
                        case 'blocked':
                            $status = 'Blocked';
                        break;
                        case 'effected':
                            $status = 'Effected';
                        break;
                        case 'canceled':
                            $status = 'Canceled';
                        break;
                    }
                    $pdf->Cell(30,6,utf8_decode($status),0,1,'C',$asColor);
                    
                    if ($asColor == 0) {
                        $asColor = 1;
                    } else {
                        $asColor = 0;
                    }
                    
                    if ($row['_type'] == 'insertion' || $row['_type'] == 'credit' || $row['_type'] == 'bonus' || $row['_type'] == 'profit') {
                        $array_data__sumWalletTotalCredit += $row['_amount'];
                    }
                    if ($row['_type'] == 'withdraw' || $row['_type'] == 'tariff' || $row['_type'] == 'purchase' || $row['_type'] == 'debit') {
                        $array_data__sumWalletTotalDebit += $row['_amount'];
                    }
                    $array_data__sumWalletTotal += $row['_amount'];
                    
                    $i++;
                }
                
                $pdf->Cell(276, 5, '', 0, 1);//end of line
                
                $pdf->Cell(167 , 5,'', 0, 0);
                $pdf->SetFont('Arial','B',9);
                $pdf->Cell(75 ,5,utf8_decode('CREDIT PERIOD:'),0,0,'R');
                $pdf->SetFont('Arial','',9);
                $pdf->Cell(34, 5, "USD " . number_format($array_data__sumWalletTotalCredit, 2, ',', '.'),0,1,'L');//end of line
                
                $pdf->Cell(167 , 5,'', 0, 0);
                $pdf->SetFont('Arial','B',9);
                $pdf->Cell(75 ,5,utf8_decode('DEBIT PERIOD:'),0,0,'R');
                $pdf->SetFont('Arial','',9);
                
                if ($array_data__sumWalletTotalDebit < 0) {
                    $pdf->SetTextColor(222,0,0);
                }
                $pdf->Cell(34, 5, "USD " . number_format($array_data__sumWalletTotalDebit, 2, ',', '.'),0,1,'L');//end of line
                $pdf->SetTextColor(0,0,0);
                
                $pdf->Cell(167 , 5,'', 0, 0);
                $pdf->SetFont('Arial','B',9);
                $pdf->Cell(75 ,5,utf8_decode('TOTAL:'),0,0,'R');
                $pdf->SetFont('Arial','',9);
                $pdf->Cell(34, 5, "USD " . number_format($array_data__sumWalletTotal, 2, ',', '.'),0,1,'L');//end of line
            break;
            case "withdrawal_pending":
            case "withdrawal_made":
                if ($args_type == "withdrawal_pending") {
                    $array_data = (new Cashout)->find(null, null, null, null, 'waiting', 'DESC', 999999);
                } else if ($args_type == "withdrawal_made") {
                    $array_data = (new Cashout)->find(null, null, null, null, 'accomplished', 'DESC', 999999);
                }
                
                //set font to arial, bold, 14pt
                $pdf->SetFont('Arial','B',14);

                //Cell(width , height , text , border , end line , [align] )

                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(69 ,5,'',0,1);//end of line

                //set font to arial, regular, 12pt
                $pdf->SetFont('Arial','',12);
                
                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(25 ,5,utf8_decode('Date:'),0,0);
                $pdf->Cell(44 ,5,date('d/m/Y H:i:s', time()),0,1);//end of line

                //make a dummy empty cell as a vertical spacer
                $pdf->Cell(189, 25, '', 0, 1);//end of line
                
                
                $pdf->SetFont('Arial','B',12);
                //$pdf->Cell(189 ,5,utf8_decode($array_ticket['dozens']),0,0,'C', false);
                if ($args_type == "withdrawal_pending") {
                    $pdf->MultiCell(189, 5, utf8_decode('Report withdrawal pending'),0,'C', false);
                } else if ($args_type == "withdrawal_made") {
                    $pdf->MultiCell(189, 5, utf8_decode('Report withdrawal accomplished'),0,'C', false);
                }
                $pdf->Cell(189, 5, '', 0, 1);
                
                $i = 1;
                $array_data__count = 0;
                $array_data__sumCashoutTotal = 0.0;
                $array_data__sumCashoutTotalServiceFee = 0.0;
                $array_data__sumCashoutTotalNetAmount = 0.0;
                foreach ($array_data as $row)
                {
                    if ($row['_id'] > 0) {
                        $accountsData = $this->find($row['_accounts__id']);
                        
                        if ($row['_amount'] > 0) {
                            $pdf->SetFont('Arial','B',12);
                            $pdf->Cell(35 ,5,utf8_decode('ID / Name:'),0,0,'R');
                            $pdf->SetFont('Arial','',12);
                            $pdf->MultiCell(154, 5, utf8_decode($accountsData['_id'] . ' - ' . $accountsData['_name']), 0, 'L', false);//end of line
                            
                            $pdf->SetFont('Arial','B',12);
                            $pdf->Cell(35 ,5,utf8_decode('Amount requested:'),0,0,'R');
                            $pdf->SetFont('Arial','',12);
                            $pdf->MultiCell(154, 5, utf8_decode("USD " . number_format($row['_amount'], 2, ',', '.')), 0, 'L', false);//end of line
                            
                            $pdf->SetFont('Arial','B',12);
                            $pdf->Cell(35 ,5,utf8_decode('Fee:'),0,0,'R');
                            $pdf->SetFont('Arial','',12);
                            if ($row['_service_fee'] > 0) {
                                $pdf->SetTextColor(222,0,0);
                                $pdf->MultiCell(154, 5, utf8_decode("USD " . number_format($row['_service_fee'], 2, ',', '.')), 0, 'L', false);//end of line
                            } else {
                                $pdf->MultiCell(154, 5, utf8_decode("USD " . number_format($row['_service_fee'], 2, ',', '.')), 0, 'L', false);//end of line
                            }
                            
                            $pdf->SetFont('Arial','B',12);
                            $pdf->SetTextColor(0,0,0);
                            $pdf->Cell(35 ,5,utf8_decode('Amount paid:'),0,0,'R');
                            $pdf->MultiCell(154, 5, utf8_decode("USD " . number_format($row['_net_amount'], 2, ',', '.')), 0, 'L', false);//end of line
                            
                            
                            $pdf->Cell(189, 5, '', 0, 1);
                            
                            $array_data__sumCashoutTotal += $row['_amount'];
                            $array_data__sumCashoutTotalServiceFee += $row['_service_fee'];
                            $array_data__sumCashoutTotalNetAmount += $row['_net_amount'];
                            $array_data__count++;
                        }
                    }
                    
                    $i++;
                }
                
                
                $pdf->Cell(80 , 5,'', 0, 0);
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(75 ,5,utf8_decode('Total requested:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                if ($array_data__count == 1) {
                    $pdf->Cell(34, 5, $array_data__count . utf8_decode(' withdrawal'),0,1,'R');//end of line
                } else {
                    $pdf->Cell(34, 5, $array_data__count . utf8_decode(' withdrawal'),0,1,'R');//end of line
                }
                
                $pdf->Cell(80 , 5,'', 0, 0);
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(75 ,5,utf8_decode('Total requested:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->Cell(34, 5, "USD " . number_format($array_data__sumCashoutTotal, 2, ',', '.'),0,1,'R');//end of line
                
                $pdf->Cell(80 , 5,'', 0, 0);
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(75 ,5,utf8_decode('Total fee:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->SetTextColor(222,0,0);
                $pdf->Cell(34, 5, "USD " . number_format($array_data__sumCashoutTotalServiceFee, 2, ',', '.'),0,1,'R');//end of line
                
                $pdf->Cell(80 , 5,'', 0, 0);
                $pdf->SetFont('Arial','B',12);
                $pdf->SetTextColor(0,0,0);
                $pdf->Cell(75 ,5,utf8_decode('Total withdrawal:'),0,0,'R');
                $pdf->Cell(34, 5, "USD " . number_format($array_data__sumCashoutTotalNetAmount, 2, ',', '.'),0,1,'R');//end of line
            break;
        }
        
        
        //header("Access-Control-Allow-Origin: http://localhost/REST API AUTHENTICATION/");
        header("Content-Type: application/json; charset=UTF-8");
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Max-Age: 3600");
        header("Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD");
        header("Access-Control-Allow-Headers: Content-Type, Accept, Access-Control-Allow-Headers, Authorization, Origin, X-Requested-With, X-Api-Key");
        //header('Access-Control-Allow-Credentials: true');
        
        ob_start();
        $pdf->Output();
        ob_end_flush();
    }
}
?>
