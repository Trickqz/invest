<?php
class Settings {
    private $conn;
    private $table_name = "settings";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function insert($args_name, $args_value)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _name = :args_name,
                    _value = :args_value";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_name', $args_name);
        $this->conn->bind(':args_value', $args_value);
        return $this->conn->execute();
    }
    
    public function find($args_name)
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _name = :args_name 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_name', $args_name);
        return $this->conn->resultSet();
    }
    
    public function findAllAsJson()
    {
        $qry = "SELECT * FROM " . $this->table_name;
        
        $this->data = $this->conn->query($qry);
        //return $this->conn->resultSet();
        
        $data = $this->conn->resultSet();
        $dataReturn = array();
        foreach ($data as $item) {
            $dataItem = array($item['_name']=>$item['_value']);
            $dataReturn = array_merge($dataReturn, $dataItem);
        }
        
        return $dataReturn;
    }
    
    public function findValue($args_name)
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _name = :args_name 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_name', $args_name);
        $result = $this->conn->single();
        return $result['_value'];
    }
    
    public function findAllParamValue($args_param)
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE 
                    _name LIKE '%$args_param%'";
        
        $this->data = $this->conn->query($qry);
        return $this->conn->resultSet();
    }
    
    public function update($args_name, $args_value)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _value = :args_value 
                WHERE 
                    _name = :args_name";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_name', $args_name);
        $this->conn->bind(':args_value', $args_value);
        return $this->conn->execute();
    }
    
    public function delete($args_name)
    {
        $qry = "DELETE 
                FROM " . $this->table_name . " 
                WHERE 
                    _name = :args_name";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_name', $args_name);
        return $this->conn->execute();
    }
}
?>
