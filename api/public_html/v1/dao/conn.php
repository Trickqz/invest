<?php
    /**
    * INI Database Connection
    */
    $ini = parse_ini_file(str_replace("/dao", "", str_replace('\\',  '/', dirname(__FILE__))) . '/config/config.ini.php');

    define('DB_CONNECTION', $ini['DB_CONNECTION']);
    define('DB_HOST',       $ini['DB_HOST']);
    define('DB_PORT',       $ini['DB_PORT']);
    define('DB_DATABASE',   $ini['DB_DATABASE']);
    define('DB_USERNAME',   $ini['DB_USERNAME']);
    define('DB_PASSWORD',   $ini['DB_PASSWORD']);
    define('DB_CHARSET',    $ini['DB_CHARSET']);
    
    define('OPENSUPPORTS_ENABLED',    $ini['OPENSUPPORTS_ENABLED']);
    define('OPENSUPPORTS_API_URL',    $ini['OPENSUPPORTS_API_URL']);


    // PDO
    require __DIR__ . '/pdo/pdo.php';


    // DBClass
    $files = core__getDirContents(str_replace("/dao", "", str_replace('\\',  '/', dirname(__FILE__))) . '/dao/objects');
    foreach($files as $file => $value){
        ob_start();
        require $value;
        ob_end_clean();
    }
    
    function core__getDirContents($dir, &$results = array()){
        $files = scandir($dir);
        
        foreach($files as $key => $value){
            $path = realpath($dir.DIRECTORY_SEPARATOR.$value);
            if(!is_dir($path)) {
                $results[] = $path;
            } else if($value != "." && $value != "..") {
                core__getDirContents($path, $results);
                $results[] = $path;
            }
        }
        
        return $results;
    }
?>
