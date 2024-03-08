<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Logs
                </h2>
            </div>
            <div class="col-auto ms-auto d-print-none">
                <div class="btn-list">
                    {{#if system.isadmin}}
                        <div class="form-group" style="max-width: 240px;">
                          <div class="input-icon">
                            <input id="logs_q" name="logs_q" type="text" class="form-control" placeholder="Search...">
                            <span class="input-icon-addon">
                              <!-- Download SVG icon from http://tabler-icons.io/i/search -->
                              <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><circle cx="10" cy="10" r="7"></circle><line x1="21" y1="21" x2="15" y2="15"></line></svg>
                            </span>
                          </div>
                          </div>
                    {{else}}
                        {{#contains "true" settings.donations_service_enabled}}
                            <!--
                            <div class="form-group">
                                <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormDonationsAdd();">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>
                                    Buy
                                </a>
                            </div>
                            -->
                        {{else}}
                        {{/contains}}
                        
                        <!--
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
                        -->
                    {{/if}}
                    
                    <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="logs_date_of" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="01/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                            </div>
                            <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="logs_date_until" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                        </div>
                    
                    {{#if system.isadmin}}
                        <!--
                        <div class="form-group">
                            <div class="btn-group w-100">
                                <!--<button type="button" class="btn btn-primary">Todos</button>-->
                        <!--        <div class="btn-group" role="group">
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
                        -->
                    {{else}}
                        <!--
                        <div class="form-group">
                            <div id="donations--btn-group" class="btn-group w-100">
                                <!-- 'pending_approval','active','suspended_by_admin','automatically_suspended' -->
                        <!--        <button type="button" class="btn btn-primary" data-tab="*">All</button>
                                <!--<button type="button" class="btn" data-tab="waiting">Pendentes</button>-->
                        <!--        <button type="button" class="btn" data-tab="receiving">Receiving</button>
                                <button type="button" class="btn" data-tab="finished">Finished</button>
                                <!--<button type="button" class="btn" data-tab="canceled">Cancelados</button>-->
                                <!--<button type="button" class="btn" data-tab="automatically_suspended">Suspendido <sup>auto</sup></button>-->
                        <!--    </div>
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
                        -->
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
    var elLogs_q = document.getElementById("logs_q");
    var elDate_of = document.getElementById("logs_date_of");
    var elDate_until = document.getElementById("logs_date_until");
    
    elLogs_q.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_logsGetAll();
        }
    });
    
    elDate_of.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_logsGetAll();
        }
    });
    
    elDate_until.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_logsGetAll();
        }
    });
    
    function fc_logsGetAll(listType){
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/logs?q="+elLogs_q.value+"&date_of="+FormatStringDate(elDate_of.value)+"&date_until="+FormatStringDate(elDate_until.value),
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var arr = response.data;
                    var tbodyHTML = '';
                    
                    if (arr.length > 0) {
                        for (var i = 0; i < arr.length; i++){
                            var id = arr[i]._id,
                                created_at = datetimeToString(arr[i]._created_at);
                            
                            /*
                            var _status = '';
                            if (arr[i]._status == 'active') {
                                _status = '<span class="badge bg-green">Active</span>';
                            } else if (arr[i]._status == 'suspended_by_admin') {
                                _status = '<span class="badge">Suspended by Admin</span>';
                            }
                            
                            var buttons = '';
                            if (arr[i]._status == "active") {
                                buttons += 
                                      '             <button type="button" class="btn btn-primary" onclick="fc_usersSetStatus(\'' + arr[i]._id + '\', \'suspended_by_admin\');">'
                                    + '                 Set inactive'
                                    + '             </button>';
                            } else {
                                buttons += 
                                      '             <button type="button" class="btn btn-primary" onclick="fc_usersSetStatus(\'' + arr[i]._id + '\', \'active\');">'
                                    + '                 Set active'
                                    + '             </button>';
                            }_log_ip
                            
                            buttons += 
                                      '             <button type="button" class="btn btn-danger" onclick="fc_usersDelete(\'' + arr[i]._id + '\');">'
                                    + '                 Delete'
                                    + '             </button>';
                            */
                            
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td data-label="USER / REFERENCE">'
                                + '        <div class="d-flex py-1 align-items-center">'
                                //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                                + '            <div class="flex-fill">'
                                + '                <div class="font-weight-medium">' + arr[i]._accounts__name + '</div>'
                                + '                <div class="font-muted">' + arr[i]._type + '</div>'
                                + '                <div class="text-muted">' + arr[i]._description + '</div>'
                                + '            </div>'
                                + '        </div>'
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="IP / USER AGENT">'
                                + '        ' + arr[i]._log_ip + '<br /><span style="max-width: 280px;display: inline-block;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">' + arr[i]._log_user_agent + '</span>'
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Created at">'
                                + '        ' + created_at
                                + '    </td>'
                                /*+ '    <td>'
                                + '        <div class="btn-list flex-nowrap">'
                                + '             <button type="button" class="btn btn-primary" onclick="View.openFormUsers(\'' + arr[i]._id + '\', \'edition\');">'
                                + '                 <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-pencil" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                + '                    <path d="M4 20h4l10.5 -10.5a1.5 1.5 0 0 0 -4 -4l-10.5 10.5v4"></path>'
                                + '                    <line x1="13.5" y1="6.5" x2="17.5" y2="10.5"></line>'
                                + '                 </svg>'
                                + '                 Edit'
                                + '             </button>'
                                +               buttons
                                + '        </div>'
                                + '    </td>'*/
                                + '</tr>';
                        }
                        
                        
                        document.querySelector(".page-body").innerHTML = 
                              ' <div class="container-xl">'
                            + '     <div class="row row-cards">'
                            + '         <div class="col-12">'
                            + '             <div class="card">'
                            + '                 <div class="table-responsive">'
                            + '                     <table class="table table-vcenter table-mobile-md card-table">'
                            + '                         <thead>'
                            + '                             <tr>'
                            + '                                 <th>User / Reference</th>'
                            + '                                 <th class="text-center">IP</th>'
                            + '                                 <th class="text-center">Created at</th>'
                            + '                                 <th></th>'
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
                        page__logs__loadClear();
                    }
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                page__logs__loadClear();
            }
        });
    }
    
    function page__logs__loadClear() {
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
    
    fc_logsGetAll();
</script>
