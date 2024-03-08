<?php
class Bonus {
    private $conn;
    private $table_name = "bonus";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    /*public function create($args_open, $args_bid, $args_date)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _open = :args_open, 
                    _bid = :args_bid, 
                    _date = :args_date";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_open', $args_open);
        $this->conn->bind(':args_bid', $args_bid);
        
        $date = date("Y-m-d H:i:s", strtotime($args_date));
        $this->conn->bind(':args_date', $date);
        return $this->conn->execute();
    }*/
    
    public function find($args_id = null, $args_date_of = null, $args_date_until = null, $order = null, $args_limit = 50)
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
                        $qry .= " WHERE DATE(_created_at) >= '$args_date_of' AND DATE(_created_at) <= '$args_date_until'";
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
    }
    
    public function findFromTypeAndLevel($args_type, $args_level)
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE 
                    _type = :args_type, 
                    _level = :args_level 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_type', $args_type);
        $this->conn->bind(':args_level', $args_level);
        $data = $this->conn->single();
        return $data;
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
