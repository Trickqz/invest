<?php
class Logs {
    private $conn;
    private $table_name = "logs";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    /*
     * Type :: Description
     *  --> Log de cadastro
     *      - Cadastro de novo usuário (usuário: $email)
     *      - Cadastro de nova senha (usuário: $email)
     * 
     *  --> Log de alteração de dados
     *      - Alteração de cadastro
     *      - Alteração de cadastro admin (usuario: $email)
     *      - Alteração de configuração (tipo: $type)
     * 
     *  --> Log de cadastro de resultado de jogos
     *      - Cadastro admin - Cancelamento (jogo: 17)
     *      - Cadastro admin (jogo: 1)
     * 
     *  --> Log de envio de convite
     *      - Envio de convite para $email
     * 
     *  --> Log de erro
     *      - Cadastro de novo usuário (e-mail: $email)
     *      - Falha de alteração se senha (e-mail: $email)
     *      - Falha de recuperação se senha (e-mail: $email)
     *      - Falha de alteração de configuração (tipo: $type)
     * 
     *  --> Log de acesso
     *      - Acesso ao sistema (usuário: $email)
     *      - Acesso não autorizado (usuário: $email)
     * 
     */
    public function create($args_type, $args_user__id = null, $args_log_user_agent, $args_log_ip, $args_description)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _type = :args_type, 
                    _user__id = :args_user__id, 
                    _log_user_agent = :args_log_user_agent, 
                    _log_ip = :args_log_ip, 
                    _description = :args_description";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_type', $args_type);
        $this->conn->bind(':args_user__id', $args_user__id);
        $this->conn->bind(':args_log_user_agent', $args_log_user_agent);
        $this->conn->bind(':args_log_ip', $args_log_ip);
        $this->conn->bind(':args_description', $args_description);
        return $this->conn->execute();
    }
    
    public function find($args_id = null, $args_user__id = null, $args_q = null, $args_limit = 400)
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE 
                    _id = :args_id 
                LIMIT 0,1";
        } else if ($args_user__id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . "
                WHERE 
                    _user__id = :args_user__id";
            
            if ($args_q != "") {
                $qry .= " AND _description LIKE '%$args_q%'";
            }
            
            if ($args_limit != null) {
                $qry .= " LIMIT 0,$args_limit";
            }
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name;
            
            if ($args_q != "") {
                $qry .= " WHERE _description LIKE '%$args_q%'";
            }
            
            if ($args_limit != null) {
                $qry .= " LIMIT 0,$args_limit";
            }
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            return $this->conn->single();
        } else if ($args_user__id) {
            $this->conn->bind(':args_user__id', $args_user__id);
            return $this->conn->resultSet();
        } else {
            return $this->conn->resultSet();
        }
    }
    
    public function findLikeUsers($args_id = null, $args_user__id = null, $args_q = null, $args_date_of = null, $args_date_until = null, $args_limit = 100, $order = 'DESC')
    {
        // SELECT A.*, B._name AS _accounts__name FROM `logs` A LEFT OUTER JOIN accounts B ON (B._id = A._user__id)
        
        if ($args_id) {
            $qry = "SELECT A.*, B._name AS _accounts__name 
                FROM " . $this->table_name . " A LEFT OUTER JOIN accounts B 
                ON 
                    (B._id = A._user__id) 
                WHERE 
                    A._id = :args_id AND 
                    A._user__id = :args_user__id ";
            
            if ($args_q != "") {
                $qry .= " AND A._description LIKE '%$args_q%'";
            }
            
            if ($args_date_of != null && $args_date_until != null) {
                $qry .= " AND DATE(_created_at) >= '$args_date_of' AND DATE(_created_at) <= '$args_date_until'";
            }
            
            if ($order != null) {
                $qry .= " ORDER BY A._id $order";
            }
            
            $qry .= " LIMIT 0,1";
        } else if ($args_user__id) {
            $qry = "SELECT A.*, B._name AS _accounts__name 
                FROM " . $this->table_name . " A LEFT OUTER JOIN accounts B 
                ON 
                    (B._id = A._user__id) 
                WHERE 
                    A._user__id = :args_user__id";
            
            if ($args_q != "") {
                $qry .= " AND A._description LIKE '%$args_q%'";
            }
            
            if ($args_date_of != null && $args_date_until != null) {
                $qry .= " AND DATE(_created_at) >= '$args_date_of' AND DATE(_created_at) <= '$args_date_until'";
            }
            
            if ($order != null) {
                $qry .= " ORDER BY A._id $order";
            }
            
            if ($args_limit != null) {
                $qry .= " LIMIT 0,$args_limit";
            }
        } else {
            $qry = "SELECT A.*, B._name AS _accounts__name 
                FROM " . $this->table_name . " A LEFT OUTER JOIN accounts B 
                ON 
                    (B._id = A._user__id) 
                WHERE 
                    A._user__id = B._id";
            
            if ($args_q != "") {
                $qry .= " AND A._description LIKE '%$args_q%'";
            }
            
            if ($args_date_of != null && $args_date_until != null) {
                $qry .= " AND DATE(A._created_at) >= '$args_date_of' AND DATE(A._created_at) <= '$args_date_until'";
            }
            
            if ($order != null) {
                $qry .= " ORDER BY A._id $order";
            }
            if ($args_limit != null) {
                $qry .= " LIMIT 0,$args_limit";
            }
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            return $this->conn->single();
        } else if ($args_user__id) {
            $this->conn->bind(':args_user__id', $args_user__id);
            return $this->conn->resultSet();
        } else {
            return $this->conn->resultSet();
        }
    }
    
    
    
    /*
     * Export Data from MySQL to CSV Script
     * Version: 1.0.0
     * Page: Export
     */
    public function exportCsv() {
        $array_logs = $this->findLikeUsers(null, null, 9999999, null);
        
        $export_data = array();
        foreach ($array_logs as $row)
        {
            //$export_data[] = $row;
            $export_data[] = array(
                "id" => $row['_id'],
                "type" => $row['_type'],
                "name" => $row['users__name'],
                "log_user_agent" => $row['_log_user_agent'],
                "log_ip" => $row['_log_ip'],
                "description" => $row['_description'],
                "created_at" => date( "m/d/Y \à\s h:i:s A", strtotime($row['_created_at']))
            );
        }
        
        
        $filename = 'Logs.csv';
        header ("Expires: ".gmdate('D, d M Y H:i:s')." GMT");
        header ("Last-Modified: " . gmdate("D,d M YH:i:s") . " GMT");
        header ("Cache-Control: no-cache, must-revalidate");
        header ("Pragma: no-cache");
        header ("Content-Type: text/csv; charset=utf-8");
        header ("Content-Disposition: attachment; filename={$filename}");
        header ("Content-Description: PHP Generated Data");
        
        $output = fopen('php://output', 'w');
        fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF));
        fputcsv($output, array('ID', 'Tipo', 'Nome', 'User Agent', 'IP', 'Descrição', 'Data'));

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
        $array_logs = $this->findLikeUsers(null, null, 9999999, null);
        $count = count($array_logs);
        
        for ($i=0;$i<1;$i++){
            $html[$i] = "";
            $html[$i] .= "<table>";
            $html[$i] .= "<tr>";
            $html[$i] .= "<td><b>ID</b></td>";
            $html[$i] .= "<td><b>Tipo</b></td>";
            $html[$i] .= "<td><b>Nome</b></td>";
            $html[$i] .= "<td><b>User Agent</b></td>";
            $html[$i] .= "<td><b>IP</b></td>";
            $html[$i] .= "<td><b>Descrição</b></td>";
            $html[$i] .= "<td><b>Data Cadastro</b></td>";
            $html[$i] .= "</tr>";
            $html[$i] .= "</table>";
        }
        
        $i = 1;
        foreach ($array_logs as $row)
        {
            $html[$i] .= "<table>";
            $html[$i] .= "<tr>";
            $html[$i] .= "<td>" . $row['_id'] . "</td>";
            $html[$i] .= "<td>" . $row['_type'] . "</td>";
            $html[$i] .= "<td>" . $row['users__name'] . "</td>";
            $html[$i] .= "<td>" . $row['_log_user_agent'] . "</td>";
            $html[$i] .= "<td>" . $row['_log_ip'] . "</td>";
            $html[$i] .= "<td>" . $row['_description'] . "</td>";
            $html[$i] .= "<td>" . date( "m/d/Y \à\s h:i:s A", strtotime($row['_created_at'])) . "</td>";
            $html[$i] .= "</tr>";
            $html[$i] .= "</table>";
            $i++;
        }
        
        
        $filename = 'Logs.xls';
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
