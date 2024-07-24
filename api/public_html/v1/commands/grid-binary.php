<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    
    
    require_once(str_replace("/commands", "", str_replace('\\',  '/', dirname(__FILE__))) . '/dao/conn.php');
    require_once(str_replace("/commands", "", str_replace('\\',  '/', dirname(__FILE__))) . '/class/class.json.php');
    
    //$accountsGrid = (new Accounts)->network_binary__find_bin_ind(3, 'right', 9999);
    $accountsGrid = (new Accounts)->network_binary__find_bin_ind($_GET['id'], $_GET['side'], 9999);
    (new Json)->echoJson($accountsGrid[0]);
    (new Json)->echoJson($accountsGrid[1]);
?>
