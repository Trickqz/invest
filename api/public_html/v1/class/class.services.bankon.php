<?php
class BankOn
{
    private $rest_api_url = "https://api.bankon.com.br";
    
    
    /**
     * Verify user from a username
     *
     * @param string $username
     * @return json
     */
    public function bankonUsernameVerify($authentication__query, $username)
    {
        $url = $this->rest_api_url . '/v1/consultas/usuario/' . $username;
        $curl = curl_init();

        curl_setopt_array($curl, array(
          CURLOPT_URL => $url,
          CURLOPT_RETURNTRANSFER => true,
          CURLOPT_ENCODING => "",
          CURLOPT_MAXREDIRS => 10,
          CURLOPT_TIMEOUT => 0,
          CURLOPT_SSL_VERIFYPEER=>false,
          CURLOPT_FOLLOWLOCATION => true,
          CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
          CURLOPT_CUSTOMREQUEST => "GET",
          CURLOPT_HTTPHEADER => array(
            "Accept: */*",    
            "Cache-Control: no-cache",
            "Connection: keep-alive",
            "Content-Type: application/json",
            "Host: api.bankon.com.br",
            "Postman-Token: a21f9435-6ccd-4f85-a9ee-b86eb7f6a911,400632d0-6934-4a07-94cc-af82e6121b24",
            "User-Agent: PostmanRuntime/7.15.0",
            "accept-encoding: gzip, deflate",
            "cache-control: no-cache",
            "cookie: PHPSESSID=0t7p4r4lbn3e7o77qlifgmakqb",    
            "Authentication:" . $authentication__query
          ),
        ));

        $response = curl_exec($curl);
        $err = curl_error($curl);

        curl_close($curl);

        if ($err) {
          echo "cURL Error #:" . $err;
        } else {
          return $response;
        }
    }
    
    /**
     * Verify transaction from a transaction code
     *
     * @param string $transaction
     * @return json
     */
    public function bankonQueryTransaction($authentication__query, $transaction)
    {
        $url = $this->rest_api_url . '/v1/consultas/transferencias/' . $transaction;
        $curl = curl_init();
        
        curl_setopt_array($curl, array(
          CURLOPT_URL => $url,
          CURLOPT_RETURNTRANSFER => true,
          CURLOPT_ENCODING => "",
          CURLOPT_MAXREDIRS => 10,
          CURLOPT_TIMEOUT => 0,
          CURLOPT_FOLLOWLOCATION => false,
          CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
          CURLOPT_CUSTOMREQUEST => "GET",
          CURLOPT_HTTPHEADER => array(
            "Content-Type: application/json",
            "Authentication:" . $authentication__query
          ),
        ));
        
        $response = curl_exec($curl);
        $err = curl_error($curl);
        
        curl_close($curl);
        
        if ($err) {
          return $err;
        } else {
            return $response;
        }
    }

    /**
     * Verify balance from a user token
     *
     * @param string $authentication__query
     * @return json
     */
    public function bankonQueryBalance($authentication__query)
    {
        $url = $this->rest_api_url . '/v1/consultas/saldo';
        $curl = curl_init();
        
        curl_setopt_array($curl, array(
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => false,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "GET",
            CURLOPT_HTTPHEADER => array(
                "Content-Type: application/json",
                "Authentication: " . $authentication__query
            ),
        ));
        
        $response = json_decode(curl_exec($curl));
        $err = curl_error($curl);
        
        curl_close($curl);
        
        if($response->sucesso){
            return $response->Dados->saldo_disponivel;
        } else {
            return 0;
        }
    }
    
    /**
     * Verify balance from a user token
     *
     * @param string $authentication__query
     * @return json
     */
    public function bankonPaymentRequest($authentication__transaction, $email, $valor, $ref_pagamento, $url_callback_successo, $url_callback_falha)
    {
        $url = $this->rest_api_url . '/v1/checkout/solicita-pagamento';
        
        $fields = array(
              'email' => $email ,
              'ref_pagamento' => $ref_pagamento,
              'valor' => $valor,
              'url_callback_successo' => $url_callback_successo,
              'url_callback_falha' => $url_callback_falha
        );
        
        $data_string = json_encode( $fields );

          $curl = curl_init();

          curl_setopt_array($curl, array(
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => false,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "POST",
            CURLOPT_POSTFIELDS =>$data_string,
            CURLOPT_HTTPHEADER => array(
              "Content-Type: application/json",
              'Content-Length: ' . strlen( $data_string ),
              "Authentication: " . $authentication__transaction
            ),
          ));
          
          $response = curl_exec($curl);
          $err = curl_error($curl);
          
          curl_close($curl);
          
          return $response;
    }
}

/*
function TransfereToBankon($beneficiario,$valor,$id_transferencia){
    $url = $this->rest_api_url . '/v1/financeiro/transferencia';
    
    $fields = array(
    'beneficiario' => $beneficiario,
    'valor' => $valor,
    'id_transferencia' => $id_transferencia
    );


    $data_string = json_encode( $fields );

    $curl = curl_init();

    curl_setopt_array($curl, array(
    CURLOPT_URL => $url,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => "",
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 0,
    CURLOPT_FOLLOWLOCATION => false,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => "POST",
    CURLOPT_POSTFIELDS =>$data_string,
    CURLOPT_HTTPHEADER => array(
    "Content-Type: application/json",
    'Content-Length: ' . strlen( $data_string ),
    "Authentication: ".bankon_token_transferencia
    ),
    ));

    $response = curl_exec($curl);
    $err = curl_error($curl);

    curl_close($curl);

    if ($err) {
      return $err;
    } else {
        return $response;
    }
}
*/
