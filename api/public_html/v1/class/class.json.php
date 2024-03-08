<?php
class Json
{
    /**
     * Generate initials from a name
     *
     * @param string $name
     * @return string
     */
    public function echoJson($json, $http_response_code = 200) {
        //header("Access-Control-Allow-Origin: http://localhost/REST API AUTHENTICATION/");
        header("Content-Type: application/json; charset=UTF-8");
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Max-Age: 3600");
        header("Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD");
        header("Access-Control-Allow-Headers: Content-Type, Accept, Access-Control-Allow-Headers, Authorization, Origin, X-Requested-With");
        //header('Access-Control-Allow-Credentials: true');
        
        http_response_code($http_response_code);
        
        if (isset($_GET['jsonp']) || isset($_GET['callback'])){
            echo $_GET['callback'] . '(' . json_encode($json) . ')';
        } else {
            echo json_encode($json);
        }
        
        //echo json_encode(array("message" => "Unable to create user."));
    }
}
?>
