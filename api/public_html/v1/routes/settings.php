<?php
    $router->map('GET','/v1/settings', function(){
        $data = (new Settings)->findAllAsJson();
        
        $data["smtp__server"] = null;
        $data["smtp__user"] = null;
        $data["smtp__password"] = null;
        $data["smtp__port"] = null;
        $data["smtp__from"] = null;
        $data["smtp__from_name"] = null;
        
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
    $router->map('POST','/v1/settings', function(){
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') {
            
            $maintenance_mode = 'false';
            if ($_POST['maintenance_mode'] == 'true') {
                $maintenance_mode = 'true';
            }
            
            $accounts_service_enabled = 'false';
            if ($_POST['accounts_service_enabled'] == 'true') {
                $accounts_service_enabled = 'true';
            }
            
            $transfer_service_enabled = 'false';
            if ($_POST['transfer_service_enabled'] == 'true') {
                $transfer_service_enabled = 'true';
            }
            
            $cashout_service_enabled = 'false';
            if ($_POST['cashout_service_enabled'] == 'true') {
                $cashout_service_enabled = 'true';
            }
            
            $cashout_minimum_value = (new Format)->clearNumber($_POST['cashout_minimum_value'])/100.0;
            $cashout_maximum_value = (new Format)->clearNumber($_POST['cashout_maximum_value'])/100.0;
            $cashout_service_fee = (new Format)->clearNumber($_POST['cashout_service_fee'])/100.0;
            $cashout_service_fee_perc = (new Format)->clearNumber($_POST['cashout_service_fee_perc'])/100.0;
            $__accounts_contracts_percentage_repurchase = (new Format)->clearNumber($_POST['__accounts_contracts_percentage_repurchase'])/100.0;
            $__accounts_contracts_block_percentage_reached = 'false';
            if ($_POST['__accounts_contracts_block_percentage_reached'] == 'true') {
                $__accounts_contracts_block_percentage_reached = 'true';
            }
            $__accounts_contracts_percentage_to_repurchase = (new Format)->clearNumber($_POST['__accounts_contracts_percentage_to_repurchase'])/100.0;
            
            $money_add_service_enabled = 'false';
            if ($_POST['money_add_service_enabled'] == 'true') {
                $money_add_service_enabled = 'true';
            }
            
            $money_add_minimum_value = (new Format)->clearNumber($_POST['money_add_minimum_value'])/100.0;
            $money_add_maximum_value = (new Format)->clearNumber($_POST['money_add_maximum_value'])/100.0;
            
            $donations_service_enabled = 'false';
            if ($_POST['donations_service_enabled'] == 'true') {
                $donations_service_enabled = 'true';
            }
            
            $contracts_value_usd = (new Format)->clearNumber($_POST['contracts_value_usd'])/100.0;
            $__accounts_max_contracts_active = (new Format)->clearNumber($_POST['__accounts_max_contracts_active']);
            
            $coinbase__api_key = $_POST['coinbase__api_key'];
            
            
            $success = (new Settings)->update('maintenance_mode', $maintenance_mode);
            $success = (new Settings)->update('accounts_service_enabled', $accounts_service_enabled);
            $success = (new Settings)->update('transfer_service_enabled', $transfer_service_enabled);
            $success = (new Settings)->update('cashout_service_enabled', $cashout_service_enabled);
            $success = (new Settings)->update('cashout_minimum_value', $cashout_minimum_value);
            $success = (new Settings)->update('cashout_maximum_value', $cashout_maximum_value);
            $success = (new Settings)->update('cashout_service_fee', $cashout_service_fee);
            $success = (new Settings)->update('cashout_service_fee_perc', $cashout_service_fee_perc);
            $success = (new Settings)->update('__accounts_contracts_percentage_repurchase', $__accounts_contracts_percentage_repurchase);
            $success = (new Settings)->update('__accounts_contracts_block_percentage_reached', $__accounts_contracts_block_percentage_reached);
            $success = (new Settings)->update('__accounts_contracts_percentage_to_repurchase', $__accounts_contracts_percentage_to_repurchase);
            $success = (new Settings)->update('money_add_service_enabled', $money_add_service_enabled);
            $success = (new Settings)->update('money_add_minimum_value', $money_add_minimum_value);
            $success = (new Settings)->update('money_add_maximum_value', $money_add_maximum_value);
            $success = (new Settings)->update('donations_service_enabled', $donations_service_enabled);
            $success = (new Settings)->update('contracts_value_usd', $contracts_value_usd);
            $success = (new Settings)->update('__accounts_max_contracts_active', $__accounts_max_contracts_active);
            $success = (new Settings)->update('coinbase__api_key', $coinbase__api_key);
            if ($success) {
                (new Json)->echoJson(array("success" => true));
            } else {
                (new Json)->echoJson(array("success" => false));
            }
        } else {
            (new Json)->echoJson(array("success" => false, "message" => "You are not allowed to change the settings."));
        }
    });
    
    $router->map('GET', '/v1/system/resume', function(){
        // coinbase
        $coinbase__brl = (new Coinbase)->getETH_BLR();
        
        $accountData = (new Accounts)->find(authGetUserId());
        if ($accountData['_role'] == 'developer' || $accountData['_role'] == 'administrator') {
            // fights
            /*$dataFights = (new Fights)->findLastClosed();
            $export_dataFights = array();
            
            $iFights = 0;
            foreach ($dataFights as $row)
            {
                if ($iFights < 10) {
                    $dataCocks1 = (new Cocks)->find($row['_cock_1']);
                    $dataCocks2 = (new Cocks)->find($row['_cock_2']);
                    
                    $export_dataFights[] = array(
                        "_id" => $row['_id'],
                        "_cock_1" => $row['_cock_1'],
                        "_cock_1__name" => $dataCocks1['_name'],
                        "_cock_2" => $row['_cock_2'],
                        "_cock_2__name" => $dataCocks2['_name']
                    );
                }
                
                $iFights++;
            }*/
            
            
            // accounts
            $dataAccounts = (new Accounts)->findOrderAndLimit(20, "DESC");
            $export_dataAccounts = array();
            
            $iAccounts = 0;
            foreach ($dataAccounts as $row)
            {
                if ($iAccounts < 20) {
                    $export_dataAccounts[] = array(
                        "_name" => $row['_name'],
                        "_created_at" => $row['_created_at']
                    );
                }
                
                $iAccounts++;
            }
            
            
            /** **//*
            $result_charts = array('day' => array(), 'count' => array());
            foreach ($SURVEY_USERS_GRAP_COUNT as $item)
            {
                $result_charts['day'][] = 'Dia '.$item['pDay'];
                $result_charts['count'][] = (int)$item['pCount'];
                <tr>
                    <td class="ls-txt-center"><?php echo $item['pDay']; ?></td>
                    <td class="ls-txt-center"><?php echo $item['pCount']; ?></td>
                </tr>
            }
            *//** **/
            
            $saldoBankOn = 0.00;
            if ((new Settings)->findValue('bankon__token_query') != "") {
                $saldoBankOn = (double)(new BankOn)->bankonQueryBalance((new Settings)->findValue('bankon__token_query'));
            }
            
            $data = array(
                "count" => array(
                    "accounts" => array(
                        "total" => (new Accounts)->count(),
                        "in_month" => (new Accounts)->countLastMonth(),
                        "in_7days" => (new Accounts)->countLast7Days()
                    ),
                    "donations" => array(
                        "donations" => array(
                            "total" => (new Donations)->countTotal(),
                            "in_month" => (new Donations)->countTotalInMonth()
                        )
                    ),
                    "donations_up" => array(
                        "donations" => array(
                            "total" => (new Donations_up)->countTotal(),
                            "in_month" => (new Donations_up)->countTotalInMonth()
                        )
                    )
                    /*"cocks" => array(
                        "total" => (new Cocks)->count(),
                        "in_month" => (new Cocks)->countLastMonth()
                    ),
                    "fights" => array(
                        "total" => (new Fights)->count(),
                        "in_month" => (new Fights)->countLastMonth()
                    ),
                    "movies" => array(
                        "total" => (new Movies)->count(),
                        "in_month" => (new Movies)->countLastMonth()
                    )*/
                ),
                "access" => array(
                    "in_month" => (new Accounts)->countLastAccessInLastMonth(),
                    "perc_in_month" => round(((new Accounts)->countLastAccessInLastMonth() / ((new Accounts)->count() / 100)), 2)
                ),
                "last" => array(
                    "accounts" => $export_dataAccounts
                ),
                "income" => array(
                    //"in_day" => (new Income)->getForCurrentDay()
                    "in_day" => (float)str_replace(",",".",(new Settings)->findValue('daily_income'))
                ),
                "wallet" => array(
                    "current_balance" => number_format((new Wallet)->getBalanceFromAccountsID(1), 2, "." ,""),
                    "month_entry" => number_format((new Wallet)->getBalanceInMonthFromAccountsID(1), 2, "." ,""),
                    //"pending_withdrawals" => number_format((new Cashout)->getAllWaitingBalance(), 2, "." ,""),
                    "total_entries" => number_format((new Wallet)->getTotalBalance(), 2, "." ,""),
                    "balance_bankon" => $saldoBankOn
                ),
                "chart_data" => array(
                    "created_at" => (new Accounts)->countChartCreatedAtLast15Days(),
                    "last_access" => (new Accounts)->countChartAccessLast15Days(),
                    "history" => (new Wallet)->chartHistoryLast30Days()
                ),
                "ext_data" => array(
                    "coinbase" => array(
                        "price_brl" => $coinbase__brl
                    )
                )
            );
        } else {
            // accounts
            $dataAccounts = (new Accounts)->findOrderAndLimit(20, "DESC");
            $export_dataAccounts = array();
            
            $iAccounts = 0;
            foreach ($dataAccounts as $row)
            {
                if ($iAccounts < 20) {
                    $export_dataAccounts[] = array(
                        "_name" => $row['_name'],
                        "_created_at" => $row['_created_at']
                    );
                }
                
                $iAccounts++;
            }
            
            $data__newDonations = (new Donations_up)->find(null, $accountData['_id'], null, null, null, null, null, 500, true);
            
            $data = array(
                "count" => array(
                    "indications" => (new Accounts)->countIndications($accountData['_id']),
                    "indications_7days" => (new Accounts)->countIndicationsLast7Days($accountData['_id']),
                    "donations" => array(
                        "donations" => array(
                            "total" => (new Donations)->countTotalFromAccountsID($accountData['_id']),
                            "in_month" => (new Donations)->countTotalInMonthFromAccountsID($accountData['_id'])
                        )
                    ),
                    "donations_up" => array(
                        "donations" => array(
                            "total" => (new Donations_up)->countTotalFromAccountsID($accountData['_id']),
                            "in_month" => (new Donations_up)->countTotalInMonthFromAccountsID($accountData['_id'])
                        )
                    )
                ),
                "last" => array(
                    "accounts" => $export_dataAccounts
                ),
                "income" => array(
                    //"in_day" => (new Income)->getForCurrentDay()
                    "in_day" => (float)str_replace(",",".",(new Settings)->findValue('daily_income'))
                ),
                "wallet" => array(
                    "current_balance" => number_format((new Wallet)->getBalanceFromAccountsID($accountData['_id']), 2, "." ,""),
                    "month_entry" => number_format((new Wallet)->getBalanceInMonthFromAccountsID($accountData['_id']), 2, "." ,""),
                    //"pending_withdrawals" => number_format((new Cashout)->getAllWaitingBalanceFromAccountsID($accountData['_id']), 2, "." ,""),
                    "profit" => array(
                        "total" => number_format((new Wallet)->getProfitFromAccountsID($accountData['_id']), 2, "." ,""),
                        "in_month" => number_format((new Wallet)->getProfitInMonthFromAccountsID($accountData['_id']), 2, "." ,"")
                    ),
                    "bonus" => array(
                        "total" => number_format((new Wallet)->getBonusFromAccountsID($accountData['_id']), 2, "." ,""),
                        "in_month" => number_format((new Wallet)->getBonusInMonthFromAccountsID($accountData['_id']), 2, "." ,"")
                    )
                ),
                "donations" => array(
                    "total" => array(
                        "received" => number_format((new Donations)->getReceivedFromAccountsID($accountData['_id']), 2, "." ,"")
                    ),
                ),
                "chart_data" => array(
                    "indications" => (new Accounts)->countChartIndicationsLast15Days($accountData['_id']),
                    "history" => (new Wallet)->chartHistoryLast30Days($accountData['_id'])
                ),
                "ext_data" => array(
                    "coinbase" => array(
                        "price_brl" => $coinbase__brl
                    )
                ),
                "new_donation" => sizeof($data__newDonations)
            );
        }
        
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
?>
