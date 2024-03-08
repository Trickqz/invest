<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    
    
    require_once(str_replace("/commands", "", dirname(__FILE__)) . '/dao/conn.php');
    
    $ch = curl_init("https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)?@dataCotacao='".date("m")."-".date("d")."-".date("Y")."'&format=json");
    //$ch = curl_init("https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)?@dataCotacao='04-19-2022'&format=json");
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $res_curl = curl_exec($ch);
    
    if(curl_error($ch)) {
        echo curl_error($ch);
    } else {
        $resultado = json_decode($res_curl, true);
        $valores = $resultado["value"][0];
        
        //Agora será possível recuperar a informação da cotação do dólar:
        //echo $valores["cotacaoCompra"];
        //echo $valores["cotacaoVenda"];
        //echo $valores["dataHoraCotacao"];
        
        $lastQuotation = (new Quotations)->findLast();
        $lastValue = 0;
        if ($lastQuotation) {
            $lastValue = $lastQuotation['_bid'];
        }
        
        if ($valores > 0) {
            (new Quotations)->create($lastValue, $valores["cotacaoCompra"]);
        }
    }
    
    curl_close($ch);
?>
