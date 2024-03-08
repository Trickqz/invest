<?php
class Notifications {
    private $conn;
    private $table_name = "notifications";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_user__id, $args_type, $args_display_type, $args_subject, $args_content, $args_img_src, $args_date_start = null, $args_date_end = null)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _user__id = :args_user__id, 
                    _type = :args_type, 
                    _display_type = :args_display_type, 
                    _subject = :args_subject, 
                    _content = :args_content, 
                    _img_src = :args_img_src, 
                    _date_start = :args_date_start, 
                    _date_end = :args_date_end";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_user__id', $args_user__id);
        $this->conn->bind(':args_type', $args_type);
        $this->conn->bind(':args_display_type', $args_display_type);
        $this->conn->bind(':args_subject', $args_subject);
        $this->conn->bind(':args_content', $args_content);
        $this->conn->bind(':args_img_src', $args_img_src);
        $this->conn->bind(':args_date_start', $args_date_start);
        $this->conn->bind(':args_date_end', $args_date_end);
        return $this->conn->execute();
    }
    
    public function find($args_id = null, $args_user__id = null, $args_read = null, $args_order = "asc")
    {
        if ($args_read == 'true') {
            $_read = true;
            $_readExists = true;
        } else if ($args_read == 'false') {
                $_read = false;
                $_readExists = true;
            } else {
                $_readExists = false;
            }
        
        
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _id = :args_id 
                LIMIT 0,1";
        } else {
                $qry = "SELECT * 
                    FROM " . $this->table_name . "
                    WHERE 
                        _user__id = :args_user__id";
            
                if ($_readExists) {
                    $qry .= " AND _read = :args_read";
                }
                
                if ($args_order == "desc") {
                    $qry .= " ORDER BY _id DESC";
                }
            }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            
            $data = $this->conn->single();
            
            if ($data['_system_message'] == '1') {
                $_system_message = true;
            } else {
                $_system_message = false;
            }
            if ($data['_read'] == '1') {
                $_read = true;
            } else {
                $_read = false;
            }
            
            $dataReturn = array(
                    '_id' => $data['_id'],
                    '_user__id' => $data['_user__id'],
                    '_type' => $data['_type'],
                    '_display_type' => $data['_display_type'],
                    '_subject' => $data['_subject'],
                    '_date_start' => $data['_date_start'],
                    '_date_end' => $data['_date_end'],
                    '_content' => $data['_content'],
                    '_img_src' => $data['_img_src'],
                    '_created_at' => $data['_created_at'],
                    '_updated_at' => $data['_updated_at'],
                    //(new Date)->formatDate($item['_created_at']),
                    '_system_message' => $_system_message,
                    '_read' => $_read
                );
            
            return $dataReturn;
        } else {
            if ($args_user__id) {
                $this->conn->bind(':args_user__id', $args_user__id);
            }
            if ($_readExists) {
                $this->conn->bind(':args_read', $_read);
            }
            
            
            $data = $this->conn->resultSet();
            $dataReturn = array();
            foreach ($data as $item) {
                if ($item['_system_message'] == '1') {
                    $_system_message = true;
                } else {
                    $_system_message = false;
                }
                if ($item['_read'] == '1') {
                    $_read = true;
                } else {
                    $_read = false;
                }
                
                array_push($dataReturn,
                    array(
                        '_id' => $item['_id'],
                        '_user__id' => $item['_user__id'],
                        '_type' => $item['_type'],
                        '_display_type' => $item['_display_type'],
                        '_subject' => $item['_subject'],
                        '_date_start' => $item['_date_start'],
                        '_date_end' => $item['_date_end'],
                        '_content' => $item['_content'],
                        '_img_src' => $item['_img_src'],
                        '_created_at' => $item['_created_at'],  //(new Date)->formatDate($item['_created_at']),
                        '_updated_at' => $item['_updated_at'],
                        '_system_message' => $_system_message,
                        '_read' => $_read
                    )
                );
            }
            
            return $dataReturn;
        }
    }
    
    public function setRead($args_id = null, $args_user__id = null, $all = false)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _read = :args_read 
                WHERE 
                    _user__id = :args_user__id";
        if (!$all) {
            $qry .= " AND _id = :args_id";
        }
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_read', true);
        if (!$all) {
            $this->conn->bind(':args_id', $args_id);
        }
        $this->conn->bind(':args_user__id', $args_user__id);
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
