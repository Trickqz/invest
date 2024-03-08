<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    {{#if system.isadmin}}
                        Licenses
                    {{else}}
                        My licenses
                    {{/if}}
                </h2>
            </div>

            <div class="col-auto ms-auto d-print-none">
                <div class="btn-list">
                    {{#if system.isadmin}}
                        <div class="form-group" style="max-width: 240px;">
                          <div class="input-icon">
                            <input id="donations_q" name="donations_q" type="text" class="form-control" placeholder="Username, name or email...">
                            <span class="input-icon-addon">
                              <!-- Download SVG icon from http://tabler-icons.io/i/search -->
                              <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><circle cx="10" cy="10" r="7"></circle><line x1="21" y1="21" x2="15" y2="15"></line></svg>
                            </span>
                          </div>
                          </div>
                    {{else}}
                        {{#contains "true" settings.donations_service_enabled}}
                            <div class="form-group">
                                <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormDonationsAdd();">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>
                                    Buy
                                </a>
                            </div>
                        {{else}}
                        {{/contains}}
                        
                        <span class="d-none d-sm-inline">
                            <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormIncomeGet();">
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-exchange" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                    <circle cx="5" cy="18" r="2" />
                                    <circle cx="19" cy="6" r="2" />
                                    <path d="M19 8v5a5 5 0 0 1 -5 5h-3l3 -3m0 6l-3 -3" />
                                    <path d="M5 16v-5a5 5 0 0 1 5 -5h3l-3 -3m0 6l3 -3" />
                                </svg>
                                Generate income
                            </a>
                        </span>
                    {{/if}}
                    
                    <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="donations_date_of" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="01/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                            </div>
                            <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="donations_date_until" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                        </div>
                    
                    {{#if system.isadmin}}
                        <div class="form-group">
                            <div class="btn-group w-100">
                                <!--<button type="button" class="btn btn-primary">Todos</button>-->
                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        All
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-end" style="">
                                        <a class="dropdown-item" href="#" onclick="donations__setStatus(this, '*');">
                                            All
                                        </a>
                                        <a class="dropdown-item" href="#" onclick="donations__setStatus(this, 'waiting');">
                                            Pending
                                        </a>
                                        <a class="dropdown-item" href="#" onclick="donations__setStatus(this, 'receiving');">
                                            Receiving
                                        </a>
                                        <a class="dropdown-item" href="#" onclick="donations__setStatus(this, 'finished');">
                                            Finished
                                        </a>
                                        <a class="dropdown-item" href="#" onclick="donations__setStatus(this, 'canceled');">
                                            Canceled
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script>
                            function donations__setStatus(el, status) {
                                var elBtnGroupDrop1 = document.getElementById("btnGroupDrop1");
                                btnGroupDrop1.innerHTML = el.innerHTML;
                                
                                fc__donationsGetListing(status);
                            }
                        </script>
                    {{else}}
                        <div class="form-group">
                            <div id="donations--btn-group" class="btn-group w-100">
                                <!-- 'pending_approval','active','suspended_by_admin','automatically_suspended' -->
                                <button type="button" class="btn btn-primary" data-tab="*">All</button>
                                <!--<button type="button" class="btn" data-tab="waiting">Pendentes</button>-->
                                <button type="button" class="btn" data-tab="receiving">Receiving</button>
                                <button type="button" class="btn" data-tab="finished">Finished</button>
                                <!--<button type="button" class="btn" data-tab="canceled">Cancelados</button>-->
                                <!--<button type="button" class="btn" data-tab="automatically_suspended">Suspendido <sup>auto</sup></button>-->
                            </div>
                            <script>
                                if (typeof page__donations__buttons === 'undefined') {
                                    let page__donations__buttons = document.querySelectorAll('#donations--btn-group .btn');
                                    for(let i = 0; i<page__donations__buttons.length; i++){
                                        page__donations__buttons[i].addEventListener('click', () => {
                                            var btnLst = document.querySelectorAll('#donations--btn-group .btn');
                                            for(var i2 = 0; i2<btnLst.length; i2++){
                                                if (page__donations__buttons[i].getAttribute("data-tab") == btnLst[i2].getAttribute("data-tab")) {
                                                    page__donations__buttons[i].classList.add("btn-primary");
                                                } else {
                                                    btnLst[i2].classList.remove("btn-primary");
                                                }
                                            }
                                            
                                            fc__donationsGetListing(page__donations__buttons[i].getAttribute("data-tab"));
                                        });
                                    }
                                }
                            </script>
                        </div>
                    {{/if}}
                </div>
            </div>
        </div>
    </div>
</div>
<div class="page-body">
    <!-- -->
</div>

<script>
    {{#if system.isadmin}}
        var elDonations_q = document.getElementById("donations_q");
    {{else}}
    {{/if}}
    
    var elDate_of = document.getElementById("donations_date_of");
    var elDate_until = document.getElementById("donations_date_until");
    var donationsStatus = "*";
    
    function fc__donationsGetListing(status = ""){
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
            
            if (status != "") donationsStatus = status;
            if (donationsStatus != "*") search_q['status'] = donationsStatus;
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
                                <div id="count_total_contracts" class="font-weight-medium">
                                    <!--<span class="float-right font-weight-medium text-green">USD 0,00</span>-->
                                </div>
                                <div id="count_receiving_contracts" class="text-muted">
                                    <!-- -->
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    <div class="col-md-6 col-xl-4">
                        <div class="card card-sm">
                          <div class="card-body">
                            <div class="row align-items-center">
                              <div class="col-auto">
                                <span class="bg-green-lt avatar"><!-- Download SVG icon from http://tabler-icons.io/i/arrow-down -->
                                  <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M16.7 8a3 3 0 0 0 -2.7 -2h-4a3 3 0 0 0 0 6h4a3 3 0 0 1 0 6h-4a3 3 0 0 1 -2.7 -2"></path><path d="M12 3v3m0 12v3"></path></svg>
                                </span>
                              </div>
                              <div class="col">
                                <div id="page__financial_resume___donations_total" class="font-weight-medium">
                                  <!--<span class="float-right font-weight-medium text-green"><!--+4%--><!--</span>-->
                                </div>
                                <div id="page__financial_resume___donations_pending" class="text-muted">
                                  <!-- -->
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
            url: CFG__API_URL + CFG__API_VERSION + "/donations/resume",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    
                    document.getElementById("count_total_contracts").innerHTML = _data._count_total_contracts + ' licenses';
                    
                    {{#if system.isadmin}}
                        document.getElementById("count_receiving_contracts").innerHTML = _data._count_receiving_contracts + ' paying';
                        document.getElementById("page__financial_resume___donations_total").innerHTML = fmtMoney(_data._total_amount_received) + ' paid';
                        document.getElementById("page__financial_resume___donations_pending").innerHTML = fmtMoney(_data._total_amount_income) + ' to be paid';
                    {{else}}
                        document.getElementById("count_receiving_contracts").innerHTML = _data._count_receiving_contracts + ' receiving';
                        document.getElementById("page__financial_resume___donations_total").innerHTML = fmtMoney(_data._total_amount_received) + ' received';
                        document.getElementById("page__financial_resume___donations_pending").innerHTML = fmtMoney(_data._total_amount_income) + ' to be receive';
                    {{/if}}
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                document.getElementById("page__financial_resume___donations_pending").innerHTML = "erro";
                document.getElementById("page__financial_resume___donations_total").innerHTML = "erro";
            }
        });
        
        $.ajax({
            type: 'GET',
            {{#if system.isadmin}}
                url: CFG__API_URL + CFG__API_VERSION + "/donations?q="+elDonations_q.value+"&date_of="+FormatStringDate(elDate_of.value)+"&date_until="+FormatStringDate(elDate_until.value)+"&status="+status,
            {{else}}
                url: CFG__API_URL + CFG__API_VERSION + "/donations?date_of="+FormatStringDate(elDate_of.value)+"&date_until="+FormatStringDate(elDate_until.value)+"&status="+status,
            {{/if}}
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
                                amount = '',  //fmtMoney(arr[i]._amount);
                                //type = '';
                                income = '',
                                received = '';
                            
                            if (arr[i]._amount < 0) {
                                amount = '<span class="text-red">'+fmtMoney(arr[i]._amount)+'</span>';
                            } else if (arr[i]._amount > 0) {
                                amount = '<span class="text-green">'+fmtMoney(arr[i]._amount)+'</span>';
                            } else {
                                amount = '<span class="">'+fmtMoney(arr[i]._amount)+'</span>';
                            }
                            
                            if (arr[i]._income < 0) {
                                income = '<span class="text-red">'+fmtMoney(arr[i]._income)+'</span>';
                            } else if (arr[i]._income > 0) {
                                income = '<span class="text-green">'+fmtMoney(arr[i]._income)+'</span>';
                            } else {
                                income = '<span class="">'+fmtMoney(arr[i]._income)+'</span>';
                            }
                            
                            if (arr[i]._received < 0) {
                                received = '<span class="text-red">'+fmtMoney(arr[i]._received)+'</span>';
                            } else if (arr[i]._received > 0) {
                                received = '<span class="text-green">'+fmtMoney(arr[i]._received)+'</span>';
                            } else {
                                received = '<span class="">'+fmtMoney(arr[i]._received)+'</span>';
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
                            
                            var status = '';
                            switch(arr[i]._status){
                                case "waiting":
                                    status = '<span class="badge bg-yellow">Pending</span>';
                                break;
                                case "receiving":
                                    status = '<span class="badge bg-green">Receiving</span>';
                                break;
                                case "blocked":
                                    status = '<span class="badge bg-red">Blocked</span>';
                                break;
                                case "finished":
                                    status = '<span class="badge">Finished</span>';
                                break;
                                case "canceled":
                                    status = '<span class="badge bg-red">Canceled</span>';
                                break;
                            }
                            
                            page__financial_resume___sum += parseInt(_amountInt);
                            
                            var buttons = '';
                            
                            buttons = 
                                    '<span class="dropdown">'
                                  + '    <button class="btn dropdown-toggle align-text-top" data-bs-boundary="viewport" data-bs-toggle="dropdown" aria-expanded="false">Actions</button>'
                                  + '    <div class="dropdown-menu dropdown-menu-end" style="">'
                                  + '        <a class="dropdown-item" href="javascript:;" onclick="View.openFormDonationsDetails(\'' + arr[i]._id + '\');">'
                                  + '            View'
                                  + '        </a>';
                            
                            //waiting, receiving, blocked, finished, canceled
                            if (arr[i]._status == "waiting") {
                                {{#if system.isadmin}}
                                    buttons += 
                                          '        <hr style="padding: 0;margin: 0;">'
                                        + '        <a class="dropdown-item" href="javascript:;" onclick="fc_donationsSetStatus(\'' + arr[i]._id + '\', \'receiving\');">'
                                        + '            Confirm'
                                        + '        </a>'
                                        + '        <a class="dropdown-item" href="javascript:;" onclick="fc_donationsCancel(\'' + arr[i]._id + '\');">'
                                        + '            Cancel'
                                        + '        </a>'
                                        //+ '        <hr style="padding: 0;margin: 0;">'
                                        //+ '        <a class="dropdown-item text-danger" href="javascript:;" onclick="fc_donationsDelete(\'' + arr[i]._id + '\');">'
                                        //+ '            Delete'
                                        //+ '        </a>'
                                        + '    </div>'
                                        + '</span>';
                                {{else}}
                                {{/if}}
                            } else if (arr[i]._status == "receiving") {
                                {{#if system.isadmin}}
                                    buttons += 
                                          '        <hr style="padding: 0;margin: 0;">'
                                        + '        <a class="dropdown-item" href="javascript:;" onclick="fc_donationsSetStatus(\'' + arr[i]._id + '\', \'finished\');">'
                                        + '            Finish'
                                        + '        </a>'
                                        + '        <a class="dropdown-item" href="javascript:;" onclick="fc_donationsCancel(\'' + arr[i]._id + '\');">'
                                        + '            Cancel'
                                        + '        </a>'
                                        + '    </div>';
                                {{else}}
                                {{/if}}
                            }
                            
                            buttons += '</span>';
                            
                            var contractsStr = ' license';
                            if (arr[i]._contracts > 1) {
                                contractsStr = ' licenses';
                            }
                            
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td data-label="Name">'
                                + '        <div class="d-flex py-1 align-items-center">'
                                //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                                + '            <div class="flex-fill">'
                                + '                <div class="font-weight-medium">Pack <b>#' + arr[i]._seq + '</b>, containing ' + arr[i]._contracts + ' ' + contractsStr + '</div>'
                                
                                {{#if system.isadmin}}
                                    + '            <div class="font-weight-medium"><b>'+arr[i]._accounts__username+'</b> | '+arr[i]._accounts__name+'</div>'
                                {{else}}
                                {{/if}}
                                
                                + '                <div class="text-muted">Hash: ' + arr[i]._hash + '</div>'
                                + '            </div>'
                                + '        </div>'
                                + '    </td>'
                                //+ '    <td class="text-muted text-center" data-label="Licenses">'
                                //+ '        ' + typeStr
                                //+ '        ' + arr[i]._contracts
                                //+ '    </td>'
                                + '    <td class="text-muted text-center" data-label="Amount / Income / Received">'
                                + '        ' + amount + ' / ' + income + '<br />' + received
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Date">'
                                + '        ' + created_at
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Status">'
                                + '        ' + status
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
                                //+ '             <button type="button" class="btn btn-primary" onclick="View.openFormCashout(\'' + arr[i]._id + '\');">'
                                //+ '                 <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-search" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                //+ '                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                //+ '                    <circle cx="10" cy="10" r="7"></circle>'
                                //+ '                    <line x1="21" y1="21" x2="15" y2="15"></line>'
                                //+ '                 </svg>'
                                //+ '                 View'
                                //+ '             </button>'
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
                            //+ '                                 <th class="text-center">Licenses</th>'
                            + '                                 <th class="text-center">Amount / Gain Cap / Received</th>'
                            + '                                 <th class="text-center">Date</th>'
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
                        page__donations__loadClear();
                    }
                    
                    document.getElementById("page__financial_resume___credit").innerHTML = fmtMoney(page__financial_resume___credit/100.0) + " in period";
                    document.getElementById("page__financial_resume___sum").innerHTML = fmtMoney(page__financial_resume___sum/100.0) + " in period";
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                page__donations__loadClear();
                
                document.getElementById("page__financial_resume___credit").innerHTML = fmtMoney("erro");
                document.getElementById("page__financial_resume___sum").innerHTML = fmtMoney("erro");
            }
        });
    }
    
    function page__donations__loadClear() {
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
    
    {{#if system.isadmin}}
        elDonations_q.addEventListener("keyup", function(event) {
            // Number 13 is the "Enter" key on the keyboard
            if (event.keyCode === 13) {
                // Cancel the default action, if needed
                event.preventDefault();
                // Trigger the button element with a click
                fc__donationsGetListing("*");
            }
        });
    {{else}}
    {{/if}}
    
    elDate_of.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc__donationsGetListing("*");
        }
    });
    
    elDate_until.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc__donationsGetListing("*");
        }
    });
    
    function fc_donationsCancel(_id) {
        alertOpen({
                title: "Confirma",
                text: "Cancel license pack?",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                $.ajax({
                    type: 'POST',
                    url: CFG__API_URL + CFG__API_VERSION + "/donations/"+_id+"/cancel",
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    data: { status: status },
                    success: function(response) {
                        if (response.success === true) {
                            fc__donationsGetListing("*");
                        }
                    }
                });
            }
        );
    }
    
    function fc_donationsSetStatus(_id, status) {
        var text = '';
        if (status == 'receiving') {
            text = 'Set received?';
        } else if (status == 'finished') {
            text = 'Set finished?';
        }
        
        alertOpen({
                title: "Confirm",
                text: text,
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                $.ajax({
                    type: 'POST',
                    url: CFG__API_URL + CFG__API_VERSION + "/donations/"+_id+"/setStatus",
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    data: { status: status },
                    success: function(response) {
                        if (response.success === true) {
                            fc__donationsGetListing("*");
                        }
                    }
                });
            }
        );
    }
    
    function fc_donationsDelete(_id) {
        alertOpen({
                title: "Confirm",
                text: "Delete pack?<br /><b>Warning:</b> Pack licenses will be permanently deleted!",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                //$('.btn_register_tranfer').attr('disabled','disabled').html("Await...")
				$.ajax({
                    type: 'DELETE',
                    url: CFG__API_URL + CFG__API_VERSION + "/donations/"+_id,
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    data: {},
                    success: function(response) {
                        if (response.success === true) {
                            fc__donationsGetListing("*");
                        } else {
                            showError(response.message);
                        }
                    }
                });
            }
        );
    }
    
    fc__donationsGetListing("*");
</script>
