<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Bonification [Extract]
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
                            <input id="bonification_extract__q" name="bonification_extract__q" type="text" class="form-control" placeholder="Username...">
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
                              <input id="bonification_extract__date_of" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="01/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                            </div>
                            <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="bonification_extract__date_until" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}">
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
                                        <a class="dropdown-item" href="#" onclick="bonification_extract__setStatus(this, '*');">
                                            All
                                        </a>
                                        <a class="dropdown-item" href="#" onclick="bonification_extract__setStatus(this, 'pending');">
                                            Pending
                                        </a>
                                        <a class="dropdown-item" href="#" onclick="bonification_extract__setStatus(this, 'blocked');">
                                            Blocked
                                        </a>
                                        <a class="dropdown-item" href="#" onclick="bonification_extract__setStatus(this, 'effected');">
                                            Effected
                                        </a>
                                        <a class="dropdown-item" href="#" onclick="bonification_extract__setStatus(this, 'canceled');">
                                            Canceled
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script>
                            var bonificationStatus = '*';
                            function bonification_extract__setStatus(el, status) {
                                var elBtnGroupDrop1 = document.getElementById("btnGroupDrop1");
                                btnGroupDrop1.innerHTML = el.innerHTML;
                                bonificationStatus = status;
                                
                                fc_bonification_extractGetAll("*");
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
    var elIncome_extract__q = document.getElementById("bonification_extract__q");
    var elDate_of = document.getElementById("bonification_extract__date_of");
    var elDate_until = document.getElementById("bonification_extract__date_until");
    var elDate_until = document.getElementById("bonification_extract__date_until");
    
    elIncome_extract__q.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_bonification_extractGetAll("*");
        }
    });
    
    elDate_of.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_bonification_extractGetAll("*");
        }
    });
    
    elDate_until.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc_bonification_extractGetAll("*");
        }
    });
    
    
    function fc_bonification_extractGetAll(status = "", listType){
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/bonification?q="+elIncome_extract__q.value+"&date_of="+FormatStringDate(elDate_of.value)+"&date_until="+FormatStringDate(elDate_until.value)+"&status="+bonificationStatus,
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
                                created_at = datetimeToString(arr[i]._created_at),
                                typeStr = commerce__formatWalletType(arr[i]._type),
                                amount = '';
                            
                            if (arr[i]._amount < 0) {
                                amount = '<span class="text-red">'+fmtMoney(arr[i]._amount)+'</span>';
                            } else if (arr[i]._amount > 0) {
                                amount = '<span class="text-green">'+fmtMoney(arr[i]._amount)+'</span>';
                            } else {
                                amount = '<span class="">'+fmtMoney(arr[i]._amount)+'</span>';
                            }
                            
                            var _amount = arr[i]._amount,
                                _amountInt = parseInt(_amount.replace(".", ""));
                            
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td data-label="Name">'
                                + '        <div class="d-flex py-1 align-items-center">'
                                //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                                + '            <div class="flex-fill">'
                                + '                <div class="font-weight-medium">' + arr[i]._accounts__name + ' <span class="text-muted">' + arr[i]._accounts__username + '</span></div>'
                                + '                <div class="text-muted">' + arr[i]._reference + ' | ' + arr[i]._description + '</div>'
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
                        
                        
                        document.querySelector(".page-body").innerHTML = 
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
                        page__bonification_extract__loadClear();
                    }
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                page__bonification_extract__loadClear();
            }
        });
    }
    
    function page__bonification_extract__loadClear() {
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
    
    fc_bonification_extractGetAll("*");
</script>
