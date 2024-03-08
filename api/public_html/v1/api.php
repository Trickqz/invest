<?php
    /**
    * INI APP SETTINGS
    */
    $ini = parse_ini_file(dirname(__FILE__) . '/config/config.ini.php');
    //if ($ini['APP_DEBUG'] == true) {
    //    ini_set('display_errors', 1);
    //    ini_set('display_startup_errors', 1);
    //    error_reporting(E_ALL);
    //}
    
    date_default_timezone_set($ini['APP_DEFAULT_TIMEZONE']);
    
    
    
    /**
     * DAO
     */
    require_once(dirname(__FILE__) . '/dao/conn.php');
    
    /**
     * FUNCTIONS / OTHERS
     */
    require_once(dirname(__FILE__) . '/functions.php');
    require_once(dirname(__FILE__) . '/custom__settings.php');
    
    /**
     * TOKEN
     */
    require_once(dirname(__FILE__) . '/jwt.php');
    
    /**
     * CLASS
     */
    require_once(dirname(__FILE__) . '/class/class.curl.php');
    require_once(dirname(__FILE__) . '/class/class.date.php');
    require_once(dirname(__FILE__) . '/class/class.string.format.php');
    require_once(dirname(__FILE__) . '/class/class.string.initials.php');
    require_once(dirname(__FILE__) . '/class/class.string.validate.php');
    require_once(dirname(__FILE__) . '/class/class.mailer.php');
    require_once(dirname(__FILE__) . '/class/class.json.php');
    require_once(dirname(__FILE__) . '/class/class.uuid.php');
    require_once(dirname(__FILE__) . '/class/class.services.bankon.php');
    require_once(dirname(__FILE__) . '/class/class.eth.php');
    require_once(dirname(__FILE__) . '/class/class.services.coinbase.php');
    require_once(dirname(__FILE__) . '/class/class.youtube.php');
    require_once(dirname(__FILE__) . '/class/class.services.neo7i.spaces.php');
    require_once(dirname(__FILE__) . '/class/coinbase-commerce/vendor/autoload.php');  // Include Composer autoload
    
    /**
     * PHP-JWT
     */
    require_once dirname(__FILE__) . '/vendor/php-jwt/src/BeforeValidException.php';
    require_once dirname(__FILE__) . '/vendor/php-jwt/src/ExpiredException.php';
    require_once dirname(__FILE__) . '/vendor/php-jwt/src/SignatureInvalidException.php';
    require_once dirname(__FILE__) . '/vendor/php-jwt/src/JWT.php';
    use \Firebase\JWT\JWT;
    
    
    /**
     * FPDF
     */
    require_once dirname(__FILE__) . '/vendor/fpdf/fpdf.php';
    
    
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
    
    
    // CLIENT INFO
    if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
        define("CLIENT_IP", $_SERVER['HTTP_CLIENT_IP']);
    } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        define("CLIENT_IP", $_SERVER['HTTP_X_FORWARDED_FOR']);
    } else {
        define("CLIENT_IP", $_SERVER['REMOTE_ADDR']);
    }
    
    define("USER_AGENT", $_SERVER['HTTP_USER_AGENT']);
    
    
    
    // AltoRouter
    // http://altorouter.com/usage/mapping-routes.html
    require(dirname(__FILE__) . '/vendor/AltoRouter/AltoRouter.php');
    $router = new AltoRouter();
    $router->setBasePath('');  // /altorouter
    
    $router->map('OPTIONS', '*', function(){
        header("Content-Type: application/json; charset=UTF-8");
        header("Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD");
        header("Access-Control-Max-Age: 3600");
        header("Access-Control-Allow-Headers: Content-Type, Accept, Access-Control-Allow-Headers, Authorization, Origin, X-Requested-With");
        header("Access-Control-Allow-Origin: *");
        
        http_response_code(204);
    });
    
    
    /**
     *  POST    /v1/auth
     *  POST    /v1/auth/token
     *  POST    /v1/auth/password/reset
     *  POST    /v1/auth/password/check-code
     *  POST    /v1/auth/password
     * 
     *  POST    /v1/accounts/check-username-available
     *  POST    /v1/accounts/check-email-available
     *  POST    /v1/accounts/check-indicator
     *  POST    /v1/accounts/check-cpf-available
     *  GET     /v1/accounts
     *  GET     /v1/accounts/[i:id]
     *  POST    /v1/accounts
     * POST', '/v1/accounts/[i:id]
     * GET', '/v1/accounts/profile
     * POST','/v1/accounts/setStatus/[i:_id]
     * POST','/v1/accounts/setChatBanned/[i:_id]
     * DELETE', '/v1/accounts/[i:id]
     * GET', '/v1/session/account
     * POST', '/v1/session/account
     * POST', '/v1/session/account/terms/accept
     * POST', '/v1/session/account/setCashout_day
     * POST', '/v1/session/account/profileImage
     * GET','/v1/session/account/indicated
     * GET','/v1/session/account/unilevel/[:username]/info
     * GET','/v1/session/account/unilevel/[:username]/direct
     * GET', '/v1/session/account/resume
     * GET','/v1/export/accounts/csv
     * GET','/v1/export/accounts/xls
     *  
     *  GET','/v1/contact
     *  GET','/v1/contact/[i:id]
     *  POST', '/v1/contact
     *  POST','/v1/contact/setReaded/[i:_id]
     *  POST','/v1/contact/setAllReaded
     *  DELETE', '/v1/contact/[i:id]
     *  GET','/v1/export/contact/csv
     *  GET','/v1/export/contact/xls
     * 
     *  +// cron.php
     *  +// donations.php
     *  +// donations_model.php
     *  +// logs.php
     *  +// notifications.php
     *  +// payment.php
     *  +// reports.php
     *  +// settings.php
     *  +// wallet.php
     */
    
    require __DIR__ . '/routes/accounts.php';
    require __DIR__ . '/routes/auth.php';
    require __DIR__ . '/routes/cron.php';
    /*require __DIR__ . '/routes/contact.php';*/
    require __DIR__ . '/routes/bonus.php';
    require __DIR__ . '/routes/bonification.php';
    require __DIR__ . '/routes/donations.php';
    require __DIR__ . '/routes/donations_model.php';
    /*require __DIR__ . '/routes/ext.bankon.php';*/
    require __DIR__ . '/routes/income.php';
    require __DIR__ . '/routes/personal_income.php';
    require __DIR__ . '/routes/notifications.php';
    require __DIR__ . '/routes/points.php';
    require __DIR__ . '/routes/logs.php';
    require __DIR__ . '/routes/reports.php';
    require __DIR__ . '/routes/search.php';
    require __DIR__ . '/routes/settings.php';
    require __DIR__ . '/routes/statistics.php';
    /*require __DIR__ . '/routes/system.php';*/
    require __DIR__ . '/routes/upload.php';
    require __DIR__ . '/routes/users.php';
    require __DIR__ . '/routes/wallet.php';
    
    $match = $router->match();
    if( $match && is_callable( $match['target'] ) ) {
    	call_user_func_array( $match['target'], $match['params'] ); 
    } else {
    	(new Json)->echoJson(array("message" => "Method Not Allowed."), 405);
    }
?>
