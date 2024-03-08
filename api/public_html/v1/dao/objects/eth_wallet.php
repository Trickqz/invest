<?php
class ETH_Wallet {
    private $conn;
    private $table_name = "eth_wallet";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    /*public function create($args_name)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _name = :args_name";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_name', $args_name);
        return $this->conn->execute();
    }*/
    
    public function find($args_id = null, $rand = false)
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _id = :args_id 
                LIMIT 0,1";
        } else {
                $qry = "SELECT * 
                    FROM " . $this->table_name;
                
                if ($rand) {
                    $qry .= " ORDER BY RAND()";
                }
            }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            return $this->conn->single();
        } else {
            return $this->conn->resultSet();
        }
    }
    
    /*public function update($args_id, $args_name)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _name = :args_name 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        $this->conn->bind(':args_name', $args_name);
        return $this->conn->execute();
    }
    
    public function delete($args_id)
    {
        (new Subcategories)->deleteAllFromCategoriesId($args_id);
        
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
