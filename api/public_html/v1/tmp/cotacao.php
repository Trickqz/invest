<!-- INICIO COTAÇÃO DO DOLAR =======================================================================================          -->
<?php 
    if(!$fp=fopen("http://economia.uol.com.br/cotacoes/" ,"r" )) { 
        echo "Erro ao abrir a página de cotação";     
        exit;
	}
    
    $conteudo = '';
    while(!feof($fp)) { // leia o conteúdo da página   
        $conteudo .= fgets($fp,1024); 
    }
    fclose($fp);
    $cont = 0;
    preg_match_all("/([0-9],[0-9]{3,}).*([0-9],[0-9]{3,})/", $conteudo, $saida, PREG_SET_ORDER);
    
    foreach ($saida as $saida2) {
        $taxaCompra = $saida2[1];
        $taxaVenda = $saida2[2];
        
        switch($cont){
            case 2: echo "<b>Dólar Comercial</b><br>Compra: <b>R$</b> $taxaCompra -- Venda :<b> R$ </b>$taxaVenda<br><br>"; break;
            case 3: echo "<b>Dólar Paralelo</b><br>Compra: <b>R$</b> $taxaCompra -- Venda :<b> R$ </b>$taxaVenda<br><br>"; break;
            case 4:	echo "<b>Dólar Turismo </b><br>Compra: <b>R$</b> $taxaCompra -- Venda :<b> R$ </b>$taxaVenda<br><br>"; break;
            case 5:	echo "<b>Euro  </b><br>Compra: <b>US$</b> $taxaCompra -- Venda :<b> US$ </b>$taxaVenda<br><br>"; break;
        }
        
        $cont = $cont+1;
    }
?>

<!-- FIM COTAÇÃO DO DOLAR =======================================================================================          -->
