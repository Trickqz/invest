<?php
class Donations_model {
    private $conn;
    private $table_name = "donations_model";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_name, $args_description, $args_contracts, $args_amount, $args_fee, $args_income)  //$args_type
    {
        $args_hash = newMD5Hash();
        
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _hash = :args_hash, 
                    _name = :args_name, 
                    _description = :args_description, 
                    _contracts = :args_contracts, 
                    _amount = :args_amount, 
                    _fee = :args_fee, 
                    _income = :args_income, 
                    _status = :args_status";
        
        // _type = :args_type, 
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_hash', $args_hash);
        $this->conn->bind(':args_name', $args_name);
        $this->conn->bind(':args_description', $args_description);
        $this->conn->bind(':args_contracts', $args_contracts);
        $this->conn->bind(':args_amount', $args_amount);
        $this->conn->bind(':args_fee', $args_fee);
        $this->conn->bind(':args_income', $args_income);
        //$this->conn->bind(':args_type', $args_type);
        $this->conn->bind(':args_status', 'active');
        return $this->conn->execute();
    }
    
    public function find($args_id = null, $args_type = null, $args_status = null, $order = null, $args_limit = 50)
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _id = :args_id 
                LIMIT 0,1";
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name;
                
                if ($args_type != null) {
                    $qry .= " WHERE _type = :args_type";
                    
                    if ($args_status != null && $args_status != "*") {
                        $qry .= " AND _status = :args_status";
                    }
                } else {
                    if ($args_status != null && $args_status != "*") {
                        $qry .= " WHERE _status = :args_status";
                    }
                }
                
                if ($order != null) {
                    //$qry .= " ORDER BY _id $order";
                    $qry .= " ORDER BY _amount $order";
                }
                
                if ($args_limit != null) {
                    $qry .= " LIMIT 0,$args_limit";
                }
            }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            return $this->conn->single();
        } else {
            if ($args_type) {
                $this->conn->bind(':args_type', $args_type);
            }
            if ($args_status && $args_status != "*") {
                $this->conn->bind(':args_status', $args_status);
            }
            return $this->conn->resultSet();
        }
    }
    
    public function update($args_id, $args_name, $args_description, $args_contracts, $args_amount, $args_fee, $args_income)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _name = :args_name, 
                    _description = :args_description, 
                    _contracts = :args_contracts, 
                    _amount = :args_amount, 
                    _fee = :args_fee, 
                    _income = :args_income 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        $this->conn->bind(':args_name', $args_name);
        $this->conn->bind(':args_description', $args_description);
        $this->conn->bind(':args_contracts', $args_contracts);
        $this->conn->bind(':args_amount', $args_amount);
        $this->conn->bind(':args_fee', $args_fee);
        $this->conn->bind(':args_income', $args_income);
        return $this->conn->execute();
    }
    
    
    public function setStatus($args_id = null, $args_status)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _status = :args_status 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_status', $args_status);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
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
