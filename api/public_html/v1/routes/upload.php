<?php
    $router->map('GET', '/v1/uploads/[:subdir]', function($subdir){
        /*$account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        /** **/
        $scandir = str_replace("/v1/routes", "", dirname(__FILE__)) . '/d/uploads/'.$subdir;
        $scan = function ($dir, $subdir) use ($scandir, &$scan) {
            $files = [];

            // Is there actually such a folder/file?
            if (file_exists($dir)) {
                foreach (scandir($dir) as $f) {
                    if (! $f || $f[0] == '.') {
                        continue; // Ignore hidden files
                    }

                    if (is_dir($dir . '/' . $f)) {
                        // The path is a folder
                        if ($_GET['path'] != "") {
                            $files[] = [
                                'filename'  => $f,
                                'contentType'  => 'folder',
                                //'path'  => '/editor/projects/' . $_GET['path'] . '/media' . str_replace($scandir, '', $dir) . '/' . $f,
                                'path'  => '/d/uploads/' .$subdir . str_replace($scandir, '', $dir) . '/' . $f,
                                'items' => $scan($dir . '/' . $f, $subdir), // Recursively get the contents of the folder
                            ];
                        } else {
                            $files[] = [
                                'filename'  => $f,
                                'contentType'  => 'folder',
                                'path'  => str_replace($scandir, '', $dir) . '/' . $f,
                                'items' => $scan($dir . '/' . $f, $subdir), // Recursively get the contents of the folder
                            ];
                        }
                    } else {
                        // It is a file
                        $fi = new finfo(FILEINFO_MIME_TYPE); 
                        $mime_type = $fi->file(str_replace("/v1/routes", "", dirname(__FILE__)) . '/d/uploads/'.$subdir.'/'.$f); 
                        
                        /*if ($_GET['path'] != "") {
                            $files[] = [
                                'filename' => $f,
                                'contentType' => $mime_type,
                                //'path' => '/editor/projects/' . $_GET['path'] . '/media' . str_replace($scandir, '', $dir) . '/' . $f,
                                'path' => '/d/uploads/' . $subdir . str_replace($scandir, '', $dir) . '/' . $f,
                                'length' => filesize($dir . '/' . $f), // Gets the size of this file
                            ];
                        } else {*/
                            $files[] = [
                                'filename' => $f,
                                'contentType' => $mime_type,
                                'path' => '/d/uploads/' . $subdir . str_replace($scandir, '', $dir) . '/' . $f,
                                'length' => filesize($dir . '/' . $f), // Gets the size of this file
                            ];
                        //}
                    }
                }
            }

            return $files;
        };
        
        $data = $scan($scandir, $subdir);
        /** **/
        
        if (sizeof($data) == 0) {
            http_response_code(404);
            die();
        }
        
        //$data = (new Projects)->find(null, $_GET['type'], $_GET['status'], 'ASC ', 500);
        (new Json)->echoJson($data);
    });
    /*$router->map('GET','/v1/projects/[i:id]', function($_id){
        $data = (new Projects)->find($_id);
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });*/
    
    $router->map('POST', '/v1/uploads/[*:path]', function($path){
        $dir = str_replace("/v1/routes", "", dirname(__FILE__)) . '/d/uploads/'.$path;
        
        /*$filename = $_FILES['files']['name'];
        unlink("$dir/$filename");
        
        // Valid extension
        $valid_ext = array('png','jpeg','jpg');
        
        // Location
        $location = "$dir/$filename";
        
        // file extension
        $file_extension = pathinfo($location, PATHINFO_EXTENSION);
        $file_extension = strtolower($file_extension);
        
        // Check extension
        if (in_array($file_extension,$valid_ext)) {
            // Compress Image
            compressImage($_FILES['files']['tmp_name'], $location, 60);
        } else {
            move_uploaded_file($_FILES['files']['tmp_name'], $location);
        }*/
        
        
        // Count total files
        $countfiles = count($_FILES['files']['name']);
        
        // Looping all files
        for ($i = 0; $i < $countfiles; $i++) {
            $filename = $_FILES['files']['name'][$i];
            unlink("$dir/$filename");
            
            // Valid extension
            $valid_ext = array('png','jpeg','jpg');
            
            // Location
            $location = "$dir/$filename";
            
            // Mkdir
            if(!is_dir($dir)){
                mkdir($dir);
            }
            
            $upPath = $dir;  //"../uploads/RS/2014/BOI/002";   // full path 
            $tags = explode('/' ,$upPath);            // explode the full path
            $mkDir = "";
            
                foreach($tags as $folder) {          
                    $mkDir = $mkDir . $folder ."/";   // make one directory join one other for the nest directory to make
                    //echo '"'.$mkDir.'"<br/>';         // this will show the directory created each time
                    if(!is_dir($mkDir)) {             // check if directory exist or not
                      mkdir($mkDir, 0777);            // if not exist then make the directory
                    }
                }
            
            
            // file extension
            $file_extension = pathinfo($location, PATHINFO_EXTENSION);
            $file_extension = strtolower($file_extension);
            
            // Check extension
            //if (in_array($file_extension,$valid_ext)) {
            //    // Compress Image
            //    compressImage($_FILES['files']['tmp_name'][$i], $location, 60);
            //} else {
                move_uploaded_file($_FILES['files']['tmp_name'][$i], $location);
            //}
        }
        
        //header("Access-Control-Allow-Origin: http://localhost/REST API AUTHENTICATION/");
        header("Content-Type: application/json; charset=UTF-8");
        header("Access-Control-Allow-Credentials: true");
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Max-Age: 3600");
        header("Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD");
        header("Access-Control-Allow-Headers: Content-Type, Accept, Access-Control-Allow-Headers, Authorization, Origin, X-Requested-With");
        //header('Access-Control-Allow-Credentials: true');
        
        http_response_code(200);
        //die();
    });
    
    $router->map('DELETE', '/v1/uploads/[*:file]', function($file){
        $dir = str_replace("/v1/routes", "", dirname(__FILE__)) . '/d/uploads/'.urldecode($file);
        unlink("$dir");
        
        //header("Access-Control-Allow-Origin: http://localhost/REST API AUTHENTICATION/");
        header("Content-Type: application/json; charset=UTF-8");
        header("Access-Control-Allow-Credentials: true");
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Max-Age: 3600");
        header("Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD");
        header("Access-Control-Allow-Headers: Content-Type, Accept, Access-Control-Allow-Headers, Authorization, Origin, X-Requested-With");
        //header('Access-Control-Allow-Credentials: true');
        
        http_response_code(200);
        //die();
    });
    
    /**$router->map('POST','/v1/uploads/gen-key', function(){
        //$data = (new Settings)->findAllAsJson();
        
        $account__id = null;
        $accountData = (new Accounts)->find(authGetUserId());
        /*if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
            $account__id = $accountData['_id'];
        }*/
        
        //if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator') {
        //    (new Json)->echoJson(array("success" => false));
        //} else {
    /**    if ($accountData != null) {
            ///BLOCKED
            ///$data = (new Neo7i__spaces)->genKey($accountData['_username'], $_POST['path'], $_POST['permission'], $accountData['_role']);
            ///(new Json)->echoJson(array("success" => true, "data" => $data));
            (new Json)->echoJson(array("success" => false, "message" => "O envio de arquivo encontra-se bloqueado!"));
        }
    });*/
?>
