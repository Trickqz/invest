<?php
//'withdraw','tariff','insertion','purchase','credit','debit','bonus','profit'

class Wallet {
    private $conn;
    private $table_name = "wallet";
    
    public function __construct()
    {
        $this->conn = WboPDO::getInstance();
    }
    
    
    public function create($args_type, $args_accounts__id, $args_reference, $args_reference__id, $args_amount, $args_service_fee, $args_net_amount, $args_description, $args_transaction_code, $args_status)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _type = :args_type, 
                    _accounts__id = :args_accounts__id, 
                    _reference = :args_reference, 
                    _reference__id = :args_reference__id, 
                    _amount = :args_amount, 
                    _service_fee = :args_service_fee, 
                    _net_amount = :args_net_amount, 
                    _description = :args_description, 
                    _transaction_code = :args_transaction_code, 
                    _status = :args_status";
        
        if ($args_type == 'profit' && $args_status == 'blocked') {
            $qry .= ", _blocked_until = DATE_ADD(NOW() , INTERVAL " . (new Settings)->findValue('profit_blocked_days') . " DAY)";
        }
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_type', $args_type);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $this->conn->bind(':args_reference', $args_reference);
        $this->conn->bind(':args_reference__id', $args_reference__id);
        $this->conn->bind(':args_amount', $args_amount);
        $this->conn->bind(':args_service_fee', $args_service_fee);
        $this->conn->bind(':args_net_amount', $args_net_amount);
        $this->conn->bind(':args_description', $args_description);
        $this->conn->bind(':args_transaction_code', $args_transaction_code);
        $this->conn->bind(':args_status', $args_status);
        return $this->conn->execute();
    }
    
    public function createProfitBinary($args_type, $args_accounts__id, $args_reference, $args_reference__id, $args_amount, $args_service_fee, $args_net_amount, $args_description, $args_transaction_code, $args_binary_side, $args_binary_points, $args_status)
    {
        $qry = "INSERT INTO " . $this->table_name . "
                SET 
                    _type = :args_type, 
                    _accounts__id = :args_accounts__id, 
                    _reference = :args_reference, 
                    _reference__id = :args_reference__id, 
                    _amount = :args_amount, 
                    _service_fee = :args_service_fee, 
                    _net_amount = :args_net_amount, 
                    _description = :args_description, 
                    _transaction_code = :args_transaction_code, 
                    _binary_payment = 'true', 
                    _binary_side = :args_binary_side, 
                    _binary_points = :args_binary_points, 
                    _status = :args_status";
        
        if ($args_type == 'profit' && $args_status == 'blocked') {
            $qry .= ", _blocked_until = DATE_ADD(NOW() , INTERVAL " . (new Settings)->findValue('profit_blocked_days') . " DAY)";
        }
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_type', $args_type);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $this->conn->bind(':args_reference', $args_reference);
        $this->conn->bind(':args_reference__id', $args_reference__id);
        $this->conn->bind(':args_amount', $args_amount);
        $this->conn->bind(':args_service_fee', $args_service_fee);
        $this->conn->bind(':args_net_amount', $args_net_amount);
        $this->conn->bind(':args_description', $args_description);
        $this->conn->bind(':args_transaction_code', $args_transaction_code);
        $this->conn->bind(':args_binary_side', $args_binary_side);
        $this->conn->bind(':args_binary_points', $args_binary_points);
        $this->conn->bind(':args_status', $args_status);
        return $this->conn->execute();
    }
    
    public function find($args_id = null, $args_accounts__id = null, $args_date_of = null, $args_date_until = null, $args_type = null, $args_status = null, $order = null, $args_limit = 50)
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM " . $this->table_name . " 
                WHERE _id = :args_id 
                LIMIT 0,1";
        } else {
            $qry = "SELECT * 
                FROM " . $this->table_name;
                
                if ($args_accounts__id > 0 && $args_accounts__id != "*") {
                    $qry .= " WHERE _accounts__id = :args_accounts__id";
                    
                    if ($args_date_of != null && $args_date_until != null) {
                        $qry .= " AND DATE(_date) >= '$args_date_of' AND DATE(_date) <= '$args_date_until'";
                        
                        if ($args_type != null) {
                            $qry .= " AND _type = :args_type";
                        }
                        
                        if ($args_status != null && $args_status != "*") {
                            $qry .= " AND _status = :args_status";
                        }
                    } else {
                        if ($args_type != null) {
                            $qry .= " WHERE _type = :args_type";
                        }
                        
                        if ($args_status != null && $args_status != "*") {
                            $qry .= " AND _status = :args_status";
                        }
                    }
                } else {
                    if ($args_date_of != null && $args_date_until != null) {
                        if ($args_type != 'withdraw' && $args_accounts__id != "*") {
                            $qry .= " WHERE _accounts__id = 0 AND DATE(_date) >= '$args_date_of' AND DATE(_date) <= '$args_date_until'";
                        } else {
                            $qry .= " WHERE DATE(_date) >= '$args_date_of' AND DATE(_date) <= '$args_date_until'";
                        }
                        
                        if ($args_type != null) {
                            $qry .= " AND _type = :args_type";
                        }
                        
                        if ($args_status != null && $args_status != "*") {
                            $qry .= " AND _status = :args_status";
                        }
                    } else {
                        if ($args_type != null) {
                            if ($args_type != 'withdraw' && $args_accounts__id != "*") {
                                $qry .= " WHERE _accounts__id = 0 AND _type = :args_type";
                            } else {
                                $qry .= " WHERE _type = :args_type";
                            }
                        }
                        
                        if ($args_status != null && $args_status != "*") {
                            $qry .= " AND _status = :args_status";
                        }
                    }
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
            $account_1 = (new Accounts)->find($data['_accounts__id']);
            
            $dataReturn = array(
                    '_id' => $data['_id'],
                    '_accounts__id' => $data['_accounts__id'],
                    '_accounts__name' => $account_1['_name'],
                    '_accounts__username' => $account_1['_username'],
                    '_accounts__crypto_wallet_network' => $account_1['_crypto_wallet_network'],
                    '_accounts__email' => $account_1['_email'],
                    '_date' => $data['_date'],
                    '_type' => $data['_type'],
                    '_reference' => $data['_reference'],
                    '_reference__id' => $data['_reference__id'],
                    '_amount' => $data['_amount'],
                    '_service_fee' => $data['_service_fee'],
                    '_net_amount' => $data['_net_amount'],
                    '_description' => $data['_description'],
                    '_transaction_code' => $data['_transaction_code'],
                    '_created_at' => $data['_created_at'],
                    '_updated_at' => $data['_updated_at'],
                    '_status' => $data['_status']
                );
            
            return $dataReturn;
        } else {
            if ($args_accounts__id > 0 && $args_accounts__id != "*") {
                $this->conn->bind(':args_accounts__id', $args_accounts__id);
            }
            
            if ($args_type != null) {
                $this->conn->bind(':args_type', $args_type);
            }
            
            if ($args_status != null && $args_status != "*") {
                $this->conn->bind(':args_status', $args_status);
            }
            
            $data = $this->conn->resultSet();
            $dataReturn = array();
            foreach ($data as $item) {
                $account_1 = (new Accounts)->find($item['_accounts__id']);
                
                array_push($dataReturn,
                    array(
                        '_id' => $item['_id'],
                        '_accounts__id' => $item['_accounts__id'],
                        '_accounts__name' => $account_1['_name'],
                        '_accounts__username' => $account_1['_username'],
                        '_accounts__crypto_wallet_network' => $account_1['_crypto_wallet_network'],
                        '_accounts__email' => $account_1['_email'],
                        '_date' => $item['_date'],
                        '_type' => $item['_type'],
                        '_reference' => $item['_reference'],
                        '_reference__id' => $item['_reference__id'],
                        '_amount' => $item['_amount'],
                        '_service_fee' => $item['_service_fee'],
                        '_net_amount' => $item['_net_amount'],
                        '_description' => $item['_description'],
                        '_transaction_code' => $item['_transaction_code'],
                        '_created_at' => $item['_created_at'],
                        '_updated_at' => $item['_updated_at'],
                        '_status' => $item['_status']
                    )
                );
            }
            
            return $dataReturn;
        }
    }
    
    /*
    public function findCashout($args_id = null, $args_date_of = null, $args_date_until = null, $args_status = null, $order = "DESC")
    {
        if ($args_id) {
            $qry = "SELECT * 
                FROM cashout 
                WHERE _id = :args_id 
                LIMIT 0,1";
        } else {
                $qry = "SELECT * 
                        FROM cashout";
                
                if ($order) {
                    $qry .= " ORDER BY _date " . $order;
                }
            }
        
        $this->data = $this->conn->query($qry);
        if ($args_id) {
            $this->conn->bind(':args_id', $args_id);
            
            $data = $this->conn->single();
            
            /*$dataReturn = array(
                    '_id' => $data['_id'],
                    '_scoreboard' => $data['_scoreboard'],
                    '_cock_1' => $data['_cock_1'],
                    '_cock_1__name' => (new Cocks)->find($data['_cock_1'])['_name'],
                    '_cock_2' => $data['_cock_2'],
                    '_cock_2__name' => (new Cocks)->find($data['_cock_2'])['_name'],
                    '_tied' => $data['_tied'],
                    '_winner' => $data['_winner'],
                    '_default_bet' => $data['_default_bet'],
                    '_only_default_bet' => $data['_only_default_bet'],
                    '_tariff' => $data['_tariff'],
                    '_date' => $data['_date'],
                    '_created_at' => $data['_created_at'],  //(new Date)->formatDate($item['_created_at']),
                    '_updated_at' => $data['_updated_at'],
                    '_status' => $data['_status']
                );*/
    /*        
            $account_1 = (new Accounts)->find($item['_accounts__id']);
            $data['_accounts__name'] = $data['_name'];
            $data['_accounts__email'] = $data['_email'];
            
            return $data;
        } else {
            $data = $this->conn->resultSet();
            $dataReturn = array();
            foreach ($data as $item) {
                /* array_push($dataReturn,
                    array(
                        '_id' => $item['_id'],
                        '_scoreboard' => $item['_scoreboard'],
                        '_cock_1' => $item['_cock_1'],
                        '_cock_1__name' => (new Cocks)->find($item['_cock_1'])['_name'],
                        '_cock_2' => $item['_cock_2'],
                        '_cock_2__name' => (new Cocks)->find($item['_cock_2'])['_name'],
                        '_tied' => $item['_tied'],
                        '_winner' => $item['_winner'],
                        '_default_bet' => $item['_default_bet'],
                        '_only_default_bet' => $item['_only_default_bet'],
                        '_tariff' => $item['_tariff'],
                        '_date' => $item['_date'],
                        '_created_at' => $item['_created_at'],  //(new Date)->formatDate($item['_created_at']),
                        '_updated_at' => $item['_updated_at'],
                        '_status' => $item['_status']
                    )
                ); */
    /*            
                $account_1 = (new Accounts)->find($item['_accounts__id']);
                $item['_accounts__name'] = $account_1['_name'];
                $item['_accounts__email'] = $account_1['_email'];
                
                array_push($dataReturn, $item);
            }
            
            return $dataReturn;
        }
    }*/
    
    public function transactionCheckCodeWasUsed($args_transaction_code)
    {
        $qry = "SELECT * 
            FROM " . $this->table_name . " 
            WHERE
                _transaction_code LIKE '%{$args_transaction_code}%'";
        
        $this->data = $this->conn->query($qry);
        $data = $this->conn->resultSet();
        
        if (sizeof($data) >= 1) {
			return true;
		} else {
            return false;
        }
    }
    
    public function getBalanceFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_status` != 'blocked' AND `_status` != 'canceled'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getBlockedBalanceFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_status` = 'blocked'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    
    public function getProfitFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_type` = 'profit' AND 
                    `_status` != 'blocked' AND `_status` != 'canceled'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getProfitInMonthFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_type` = 'profit' AND 
                    `_status` != 'blocked' AND `_status` != 'canceled' 
                    AND MONTH(_date) = MONTH(CURDATE())";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    
    public function getBonusFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_type` = 'bonus' AND 
                    `_status` != 'blocked' AND `_status` != 'canceled'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getBonusInMonthFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_type` = 'bonus' AND 
                    `_status` != 'blocked' AND `_status` != 'canceled'
                    AND MONTH(_date) = MONTH(CURDATE())";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    
    // 'withdraw','tariff','insertion','purchase','credit','debit','bonus','profit'
    public function getTotalCreditBalanceFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    (`_type` = 'insertion' OR `_type` = 'credit' OR `_type` = 'bonus' OR `_type` = 'profit') AND 
                    `_status` != 'blocked' AND `_status` != 'canceled'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getTotalDebitBalanceFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    (`_type` = 'withdraw' OR `_type` = 'tariff' OR `_type` = 'purchase' OR `_type` = 'debit') AND 
                    `_status` != 'blocked' AND `_status` != 'blocked' AND `_status` != 'canceled'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getTotalBalanceFromAccountsID($args_accounts__id)
    {
        
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_status` != 'blocked' AND `_status` != 'canceled'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    
    public function getTotalCashoutPendingBalanceFromAccountsID($args_accounts__id)
    {
        if ($args_accounts__id != 0) {
            $qry = "SELECT SUM(`_amount`) AS _balance 
                    FROM " . $this->table_name . "
                        WHERE 
                        `_accounts__id` = :args_accounts__id AND 
                        `_type` = 'withdraw' AND 
                        `_status` = 'pending'";
        } else {
            $qry = "SELECT SUM(`_amount`) AS _balance 
                    FROM " . $this->table_name . "
                        WHERE 
                            `_type` = 'withdraw' AND `_status` = 'pending'";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_accounts__id != 0) {
            $this->conn->bind(':args_accounts__id', $args_accounts__id);
        }
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getTotalCashoutBalanceFromAccountsID($args_accounts__id)
    {
        if ($args_accounts__id != 0) {
            $qry = "SELECT SUM(`_amount`) AS _balance 
                    FROM " . $this->table_name . "
                        WHERE 
                            `_accounts__id` = :args_accounts__id AND 
                            `_type` = 'withdraw' AND 
                            `_status` = 'effected'";
        } else {
            $qry = "SELECT SUM(`_amount`) AS _balance 
                    FROM " . $this->table_name . "
                        WHERE 
                            `_type` = 'withdraw' AND 
                            `_status` = 'effected'";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_accounts__id != 0) {
            $this->conn->bind(':args_accounts__id', $args_accounts__id);
        }
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    
    public function getTotalBalance()
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                WHERE 
                    `_status` != 'blocked' AND `_status` != 'canceled'";
        
        $this->data = $this->conn->query($qry);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getBalanceInMonthFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    `_status` != 'blocked' AND `_status` != 'canceled' 
                    AND MONTH(_date) = MONTH(CURDATE())";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getGainBalanceFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    (`_type` = 'bonus' OR `_type` = 'profit')";  //credit, insertion
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getBinaryGainBalanceFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    _reference_ext = 'binary'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getGainBalanceInMonthFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    (`_type` = 'bonus' OR `_type` = 'profit')
                    AND MONTH(_created_at) = MONTH(CURDATE())";  //credit, insertion
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getProfitBalanceFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_type` = 'profit' AND `_accounts__id` = :args_accounts__id AND 
                    `_status` != 'blocked' AND `_status` != 'canceled'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        
        return $result['_balance'];
    }
    
    public function getMonthCreditBalanceFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    MONTH(`_date`) = MONTH(CURRENT_DATE()) AND
                    `_amount` > 0 AND 
                    `_status` != 'blocked' AND `_status` != 'canceled'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    public function getMonthDebitBalanceFromAccountsID($args_accounts__id)
    {
        $qry = "SELECT SUM(`_amount`) AS _balance 
                FROM " . $this->table_name . "
                    WHERE 
                    `_accounts__id` = :args_accounts__id AND 
                    MONTH(`_date`) = MONTH(CURRENT_DATE()) AND
                    `_amount` < 0 AND 
                    `_status` != 'blocked' AND `_status` != 'canceled'";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result = $this->conn->single();
        return $result['_balance'];
    }
    
    
    /*public function chartHistoryLast30Days($args_accounts__id)
    {
        $qry1 = "SELECT EXTRACT(DAY FROM `_created_at`) AS pDay, SUM(`_amount`) AS pAmount FROM wallet WHERE `_accounts__id` = :args_accounts__id AND `_amount` > 0 AND `_created_at` BETWEEN CURRENT_DATE() - INTERVAL 30 DAY AND CURRENT_DATE()+1 GROUP BY pDay ORDER BY `_created_at`";
        $this->data = $this->conn->query($qry1);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result1 = $this->conn->resultSet();
        
        $qry2 = "SELECT EXTRACT(DAY FROM `_created_at`) AS pDay, SUM(`_amount`) AS pAmount FROM wallet WHERE `_accounts__id` = :args_accounts__id AND `_amount` < 0 AND `_created_at` BETWEEN CURRENT_DATE() - INTERVAL 30 DAY AND CURRENT_DATE()+1 GROUP BY pDay ORDER BY `_created_at`";
        $this->data = $this->conn->query($qry2);
        $this->conn->bind(':args_accounts__id', $args_accounts__id);
        $result2 = $this->conn->resultSet();
        
        return array("in" => $result1, "out" => $result2);
    }*/
    
    public function chartHistoryLast30Days($args_accounts__id = null)
    {
        if ($args_accounts__id != null) {
            $qry = "SELECT EXTRACT(DAY FROM `_created_at`) AS pDay, SUM(`_amount`) AS pAmount FROM wallet WHERE `_accounts__id` = :args_accounts__id AND `_type` IN ('bonus','profit') AND `_created_at` BETWEEN CURRENT_DATE() - INTERVAL 30 DAY AND CURRENT_DATE()+1 GROUP BY pDay ORDER BY `_created_at`";
        } else {
            $qry = "SELECT EXTRACT(DAY FROM `_created_at`) AS pDay, SUM(`_amount`) AS pAmount FROM wallet WHERE `_created_at` BETWEEN CURRENT_DATE() - INTERVAL 30 DAY AND CURRENT_DATE()+1 GROUP BY pDay ORDER BY `_created_at`";
        }
        
        $this->data = $this->conn->query($qry);
        if ($args_accounts__id != null) {
            $this->conn->bind(':args_accounts__id', $args_accounts__id);
        }
        $result = $this->conn->resultSet();
        
        return $result;
    }
    
    public function setConfirmed($args_id = null, $args_transaction_code)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET 
                    _transaction_code = :args_transaction_code, 
                    _status = 'effected' 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_transaction_code', $args_transaction_code);
        $this->conn->bind(':args_id', $args_id);
        return $this->conn->execute();
    }
    
    public function setStatus($args_id = null, $args_status)
    {
        $qry = "UPDATE 
                " . $this->table_name . " 
                SET _status = :args_status 
                WHERE 
                    _id = :args_id";
        
        $this->data = $this->conn->query($qry);
        $this->conn->bind(':args_status', $args_status);
        $this->conn->bind(':args_id', $args_id);
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
    public function new__sumChartLast30($args_accounts__id = 0)
    {
        if ($args_accounts__id != 0) {
            $this->data = $this->conn->query("SELECT DATE_FORMAT(_created_at, \"%d/%m/%Y\") AS _date, SUM(_amount) AS _value FROM `wallet` WHERE _accounts__id = '$args_accounts__id' AND (`_type` = 'insertion' OR `_type` = 'credit' OR `_type` = 'bonus' OR `_type` = 'profit') AND _status != 'canceled' GROUP BY DATE_FORMAT(_created_at, \"%d-%m-%Y\") ORDER BY YEAR(_created_at) DESC, MONTH(_created_at) DESC, DAY(_created_at) DESC LIMIT 0,30");
        } else {
            $this->data = $this->conn->query("SELECT DATE_FORMAT(_created_at, \"%d/%m/%Y\") AS _date, SUM(_amount) AS _value FROM `wallet` WHERE (`_type` = 'insertion' OR `_type` = 'credit' OR `_type` = 'bonus' OR `_type` = 'profit') AND _status != 'canceled' GROUP BY DATE_FORMAT(_created_at, \"%d-%m-%Y\") ORDER BY YEAR(_created_at) DESC, MONTH(_created_at) DESC, DAY(_created_at) DESC LIMIT 0,30");
        }
        return $this->conn->resultSet();
    }
    /** **/
}
?>
