<?php
class System_emails {
    private $conn;
    private $table_name = "system_emails";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    /*public function insert($args_name, $args_value)
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
    }*/
    
    public function findObject($args_object)
    {
        $qry = "SELECT *
                FROM " . $this->table_name . "
                WHERE _object = :args_object 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_object', $args_object);
        $result = $this->conn->single();
        return $result;
    }
    
    public function update($args_object, $args_subject, $args_content)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _subject = :args_subject, 
                    _content = :args_content 
                WHERE 
                    _object = :args_object";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_object', $args_object);
        $this->conn->bind(':args_subject', $args_subject);
        $this->conn->bind(':args_content', $args_content);
        return $this->conn->execute();
    }
    
    /*public function delete($args_name)
    {
        $qry = "DELETE 
                FROM " . $this->table_name . " 
                WHERE 
                args_name = :args_name";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_name', $args_name);
        return $this->conn->execute();
    }*/
}
?>
