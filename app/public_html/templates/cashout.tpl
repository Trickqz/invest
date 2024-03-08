<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Withdraw
                </h2>
            </div>

            <div class="col-auto ms-auto d-print-none">
                <div class="btn-list">
                    {{#if system.isadmin}}
                    {{else}}
                        {{#contains "true" settings.cashout_service_enabled}}
                            <div class="form-group">
                                <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormWalletWithdrawal();">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>
                                    New withdrawal
                                </a>
                            </div>
                        {{else}}
                        {{/contains}}
                    {{/if}}
                    
                    <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="cashout_date_of" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="01/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                            </div>
                            <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="cashout_date_until" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                            </div>
                    <div class="form-group">
                        <div id="cashout--btn-group" class="btn-group w-100">
                            <!-- 'pending_approval','active','suspended_by_admin','automatically_suspended' -->
                            <button type="button" class="btn btn-primary" data-tab="*">All</button>
                            <button type="button" class="btn" data-tab="pending">Pending</button>
                            <button type="button" class="btn" data-tab="effected">Concluded</button>
                            <button type="button" class="btn" data-tab="canceled">Canceled</button>
                            <!--<button type="button" class="btn" data-tab="automatically_suspended">Suspendido <sup>auto</sup></button>-->
                        </div>
                        <script>
                            if (typeof page__cashout__buttons === 'undefined') {
                                let page__cashout__buttons = document.querySelectorAll('#cashout--btn-group .btn');
                                for(let i = 0; i<page__cashout__buttons.length; i++){
                                    page__cashout__buttons[i].addEventListener('click', () => {
                                        var btnLst = document.querySelectorAll('#cashout--btn-group .btn');
                                        for(var i2 = 0; i2<btnLst.length; i2++){
                                            if (page__cashout__buttons[i].getAttribute("data-tab") == btnLst[i2].getAttribute("data-tab")) {
                                                page__cashout__buttons[i].classList.add("btn-primary");
                                            } else {
                                                btnLst[i2].classList.remove("btn-primary");
                                            }
                                        }
                                        
                                        fc__cashoutGetListing(page__cashout__buttons[i].getAttribute("data-tab"));
                                    });
                                }
                            }
                        </script>
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
    var elDate_of = document.getElementById("cashout_date_of");
    var elDate_until = document.getElementById("cashout_date_until");
    var financial_resumeStatus = "*";
    
    function fc__cashoutGetListing(status = ""){
        var search_q = {
            limit: 1000,
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
            
            if (status != "") financial_resumeStatus = status;
            if (financial_resumeStatus != "*") search_q['status'] = financial_resumeStatus;
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
                                <span class="bg-yellow-lt avatar"><!-- Download SVG icon from http://tabler-icons.io/i/currency-dollar -->
                                  <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M16.7 8a3 3 0 0 0 -2.7 -2h-4a3 3 0 0 0 0 6h4a3 3 0 0 1 0 6h-4a3 3 0 0 1 -2.7 -2"></path><path d="M12 3v3m0 12v3"></path></svg>
                                </span>
                              </div>
                              <div class="col">
                                <div id="page__financial_resume___cashout_pending" class="font-weight-medium">
                                  <!--<span class="float-right font-weight-medium text-green">USD 0,00</span>-->
                                </div>
                                <div class="text-muted">
                                    Withdrawal pending
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
                                  <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M16.7 8a3 3 0 0 0 -2.7 -2h-4a3 3 0 0 0 0 6h4a3 3 0 0 1 0 6h-4a3 3 0 0 1 -2.7 -2"></path><path d="M12 3v3m0 12v3"></path></svg>
                                </span>
                              </div>
                              <div class="col">
                                <div id="page__financial_resume___cashout_total" class="font-weight-medium">
                                  <!--<span class="float-right font-weight-medium text-green"><!--+4%--><!--</span>-->
                                </div>
                                <div class="text-muted">
                                  Total withdrawal
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                </div>
            </div>
            <div class="list container-xl mb1_25"></div>`;
        /** **/
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/wallet/cashout/resume",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    
                    document.getElementById("page__financial_resume___cashout_pending").innerHTML = fmtMoney(_data._pending * -1);
                    document.getElementById("page__financial_resume___cashout_total").innerHTML = fmtMoney(_data._total * -1);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                document.getElementById("page__financial_resume___cashout_pending").innerHTML = "erro";
                document.getElementById("page__financial_resume___cashout_total").innerHTML = "erro";
            }
        });
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/wallet/cashout?date_of="+FormatStringDate(elDate_of.value)+"&date_until="+FormatStringDate(elDate_until.value)+"&status="+status,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var arr = response.data;
                    var tbodyHTML = '';
                    
                    var page__financial_resume___credit = 0,
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
                                    //page__financial_resume___debit += parseInt(_amountInt);
                                    
                                    //amount = '<span style="color: #CC0000;">' + amount + '</span>';
                                    //type = 'Débito';
                                break;
                            }
                            
                            page__financial_resume___sum += parseInt(_amountInt);
                            
                            var buttons = '';
                        
                        buttons = 
                                '<span class="dropdown">'
                              + '    <button class="btn dropdown-toggle align-text-top" data-bs-boundary="viewport" data-bs-toggle="dropdown" aria-expanded="false">Actions</button>'
                              + '    <div class="dropdown-menu dropdown-menu-end" style="">'
                              + '        <a class="dropdown-item" href="javascript:;" onclick="View.openFormCashout(\'' + arr[i]._id + '\');">'
                              + '            View'
                              + '        </a>';
                        
                        if (arr[i]._status == "pending") {
                                {{#if system.isadmin}}
                                    buttons += 
                                          '        <hr style="padding: 0;margin: 0;">'
                                        + '        <a class="dropdown-item" href="javascript:;" onclick="View.openFormCashoutConfirm(\'' + arr[i]._id + '\');">'
                                        + '            Confirm'
                                        + '        </a>';
                                {{else}}
                                {{/if}}
                                
                                buttons += 
                                      '        <a class="dropdown-item" href="javascript:;" onclick="fc_cashoutCancel(\'' + arr[i]._id + '\');">'
                                    + '            Cancel'
                                    + '        </a>'
                                    + '        <hr style="padding: 0;margin: 0;">'
                                    + '        <a class="dropdown-item text-danger" href="javascript:;" onclick="fc_cashoutDelete(\'' + arr[i]._id + '\');">'
                                    + '            Delete'
                                    + '        </a>'
                                    + '    </div>';
                            }
                            
                            buttons += 
                                '</span>';

                            acwn = arr[i]._accounts__crypto_wallet_network;

                            if (acwn == null) {
                                acwn = '';
                            } else {
                                acwn = arr[i]._accounts__crypto_wallet_network;
                            }
                            
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td data-label="Name">'
                                + '        <div class="d-flex py-1 align-items-center">'
                                //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                                + '            <div class="flex-fill">'
                                + '                <div class="font-weight-medium">' + arr[i]._reference + '</div>'
                                + '                <div class="font-weight-medium">' + arr[i]._description + '</div>'
                                + '                <div class="font-weight-medium">' + arr[i]._transaction_code + '</div>'
                                + '                <div class="font-weight-medium">' + arr[i]._accounts__username + '</div>'
                                + '                <div class="font-weight-medium">' + acwn + '</div>'
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
                                + '    <td>'
                                + '        <div class="btn-list flex-nowrap">'
                                + '             <button type="button" class="btn btn-primary" onclick="View.openFormCashout(\'' + arr[i]._id + '\');">'
                                + '                 <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-search" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                + '                    <circle cx="10" cy="10" r="7"></circle>'
                                + '                    <line x1="21" y1="21" x2="15" y2="15"></line>'
                                + '                 </svg>'
                                + '                 View'
                                + '             </button>'
                                +               buttons
                                + '        </div>'
                                + '    </td>'
                                + '</tr>';
                        }
                        
                        
                        document.querySelector(".page-body .list").innerHTML = 
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
                        page__cashout__loadClear();
                    }
                    
                    document.getElementById("page__financial_resume___credit").innerHTML = fmtMoney(page__financial_resume___credit/100.0) + " in the period";
                    document.getElementById("page__financial_resume___sum").innerHTML = fmtMoney(page__financial_resume___sum/100.0) + " in the period";
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                page__cashout__loadClear();
                
                document.getElementById("page__financial_resume___credit").innerHTML = fmtMoney("erro");
                document.getElementById("page__financial_resume___sum").innerHTML = fmtMoney("erro");
            }
        });
    }
    
    function page__cashout__loadClear() {
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
            fc__cashoutGetListing("*");
        }
    });*/
    
    elDate_of.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc__cashoutGetListing("*");
        }
    });
    
    elDate_until.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc__cashoutGetListing("*");
        }
    });
    
    function fc_cashoutCancel(_id) {
        alertOpen({
                title: "Confirm",
                text: "Cancel withdrawal?",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                $.ajax({
                    type: 'POST',
                    url: CFG__API_URL + CFG__API_VERSION + "/wallet/cashout/"+_id+"/cancel",
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    data: { status: status },
                    success: function(response) {
                        if (response.success === true) {
                            fc__cashoutGetListing("*");
                        }
                    }
                });
            }
        );
    }
    
    function fc_cashoutDelete(_id) {
        alertOpen({
                title: "Confirma",
                text: "Delete withdrawal?<br /><b>Warning:</b> Withdrawal will be permanently deleted!",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                //$('.btn_register_tranfer').attr('disabled','disabled').html("Aguarde...")
				$.ajax({
                    type: 'DELETE',
                    url: CFG__API_URL + CFG__API_VERSION + "/wallet/cashout/"+_id,
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    data: {},
                    success: function(response) {
                        if (response.success === true) {
                            fc__cashoutGetListing("*");
                        } else {
                            showError(response.message);
                        }
                    }
                });
            }
        );
    }
    
    fc__cashoutGetListing("*");
</script>
