<?php
class Coinbase
{
    public function getETH_BLR()
    {
        $cache = 500; //diferença entre o tempo atual e o tempo de ultima modificação dos arquivos de Cache (em segundos)
        //puxa as exchanges

        //coinbase
        $cache_coinbase = $_SERVER['DOCUMENT_ROOT'] . '/cache/coinbase.cache';
        if(file_exists($cache_coinbase)) {
            if(time() - filemtime($cache_coinbase) > $cachetime) {
                // too old , re-fetch
                $cache = file_get_contents("https://api.coinbase.com/v2/prices/ETH-BRL/spot"); //Atualiza o Cache
                file_put_contents($cache_coinbase, $cache);
                $jsoncoinbase = file_get_contents($cache_coinbase);
            } else {
                $jsoncoinbase = file_get_contents($cache_coinbase);
            }
        } else {
            // no cache, create one
            $cache = file_get_contents("https://api.coinbase.com/v2/prices/ETH-BRL/spot"); //Cria o Cache
            file_put_contents($cache_coinbase, $cache);
            $jsoncoinbase = file_get_contents($cache_coinbase);
        }


        $databrzx = json_decode($jsoncoinbase, true); //decodifica os dados da api
        ///$coinbase_price = $databrzx['last']; //seleciona um valor especifico da api
        $coinbase_price = $databrzx['data']['amount']; //seleciona um valor especifico da api
        ///$coinbase_volume = $databrzx['baseVolume'];
        //$coinbase_price = intval($coinbase_price); //transforma em numero
        //$coinbase_volume = intval($coinbase_volume);
        ///$varcoinbase = $coinbase_price * $coinbase_volume;



        //cache da API
        $cache_data = $_SERVER['DOCUMENT_ROOT'] . '/cache/data.cache';
        if(file_exists($cache_data)) {
            if(time() - filemtime($cache_data) > $cachetime) {
                // too old , re-fetch
                $cache = date('Y-m-d H:i'); //Atualiza o Cache
                file_put_contents($cache_data, $cache);
                $date = file_get_contents($cache_data);
            } else {
                $date = file_get_contents($cache_data);
            }
        } else {
            // no cache, create one
            $cache = date('Y-m-d H:i'); //Cria o Cache
            file_put_contents($cache_data, $cache);
            $date = file_get_contents($cache_data);
        }
        
        
        return $coinbase_price;
    }
}
?>
