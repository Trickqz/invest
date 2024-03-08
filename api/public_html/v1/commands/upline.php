<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    
    
    require_once(str_replace("/commands", "", dirname(__FILE__)) . '/dao/conn.php');
    require_once(str_replace("/commands", "", dirname(__FILE__)) . '/class/class.json.php');
    
    $upline = (new Accounts)->network__gen_upLine(14, null);
    if (sizeof($upline) > 0) {
        for ($i=0;$i<sizeof($upline);$i++){
            echo 'level: '.($i+1).'<br />';
            
            switch(($i+1)){
                case 1:
                    echo '10%<br />';
                break;
                case 3:
                case 5:
                case 7:
                case 9:
                case 20:
                    echo '2%<br />';
                break;
                case 2:
                case 3:
                case 4:
                case 5:
                case 10:
                case 19:
                    echo '1%<br />';
                break;
                case 11:
                case 12:
                case 13:
                case 14:
                case 15:
                case 16:
                case 17:
                case 18:
                    echo '0.5%<br />';
                break;
            }
            
            var_dump($upline[$i]['_id']);
            echo '<br /><br />';
        }
    }
    
    //(new Json)->echoJson(array("success" => true, "data" => $upline));
?>
