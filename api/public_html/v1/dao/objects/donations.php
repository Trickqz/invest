<?php
class Donations {
    private $conn;
    private $table_name = "donations";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_accounts__id, $args_contracts)
    {
        $args_hash = newMD5Hash();
        
        /*$donations_modelData = (new Donations_model)->find($args_model__id);
        if ($donations_modelData['_type'] == 'extra') {
            $args_is_extra = 'true';
        } else {
            $args_is_extra = 'false';
        }*/
        
        //$args_contracts = $donations_modelData['_contracts'];
        $args_amount = $args_contracts*(new Settings)->findValue('contracts_value_usd');  //$donations_modelData['_amount'];
        $args_income = $args_contracts*(new Settings)->findValue('contracts_income_percentage');  //$donations_modelData['_income'];
        
        $args_seq = $this->getNextSeqFromAccountsID($args_accounts__id);
        
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _hash = :args_hash, 
                    _seq = :args_seq, 
                    _accounts__id = :args_accounts__id, 
                    _is_extra = :args_is_extra, 
                    _contracts = :args_contracts, 
                    _date = NOW(), 
                    _amount = :args_amount, 
                    _validated = :args_validated, 
                    _income = :args_income, 
                    _received = :args_received, 
                    _status = :args_status";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_hash', $args_hash);
        $this->conn->bind(':args_seq', $args_seq);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        //$this->conn->bind(':args_model__id', $args_model__id);
        $this->conn->bind(':args_is_extra', 'false');
        $this->conn->bind(':args_contracts', $args_contracts);
        $this->conn->bind(':args_amount', $args_amount);
        $this->conn->bind(':args_validated', 'true');
        $this->conn->bind(':args_income', $args_income);
        $this->conn->bind(':args_received', 0.00);
        //$this->conn->bind(':args_status', 'receiving');
        $this->conn->bind(':args_status', 'waiting');
        return $this->conn->execute();
    }
    
    public function find($args_id = null, $args_accountsArr = null, $args_date_of = null, $args_date_until = null, $args_type = null, $args_status = null, $order_by = null, $order = null, $args_limit = 50)
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _id = :args_id 
                LIMIT 0,1";
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name;
                
                if ($args_accountsArr != null) {
                    $qry .= " WHERE _accounts__id IN $args_accountsArr ";
                    
                    if ($args_date_of != null && $args_date_until != null) {
                        $qry .= " AND DATE(_created_at) >= '$args_date_of' AND DATE(_created_at) <= '$args_date_until'";
                        
                        if ($args_type != null) {
                            $qry .= " AND _type = :args_type";
                        }
                    } else {
                        if ($args_type != null) {
                            $qry .= " WHERE _type = :args_type";
                        }
                    }
                } else {
                    if ($args_date_of != null && $args_date_until != null) {
                        $qry .= " WHERE DATE(_created_at) >= '$args_date_of' AND DATE(_created_at) <= '$args_date_until'";
                        
                        if ($args_type != null) {
                            $qry .= " AND _type = :args_type";
                        }
                    } else {
                        if ($args_type != null) {
                            $qry .= " WHERE _type = :args_type";
                        }
                    }
                }
                
                if ($args_status != null && $args_status != "*") {
                    if (($args_date_of != null && $args_date_until != null) || $args_type != null || $args_accountsArr != null) {
                        $qry .= " AND ";
                    } else {
                        $qry .= " WHERE ";
                    }
                    
                    $qry .= " _status = :args_status";
                }
                
                if ($order != null) {
                    if ($order_by != null) {
                        $qry .= " ORDER BY $order_by $order";
                    } else {
                        $qry .= " ORDER BY _id $order";
                    }
                }
                
                if ($args_limit != null) {
                    $qry .= " LIMIT 0,$args_limit";
                }
            }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            
            $data = $this->conn->single();
            /*
            $account_1 = (new Accounts)->find($data['_accounts__id']);
            
            if ($data['_is_extra'] == 'true') {
                $_is_extra = true;
            } else {
                $_is_extra = false;
            }
            
            if ($data['_validated'] == 'true') {
                $_validated = true;
            } else {
                $_validated = false;
            }
            
            $dataReturn = array(
                    '_id' => $data['_id'],
                    '_seq' => $data['_seq'],
                    '_hash' => $data['_hash'],
                    '_accounts__id' => $data['_accounts__id'],
                    '_model__id' => $data['_model__id'],
                    '_is_extra' => $_is_extra,
                    '_accounts__username' => $account_1['_username'],
                    '_accounts__name' => $account_1['_name'],
                    '_accounts__email' => $account_1['_email'],
                    '_contracts' => $data['_contracts'],
                    '_date' => $data['_date'],
                    '_expires_date' => $data['_expires_date'],
                    '_amount' => $data['_amount'],
                    '_transaction' => $data['_transaction'],
                    '_validated' => $_validated,
                    '_1th_pgto' => $data['_1th_pgto'],
                    '_1th_payment_date' => $data['_1th_payment_date'],
                    '_1th_payment_transaction' => $data['_1th_payment_transaction'],
                    '_date_closed' => $data['_date_closed'],
                    '_income' => $data['_income'],
                    '_received' => $data['_received'],
                    '_created_at' => $data['_created_at'],
                    '_updated_at' => $data['_updated_at'],
                    '_status' => $data['_status']
                );*/
            
            //return $dataReturn;
            return $data;
        } else {
            /*if ($args_accounts__id != "") {
                $this->conn->bind(':args_accounts__id', $args_accounts__id);
            }*/
            if ($args_status != "" && $args_status != "*") {
                $this->conn->bind(':args_status', $args_status);
            }
            
            $data = $this->conn->resultSet();
            $dataReturn = array();
            foreach ($data as $item) {
                $account_1 = (new Accounts)->find($item['_accounts__id']);
                
                /*if ($item['_is_extra'] == 'true') {
                    $_is_extra = true;
                } else {
                    $_is_extra = false;
                }*/
                
                if ($item['_validated'] == 'true') {
                    $_validated = true;
                } else {
                    $_validated = false;
                }
                
                array_push($dataReturn,
                    array(
                        '_id' => $item['_id'],
                        '_seq' => $item['_seq'],
                        '_hash' => $item['_hash'],
                        '_accounts__id' => $item['_accounts__id'],
                        '_model__id' => $item['_model__id'],
                        '_is_extra' => $_is_extra,
                        '_accounts__username' => $account_1['_username'],
                        '_accounts__name' => $account_1['_name'],
                        '_accounts__email' => $account_1['_email'],
                        '_contracts' => $item['_contracts'],
                        '_date' => $item['_date'],
                        '_expires_date' => $item['_expires_date'],
                        '_amount' => $item['_amount'],
                        '_transaction' => $item['_transaction'],
                        '_validated' => $_validated,
                        '_1th_pgto' => $item['_1th_pgto'],
                        '_1th_payment_date' => $item['_1th_payment_date'],
                        '_1th_payment_transaction' => $item['_1th_payment_transaction'],
                        '_date_closed' => $item['_date_closed'],
                        '_income' => $item['_income'],
                        '_received' => $item['_received'],
                        '_created_at' => $item['_created_at'],
                        '_updated_at' => $item['_updated_at'],
                        '_status' => $item['_status']
                    )
                );
            }
            
            return $dataReturn;
        }
    }
    
    public function findWaitingFor48h()
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                    WHERE 
                        DATE(_date) < DATE_SUB(DATE(now()), INTERVAL  2 day) AND 
                        _status = 'waiting'";
        
        $this->data = $this->conn->query($qry);
        $data = $this->conn->single();
        return $data;
    }
    
    public function processWaiting()
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                    WHERE 
                        DATE(_date) < DATE_SUB(DATE(now()), INTERVAL  2 day) AND 
                        _status = 'waiting'";
        
        $this->data = $this->conn->query($qry);
        $result = $this->conn->resultSet();
        
        for($i = 0; $i <= sizeof($result); $i++){
            (new Donations)->processWaitingSetReceiving($result[$i]['_id']);
        }
        
        return true;
    }
    
    public function processWaitingSetReceiving($args_id) {
        // _blocked_until >> _created_at
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET 
                    _updated_at = NOW(), 
                    _status = 'receiving' 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function findHash($args_hash)
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE 
                    _hash = '$args_hash' 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $data = $this->conn->single();
        return $data;
    }
    
    public function findByAccountAndSeq($args__accounts__id, $args__seq)
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE 
                    _accounts__id = '$args__accounts__id' 
                    AND 
                    _seq = '$args__seq' 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $data = $this->conn->single();
        return $data;
    }
    
    public function transactionCheckCodeWasUsed($args_transaction_code)
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE
                    (_1th_payment_transaction LIKE '%{$args_transaction_code}%' OR _1th_payment_transaction LIKE '%{$args_transaction_code}%')";
        
        $this->data = $this->conn->query($qry);
        $data = $this->conn->resultSet();
        
        if (sizeof($data) >= 1) {
			return true;
		} else {
            return false;
        }
    }
    
    public function update1thPayment($args_id = null, $args_1th_pgto, $args_1th_payment_transaction, $args_status)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET 
                    _1th_payment_date = NOW(), 
                    _1th_pgto = :args_1th_pgto, 
                    _1th_payment_transaction = :args_1th_payment_transaction, 
                    _status = :args_status 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_1th_pgto', $args_1th_pgto);
        $this->conn->bind(':args_1th_payment_transaction', $args_1th_payment_transaction);
        $this->conn->bind(':args_status', $args_status);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function update2thPayment($args_id = null, $args_2th_pgto, $args_2th_payment_transaction, $args_status)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET 
                    _2th_payment_date = NOW(), 
                    _2th_pgto = :args_2th_pgto, 
                    _2th_payment_transaction = :args_2th_payment_transaction, 
                    _validated = :args_validated, 
                    _status = :args_status 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_2th_pgto', $args_2th_pgto);
        $this->conn->bind(':args_2th_payment_transaction', $args_2th_payment_transaction);
        $this->conn->bind(':args_validated', 'true');
        $this->conn->bind(':args_status', $args_status);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function setReceived($args_id = null, $args_received)
    {
        $donation = (new Donations)->find($args_id);
        if ($args_received >= (float)$donation['_income']) {
            $qry = "UPDATE 
                    " . $this->table_name . " 
                    SET 
                        _received = :args_received, 
                        _status = 'finished' 
                    WHERE 
                        _id = :args_id";
        } else {
            $qry = "UPDATE 
                    " . $this->table_name . " 
                    SET 
                        _received = :args_received 
                    WHERE 
                        _id = :args_id";
        }
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_received', $args_received);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function setStatus($args_id = null, $args_status)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET 
                    _status = :args_status 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_status', $args_status);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function cancel($args_id = null)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET 
                    _status = :args_status 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_status', "canceled");
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function getNextSeqFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT MAX(_seq) AS seq 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['seq']+1;
    }
    
    public function countTotalInMonth()
    {
        $qry = "SELECT SUM(_contracts) AS _sum 
                FROM " . $this->table_name . "
                    WHERE 
                    `_validated` = 'true' 
                    AND YEAR(_created_at) = YEAR(CURDATE()) 
                    AND MONTH(_created_at) = MONTH(CURDATE())";
        
        $this->data = $this->conn->query($qry);
        $result = $this->conn->single();
        return (int)$result['_sum'];
    }
    
    public function countTotal($args_is_extra = null)
    {
        $qry = "SELECT SUM(_contracts) AS _sum 
                FROM " . $this->table_name . "
                    WHERE 
                    `_validated` = 'true'";
        
        if ($args_is_extra != null) {
            $qry .= " AND _is_extra = :args_is_extra";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_is_extra != null) {
            $this->conn->bind(':args_is_extra', $args_is_extra);
        }
        $result = $this->conn->single();
        return (int)$result['_sum'];
    }
    
    public function countTotalReceiving($args_accounts__id)
    {
        $qry = "SELECT SUM(_contracts) AS _sum 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_status` = 'receiving'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return (int)$result['_sum'];
    }
    
    
    public function countTotalInMonthFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(_contracts) AS _sum 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id 
                    AND `_validated` = 'true' 
                    AND YEAR(_created_at) = YEAR(CURDATE()) 
                    AND MONTH(_created_at) = MONTH(CURDATE())";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return (int)$result['_sum'];
    }
    
    public function countTotalFromAccountsID($args_accounts__id, $args_is_extra = null, $args_status = null)
    {
        $qry = "SELECT SUM(_contracts) AS _sum 
                FROM " . $this->table_name . "
                    WHERE 
                    `_validated` = 'true'";
        
        if ($args_accounts__id != null) {
            $qry .= " AND _accounts__id = :args_accounts__id";
        }
        
        if ($args_is_extra != null) {
            $qry .= " AND _is_extra = :args_is_extra";
        }
        
        if ($args_status != null) {
            $qry .= " AND _status = :args_status";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_accounts__id != null) {
            $this->conn->bind(':args_accounts__id', $args_accounts__id);
        }
        if ($args_is_extra != null) {
            $this->conn->bind(':args_is_extra', $args_is_extra);
        }
        if ($args_status != null) {
            $this->conn->bind(':args_status', $args_status);
        }
        $result = $this->conn->single();
        return (int)$result['_sum'];
    }
    
    public function sumTotalAmountIncomeFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(_income) AS _sum 
                FROM " . $this->table_name . "
                    WHERE 
                    `_validated` = 'true' 
                    AND (_status = 'receiving' OR _status = 'finished' OR _status = 'blocked' OR _status = 'canceled')";
        
        if ($args_accounts__id != null) {
            $qry .= " AND _accounts__id = :args_accounts__id";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_accounts__id != null) {
            $this->conn->bind(':args_accounts__id', $args_accounts__id);
        }
        $result = $this->conn->single();
        return (int)$result['_sum'];
    }
    
    public function sumTotalAmountReceivedFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(_received) AS _sum 
                FROM " . $this->table_name . "
                    WHERE 
                    `_validated` = 'true' 
                    AND (_status = 'receiving' OR _status = 'finished' OR _status = 'blocked' OR _status = 'canceled')";
        
        if ($args_accounts__id != null) {
            $qry .= " AND _accounts__id = :args_accounts__id";
        }
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return (int)$result['_sum'];
    }
    
    /** **/
    public function sumReceivingTotalAmountFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(_amount) AS _sum 
                FROM " . $this->table_name . "
                    WHERE 
                    `_validated` = 'true' 
                    AND _status = 'receiving'";
        
        if ($args_accounts__id != null) {
            $qry .= " AND _accounts__id = :args_accounts__id";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_accounts__id != null) {
            $this->conn->bind(':args_accounts__id', $args_accounts__id);
        }
        $result = $this->conn->single();
        return (int)$result['_sum'];
    }
    public function sumReceivingTotalAmountIncomeFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(_income) AS _sum 
                FROM " . $this->table_name . "
                    WHERE 
                    `_validated` = 'true' 
                    AND _status = 'receiving'";
        
        if ($args_accounts__id != null) {
            $qry .= " AND _accounts__id = :args_accounts__id";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_accounts__id != null) {
            $this->conn->bind(':args_accounts__id', $args_accounts__id);
        }
        $result = $this->conn->single();
        return (int)$result['_sum'];
    }
    public function sumReceivingTotalAmountReceivedFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(_received) AS _sum 
                FROM " . $this->table_name . "
                    WHERE 
                    `_validated` = 'true' 
                    AND _status = 'receiving'";
        
        if ($args_accounts__id != null) {
            $qry .= " AND _accounts__id = :args_accounts__id";
        }
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return (int)$result['_sum'];
    }
    /** **/
    
    public function getReceivedFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_received`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id";
        
        $this->data = $this->conn->query($qry);
        if ($args_accounts__id != null) {
            $this->conn->bind(':args_accounts__id', $args_accounts__id);
        }
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    
    /** **/
    public function new__countChartLast30($args_accounts__id = 0)
    {
        if ($args_accounts__id != 0) {
            $this->data = $this->conn->query("SELECT DATE_FORMAT(_created_at, \"%d/%m/%Y\") AS _date, SUM(_contracts) AS _value FROM `donations` WHERE _accounts__id = '$args_accounts__id' AND (_status = 'receiving' OR _status = 'blocked' OR _status = 'finished') GROUP BY DATE_FORMAT(_created_at, \"%d-%m-%Y\") ORDER BY YEAR(_created_at) DESC, MONTH(_created_at) DESC, DAY(_created_at) DESC LIMIT 0,30");
        } else {
            $this->data = $this->conn->query("SELECT DATE_FORMAT(_created_at, \"%d/%m/%Y\") AS _date, SUM(_contracts) AS _value FROM `donations` WHERE (_status = 'receiving' OR _status = 'blocked' OR _status = 'finished') GROUP BY DATE_FORMAT(_created_at, \"%d-%m-%Y\") ORDER BY YEAR(_created_at) DESC, MONTH(_created_at) DESC, DAY(_created_at) DESC LIMIT 0,30");
        }
        return $this->conn->resultSet();
    }
    /** **/
    
    
    
    /*
     * Export Data from MySQL to PDF Script
     * Version: 1.0.0
     * Page: Export
     */
    public function exportPdf($args_type) {
        $isAdmin = false;
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') {
            $isAdmin = true;
        }
        $authUserId = $accountData['_id'];
        //if ($isAdmin == false || $authUserId == $row['_accounts__id']) {
        
        
        //setlocale(LC_ALL, 'pt_BR', 'pt_BR.iso-8859-1', 'pt_BR.utf-8', 'portuguese');
        //date_default_timezone_set('America/Sao_Paulo');
        
        /*
         * PDF
         */
        $pdf = new FPDF();
        //$pdf->AliasNbPages();
        $pdf->SetAuthor(utf8_decode((new Settings)->findValue('site__name')));
        $pdf->SetTitle('Documento proveniente de ' . utf8_decode((new Settings)->findValue('site__copyright')));
        //$pdf->SetAutoPageBreak(false);
        
        if ($args_type == 'details') {
            $pdf->AddPage('L');
        } else {
            $pdf->AddPage();
        }
        
        switch($args_type){
            case "single":
                if ($isAdmin == true) {
                    $array_data = $this->find(null, null, '', 9999);
                } else {
                    $array_data = $this->find(null, '('.$authUserId.')', '', 9999);
                }
                
                //set font to arial, bold, 14pt
                $pdf->SetFont('Arial','B',14);

                //Cell(width , height , text , border , end line , [align] )

                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(69 ,5,'',0,1);//end of line

                //set font to arial, regular, 12pt
                $pdf->SetFont('Arial','',12);
                
                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(25 ,5,utf8_decode('Date:'),0,0);
                $pdf->Cell(44 ,5,date('d/m/Y H:i:s', time()),0,1);//end of line

                //make a dummy empty cell as a vertical spacer
                $pdf->Cell(189 ,10,'',0,1);//end of line
                
                
                /*
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(35 ,5,utf8_decode('Listagem:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->MultiCell(154, 5, utf8_decode('Contas de usuário'), 0, 'L', false);//end of line
                
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(35 ,5,utf8_decode('Ano:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->Cell(154 ,5,utf8_decode('2020'),0,1);//end of line
                $pdf->SetFont('Arial','B',12);
                */
                
                $pdf->Cell(189, 4, '', 0, 1);
                
                
                $pdf->SetFont('Arial','B',12);
                //$pdf->Cell(189 ,5,utf8_decode($array_ticket['dozens']),0,0,'C', false);
                $pdf->MultiCell(189, 5, utf8_decode('Report of packs / '.STRNAME__LICENSES),0,'C', false);
                $pdf->Cell(189, 6, '', 0, 1);
                
                
                $pdf->SetFont('Arial','B',9);
                $pdf->SetFillColor(230,230,230);
                $pdf->Cell(10,6,utf8_decode('ID'),0,0,'C',1);
                $pdf->Cell(70,6,utf8_decode('REFERENCE'),0,0,'L',1);
                $pdf->Cell(60,6,utf8_decode('AMOUNT / PROFIT / RECEIVED'),0,0,'C',1);
                $pdf->Cell(26,6,utf8_decode('DATE'),0,0,'C',1);
                $pdf->Cell(22,6,utf8_decode('STATUS'),0,1,'C',1);
                
                //$pdf->MultiCell(154, 5, utf8_decode('NOME'), 0, 'L', false);//end of line
                
                $pdf->SetFont('Arial','',9);
                
                $i = 1;
                $array_data__count = 0;
                $asColor = 0;
                foreach ($array_data as $row)
                {
                    $accountData = (New Accounts)->find($row['_accounts__id']);
                    
                    $pdf->Cell(10,6,utf8_decode($row['_id']),0,0,'C',$asColor);
                    $pdf->Cell(70,6,utf8_decode($accountData['_name'] . ' (' . $accountData['_username'] . ')'),0,0,'L',$asColor);
                    $pdf->Cell(60,6,utf8_decode(number_format($row['_amount'], 2, ',', '.') . ' / ' . number_format($row['_income'], 2, ',', '.') . ' / ' . number_format($row['_received'], 2, ',', '.')),0,0,'C',$asColor);
                    $pdf->Cell(26,6,utf8_decode(date( "m/d/Y", strtotime($row['_created_at']))),0,0,'C',$asColor);
                    
                    if ($row['_status'] == "waiting") {
                        $accountStatus = 'Waiting';
                        $pdf->SetTextColor(245,159,0);
                    } else if ($row['_status'] == "receiving") {
                        $accountStatus = 'Receiving';
                        $pdf->SetTextColor(47,179,68);
                    } else if ($row['_status'] == "blocked") {
                        $accountStatus = 'Blocked';
                        $pdf->SetTextColor(214,57,57);
                    } else if ($row['_status'] == "finished") {
                        $accountStatus = 'Finished';
                        $pdf->SetTextColor(100,116,139);
                    } else if ($row['_status'] == "canceled") {
                        $accountStatus = 'Canceled';
                        $pdf->SetTextColor(214,57,57);
                    }
                    $pdf->Cell(22,6,utf8_decode($accountStatus),0,1,'C',$asColor);
                    $pdf->SetTextColor(0,0,0);
                    
                    if ($asColor == 0) {
                        $asColor = 1;
                    } else {
                        $asColor = 0;
                    }
                    
                    $array_data__count++;
                    $i++;
                }
                
                $pdf->Cell(189, 5, '', 0, 1);
                $pdf->Cell(80 , 5,'', 0, 0);
                
                $pdf->SetFont('Arial','B',9);
                $pdf->Cell(75 ,5,utf8_decode('Total:'),0,0,'R');
                $pdf->SetFont('Arial','',9);
                $pdf->Cell(34, 5, $array_data__count . utf8_decode(' packs / '.STRNAME__LICENSES),0,1,'L');//end of line
            break;
            case "details":
            if ($isAdmin == true) {
                    $array_data = $this->find(null, null, null, null, null, null, '_accounts__id', 'ASC', 9999);
                } else {
                    $array_data = $this->find(null, '('.$authUserId.')', null, null, null, null, '_accounts__id', 'ASC', 9999);
                }
                
                //set font to arial, bold, 14pt
                $pdf->SetFont('Arial','B',14);

                //Cell(width , height , text , border , end line , [align] )

                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(69 ,5,'',0,1);//end of line

                //set font to arial, regular, 12pt
                $pdf->SetFont('Arial','',12);
                
                $pdf->Cell(120 ,5,utf8_decode((new Settings)->findValue('site__name')),0,0);
                $pdf->Cell(25 ,5,utf8_decode('Date:'),0,0);
                $pdf->Cell(44 ,5,date('d/m/Y H:i:s', time()),0,1);//end of line

                //make a dummy empty cell as a vertical spacer
                $pdf->Cell(276 ,10,'',0,1);//end of line
                
                
                /*
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(35 ,5,utf8_decode('Listagem:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->MultiCell(154, 5, utf8_decode('Contas de usuário'), 0, 'L', false);//end of line
                
                $pdf->SetFont('Arial','B',12);
                $pdf->Cell(35 ,5,utf8_decode('Ano:'),0,0,'R');
                $pdf->SetFont('Arial','',12);
                $pdf->Cell(154 ,5,utf8_decode('2020'),0,1);//end of line
                $pdf->SetFont('Arial','B',12);
                */
                
                $pdf->Cell(276, 4, '', 0, 1);
                
                
                $pdf->SetFont('Arial','B',12);
                //$pdf->Cell(276 ,5,utf8_decode($array_ticket['dozens']),0,0,'C', false);
                $pdf->MultiCell(276, 5, utf8_decode('Members report with packs / '.STRNAME__LICENSES),0,'C', false);
                $pdf->Cell(276, 6, '', 0, 1);
                
                
                /*
                $pdf->SetFont('Arial','B',9);
                $pdf->SetFillColor(230,230,230);
                $pdf->Cell(10,6,utf8_decode('ID'),0,0,'C',1);
                $pdf->Cell(70,6,utf8_decode('REFERÊNCIA'),0,0,'L',1);
                $pdf->Cell(60,6,utf8_decode('VALOR / GANHO / RECEBIDO'),0,0,'C',1);
                $pdf->Cell(26,6,utf8_decode('DATA'),0,0,'C',1);
                $pdf->Cell(22,6,utf8_decode('STATUS'),0,1,'C',1);
                */
                
                //$pdf->MultiCell(154, 5, utf8_decode('NOME'), 0, 'L', false);//end of line
                
                $pdf->SetFont('Arial','',9);
                
                $i = 1;
                $array_data__count = 0;
                $asColor = 0;
                $lastUserId = 0;
                $userTotalContracts = 0;
                $userTotalAmount = 0;
                $userTotalIncome = 0;
                $userTotalReceived = 0;
                
                $totalContracts = 0;
                $totalAmount = 0;
                $totalIncome = 0;
                $totalReceived = 0;
                foreach ($array_data as $row)
                {
                    if ($row['_accounts__id'] > 0) {
                        $accountData = (New Accounts)->find($row['_accounts__id']);
                        if ($accountData['_role'] != 'developer' && $accountData['_role'] != 'administrator' && $accountData['_id'] > 0) {
                            if ($lastUserId < $accountData['_id']) {
                                if ($lastUserId > 0) {
                                    $pdf->SetFont('Arial','B',9);
                                    $pdf->SetFillColor(220,220,220);
                                    $pdf->Cell(10,6,utf8_decode(''),0,0,'C',1);
                                    $pdf->Cell(92,6,utf8_decode('TOTAIS'),0,0,'L',1);
                                    $pdf->Cell(18,6,utf8_decode($userTotalContracts),0,0,'C',1);
                                    $pdf->Cell(28,6,utf8_decode(number_format($userTotalAmount, 2, ',', '.')),0,0,'C',1);
                                    $pdf->Cell(28,6,utf8_decode(number_format($userTotalIncome, 2, ',', '.')),0,0,'C',1);
                                    $pdf->Cell(28,6,utf8_decode(number_format($userTotalReceived, 2, ',', '.')),0,0,'C',1);
                                    $pdf->Cell(28,6,utf8_decode(number_format($userTotalIncome-$userTotalReceived, 2, ',', '.')),0,0,'C',1);
                                    $pdf->Cell(26,6,utf8_decode(''),0,0,'C',1);
                                    $pdf->Cell(22,6,utf8_decode(''),0,1,'C',1);
                                    
                                    $userTotalContracts = 0;
                                    $userTotalAmount = 0;
                                    $userTotalIncome = 0;
                                    $userTotalReceived = 0;
                                }
                                
                                $pdf->Cell(276, 6, '', 0, 1);
                                
                                $pdf->SetFont('Arial','B',9);
                                $pdf->SetFillColor(230,230,230);
                                $pdf->Cell(10,6,utf8_decode(''),0,0,'C',1);
                                $pdf->Cell(92,6,utf8_decode($accountData['_name'] . ' (' . $accountData['_username'] . ')'),0,0,'L',1);
                                $pdf->Cell(18,6,utf8_decode(strtoupper(STRNAME__LICENSES)),0,0,'C',1);
                                $pdf->Cell(28,6,utf8_decode('AMOUNT'),0,0,'C',1);
                                $pdf->Cell(28,6,utf8_decode('PROFIT'),0,0,'C',1);
                                $pdf->Cell(28,6,utf8_decode('RECEIVED'),0,0,'C',1);
                                $pdf->Cell(28,6,utf8_decode('TO RECEIVE'),0,0,'C',1);
                                $pdf->Cell(26,6,utf8_decode('DATE'),0,0,'C',1);
                                $pdf->Cell(22,6,utf8_decode('STATUS'),0,1,'C',1);
                                
                                $asColor = 0;
                            }
                            
                            $pdf->SetFont('Arial','',9);
                            $pdf->Cell(10,6,utf8_decode($row['_id']),0,0,'C',$asColor);
                            $pdf->Cell(92,6,utf8_decode('hash: '.$row['_hash']),0,0,'L',$asColor);
                            $pdf->Cell(18,6,utf8_decode($row['_contracts']),0,0,'C',$asColor);
                            $pdf->Cell(28,6,utf8_decode(number_format($row['_amount'], 2, ',', '.')),0,0,'C',$asColor);
                            $pdf->Cell(28,6,utf8_decode(number_format($row['_income'], 2, ',', '.')),0,0,'C',$asColor);
                            $pdf->Cell(28,6,utf8_decode(number_format($row['_received'], 2, ',', '.')),0,0,'C',$asColor);
                            $pdf->Cell(28,6,utf8_decode(number_format($row['_income']-$row['_received'], 2, ',', '.')),0,0,'C',$asColor);
                            $pdf->Cell(26,6,utf8_decode(date( "m/d/Y", strtotime($row['_created_at']))),0,0,'C',$asColor);
                            
                            if ($row['_status'] == "waiting") {
                                $accountStatus = 'Waiting';
                                $pdf->SetTextColor(245,159,0);
                            } else if ($row['_status'] == "receiving") {
                                $accountStatus = 'Receiving';
                                $pdf->SetTextColor(47,179,68);
                            } else if ($row['_status'] == "blocked") {
                                $accountStatus = 'Blocked';
                                $pdf->SetTextColor(214,57,57);
                            } else if ($row['_status'] == "finished") {
                                $accountStatus = 'Finished';
                                $pdf->SetTextColor(100,116,139);
                            } else if ($row['_status'] == "canceled") {
                                $accountStatus = 'Canceled';
                                $pdf->SetTextColor(214,57,57);
                            }
                            $pdf->Cell(22,6,utf8_decode($accountStatus),0,1,'C',$asColor);
                            $pdf->SetTextColor(0,0,0);
                            
                            if ($asColor == 0) {
                                $asColor = 1;
                            } else {
                                $asColor = 0;
                            }
                            
                            //if ($accountData['_id'] > 0) {
                                $lastUserId = $accountData['_id'];
                            //}
                            
                            $userTotalContracts += $row['_contracts'];
                            $userTotalAmount += $row['_amount'];
                            $userTotalIncome += $row['_income'];
                            $userTotalReceived += $row['_received'];
                            
                            $totalContracts += $row['_contracts'];
                            $totalAmount += $row['_amount'];
                            $totalIncome += $row['_income'];
                            $totalReceived += $row['_received'];
                            
                            $i++;
                        }
                    }
                }
                
                if ($lastUserId > 0) {
                    $pdf->SetFont('Arial','B',9);
                    $pdf->SetFillColor(220,220,220);
                    $pdf->Cell(10,6,utf8_decode(''),0,0,'C',1);
                    $pdf->Cell(92,6,utf8_decode('TOTAL'),0,0,'L',1);
                    $pdf->Cell(18,6,utf8_decode($userTotalContracts),0,0,'C',1);
                    $pdf->Cell(28,6,utf8_decode(number_format($userTotalAmount, 2, ',', '.')),0,0,'C',1);
                    $pdf->Cell(28,6,utf8_decode(number_format($userTotalIncome, 2, ',', '.')),0,0,'C',1);
                    $pdf->Cell(28,6,utf8_decode(number_format($userTotalReceived, 2, ',', '.')),0,0,'C',1);
                    $pdf->Cell(28,6,utf8_decode(number_format($userTotalIncome-$userTotalReceived, 2, ',', '.')),0,0,'C',1);
                    $pdf->Cell(26,6,utf8_decode(''),0,0,'C',1);
                    $pdf->Cell(22,6,utf8_decode(''),0,1,'C',1);
                    
                    $userTotalContracts = 0;
                    $userTotalAmount = 0;
                    $userTotalIncome = 0;
                    $userTotalReceived = 0;
                    
                    $pdf->Cell(276, 6, '', 0, 1);
                }
                
                $pdf->Cell(276, 5, '', 0, 1);
                
                /*$pdf->Cell(80 , 5,'', 0, 0);
                
                $pdf->SetFont('Arial','B',9);
                $pdf->Cell(75 ,5,utf8_decode('Total:'),0,0,'R');
                $pdf->SetFont('Arial','',9);
                $pdf->Cell(34, 5, $array_data__count . utf8_decode(' pacotes / cotas'),0,1,'L');//end of line
                */
                
                
                $pdf->SetFont('Arial','B',9);
                $pdf->SetFillColor(220,220,220);
                $pdf->Cell(10,6,utf8_decode(''),0,0,'C',1);
                $pdf->Cell(92,6,utf8_decode('GENERAL TOTAL'),0,0,'L',1);
                $pdf->Cell(18,6,utf8_decode($totalContracts),0,0,'C',1);
                $pdf->Cell(28,6,utf8_decode(number_format($totalAmount, 2, ',', '.')),0,0,'C',1);
                $pdf->Cell(28,6,utf8_decode(number_format($totalIncome, 2, ',', '.')),0,0,'C',1);
                $pdf->Cell(28,6,utf8_decode(number_format($totalReceived, 2, ',', '.')),0,0,'C',1);
                $pdf->Cell(28,6,utf8_decode(number_format($totalIncome-$totalReceived, 2, ',', '.')),0,0,'C',1);
                $pdf->Cell(26,6,utf8_decode(''),0,0,'C',1);
                $pdf->Cell(22,6,utf8_decode(''),0,1,'C',1);
            break;
        }
        
        
        //header("Access-Control-Allow-Origin: http://localhost/REST API AUTHENTICATION/");
        header("Content-Type: application/json; charset=UTF-8");
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Max-Age: 3600");
        header("Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD");
        header("Access-Control-Allow-Headers: Content-Type, Accept, Access-Control-Allow-Headers, Authorization, Origin, X-Requested-With, X-Api-Key");
        //header('Access-Control-Allow-Credentials: true');
        
        ob_start();
        $pdf->Output();
        ob_end_flush();
    }
}
?>
