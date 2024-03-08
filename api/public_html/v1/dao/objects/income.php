<?php
class Income {
    private $conn;
    private $table_name = "income";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_open, $args_bid, $args_date)
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
    
    public function getForCurrentDay()
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . "
                    WHERE 
                    `_date` < NOW() 
                    ORDER BY _id DESC LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $result = $this->conn->single();
        return $result;
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
    
    public function findLastLimitTime()
    {
        $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _date <= NOW() 
                ORDER BY _id DESC 
                LIMIT 0,1";
        
        $this->data = $this->conn->query($qry);
        $data = $this->conn->single();
        return $data;
    }
    
    public function update($args_id, $args_bid)
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
    
    
    /** **/
    public function new__countChartLast30()
    {
        // BY DAY
        // $this->data = $this->conn->query("SELECT DATE_FORMAT(_created_at, \"%d/%m/%Y\") AS _date, AVG(_bid) AS _value FROM `income` GROUP BY DATE_FORMAT(_created_at, \"%d-%m-%Y\") ORDER BY YEAR(_created_at) DESC, MONTH(_created_at) DESC, DAY(_created_at) DESC LIMIT 0,30");
        $this->data = $this->conn->query("SELECT DATE_FORMAT(_date, \"%d/%m/%Y %H:%i\") AS _date, _bid AS _value FROM `income` WHERE _date <= NOW() ORDER BY _date DESC LIMIT 0,30");
        return $this->conn->resultSet();
    }
    /** **/
}
?>
