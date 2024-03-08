<?php
    ini_set('display_errors', 0);
    ini_set('display_startup_errors', 0);
    //error_reporting(E_ALL);
    
    
    //require( $_SERVER[ 'DOCUMENT_ROOT' ] . "/_shared/app.global.config.php" );
    //require( ROOT_PATH . "/session.php" );
    
    
    /*
     * https://github.com/davider2004/BitcoinTransactionChecker
     * 
     * https://investimentos.demo.weyboo.com/api/btc.php?TxID=62f1085c06aa841bcca8c3ade28c64429c83204a56bf072cd3ed76e22c1495be
     * https://investimentos.demo.weyboo.com/api/btc.php?TxID=62f1085c06aa841bcca8c3ade28c64429c83204a56bf072cd3ed76e22c1495be&ShowApiExtract=yes
     * 
     * https://live.blockcypher.com/btc/tx/62f1085c06aa841bcca8c3ade28c64429c83204a56bf072cd3ed76e22c1495be/
     */
    
    
// -- USER INPUTS -- //
$TxID = $_GET['TxID'];
// -- USER INPUTS -- //

// -- CONFIGURATIONS -- //
$link = "http://ramondettidavide.com/software_test/bitcoin_transaction_checker.php"; // REPLACE WITH YOUR PAGE URL
$BlockExplorer = "https://live.blockcypher.com/"; // DO NOT EDIT
$BlockExplorerAPILink = "https://api.blockcypher.com/v1/btc/main/txs/".$TxID."?limit=50&includeHex=true"; // DO NOT EDIT
// -- CONFIGURATIONS -- //

// TRY THIS WITH 62f1085c06aa841bcca8c3ade28c64429c83204a56bf072cd3ed76e22c1495be

$TxLink = "https://live.blockcypher.com/btc/tx/".$TxID;
$ThisLink = $link."?TxID=".$TxID;

if (!$TxID){
    exit("Missing TxID");
}

// Download JSON from BlockCypher
$result = json_decode(file_get_contents($BlockExplorerAPILink),true);

// Check if this is working
if (!$result){
    exit("ERROR! Unable to download informations from block explorer");
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
    if ($_GET['ShowApiExtract'] === 'no') {
        echo '<b>Hash:</b> ' . $hash . '<br />';
        echo '<b>Doador:</b> ' . $inputs[0]['addresses'][0] . '<br />';
        echo '<b>Recebedor:</b> ' . $outputs[0]['addresses'][0] . '<br />';
        echo '<b>BTC:</b> ' . brlToBtc(1000) . '<br />';
        echo '<b>R$:</b> ' . btcToBrl($inputs[0]['output_value']/100000000) . '<br /><br />';
        echo '<b>Status:</b> OK' . '<br />';
    } else {
        $amount_btc = 0;
        
        $keys = array_keys($outputs);
        $size = count($outputs);
        for ($i = 0; $i < $size; $i++) {
            $key   = $keys[$i];
            $value = $outputs[$key];
            
            if ($value['addresses'][0] === '1HTuGq6U76Mm93c23UbsNvzHn3Yvb8ge5N') {
            //if ($value['addresses'][0] === '1H3LEbeS1DEHwxfgJCE8x3EMQSxEjSkpiq') {
                $amount_btc += $value['value'];
            }

        }
        
        //$result = array("hash"=>$hash, "from"=>$inputs[0]['addresses'][0], "to"=>$outputs[0]['addresses'][0], "amount_btc"=>(float)brlToBtc(1000), "amount_brl"=>(float)btcToBrl($inputs[0]['output_value']/100000000), "status"=>"VALID");
        $result = array("hash"=>$hash, "from"=>$inputs[0]['addresses'][0], "to"=>'1HTuGq6U76Mm93c23UbsNvzHn3Yvb8ge5N', "amount_btc"=>(float)$amount_btc/100000000, "amount_brl"=>(float)btcToBrl($amount_btc/100000000), "status"=>"VALID");
        //$result = array("hash"=>$hash, "from"=>$inputs[0]['addresses'][0], "to"=>'1H3LEbeS1DEHwxfgJCE8x3EMQSxEjSkpiq', "amount_btc"=>(float)$amount_btc/100000000, "amount_brl"=>(float)btcToBrl($amount_btc/100000000), "status"=>"VALID");
        echo json_encode($result, true);
    }
} else {
    if ($_GET['ShowApiExtract'] === 'no') {
        echo '<b>Status:</b> INVALID';
    } else {
        $result = array("status"=>"INVALID");
        echo json_encode($result, true);
    }
}


function brlToBtc($brl_value) {
    $url='https://bitpay.com/api/rates';
    $json=json_decode(file_get_contents($url));
    
    foreach($json as $obj){
        if($obj->code=='BRL')$btc=$obj->rate;
    }
    
    $bitCoin=1/$btc;
    return number_format(((float)$bitCoin)*$brl_value, 8, '.', '');
}

function btcToBrl($btc_value) {
    $url='https://bitpay.com/api/rates';
    $json=json_decode(file_get_contents($url));
    
    foreach($json as $obj){
        if($obj->code=='BRL')$btc=$obj->rate;
    }

    $bitCoin=1*$btc;
    return number_format((float)$bitCoin*$btc_value, 2, '.', '');
}
?>
