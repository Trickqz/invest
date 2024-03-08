<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Income [Extract]
                </h2>
            </div>
            <div class="col-auto ms-auto d-print-none">
                <div class="btn-list">
                        {{#if system.isadmin}}
                            <div class="form-group" style="max-width: 240px;/*display: none;*/">
                        {{else}}
                            <div class="form-group" style="max-width: 240px;display: none;">
                        {{/if}}
                          <div class="input-icon">
                            <input id="income_extract__q" name="income_extract__q" type="text" class="form-control" placeholder="Username...">
                            <span class="input-icon-addon">
                              <!-- Download SVG icon from http://tabler-icons.io/i/search -->
                              <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><circle cx="10" cy="10" r="7"></circle><line x1="21" y1="21" x2="15" y2="15"></line></svg>
                            </span>
                          </div>
                          </div>
                    
                    <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="income_extract__date_of" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="01/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                            </div>
                            <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="income_extract__date_until" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                        </div>
                    
                        <div class="form-group">
                            <div class="btn-group w-100">
                                <!--<button type="button" class="btn btn-primary">Todos</button>-->
                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        All
                                    </button>
                                    <div class="dropdown-menu dropdown-menu-end" style="">
                                        <a class="dropdown-item" href="#" onclick="income_extract__setStatus(this, '*');">
                                            All
                                        </a>
                                        <a class="dropdown-item" href="#" onclick="income_extract__setStatus(this, 'pending');">
                                            Pending
                                        </a>
                                        <a class="dropdown-item" href="#" onclick="income_extract__setStatus(this, 'blocked');">
                                            Blocked
                                        </a>
                                        <a class="dropdown-item" href="#" onclick="income_extract__setStatus(this, 'effected');">
                                            Effected
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script>
                            var incomeStatus = '*';
                            function income_extract__setStatus(el, status) {
                                var elBtnGroupDrop1 = document.getElementById("btnGroupDrop1");
                                btnGroupDrop1.innerHTML = el.innerHTML;
                                incomeStatus = status;
                                
                                fc_income_extractGetAll("*");
                            }
                        </script>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="page-body">
    <!-- -->
</div>

<script>
    var elIncome_extract__q = document.getElementById("income_extract__q");
    var elDate_of = document.getElementById("income_extract__date_of");
    var elDate_until = document.getElementById("income_extract__date_until");
    var elDate_until = document.getElementById("income_extract__date_until");
    
    elIncome_extract__q.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_income_extractGetAll("*");
        }
    });
    
    elDate_of.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_income_extractGetAll("*");
        }
    });
    
    elDate_until.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_income_extractGetAll("*");
        }
    });
    
    
    function fc_income_extractGetAll(status = "", listType){
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/personal_income?q="+elIncome_extract__q.value+"&date_of="+FormatStringDate(elDate_of.value)+"&date_until="+FormatStringDate(elDate_until.value)+"&status="+incomeStatus,
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
                            var id = arr[i]._id;
                            
                            var statusFmt = '';
                            if (arr[i]._status == 'pending') {
                                statusFmt = '<span class="badge bg-yellow">Pending</span>';
                            } else if (arr[i]._status == 'blocked') {
                                statusFmt = '<span class="badge bg-red">Blocked</span>';
                            } else if (arr[i]._status == 'effected') {
                                statusFmt = '<span class="badge bg-green">Effected</span>';
                            }
                            
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td data-label="Name">'
                                + '        <div class="d-flex py-1 align-items-center">'
                                //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                                + '            <div class="flex-fill">'
                                + '                <div class="font-weight-medium">' + arr[i]._accounts__name + '</div>'
                                + '                <div class="text-muted">' + arr[i]._accounts__username + '</div>'
                                + '            </div>'
                                + '        </div>'
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Licenses">'
                                + '        ' + arr[i]._contracts
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Percenteage / Amount">'
                                + '        ' + arr[i]._percentage + '% | ' + fmtMoney(arr[i]._amount)
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Date">'
                                + '        ' + datetimeToString(arr[i]._created_at, true, true)
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Status">'
                                + '        ' + statusFmt
                                + '    </td>'
                                //+ '    <td>'
                                //+ '        <div class="btn-list flex-nowrap">'
                                //+ '             <button type="button" class="btn btn-primary" onclick="View.openFormPackages(\'' + arr[i]._id + '\', \'edition\');">'
                                //+ '                 <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-pencil" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                //+ '                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                //+ '                    <path d="M4 20h4l10.5 -10.5a1.5 1.5 0 0 0 -4 -4l-10.5 10.5v4"></path>'
                                //+ '                    <line x1="13.5" y1="6.5" x2="17.5" y2="10.5"></line>'
                                //+ '                 </svg>'
                                //+ '                 Editar'
                                //+ '             </button>'
                                //+ '             <button type="button" class="btn btn-danger" onclick="fc_bonusDelete(\'' + arr[i]._id + '\');">'
                                //+ '                 <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-pencil" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                //+ '                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                //+ '                    <path d="M4 20h4l10.5 -10.5a1.5 1.5 0 0 0 -4 -4l-10.5 10.5v4"></path>'
                                //+ '                    <line x1="13.5" y1="6.5" x2="17.5" y2="10.5"></line>'
                                //+ '                 </svg>'
                                //+ '                 Excluir'
                                //+ '             </button>'
                                //+               buttons
                                //+ '        </div>'
                                //+ '    </td>'
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
                            + '                                 <th>Nome</th>'
                            + '                                 <th class="text-center">Licenses</th>'
                            + '                                 <th class="text-center">Percentage / Amount</th>'
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
                        page__income_extract__loadClear();
                    }
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                page__income_extract__loadClear();
            }
        });
    }
    
    function page__income_extract__loadClear() {
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
    
    fc_income_extractGetAll("*");
</script>
