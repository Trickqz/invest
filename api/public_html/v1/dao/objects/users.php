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


class Users {
    private $conn;
    private $table_name = "accounts";
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    // create() method will be here
    // create new user record
    public function create($args_name, $args_email, $args_username, $args_password, $args_role, $args_status = "active"){
        // query
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _hash = :args_hash, 
                    _unilevel_id_master = 0, 
                    _indicator__accounts_id = 0, 
                    _type = 'natural_person', 
                    _name = :args_name, 
                    _email = :args_email, 
                    _username = :args_username, 
                    _password = :args_password, 
                    _role = :args_role, 
                    _status = :args_status";
        
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_hash', newMD5Hash());
        $this->conn->bind(':args_name', $args_name);
        $this->conn->bind(':args_email', $args_email);
        $this->conn->bind(':args_username', $args_username);
        $this->conn->bind(':args_role', $args_role);
        $this->conn->bind(':args_status', $args_status);
        
        // hash the password before saving to database
        $password_hash = password_hash($args_password, PASSWORD_BCRYPT);
        $this->conn->bind(':args_password', $password_hash);
        
        // execute the query, also check if query was successful
        if ($this->conn->execute()) {
            $system_emails_data = (new System_emails)->findObject('users__register');
            $template = $system_emails_data['_content'];
            $phpStr = LightnCandy::compile($template);
            $renderer = LightnCandy::prepare($phpStr);
            $content = $renderer(array(
                    'username' => $args_username,
                    'date' => date("d/m/Y h:i:s"),
                    'name' => $args_name,
                    'password' => $args_password,
                    'telegram' => (new Settings)->findValue('social__telegram'),
                    'whatsapp' => (new Settings)->findValue('social__whatsapp'),
                    'instagram' => (new Settings)->findValue('social__instagram'),
                    'facebook' => (new Settings)->findValue('social__facebook'),
                    'youtube' => (new Settings)->findValue('social__youtube'),
                    'twitter' => (new Settings)->findValue('social__twitter')
                ));
            
            (new Mailer)->send($args_email, $args_name, $system_emails_data['_subject'], $content, $content);
            
            // auto login
            $accounts_data = (new Accounts)->accountsFromUsername($args_username);
            
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
    
    
    public function find($args_id = null, $args_q = null, $args_status = '', $args_limit = 50)
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE 
                    _id = :args_id 
                LIMIT 0,1";
        } else if ($args_q) {
            $qry = "SELECT * 
                FROM " . $this->table_name . "
                WHERE 
                    _role != 'developer' AND 
                    (_name LIKE '%$args_q%' OR _username LIKE '%$args_q%' OR _email LIKE '%$args_q%')";
            
            if ($args_status != '*' && $args_status != '') {
                $qry .= " AND _status = :args_status";
            }
            
            $qry .= " AND (_role = 'administrator' OR _role = 'financial' OR _role = 'support')";
            
            if ($args_limit != null) {
                $qry .= " LIMIT 0,$args_limit";
            }
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name . "
                WHERE
                    _role != 'developer'";
            
            if ($args_status != '*' && $args_status != '') {
                $qry .= " AND _status = :args_status";
            }
            
            $qry .= " AND (_role = 'administrator' OR _role = 'financial' OR _role = 'support')";
            
            if ($args_limit != null) {
                $qry .= " LIMIT 0,$args_limit";
            }
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            return $this->conn->single();
        } else {
            if ($args_status != '*' && $args_status != '') {
                $this->conn->bind(':args_status', $args_status);
            }
            return $this->conn->resultSet();
        }
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
    
    public function updateUsers($_id, $_role, $_name, $_email, $_password)
    {
        $qry = "UPDATE 
            " . $this->table_name . " 
            SET  
                _role = :_role, 
                _name = :_name, 
                _email = :_email, 
                _updated_at = NOW() 
            WHERE 
                _id = :_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':_id', $_id);
        $this->conn->bind(':_role', $_role);
        $this->conn->bind(':_name', $_name);
        $this->conn->bind(':_email', $_email);
        
        if ($_password != "") {
            $data = (new Accounts)->find($_id);
            (new Accounts)->passwordUpdate($data['_username'], null, $_password);
        }
        
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
}
?>
