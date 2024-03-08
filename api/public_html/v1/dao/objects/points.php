<?php
class Points {
    private $conn;
    private $table_name = "points";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_accounts__id, $args_type, $args_binary_side, $args_value, $args_ref, $args_ref_accounts__id, $args_level, $args_manual)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _accounts__id = :args_accounts__id, 
                    _type = :args_type, 
                    _binary_side = :args_binary_side, 
                    _value = :args_value, 
                    _ref = :args_ref, 
                    _ref_accounts__id = :args_ref_accounts__id, 
                    _level = :args_level, 
                    _manual = :args_manual";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $this->conn->bind(':args_type', $args_type);
        $this->conn->bind(':args_binary_side', $args_binary_side);
        //$this->conn->bind(':args_phone', (new Format)->clearNumber($args_phone));
        $this->conn->bind(':args_value', $args_value);
        $this->conn->bind(':args_ref', $args_ref);
        $this->conn->bind(':args_ref_accounts__id', $args_ref_accounts__id);
        $this->conn->bind(':args_level', $args_level);
        $this->conn->bind(':args_manual', $args_manual);
        return $this->conn->execute();
    }
    
    public function find($args_id = null, $args_accounts__id = null, $args_date_of = null, $args_date_until = null)
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _id = :args_id 
                LIMIT 0,1";
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name;
            
            if ($args_accounts__id > 0) {
                $qry .= " WHERE _accounts__id = :args_accounts__id";
                
                if ($args_date_of != null && $args_date_until != null) {
                    $qry .= " AND DATE(_date) >= '$args_date_of' AND DATE(_date) <= '$args_date_until'";
                }
            } else {
                if ($args_date_of != null && $args_date_until != null) {
                    $qry .= " WHERE DATE(_date) >= '$args_date_of' AND DATE(_date) <= '$args_date_until'";
                }
            }
            
            $qry .= " ORDER BY _date DESC";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            
            $data = $this->conn->single();
            
            
            $account_1 = (new Accounts)->find($data['_accounts__id']);
            $account_2 = (new Accounts)->find($data['_ref_accounts__id']);
            
            if ($data['_manual'] == 'true') {
                $_manual = true;
            } else {
                $_manual = false;
            }
            
            if ($data['_removed'] == 'true') {
                $_removed = true;
            } else {
                $_removed = false;
            }
            
            $dataReturn = array(
                    '_id' => $data['_id'],
                    '_accounts__id' => $data['_accounts__id'],
                    '_accounts__username' => $account_1['_username'],
                    '_accounts__name' => $account_1['_name'],
                    '_accounts__email' => $account_1['_email'],
                    '_origin__accounts__username' => $account_2['_username'],
                    '_origin__accounts__name' => $account_2['_name'],
                    '_origin__accounts__email' => $account_2['_email'],
                    '_type' => $data['_type'],
                    '_binary_side' => $data['_binary_side'],
                    '_value' => $data['_value'],
                    '_ref' => $data['_ref'],
                    '_ref_accounts__id' => $data['_ref_accounts__id'],
                    '_level' => $data['_level'],
                    '_date' => $data['_date'],
                    '_manual' => $_manual,
                    '_removed' => $_removed
                );
            
            return $dataReturn;
        } else {
            if ($args_accounts__id > 0) {
                $this->conn->bind(':args_accounts__id', $args_accounts__id);
            }
            
            $data = $this->conn->resultSet();
            
            $dataReturn = array();
            foreach ($data as $item) {
                $account_1 = (new Accounts)->find($item['_accounts__id']);
                $account_2 = (new Accounts)->find($item['_ref_accounts__id']);
                
                if ($item['_manual'] == 'true') {
                    $_manual = true;
                } else {
                    $_manual = false;
                }
                
                if ($item['_removed'] == 'true') {
                    $_removed = true;
                } else {
                    $_removed = false;
                }
                
                array_push($dataReturn,
                    array(
                        '_id' => $item['_id'],
                        '_accounts__id' => $item['_accounts__id'],
                        '_accounts__username' => $account_1['_username'],
                        '_accounts__name' => $account_1['_name'],
                        '_accounts__email' => $account_1['_email'],
                        '_origin__accounts__username' => $account_2['_username'],
                        '_origin__accounts__name' => $account_2['_name'],
                        '_origin__accounts__email' => $account_2['_email'],
                        '_type' => $item['_type'],
                        '_binary_side' => $item['_binary_side'],
                        '_value' => $item['_value'],
                        '_ref' => $item['_ref'],
                        '_ref_accounts__id' => $item['_ref_accounts__id'],
                        '_level' => $item['_level'],
                        '_date' => $item['_date'],
                        '_manual' => $_manual,
                        '_removed' => $_removed
                    )
                );
            }
            
            return $dataReturn;
        }
    }
    
    public function getBinaryBalanceFromAccountsID($args_accounts__id, $args_binary_side, $args_deduction = true)
    {
        $qry = "SELECT SUM(`_value`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_binary_side` = :args_binary_side";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $this->conn->bind(':args_binary_side', $args_binary_side);
        $result = $this->conn->single();
        
        /** **/
        $valuePaid = 0;
        /*if ($args_binary_side == 'left') {
            $valuePaid = (new Points)->sumBinaryPaidFromAccountsID($args_accounts__id, 'right');
        } else {
            $valuePaid = (new Points)->sumBinaryPaidFromAccountsID($args_accounts__id, 'left');
        }*/
        
        $valuePaid = (new Points)->sumBinaryPaidFromAccountsID($args_accounts__id);
        /** **/
        
        if ($args_deduction == true) {
            //if ($result['_balance'] > 0) {
                return $result['_balance'] - $valuePaid;
            /*} else {
                return $result['_balance'];
            }*/
        } else {
            return $result['_balance'];
        }
    }
    
    public function sumBinaryPaidFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_binary_points`) AS _balance 
                    FROM wallet 
                WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_binary_payment` = 'true'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    /**public function setPaid($args_accounts__id, $args_type, $args_binary_side)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                    SET _paid = 'true' 
                WHERE 
                    _accounts__id = :args_accounts__id AND 
                    _type = :args_type AND 
                    _binary_side = :args_binary_side";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $this->conn->bind(':args_type', $args_type);
        $this->conn->bind(':args_binary_side', $args_binary_side);
        return $this->conn->execute();
    }**/
    
    public function delete($args_id)
    {
        $qry = "DELETE 
                FROM " . $this->table_name . " 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
}
?>
