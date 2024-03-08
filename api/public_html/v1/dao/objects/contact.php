<?php
class Contact {
    private $conn;
    private $table_name = "contact";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_type, $args_name, $args_phone, $args_mobile_phone, $args_email, $args_sex, $args_message)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _type = :args_type, 
                    _name = :args_name, 
                    _phone = :args_phone, 
                    _mobile_phone = :args_mobile_phone, 
                    _email = :args_email, 
                    _message = :args_message, 
                    _sex = :args_sex";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_type', $args_type);
        $this->conn->bind(':args_name', $args_name);
        $this->conn->bind(':args_phone', (new Format)->clearNumber($args_phone));
        $this->conn->bind(':args_mobile_phone', (new Format)->clearNumber($args_mobile_phone));
        $this->conn->bind(':args_email', $args_email);
        $this->conn->bind(':args_sex', $args_sex);
        $this->conn->bind(':args_message', $args_message);
        return $this->conn->execute();
    }
    
    public function find($args_id = null)
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _id = :args_id 
                LIMIT 0,1";
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name . " ORDER BY _created_at DESC";
            }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            
            $data = $this->conn->single();
            
            if ($data['_readed'] == '1') {
                $_readed = true;
            } else {
                $_readed = false;
            }
            
            $dataReturn = array(
                    '_id' => $data['_id'],
                    '_type' => $data['_type'],
                    '_name' => $data['_name'],
                    '_phone' => $data['_phone'],
                    '_mobile_phone' => $data['_mobile_phone'],
                    '_email' => $data['_email'],
                    '_sex' => $data['_sex'],
                    '_subject' => $data['_subject'],
                    '_message' => $data['_message'],
                    '_created_at' => $data['_created_at'],  //(new Date)->formatDate($item['_created_at']),
                    '_updated_at' => $data['_updated_at'],
                    '_readed' => $_readed
                );
            
            return $dataReturn;
        } else {
            if ($args_user__id) {
                $this->conn->bind(':args_user__id', $args_user__id);
            }
            if ($_readedExists) {
                $this->conn->bind(':args_readed', $_readed);
            }
            
            
            $data = $this->conn->resultSet();
            $dataReturn = array();
            foreach ($data as $item) {
                if ($item['_readed'] == '1') {
                    $_readed = true;
                } else {
                    $_readed = false;
                }
                
                array_push($dataReturn,
                    array(
                        '_id' => $item['_id'],
                        '_type' => $item['_type'],
                        '_name' => $item['_name'],
                        '_phone' => $item['_phone'],
                        '_mobile_phone' => $item['_mobile_phone'],
                        '_email' => $item['_email'],
                        '_sex' => $item['_sex'],
                        '_subject' => $item['_subject'],
                        '_message' => $item['_message'],
                        '_created_at' => $item['_created_at'],  //(new Date)->formatDate($item['_created_at']),
                        '_updated_at' => $item['_updated_at'],
                        '_readed' => $_readed
                    )
                );
            }
            
            return $dataReturn;
        }
    }
    
    public function setReaded($args_id = null, $all = false)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _readed = :args_readed";
        if (!$all) {
            $qry .= " WHERE _id = :args_id";
        }
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_readed', true);
        if (!$all) {
            $this->conn->bind(':args_id', $args_id);
        }
        return $this->conn->execute();
    }
    
    public function update($args_id, $args_type, $args_name, $args_phone, $args_mobile_phone, $args_email, $args_sex, $args_message)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET  
                    _type = :args_type, 
                    _name = :args_name, 
                    _phone = :args_phone, 
                    _mobile_phone = :args_mobile_phone, 
                    _email = :args_email, 
                    _sex = :args_sex, 
                    _message = :args_message 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_id', $args_id);
        $this->conn->bind(':args_type', $args_type);
        $this->conn->bind(':args_name', $args_name);
        $this->conn->bind(':args_phone', (new Format)->clearNumber($args_phone));
        $this->conn->bind(':args_mobile_phone', (new Format)->clearNumber($args_mobile_phone));
        $this->conn->bind(':args_email', $args_email);
        $this->conn->bind(':args_sex', $args_sex);
        $this->conn->bind(':args_message', $args_message);
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
    
    
    
    /*
     * Export Data from MySQL to CSV Script
     * Version: 1.0.0
     * Page: Export
     */
    public function exportCsv() {
        $array_banks = $this->find();
        
        $export_data = array();
        foreach ($array_banks as $row)
        {
            //$export_data[] = $row;
            $export_data[] = array(
                "id" => $row['_id'],
                "type" => $row['_type'],
                "name" => $row['_name'],
                "phone" => $row['_phone'],
                "mobile_phone" => $row['_mobile_phone'],
                "email" => $row['_email'],
                "sex" => $row['_sex']=='male' ? 'Masculino' : 'Feminino',
                "message" => $row['_message']
            );
        }
        
        
        $filename = 'Contato.csv';
        header ("Expires: ".gmdate('D, d M Y H:i:s')." GMT");
        header ("Last-Modified: " . gmdate("D,d M YH:i:s") . " GMT");
        header ("Cache-Control: no-cache, must-revalidate");
        header ("Pragma: no-cache");
        header ("Content-Type: text/csv; charset=utf-8");
        header ("Content-Disposition: attachment; filename={$filename}");
        header ("Content-Description: PHP Generated Data");
        
        $output = fopen('php://output', 'w');
        fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF));
        fputcsv($output, array('ID', 'Tipo', 'Nome', 'Telefone', 'Telefone Móvel', 'E-mail', 'Sexo', 'Mensagem'));

        if (count($export_data) > 0) {
            foreach ($export_data as $row) {
                fputcsv($output, $row);
            }
        }
    }
    
    /*
     * Export Data from MySQL to XLS Script
     * Version: 1.0.0
     * Page: Export
     */
    public function exportXls()
    {
        $array_banks = $this->find();
        $count = count($array_banks);
        
        for ($i=0;$i<1;$i++){
            $html[$i] = "";
            $html[$i] .= "<table>";
            $html[$i] .= "<tr>";
            $html[$i] .= "<td><b>ID</b></td>";
            $html[$i] .= "<td><b>Tipo</b></td>";
            $html[$i] .= "<td><b>Nome</b></td>";
            $html[$i] .= "<td><b>Telefone</b></td>";
            $html[$i] .= "<td><b>Telefone Móvel</b></td>";
            $html[$i] .= "<td><b>E-mail</b></td>";
            $html[$i] .= "<td><b>Sexo</b></td>";
            $html[$i] .= "<td><b>Mensagem</b></td>";
            $html[$i] .= "</tr>";
            $html[$i] .= "</table>";
        }
        
        $i = 1;
        foreach ($array_banks as $row)
        {
            $row_id             = $row['_id'];
            $row_type           = $row['_type'];
            $row_name           = $row['_name'];
            $row_phone          = $row['_phone'];
            $row_mobile_phone   = $row['_mobile_phone'];
            $row_email          = $row['_email'];
            $row_sex            = $row['_sex']=='male' ? 'Masculino' : 'Feminino';
            $row_message        = $row['_message'];
            
            $html[$i] .= "<table>";
            $html[$i] .= "<tr>";
            $html[$i] .= "<td>$row_id</td>";
            $html[$i] .= "<td>$row_type</td>";
            $html[$i] .= "<td>$row_name</td>";
            $html[$i] .= "<td>$row_phone</td>";
            $html[$i] .= "<td>$row_mobile_phone</td>";
            $html[$i] .= "<td>$row_email</td>";
            $html[$i] .= "<td>$row_sex</td>";
            $html[$i] .= "<td>$row_message</td>";
            $html[$i] .= "</tr>";
            $html[$i] .= "</table>";
            $i++;
        }
        
        
        $filename = 'Contato.xls';
        header ("Expires: ".gmdate('D, d M Y H:i:s')." GMT");
        header ("Last-Modified: " . gmdate("D,d M YH:i:s") . " GMT");
        header ("Cache-Control: no-cache, must-revalidate");
        header ("Pragma: no-cache");
        header ("Content-Type: application/x-msexcel");
        header ("Content-Disposition: attachment; filename={$filename}");
        header ("Content-Transfer-Encoding: binary");
        header ("Content-Description: PHP Generated Data");
        
        for ($i=0;$i<=$count;$i++)
        {  
            echo utf8_decode($html[$i]);
        }
    }
}
?>
