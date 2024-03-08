<?php
    /**
     * PHP-JWT
     */
    /**
       {
          "username": "wondercosmetics",
          "sub": "wondercosmetics",
          "role": "administrator",
          "droplet": "Trade_5ca248f0-a23d-b577-7f0f-0927",
          "exp": 1649348681
        }
     */
    require_once $_SERVER[ 'DOCUMENT_ROOT' ] . '/v1/vendor/php-jwt/src/BeforeValidException.php';
    require_once $_SERVER[ 'DOCUMENT_ROOT' ] . '/v1/vendor/php-jwt/src/ExpiredException.php';
    require_once $_SERVER[ 'DOCUMENT_ROOT' ] . '/v1/vendor/php-jwt/src/SignatureInvalidException.php';
    require_once $_SERVER[ 'DOCUMENT_ROOT' ] . '/v1/vendor/php-jwt/src/JWT.php';
    use \Firebase\JWT\JWT;
    
    
    function authGetUserId() {
        // HEADERS
        if (!function_exists('getallheaders')) {
            foreach ($_SERVER as $name => $value) {
                /* RFC2616 (HTTP/1.1) defines header fields as case-insensitive entities. */
                if (strtolower(substr($name, 0, 5)) == 'http_') {
                    $headers[str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))))] = $value;
                }
            }
            
            $request_headers = $headers;
        } else {
            $request_headers = getallheaders();
        }
        
        
        // CHECK TOKEN
        $jwt = isset($request_headers['Authorization']) ? $request_headers['Authorization'] : "";
        if (empty($jwt)) {
            $jwt = isset($_COOKIE['__utmo']) ? $_COOKIE['__utmo'] : "";
        }
        if ($jwt){
            try {
                $decoded = JWT::decode($jwt, (new Settings)->findValue('jwt__key'), array('HS256'));
                
                $accounts_data = (new Accounts)->accountsFromUsername($decoded->username);
                return $accounts_data['_id'];
                //return $decoded->_id;
            } catch (Exception $e){
                return null;
            }
        } else {
            return null;
        }
    }
?>
