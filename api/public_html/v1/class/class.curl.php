<?php
class Curl
{
    /**
     * Generate initials from a name
     *
     * @param string $name
     * @return string
     */
    public function get($args_url, $args_postfields, $args_authorization, $args_cookie) {
        $curl = curl_init();
        
        $headers = array();
        $headers[] = 'Content-type: application/json';
        
        if ($args_authorization != "") {
            $headers[] = 'Authorization: ' . $args_authorization;
            if ($args_cookie) {
                //TOKEN1=Yes;TOKEN2=no
                $headers[] = 'Cookie: ' . $args_cookie;
            }
            
            //$headers[] = 'X-abc-AUTH: 123456789';
            //$headers[] = 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
            //$headers[] = 'Accept-Encoding: gzip, deflate';
            //$headers[] = 'Accept-Language: en-US,en;q=0.5';
            //$headers[] = 'Cache-Control: no-cache';
            //$headers[] = 'Content-Type: application/x-www-form-urlencoded; charset=utf-8';
            //$headers[] = 'Host: 202.71.152.126';
            //$headers[] = 'Referer: http://www.example.com/index.php'; //Your referrer address
            //$headers[] = 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:28.0) Gecko/20100101 Firefox/28.0';
            //$headers[] = 'X-MicrosoftAjax: Delta=true';*/
        }
        
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        
        curl_setopt($curl, CURLOPT_URL, $args_url);
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        if ($args_postfields != null) {
            //curl_setopt($curl, CURLOPT_RETURNTRANSFER, 0);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $args_postfields);
            curl_setopt($curl, CURLOPT_POST, 1);
        }
        curl_setopt($curl, CURLOPT_USERAGENT, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:7.0.1) Gecko/20100101 Firefox/7.0.1');
        $return = curl_exec($curl);
        
        curl_close($curl);
        
        return $return;
    }
    
    public function getJson($args_url, $args_authorization = null, $args_cookie = null) {
        $data = $this->get($args_url, null, $args_authorization, $args_cookie);
        $dataJson = json_decode($data, true);
        return $dataJson;
    }
    
    public function getJsonGraphQL($args_url, $args_postfields, $args_authorization = null, $args_cookie = null) {
        $data = $this->get($args_url, $args_postfields, $args_authorization, $args_cookie);
        $dataJson = json_decode($data, true);
        return $dataJson;
    }
    
    /**
     * Make initials from a word with no spaces
     *
     * @param string $name
     * @return string
     *//*
    protected function makeInitialsFromSingleWord(string $name) : string
    {
        preg_match_all('#([A-Z]+)#', $name, $capitals);
        if (count($capitals[1]) >= 2) {
            return substr(implode('', $capitals[1]), 0, 2);
        }
        return strtoupper(substr($name, 0, 2));
    }*/
}
?>
