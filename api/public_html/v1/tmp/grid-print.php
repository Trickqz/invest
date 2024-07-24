<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    
    
    require_once(str_replace("/commands", "", str_replace('\\',  '/', dirname(__FILE__))) . '/dao/conn.php');
    require_once(str_replace("/commands", "", str_replace('\\',  '/', dirname(__FILE__))) . '/class/class.json.php');
    
    $accountsGrid = (new Accounts)->network__list(4, 20);  //219
    $grid = (new Accounts)->network__gen_grid($accountsGrid);
    (new Json)->echoJson(array("success" => true, "data" => $grid));
    
    /* ERROR COUNT */
?>
