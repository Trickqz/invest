<?php
require($_SERVER[ 'DOCUMENT_ROOT' ] . '/v1/class/class.services.coinbase.php');

class Eth
{
    public function getETH_TRANSACTION($Hash)
    {
        
        /*
         * https://github.com/davider2004/BitcoinTransactionChecker
         * 
         * https://investimentos.demo.weyboo.com/api/btc.php?TxID=62f1085c06aa841bcca8c3ade28c64429c83204a56bf072cd3ed76e22c1495be
         * https://investimentos.demo.weyboo.com/api/btc.php?TxID=62f1085c06aa841bcca8c3ade28c64429c83204a56bf072cd3ed76e22c1495be&ShowApiExtract=yes
         * 
         * https://live.blockcypher.com/btc/tx/62f1085c06aa841bcca8c3ade28c64429c83204a56bf072cd3ed76e22c1495be/
         */
        
        
        // -- USER INPUTS -- //
        $TxID = $Hash;  //$_GET['TxID'];
        // -- USER INPUTS -- //

        // -- CONFIGURATIONS -- //
        $link = "http://ramondettidavide.com/software_test/bitcoin_transaction_checker.php"; // REPLACE WITH YOUR PAGE URL
        $BlockExplorer = "https://live.blockcypher.com/"; // DO NOT EDIT
        $BlockExplorerAPILink = "https://api.blockcypher.com/v1/eth/main/txs/".$TxID."?limit=50&includeHex=true"; // DO NOT EDIT
        // -- CONFIGURATIONS -- //

        // TRY THIS WITH 62f1085c06aa841bcca8c3ade28c64429c83204a56bf072cd3ed76e22c1495be

        $TxLink = "https://live.blockcypher.com/eth/tx/".$TxID;
        $ThisLink = $link."?TxID=".$TxID;

        if (!$TxID){
            //exit("Missing TxID");
            return array("msg" => "Missing TxID", "status" => "INVALID");
        }

        // Download JSON from BlockCypher
        $result = json_decode(file_get_contents($BlockExplorerAPILink),true);

        // Check if this is working
        if (!$result){
            //exit("ERROR! Unable to download informations from block explorer");
            return array("msg" => "ERROR! Unable to download informations from block explorer", "status" => "INVALID");
        }

        // Here is the data
        $block_hash = $result['block_hash'];
        $block_height = $result['block_height'];
        $block_index = $result['block_index'];
        $hash = $result['hash'];
        $addresses = $result['addresses'];
        $total = $result['total']; // total amount in satoshis
        $fees = $result['fees']; // fees in satoshis
        $size = $result['size']; // size in kb
        $preference = $result['preference']; // miners preferences
        $relayed_by = $result['relayed_by']; // IP address that sends the transaction
        $confirmed = $result['confirmed']; // the first confirmation at what time?
        $received = $result['received']; // At what the transaction will be received
        $ver = $result['ver']; // version
        $lock_time = $result['lock_time']; // lock time
        $double_spend = $result['double_spend']; // there are any double spends
        $vin_sz = $result['vin_sz']; // n
        $vout_sz = $result['vout_sz']; // n
        $confirmations = $result['confirmations']; // how much confirmations in the transaction
        $confidence = $result['confidence']; // confidence
        $inputs = $result['inputs'];
        $outputs = $result['outputs'];

        // Inputs
        $prev_hash = $inputs['prev_hash'];
        $output_index = $inputs['output_index'];
        $script = $inputs['script'];
        $output_value = $inputs['output_value'];
        $sequence = $inputs['sequence'];
        $addresses_inputs = $inputs['addresses'];

        // Outputs
        $outputs_value = $outputs['value'];
        $scripto = $outputs['script'];
        $scripto_type = $outputs['script_type'];


        // Show API
        //echo file_get_contents($BlockExplorerAPILink);

        //echo '<br />';

        // OK MAIOR QUE 5 - liberado >= 1
        if ($confirmations >= 1) {
            /* if ($_GET['ShowApiExtract'] === 'no') {
                echo '<b>Hash:</b> ' . $hash . '<br />';
                echo '<b>Doador:</b> ' . $inputs[0]['addresses'][0] . '<br />';
                echo '<b>Recebedor:</b> ' . $outputs[0]['addresses'][0] . '<br />';
                //echo '<b>ETH:</b> ' . brlToEth(1000) . '<br />';
                echo '<b>ETH:</b> ' . ($total/100000000)/10000000000.0 . '<br />';
                //echo '<b>R$:</b> ' . ethToBrl($inputs[0]['output_value']/100000000) . '<br /><br />';
                echo '<b>R$:</b> ' . ethToBrl(($total/100000000)/10000000000.0) . '<br /><br />';
                echo '<b>Status:</b> OK' . '<br />';
            } else { */
                $amount_eth = 0;
                
                $keys = array_keys($outputs);
                $size = count($outputs);
                for ($i = 0; $i < $size; $i++) {
                    $key   = $keys[$i];
                    $value = $outputs[$key];
                    
                    //if ($value['addresses'][0] === '0x4bd11927e6a922b264e9e830f84bfbbdc358b0ef') {
                        $amount_eth += $value['value'];
                    //}
                }
                
                $result = array("hash"=>$hash, "from"=>$inputs[0]['addresses'][0], "to"=>'', "amount_eth"=>(float)($amount_eth/100000000)/10000000000.0, "amount_brl"=>(float)ethToBrl(($amount_eth/100000000)/10000000000.0), "status"=>"VALID");
                return $result;
            //}
        } else {
            //if ($_GET['ShowApiExtract'] === 'no') {
            //    echo '<b>Status:</b> INVALID';
            //} else {
                $result = array("status"=>"INVALID");
                return $result;
            //}
        }
    }
}


function brlToEth($brl_value) {
    $url='https://bitpay.com/api/rates';
    $json=json_decode(file_get_contents($url));
    
    foreach($json as $obj){
        if($obj->code=='BRL')$eth=$obj->rate;
    }
    
    $bitCoin=1/$eth;
    return number_format(((float)$bitCoin)*$brl_value, 8, '.', '');
}

function ethToBrl($eth_value) {
    /**$url='https://bitpay.com/api/rates';
    $json=json_decode(file_get_contents($url));
    
    foreach($json as $obj){
        if($obj->code=='BRL')$eth=$obj->rate;
    }

    $bitCoin=1*$eth;
    return number_format((float)$bitCoin*$eth_value, 2, '.', '');*/
    
    $eth_brl = (new Coinbase)->getETH_BLR();
    return (double)($eth_brl*$eth_value);
}
?>
