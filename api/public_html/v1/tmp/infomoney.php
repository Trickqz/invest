<?php
if(!$fp=fopen("https://www.infomoney.com.br/mercados/cambio" , "r" )) 
{
    echo "Erro ao abrir a página de cotação" ;
    exit;
}
$conteudo = '';
while(!feof($fp)) 
{ 
    $conteudo .= fgets($fp,1024);
}
fclose($fp);
$valorCompraHTML = explode('class="numbers">', $conteudo); 

$valorCompra = trim(strip_tags($valorCompraHTML[5]));

$valorVendaHTML = explode(' ', strip_tags($valorCompraHTML[6]));

//Estes são os valores HTML para exibir no site.    
$valorVendaHTML = explode(' ', $valorVendaHTML[0]);
$valorVenda  = trim($valorVendaHTML[0]) ;

//Compra Turismo.
$valorCompraT = trim(strip_tags($valorCompraHTML[7]));
$valorCompraT = explode(' ', $valorCompraT);
$valorCT  = trim($valorCompraT [0]) ;

//Venda Turismo.
$valorVendaT = trim(strip_tags($valorCompraHTML[8]));
$valorVendaT = explode(' ', $valorVendaT);
$valorVT  = trim($valorVendaT[0]) ;

//Compra Euro.
$valorCompraE = trim(strip_tags($valorCompraHTML[11]));
$valorCompraE = explode(' ', $valorCompraE);
$valorCE  = trim($valorCompraE[0]) ;

//Venda Euro.
$valorVendaE = trim(strip_tags($valorCompraHTML[12]));
$valorVendaE = explode(' ', $valorVendaE);
$valorVE  = trim($valorVendaE[0]) ;

//Estes são os valores numéricos para cálculos.   
$valorCompraCalculavel = str_replace(',','.', $valorCompra);
$valorVendaCalculavel  = str_replace(',','.', $valorVenda);
?> 
<html lan="pt-br">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, user-scalable=yes">
        <link href="https://fonts.googleapis.com/css?family=Simonetta" rel="stylesheet">
        <title>
            Exemplo de Script de cotação do dólar
        </title>
    </head>
    <body style="font-family: 'Simonetta', cursive;">
        <p>
            <strong>Compra:</strong>
            R$ 
            <?php echo $valorCompra ?> 
            <br/>
            <strong>Venda:</strong>
            R$ 
            <?php echo $valorVenda ?>  
        </p>
        <p>
            <strong>Turismo Compra:</strong>
            R$ 
            <?php echo $valorCT ?> 
            <br/>
            <strong>Turismo Venda:</strong>
            R$ 
            <?php echo $valorVT ?>  
        </p>
        <p>
            <strong>Euro Compra:</strong>
            R$ 
            <?php echo $valorCE ?> 
            <br/>
            <strong>Euro Venda:</strong>
            R$ 
            <?php echo $valorVE ?>  
        </p>
        <h2>
            Exemplo de câmbio:
        </h2>
        <label>Digite o valor em reais:</label>
        <input type="text" id="converte" placeholder="1.00" onKeyUp="cambio()" style="width:50px">
        <span id="resultado">0.00</span>
        <script>
            function cambio()
            {
                var valorDolarVenda = <?php echo $valorVendaCalculavel ?>;
                var valorReais   = document.getElementById('converte').value;
                if (document.getElementById('converte').value == '') valorReais = 0;
                var valorCambio = valorReais * valorDolarVenda;
                document.getElementById('resultado').innerHTML = valorCambio.toFixed(2);
            }
        </script>
    </body>
</html>
