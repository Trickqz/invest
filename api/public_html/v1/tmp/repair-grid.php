<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    
    
    require_once(str_replace("/commands", "", dirname(__FILE__)) . '/dao/conn.php');
    
    $accounts = (new Accounts)->find(null, null, '', 99999);
    foreach ($accounts as $row) {
        //if ($row['_id'] < 10) {
            echo $row['_username'] . '<br />';
            
            $dataGrid = array();
            $break = false;
            $nextId = $row['_id'];
            while($break == false){
                $account = (new Accounts)->find($nextId);
                if ($account['_id'] > 0) {
                    array_push($dataGrid, $account['_unilevel_id_master']);
                    $nextId = $account['_unilevel_id_master'];
                } else {
                    $break = true;
                }
            }
            
            $level = count($dataGrid);
            foreach ($dataGrid as $row2) {
                (new Network_grid)->create($level, $row2, $row['_indicator__accounts_id'], $row['_id']);
                $level--;
            }
        //}
    }
?>
