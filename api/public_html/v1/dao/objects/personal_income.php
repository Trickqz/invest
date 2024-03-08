<?php
class Personal_income {
    private $conn;
    private $table_name = "personal_income";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_accounts__id, $args_contracts, $args_percentage, $args_amount)
    {
        $qry = "INSERT INTO " . $this->table_name . " 
                SET 
                    _accounts__id = :args_accounts__id, 
                    _contracts = :args_contracts, 
                    _percentage = :args_percentage, 
                    _amount = :args_amount, 
                    _blocked_until = DATE_ADD(NOW() , INTERVAL " . (new Settings)->findValue('profit_blocked_days') . " DAY), 
                    _status = 'blocked'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $this->conn->bind(':args_contracts', $args_contracts);
        $this->conn->bind(':args_percentage', $args_percentage);
        $this->conn->bind(':args_amount', $args_amount);
        return $this->conn->execute();
    }
    
    public function find($args_id = null, $args_accounts__id = null, $args_date_of = null, $args_date_until = null, $args_status = null, $order = null, $args_limit = 50)
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _id = :args_id 
                LIMIT 0,1";
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name;
                
                if ($args_accounts__id != null) {
                    $qry .= " WHERE 
                        _accounts__id = :args_accounts__id";
                    
                    if ($args_date_of != null && $args_date_until != null) {
                        $qry .= " AND DATE(_created_at) >= '$args_date_of' AND DATE(_created_at) <= '$args_date_until'";
                    }
                } else {
                    if ($args_date_of != null && $args_date_until != null) {
                        $qry .= " WHERE DATE(_created_at) >= '$args_date_of' AND DATE(_created_at) <= '$args_date_until'";
                    }
                }
                
                if ($args_status != '*' && $args_status != '') {
                    $qry .= " AND _status = '$args_status'";
                }
                
                if ($order != null) {
                    $qry .= " ORDER BY _id $order";
                }
                
                if ($args_limit != null) {
                    $qry .= " LIMIT 0,$args_limit";
                }
            }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            $data = $this->conn->single();
            return $data;
        } else {
            if ($args_accounts__id != null) {
                $this->conn->bind(':args_accounts__id', $args_accounts__id);
            }
            $data = $this->conn->resultSet();
            
            $dataReturn = array();
            foreach ($data as $item) {
                $account_1 = (new Accounts)->find($item['_accounts__id']);
                
                /*if ($item['_manual'] == 'true') {
                    $_manual = true;
                } else {
                    $_manual = false;
                }*/
                
                array_push($dataReturn,
                    array(
                        '_id' => $item['_id'],
                        '_accounts__id' => $item['_accounts__id'],
                        '_accounts__username' => $account_1['_username'],
                        '_accounts__name' => $account_1['_name'],
                        '_accounts__email' => $account_1['_email'],
                        '_contracts' => $item['_contracts'],
                        '_percentage' => $item['_percentage'],
                        '_amount' => $item['_amount'],
                        '_blocked_until' => $item['_blocked_until'],
                        '_created_at' => $item['_created_at'],
                        '_updated_at' => $item['_updated_at'],
                        '_status' => $item['_status']
                    )
                );
            }
            
            return $dataReturn;
        }
    }
    
    public function getForCurrentDay($args_account__id = null)
    {
        if ($args_account__id != null) {
            $qry = "SELECT * 
                    FROM " . $this->table_name . " 
                        WHERE 
                        _accounts__id = :args_account__id 
                        AND DAY(`_created_at`) = DAY(CURRENT_DATE()) AND MONTH(`_created_at`) = MONTH(CURRENT_DATE()) AND YEAR(`_created_at`) = YEAR(CURRENT_DATE())";
        } else {
            $qry = "SELECT * 
                    FROM " . $this->table_name . "
                        WHERE 
                        DAY(`_created_at`) = DAY(CURRENT_DATE()) AND MONTH(`_created_at`) = MONTH(CURRENT_DATE()) AND YEAR(`_created_at`) = YEAR(CURRENT_DATE())";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_account__id != null) {
            $this->conn->bind(':args_account__id', $args_account__id);
        }
        $result = $this->conn->resultSet();
        return $result;
    }
    
    public function getAvailableBalanceFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_status` = 'pending'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getBlockedBalanceFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_status` = 'blocked'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function findLast($args_account__id = null)
    {
        if ($args_account__id != null) {
            $qry = "SELECT * 
                    FROM " . $this->table_name . " 
                    WHERE 
                        _accounts__id = :args_accounts__id
                    ORDER BY _id DESC 
                    LIMIT 0,1";
        } else {
            $qry = "SELECT * 
                    FROM " . $this->table_name . " 
                    ORDER BY _id DESC 
                    LIMIT 0,1";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_account__id != null) {
            $this->conn->bind(':args_accounts__id', $args_accounts__id);
        }
        $data = $this->conn->single();
        return $data;
    }
    
    public function setEffected($args_accounts__id)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET 
                    _status = 'effected' 
                WHERE 
                    _accounts__id = :args_accounts__id 
                    AND _status = 'pending'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        return $this->conn->execute();
    }
    
    public function processPending()
    {
        //SELECT _created_at FROM `personal_income` GROUP BY DATE_FORMAT(`_created_at`, "%y%m%d") ORDER BY YEAR(`_created_at`) DESC, MONTH(`_created_at`) DESC, DAY(`_created_at`) DESC;
        //SELECT COUNT(*) as _count, `_accounts__id` as _accounts__id FROM `personal_income` WHERE _blocked_until <= NOW() AND _status = 'blocked' GROUP BY _accounts__id;
        
        //$qry = "SELECT COUNT(*) as _count, `_accounts__id` as _accounts__id FROM `personal_income` WHERE _created_at <= NOW() AND _status = 'blocked' GROUP BY _accounts__id";
        $qry = "SELECT COUNT(*) as _count, `_accounts__id` as _accounts__id FROM `personal_income` WHERE _blocked_until <= NOW() AND _status = 'blocked' GROUP BY _accounts__id";
        $this->data = $this->conn->query($qry);
        $result = $this->conn->resultSet();
        
        for($i = 0; $i <= sizeof($result); $i++){
            //if ($result[$i]['_count'] >= 7) {
                (new Personal_income)->processPendingFromAccountId($result[$i]['_accounts__id']);
            //}
        }
        
        return true;
    }
    
    public function processPendingFromAccountId($args_accounts__id) {
        // _blocked_until >> _created_at
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET 
                    _status = 'pending' 
                WHERE 
                    _created_at <= NOW() 
                    AND _accounts__id = :args_accounts__id 
                    AND _status = 'blocked'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        return $this->conn->execute();
    }
    
    /*public function update($args_id, $args_bid)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _bid = :args_bid  
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        $this->conn->bind(':args_bid', $args_bid);
        return $this->conn->execute();
    }*/
    
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
