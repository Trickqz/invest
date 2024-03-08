<?php
class Coinbase_ins {
    private $conn;
    private $table_name = "coinbase_ins";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_hash, $args_accounts__id, $args_amount, $args_coinbase_id, $args_coinbase_code, $args_coinbase_hosted_url, $args_coinbase_expires_at, $args_response, $args_webhook, $args_status)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _hash = :args_hash, 
                    _accounts__id = :args_accounts__id, 
                    _amount = :args_amount, 
                    _coinbase_id = :args_coinbase_id, 
                    _coinbase_code = :args_coinbase_code, 
                    _coinbase_hosted_url = :args_coinbase_hosted_url, 
                    _coinbase_expires_at = :args_coinbase_expires_at, 
                    _response = :args_response, 
                    _webhook = :args_webhook, 
                    _status = :args_status";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_hash', $args_hash);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $this->conn->bind(':args_amount', $args_amount);
        $this->conn->bind(':args_coinbase_id', $args_coinbase_id);
        $this->conn->bind(':args_coinbase_code', $args_coinbase_code);
        $this->conn->bind(':args_coinbase_hosted_url', $args_coinbase_hosted_url);
        $this->conn->bind(':args_coinbase_expires_at', date('Y-m-d h:i:s', strtotime($args_coinbase_expires_at)));
        $this->conn->bind(':args_response', $args_response);
        $this->conn->bind(':args_webhook', $args_webhook);
        $this->conn->bind(':args_status', $args_status);
        return $this->conn->execute();
    }
    
    /*public function find($args_id = null, $args_date_of = null, $args_date_until = null, $order = null, $args_limit = 50)
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _id = :args_id 
                LIMIT 0,1";
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name;
                
                    if ($args_date_of != null && $args_date_until != null) {
                        $qry .= " WHERE DATE(_date) >= '$args_date_of' AND DATE(_date) <= '$args_date_until'";
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
            $data = $this->conn->resultSet();
            return $data;
        }
    }*/
    
    public function findAllWaiting($args_accounts__id = null)
    {
        if ($args_accounts__id != null && $args_accounts__id != 0) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE 
                    _accounts__id = :args_accounts__id 
                    AND _status = :args_status";
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE 
                    _status = :args_status";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_accounts__id != null && $args_accounts__id != 0) {
            $this->conn->bind(':args_accounts__id', $args_accounts__id);
        }
        $this->conn->bind(':args_status', 'waiting');
        $data = $this->conn->resultSet();
        return $data;
    }
    
    public function countAllWaiting($args_accounts__id = null)
    {
        if ($args_accounts__id != null && $args_accounts__id != 0) {
            $qry = "SELECT COUNT(*) AS _count 
                FROM " . $this->table_name . " 
                WHERE 
                    _accounts__id = :args_accounts__id 
                    AND _status = :args_status";
        } else {
            $qry = "SELECT COUNT(*) AS _count 
                FROM " . $this->table_name . " 
                WHERE 
                    _status = :args_status";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_accounts__id != null && $args_accounts__id != 0) {
            $this->conn->bind(':args_accounts__id', $args_accounts__id);
        }
        $this->conn->bind(':args_status', 'waiting');
        $data = $this->conn->single();
        return $data['_count'];
    }
    
    public function findCoinbase_code($args_coinbase_code)
    {
        $qry = "SELECT * 
            FROM " . $this->table_name . " 
            WHERE 
                _coinbase_code = :args_coinbase_code 
            LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_coinbase_code', $args_coinbase_code);
        $data = $this->conn->single();
        return $data;
    }
    
    public function findHash($args_hash)
    {
        $qry = "SELECT * 
            FROM " . $this->table_name . " 
            WHERE 
                _hash = :args_hash 
            LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_hash', $args_hash);
        $data = $this->conn->single();
        return $data;
    }
    
    public function update($args_id, $args_charge, $args_status)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _charge = :args_charge, 
                    _status = :args_status 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        $this->conn->bind(':args_charge', $args_charge);
        $this->conn->bind(':args_status', $args_status);
        return $this->conn->execute();
    }
    
    /*public function delete($args_id)
    {
        $qry = "DELETE 
                FROM " . $this->table_name . " 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }*/
}
?>
