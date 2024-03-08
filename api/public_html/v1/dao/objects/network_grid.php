<?php
class Network_grid {
    private $conn;
    private $table_name = "network_grid";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_level, $args_master, $args_sponsor, $args_accounts__id)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _level = :args_level, 
                    _master = :args_master, 
                    _sponsor = :args_sponsor, 
                    _accounts__id = :args_accounts__id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_level', $args_level);
        $this->conn->bind(':args_master', $args_master);
        $this->conn->bind(':args_sponsor', $args_sponsor);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        return $this->conn->execute();
    }
    
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
