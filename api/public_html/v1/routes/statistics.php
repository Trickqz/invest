<?php
    $router->map('GET', '/v1/session/statistics', function(){
        $data = (new Accounts)->find(authGetUserId());
        $id = $data['_id'];
        
        // fights
        /**$dataFights = (new Fights)->findLastClosed();
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
        }***/
        
        
        // accounts
        /**$dataAccounts = (new Accounts)->findOrderAndLimit(20, "DESC");
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
        }**/
        
        /**$dataDonations__count = (new Donations)->countFromAccountsID($id);
        $dataDonations__last = (new Donations)->findLast($id);
        if (!$dataDonations__last && $dataDonations__last['_status'] == 'paid') {
            $dataDonations__last = null;
        }
        
        $dataReceivements__count = (new Donations_queue)->countReceivementsFromAccountsID($id);
        $dataReceivements__last = (new Donations_queue)->lastQueueReceivementFromAccountsID($id);
        if (!$dataReceivements__last && $dataReceivements__last['_status'] == 'paid') {
            $dataReceivements__last = null;
        }*/
        
        $data = array(
            "count" => array(
                "indications" => array(
                    "total" => (new Accounts)->countIndications($id),
                    "in_month" => (new Accounts)->countIndicationsLastMonth($id)
                ),
                ///"donations" => $dataDonations__count,
                ///"receivements" => $dataReceivements__count
            ),
            /*"access" => array(
                "in_month" => (new Accounts)->countLastAccessInLastMonth(),
                "perc_in_month" => round(((new Accounts)->countLastAccessInLastMonth() / ((new Accounts)->count() / 100)), 2)
            ),*/
            "last" => array(
                "accounts" => $export_dataAccounts,
                ///"donation" => $dataDonations__last,
                ///"receivement" => $dataReceivements__last
            ),
            "wallet" => array(
                "current_balance" => (new Wallet)->getBalanceFromAccountsID($id),
                //"current_balance_blocked" => (new Wallet)->getBlockedBalanceFromAccountsID($id),
                "month_entry" => (new Wallet)->getBalanceInMonthFromAccountsID($id),
                "reentry" => array(
                    "current_balance" => (new Wallet)->getBalanceFromAccountsID($id)
                ),
                "sponsorship" => array(
                    "current_balance" => (new Wallet)->getBalanceFromAccountsID($id)
                ),
                //"pending_withdrawals" => (new Cashout)->getAllWaitingBalance(),
                "total_entries" => (new Wallet)->getTotalBalance()
            ),
            "chart_data" => array(
                //"created_at" => (new Accounts)->countChartCreatedAtLast15Days(),
                //"last_access" => (new Accounts)->countChartAccessLast15Days()
                "indications_last15days" => (new Accounts)->countChartIndicationsLast15Days($id)
            )
        );
        
        (new Json)->echoJson(array("success" => true, "data" => $data));
    });
?>
