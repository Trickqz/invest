<?php
class Personal_income_requests {
    private $conn;
    private $table_name = "personal_income_requests";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_accounts__id, $args_amount, $args_status = 'pending')
    {
        $qry = "INSERT INTO " . $this->table_name . " 
                SET 
                    _accounts__id = :args_accounts__id, 
                    _amount = :args_amount, 
                    _status = :args_status";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $this->conn->bind(':args_amount', $args_amount);
        $this->conn->bind(':args_status', $args_status);
        return $this->conn->execute();
    }
    
    public function find($args_id = null, $args_account__id = null, $args_date_of = null, $args_date_until = null, $args_status = null, $order = null, $args_limit = 50)
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _id = :args_id 
                LIMIT 0,1";
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name;
                
                if ($args_account__id != null) {
                    $qry .= " WHERE 
                        _accounts__id = :args_accounts__id";
                    
                    if ($args_date_of != null && $args_date_until != null) {
                        $qry .= " AND DATE(_date) >= '$args_date_of' AND DATE(_date) <= '$args_date_until'";
                    }
                } else {
                    if ($args_date_of != null && $args_date_until != null) {
                        $qry .= " WHERE DATE(_date) >= '$args_date_of' AND DATE(_date) <= '$args_date_until'";
                    }
                }
                
                if ($args_status != null) {
                    $qry .= " AND _status = :args_status";
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
            if ($args_account__id != null) {
                $this->conn->bind(':args_accounts__id', $args_account__id);
            }
            if ($args_status != null) {
                $this->conn->bind(':args_status', $args_status);
            }
            $data = $this->conn->resultSet();
            return $data;
        }
    }
    
    public function findPending()
    {
        $qry = "SELECT * 
            FROM " . $this->table_name . "
            WHERE 
                _status = 'pending'";
        
        $this->data = $this->conn->query($qry);
        $data = $this->conn->resultSet();
        return $data;
    }
    
    public function findPendingValue()
    {
        $qry = "SELECT SUM(_amount) AS TOTAL 
            FROM " . $this->table_name . "
            WHERE 
                _status = 'pending'";
        
        $this->data = $this->conn->query($qry);
        $data = $this->conn->single();
        return $data['TOTAL'];
    }
    
    /*public function getBlockedBalanceFromAccountsID($args_accounts__id)
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
    }*/
    
    public function findLastPub($args_accounts__id = null)
    {

        //var_dump($args_accounts__id);

        $qry = "SELECT personal_income_requests.*, accounts._name
                FROM personal_income_requests 
                LEFT OUTER JOIN accounts
                ON accounts._id = personal_income_requests._accounts__id 
                WHERE personal_income_requests._status = 'pending'";
                if($args_accounts__id != null){
                    $qry .= " AND personal_income_requests._accounts__id = " . $args_accounts__id;
                }
                $qry .= " ORDER BY _id ASC LIMIT 0,40";

                // if($args_accounts__id != null) {
                //     $qry .= " AND personal_income_requests._account__id = :args_accounts__id;
                // }

                // $qry .= ORDER BY _id ASC LIMIT 0,40;
        
        $this->data = $this->conn->query($qry);
        $data = $this->conn->resultSet();
        return $data;
    }
    
    public function setReceived($args_id = null, $args_received)
    {
        $personal_income_requests = (new Personal_income_requests)->find($args_id);
        if ($args_received+(float)$personal_income_requests['_amount'] >= (float)$personal_income_requests['_amount']) {
            $qry = "UPDATE 
                    " . $this->table_name . " 
                    SET 
                        _received = :args_received, 
                        _status = 'effected' 
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
