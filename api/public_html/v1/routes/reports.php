<?php
    $router->map('GET','/v1/reports/accounts/list.pdf', function(){
        if ($_GET['type'] == 'single_list') {
            (new Accounts)->exportPdf('accounts__single_list');
        } else if ($_GET['type'] == 'details') {
            (new Accounts)->exportPdf('accounts__details');
        }
    });
    
    $router->map('GET','/v1/reports/accounts/indicated.pdf', function(){
        if ($_GET['type'] == 'direct') {
            (new Accounts)->exportPdf('accounts__indicated__direct');
        }
    });
    
    $router->map('GET','/v1/reports/donations/balance.pdf', function(){
        if ($_GET['report_model'] == 'single') {
            (new Donations)->exportPdf('single');
        } else if ($_GET['report_model'] == 'details') {
            (new Donations)->exportPdf('details');
        }
    });
    
    $router->map('GET','/v1/reports/wallet/balance.pdf', function(){
        if ($_GET['report_model'] == 'single') {
            (new Accounts)->exportPdf('wallet__ballance');
        } else if ($_GET['report_model'] == 'details') {
            (new Accounts)->exportPdf('wallet__ballance__details');
        } else if ($_GET['report_model'] == 'accounts_balance') {
            (new Accounts)->exportPdf('wallet__accounts__balance');
        }
    });
    
    /*$router->map('GET','/v1/reports/wallet/withdrawal/pending.pdf', function(){
        (new Accounts)->exportPdf('withdrawal_pending');
    });
    $router->map('GET','/v1/reports/wallet/withdrawal/made.pdf', function(){
        (new Accounts)->exportPdf('withdrawal_made');
    });*/
?>
