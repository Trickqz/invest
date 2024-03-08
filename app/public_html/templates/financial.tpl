<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    {{#if system.isadmin}}
                        Financial
                    {{else}}
                        My wallet
                    {{/if}}
                </h2>
            </div>

            <div class="col-auto ms-auto d-print-none">
                <div class="btn-list">
                    <div class="form-group">
                        {{#if system.isadmin}}
                        {{else}}
                            {{#contains "true" settings.money_add_service_enabled}}
                                <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormWalletMoneyAdd();">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-currency-dollar" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                       <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                       <path d="M16.7 8a3 3 0 0 0 -2.7 -2h-4a3 3 0 0 0 0 6h4a3 3 0 0 1 0 6h-4a3 3 0 0 1 -2.7 -2"></path>
                                       <path d="M12 3v3m0 12v3"></path>
                                    </svg>
                                    Add money
                                </a>
                            {{else}}
                            {{/contains}}
                        {{/if}}
                        
                        {{#contains "true" settings.transfer_service_enabled}}
                            <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormWalletMoneyAdd();">
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>
                                New transfer
                            </a>
                        {{else}}
                        {{/contains}}
                        
                        {{#if system.isadmin}}
                        {{else}}
                            {{#contains "true" settings.cashout_service_enabled}}
                                <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormWalletWithdrawal();">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>
                                    New withdrawal
                                </a>
                            {{else}}
                            {{/contains}}
                        {{/if}}
                    </div>
                    <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="wallet_date_of" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="01/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                            </div>
                            <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="wallet_date_until" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                            </div>
                    <div class="form-group" style="display: none;">
                        <div class="btn-group w-100">
                            <!--<button type="button" class="btn btn-primary">Todos</button>-->
                            <div class="btn-group" role="group">
                                <button id="btnGroupDrop1" type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" disabled="">
                                    All
                                </button>
                                <div class="dropdown-menu dropdown-menu-end" style="">
                                    <a class="dropdown-item" href="#" style="">
                                        Credit
                                    </a>
                                    <a class="dropdown-item" href="#" style="">
                                        Debit
                                    </a>
                                    <a class="dropdown-item" href="#" style="">
                                        Purchase
                                    </a>
                                    <a class="dropdown-item" href="#" style="">
                                        Withdrawal
                                    </a>
                                    <a class="dropdown-item" href="#" style="">
                                        Bonus
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="page-body">
    <!-- -->
</div>

<script>
    //var elCode = document.getElementById("invoices_code");
    var elDate_of = document.getElementById("wallet_date_of");
    var elDate_until = document.getElementById("wallet_date_until");
    //var elSubtype = document.getElementById("wallet_subtype");
    var financial_resumeSubtype = "*";
    
    function fc_walletGetListing(subtype = ""){
        var search_q = {
            limit: 50,
            order: "desc"
        };
        
        //if (elCode.value != "") {
        //    search_q['code'] = elCode.value;
        //} else {
            search_q['date_of'] = FormatStringDate(elDate_of.value);
            search_q['date_until'] = FormatStringDate(elDate_until.value);
            
            //if (elStatus.value != "") {
            //    search_q['status'] = elStatus.value;
            //}
            
            /**if (elSubtype.value != "") {
                search_q['subtype'] = elSubtype.value;
            }*/
            
            if (subtype != "") financial_resumeSubtype = subtype;
            if (financial_resumeSubtype != "*") search_q['subtype'] = financial_resumeSubtype;
        //}
        
        
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        
        /** TEMP **/
        document.querySelector(".page-body").innerHTML = 
            `<div class="container-xl mb1_25">
                <div class="row row-cards flex-center">
                    <div class="col-md-6 col-xl-3">
                        <div class="card card-sm">
                          <div class="card-body">
                            <div class="row align-items-center">
                              <div class="col-auto">
                                <span class="bg-green-lt avatar"><!-- Download SVG icon from http://tabler-icons.io/i/currency-dollar -->
                                  <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M16.7 8a3 3 0 0 0 -2.7 -2h-4a3 3 0 0 0 0 6h4a3 3 0 0 1 0 6h-4a3 3 0 0 1 -2.7 -2"></path><path d="M12 3v3m0 12v3"></path></svg>
                                </span>
                              </div>
                              <div class="col">
                                <div id="page__financial_resume___total_sum" class="font-weight-medium">
                                  <!--<span class="float-right font-weight-medium text-green">USD 0,00</span>-->
                                </div>
                                <div id="page__financial_resume___sum" class="text-muted">
                                  <!--Revenue last 30 days-->
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    <div class="col-md-6 col-xl-3">
                        <div class="card card-sm">
                          <div class="card-body">
                            <div class="row align-items-center">
                              <div class="col-auto">
                                <span class="bg-green-lt avatar"><!-- Download SVG icon from http://tabler-icons.io/i/arrow-down -->
                                  <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><line x1="12" y1="5" x2="12" y2="19"></line><line x1="18" y1="13" x2="12" y2="19"></line><line x1="6" y1="13" x2="12" y2="19"></line></svg>
                                </span>
                              </div>
                              <div class="col">
                                <div id="page__financial_resume___total_credit" class="font-weight-medium">
                                  <!--<span class="float-right font-weight-medium text-green"><!--+4%--><!--</span>-->
                                </div>
                                <div id="page__financial_resume___credit" class="text-muted">
                                  <!--Revenue last 30 days-->
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="col-md-6 col-xl-3">
                        <div class="card card-sm">
                          <div class="card-body">
                            <div class="row align-items-center">
                              <div class="col-auto">
                                <span class="bg-red-lt avatar"><!-- Download SVG icon from http://tabler-icons.io/i/arrow-up -->
                                  <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><line x1="12" y1="5" x2="12" y2="19"></line><line x1="18" y1="11" x2="12" y2="5"></line><line x1="6" y1="11" x2="12" y2="5"></line></svg>
                                </span>
                              </div>
                              <div class="col">
                                <div id="page__financial_resume___total_debit" class="font-weight-medium">
                                  <!--<span class="float-right font-weight-medium text-red"><!---4.3%--><!--</span>-->
                                </div>
                                <div id="page__financial_resume___debit" class="text-muted">
                                  <!--Sales last 30 days-->
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                </div>
            </div>`;
        /** **/
        
        ///var qValue = document.getElementById('q').value;
        //url: '<?=$ini['API_REST_URL']?>/accounts?q='+qValue,
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/wallet/resume",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    
                    document.getElementById("page__financial_resume___total_credit").innerHTML = fmtMoney(_data._total_credit);
                    document.getElementById("page__financial_resume___total_debit").innerHTML = fmtMoney(_data._total_debit * -1);
                    document.getElementById("page__financial_resume___total_sum").innerHTML = fmtMoney(_data._total);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                document.getElementById("page__financial_resume___total_credit").innerHTML = "erro";
                document.getElementById("page__financial_resume___total_debit").innerHTML = "erro";
                document.getElementById("page__financial_resume___total_sum").innerHTML = "erro";
            }
        });
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/wallet?date_of="+FormatStringDate(elDate_of.value)+"&date_until="+FormatStringDate(elDate_until.value),
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var arr = response.data;
                    var tbodyHTML = '';
                    
                    var page__financial_resume___credit = 0,
                        page__financial_resume___debit = 0,
                        page__financial_resume___sum = 0;
                    
                    if (arr.length > 0) {
                        for (var i = 0; i < arr.length; i++){
                            var id = arr[i]._id,
                                created_at = datetimeToString(arr[i]._created_at),
                                typeStr = commerce__formatWalletType(arr[i]._type),
                                //subtypeStr = commerce__formatWalletSubtype(arr[i].subtype),
                                //history = arr[i]._hash,
                                amount = '';  //fmtMoney(arr[i]._amount);
                                //type = '';
                            
                            if (arr[i]._amount < 0) {
                                amount = '<span class="text-red">'+fmtMoney(arr[i]._amount)+'</span>';
                            } else if (arr[i]._amount > 0) {
                                amount = '<span class="text-green">'+fmtMoney(arr[i]._amount)+'</span>';
                            } else {
                                amount = '<span class="">'+fmtMoney(arr[i]._amount)+'</span>';
                            }
                            
                            var _amount = arr[i]._amount,
                                _amountInt = parseInt(_amount.replace(".", ""));
                            
                            switch(arr[i]._type){
                                case "credit":
                                    page__financial_resume___credit += parseInt(_amountInt);
                                    
                                    //if (arr[i].subtype == "bonus") {
                                    //    page__financial_resume___bonus += arr[i].amount;
                                    //}
                                    
                                    //amount = '<span style="color: #739E41;">' + amount + '</span>';
                                    //type = 'Crédito';
                                break;
                                case "debit":
                                    page__financial_resume___debit += parseInt(_amountInt);
                                    
                                    //amount = '<span style="color: #CC0000;">' + amount + '</span>';
                                    //type = 'Débito';
                                break;
                            }
                            
                            page__financial_resume___sum += parseInt(_amountInt);
                            
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td data-label="Name">'
                                + '        <div class="d-flex py-1 align-items-center">'
                                //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                                + '            <div class="flex-fill">'
                                + '                <div class="font-weight-medium">' + arr[i]._reference + '</div>'
                                + '                <div class="font-weight-medium">' + arr[i]._description + '</div>'
                                + '                <div class="text-muted">' + arr[i]._transaction_code + '</div>'
                                + '            </div>'
                                + '        </div>'
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Type">'
                                + '        ' + typeStr
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Date">'
                                + '        ' + created_at
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Amount">'
                                + '        ' + amount
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Status">'
                                + '        ' + commerce__formatWalletStatus(arr[i]._status)
                                + '    </td>'
                                //+ '    <td>'
                                //+ '        <div class="btn-list flex-nowrap">'
                                //+ '            <a href="="javascript:OpenFile(\'/uploads/materials/' + type + '/' + response[i].filename + '\', \'' + response[i].contentType + '\');" class="btn btn-white">'
                                //+ '                View'
                                //+ '            </a>'
                                //+ '        </div>'
                                //+ '    </td>'
                                + '</tr>';
                        }
                        
                        
                        document.querySelector(".page-body").innerHTML += 
                              ' <div class="container-xl">'
                            + '     <div class="row row-cards">'
                            + '         <div class="col-12">'
                            + '             <div class="card">'
                            + '                 <div class="table-responsive">'
                            + '                     <table class="table table-vcenter table-mobile-md card-table">'
                            + '                         <thead>'
                            + '                             <tr>'
                            + '                                 <th>History</th>'
                            + '                                 <th class="text-center">Type</th>'
                            + '                                 <th class="text-center">Date</th>'
                            + '                                 <th class="text-center">Amount</th>'
                            + '                                 <th class="text-center">Status</th>'
                            //+ '                                 <th class="w-1"></th>'
                            + '                             </tr>'
                            + '                         </thead>'
                            + '                         <tbody>'
                            +                               tbodyHTML                                
                            + '                         </tbody>'
                            + '                     </table>'
                            + '                 </div>'
                            + '             </div>'
                            + '         </div>'
                            + '     </div>'
                            + ' </div>';
                    } else {
                        page__wallet__loadClear();
                    }
                    
                    document.getElementById("page__financial_resume___credit").innerHTML = fmtMoney(page__financial_resume___credit/100.0) + " in the period";
                    document.getElementById("page__financial_resume___debit").innerHTML = fmtMoney((page__financial_resume___debit/100.0) * -1) + " in the period";
                    document.getElementById("page__financial_resume___sum").innerHTML = fmtMoney(page__financial_resume___sum/100.0) + " in the period";
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                page__wallet__loadClear();
                
                document.getElementById("page__financial_resume___credit").innerHTML = fmtMoney("erro");
                document.getElementById("page__financial_resume___debit").innerHTML = fmtMoney("erro");
                document.getElementById("page__financial_resume___sum").innerHTML = fmtMoney("erro");
            }
        });
    }
    
    function page__wallet__loadClear() {
        document.querySelector(".page-body").innerHTML = 
              '<div class="container-xl d-flex flex-column justify-content-center">'
            + '    <div class="empty">'
            + '        <div class="empty-img"><img src="https://cdn.brauntech.com.br/ajax/libs/tabler/1.0.0-beta9/demo/static/illustrations/undraw_printing_invoices_5r4r.svg" height="128" alt="" /></div>'
            + '        <p class="empty-title">No results found</p>'
            + '        <p class="empty-subtitle text-muted">'
            + '            Try changing your search or filter to find what you\'re looking for.'
            + '        </p>'
            + '    </div>'
            + '</div>';
    }
    
    /*elCode.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_walletGetListing("*");
        }
    });*/
    
    elDate_of.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_walletGetListing("*");
        }
    });
    
    elDate_until.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_walletGetListing("*");
        }
    });
    
    fc_walletGetListing("*");
</script>
