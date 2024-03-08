<?php
class Format
{
    /**
     * Generate initials from a name
     *
     * @param string $name
     * @return string
     */
    public function generate(string $name) : string
    {
        $words = explode(' ', $name);
        if (count($words) >= 2) {
            return strtoupper(substr($words[0], 0, 1) . substr(end($words), 0, 1));
        }
        return $this->makeInitialsFromSingleWord($name);
    }
    
    public function phone($args_phone) {
        $formatedPhone = preg_replace('/[^0-9]/', '', $args_phone);
        $matches = [];
        preg_match('/^([0-9]{2})([0-9]{4,5})([0-9]{4})$/', $formatedPhone, $matches);
        
        if ($matches) {
            return '('.$matches[1].') '.$matches[2].'-'.$matches[3];
        }
        
        return $args_phone; // return number without format
    }
    
    /**
      $cnpj = "11222333000199";
      $cpf = "00100200300";
      $cep = "08665110";
      $data = "10102010";
      
      echo mask($cnpj,'##.###.###/####-##');
      echo mask($cpf,'###.###.###-##');
      echo mask($cep,'#####-###');
      echo mask($data,'##/##/####');
    */
    public function mask($args_value, $args_mask) {
        $maskared = '';
        $k = 0;
        
        for($i = 0; $i<=strlen($args_mask)-1; $i++) {
            //if($args_mask[$i] == '#') {
            if($args_mask[$i] == '0') {
                if(isset($args_value[$k]))
                $maskared .= $args_value[$k++];
            } else {
                if(isset($args_mask[$i]))
                $maskared .= $args_mask[$i];
            }
        }
        
        return $maskared;
    }
    
    public static function clearNumber( $str )
    {
        return preg_replace("/[^0-9]/", "", $str);
    }
    
    public static function clearNumberToFloat( $str )
    {
        return preg_replace("/[^0-9].,/", "", $str);
    }
}
?>
