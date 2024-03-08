<?php
class Quotations {
    private $conn;
    private $table_name = "quotations";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_open, $args_bid)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _open = :args_open, 
                    _bid = :args_bid";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_open', $args_open);
        $this->conn->bind(':args_bid', $args_bid);
        return $this->conn->execute();
    }
    
    public function findLast()
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                ORDER BY _id DESC 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $data = $this->conn->single();
        return $data;
    }
    
    
    /** **/
    public function new__countChartLast30()
    {
        $this->data = $this->conn->query("SELECT DATE_FORMAT(_created_at, \"%d/%m/%Y\") AS _date, AVG(_bid) AS _value FROM `quotations` GROUP BY DATE_FORMAT(_created_at, \"%d-%m-%Y\") ORDER BY YEAR(_created_at) DESC, MONTH(_created_at) DESC, DAY(_created_at) DESC LIMIT 0,30");
        return $this->conn->resultSet();
    }
    /** **/
}
?>
