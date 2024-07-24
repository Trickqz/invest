<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    
    $ini = parse_ini_file(str_replace("/commands", "", str_replace('\\',  '/', dirname(__FILE__))) . '/config/config.ini.php');

    define('OPENSUPPORTS_ENABLED',    $ini['OPENSUPPORTS_ENABLED']);
    define('OPENSUPPORTS_API_URL',    $ini['OPENSUPPORTS_API_URL']);
    
    
    $url = OPENSUPPORTS_API_URL . '/user/signup';
    
    $fields = array(
        'csrf_token' => '',
        'csrf_userid' => '',
        'captcha' => 'valid',
        'name' => $_GET['name'],
        'email' => $_GET['email'],
        'password' => $_GET['password'],
        'repeated-password' => $_GET['password']
    );
    
    //$data_string = json_encode( $fields );
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => false,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "POST",
        //CURLOPT_POSTFIELDS =>$data_string,
        CURLOPT_POSTFIELDS =>$fields,
        CURLOPT_HTTPHEADER => array(
            //"Content-Type: application/json",
            //'Content-Length: ' . strlen( $data_string ),
            //"Authentication: " . $authentication__transaction
        ),
    ));
    
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_setopt($curl,CURLOPT_SSL_VERIFYHOST, FALSE);
    
    $response = curl_exec($curl);
    $err = curl_error($curl);
    
    var_dump($response);
    var_dump($err);
    
    curl_close($curl);
    
    //return $response;
?>
