<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    
    
    require_once(str_replace("/commands", "", dirname(__FILE__)) . '/dao/conn.php');
    require_once(str_replace("/commands", "", dirname(__FILE__)) . '/class/class.json.php');
    
    $upline = (new Accounts)->network__gen_binary_upLine(23, null);
    (new Json)->echoJson($upline);
?>
