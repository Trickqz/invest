<?php
    // https://vijayasankarn.wordpress.com/2017/07/11/php-ini-parser-with-environment-support/
    
    /*
     * // Simple Call: List all files
        var_dump(getDirContents('/xampp/htdocs/WORK'));

        // Regex Call: List php files only
        var_dump(getDirContents('/xampp/htdocs/WORK', '/\.php$/'));
     */
class Dir
{
    function getContents($dir, $filter = '', &$results = array()) {
        $files = scandir($dir);

        foreach($files as $key => $value){
            $path = realpath($dir.DIRECTORY_SEPARATOR.$value); 

            if(!is_dir($path)) {
                if(empty($filter) || preg_match($filter, $path)) $results[] = $path;
            } elseif($value != "." && $value != "..") {
                getDirContents($path, $filter, $results);
            }
        }

        return $results;
    }
    
    function stripFirstLine($text)
    {
        return substr( $text, strpos($text, "\n")+1 );
    }
}
?>
