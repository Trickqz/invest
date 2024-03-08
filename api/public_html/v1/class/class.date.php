<?php
class Date
{
    /**
     * Generate initials from a name
     *
     * @param string $name
     * @return string
     */
    public function getDateForDatabase(string $date): string {
        $timestamp = strtotime($date);
        $date_formated = date('Y-m-d H:i:s', $timestamp);
        return $date_formated;
    }
    
    public function formatDate(string $date, string $format = 'd/m/Y H:i:s'): string {
        $timestamp = strtotime($date);
        $date_formated = date($format, $timestamp);
        return $date_formated;
    }
    
    public function formatDateToExtensive(string $date)
    {
        $data = date('D', strtotime($date));
        $mes = date('M', strtotime($date));
        $dia = date('d', strtotime($date));
        $ano = date('Y', strtotime($date));
        
        $semana = array(
            'Sun' => 'Domingo',
            'Mon' => 'Segunda-Feira',
            'Tue' => 'Terca-Feira',
            'Wed' => 'Quarta-Feira',
            'Thu' => 'Quinta-Feira',
            'Fri' => 'Sexta-Feira',
            'Sat' => 'Sábado'
        );
        
        $mes_extenso = array(
            'Jan' => 'Janeiro',
            'Feb' => 'Fevereiro',
            'Mar' => 'Marco',
            'Apr' => 'Abril',
            'May' => 'Maio',
            'Jun' => 'Junho',
            'Jul' => 'Julho',
            'Aug' => 'Agosto',
            'Nov' => 'Novembro',
            'Sep' => 'Setembro',
            'Oct' => 'Outubro',
            'Dec' => 'Dezembro'
        );
        
        $data= $semana["$data"] . ", {$dia} de " . $mes_extenso["$mes"] . " de {$ano}";
        return $data;
    }
    
    public function formatDateMonthInitialsToExtensive(string $date)
    {
        $mes = date('M', strtotime($date));
        
        $mes_extenso = array(
            'Jan' => 'Janeiro',
            'Feb' => 'Fevereiro',
            'Mar' => 'Marco',
            'Apr' => 'Abril',
            'May' => 'Maio',
            'Jun' => 'Junho',
            'Jul' => 'Julho',
            'Aug' => 'Agosto',
            'Nov' => 'Novembro',
            'Sep' => 'Setembro',
            'Oct' => 'Outubro',
            'Dec' => 'Dezembro'
        );
        
        return $mes_extenso["$mes"];
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
