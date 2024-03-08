<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Request | help
                </h2>
            </div>
            <div class="col-auto ms-auto d-print-none">
                <div class="btn-list">
                    <div class="form-group">
                        <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormIncomeGet2();">
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-exchange" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                <circle cx="5" cy="18" r="2" />
                                <circle cx="19" cy="6" r="2" />
                                <path d="M19 8v5a5 5 0 0 1 -5 5h-3l3 -3m0 6l-3 -3" />
                                <path d="M5 16v-5a5 5 0 0 1 5 -5h3l-3 -3m0 6l3 -3" />
                            </svg>
                            Request help
                        </a>
                    </div>
                    
                    <!--
                    <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                    <!--
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="income_date_of" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="01/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                            </div>
                            <div class="form-group" style="max-width: 140px;">
                            <div class="input-icon">
                              <span class="input-icon-addon"><!-- Download SVG icon from http://tabler-icons.io/i/calendar -->
                   <!--
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><rect x="4" y="5" width="16" height="16" rx="2"></rect><line x1="16" y1="3" x2="16" y2="7"></line><line x1="8" y1="3" x2="8" y2="7"></line><line x1="4" y1="11" x2="20" y2="11"></line><line x1="11" y1="15" x2="12" y2="15"></line><line x1="12" y1="15" x2="12" y2="18"></line></svg>
                              </span>
                              <input id="income_date_until" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}">
                            </div>
                        </div>
                    
                    <!--
                    <div class="form-group" style="/*max-width: 140px;*/">
                        <div class="form-group">
                            <div id="extract_unilevel--btn-group" class="btn-group w-100">
                                <button type="button" class="btn btn-primary" data-tab="*">Todos</button>
                                <button type="button" class="btn" data-tab="active">Ativos</button>
                                <button type="button" class="btn" data-tab="inactive">Inativos</button>
                            </div>
                            <script>
                                if (typeof page__extract_unilevel__buttons === 'undefined') {
                                    let page__extract_unilevel__buttons = document.querySelectorAll('#extract_unilevel--btn-group .btn');
                                    for(let i = 0; i<page__extract_unilevel__buttons.length; i++){
                                        page__extract_unilevel__buttons[i].addEventListener('click', () => {
                                            var btnLst = document.querySelectorAll('#extract_unilevel--btn-group .btn');
                                            for(var i2 = 0; i2<btnLst.length; i2++){
                                                if (page__extract_unilevel__buttons[i].getAttribute("data-tab") == btnLst[i2].getAttribute("data-tab")) {
                                                    page__extract_unilevel__buttons[i].classList.add("btn-primary");
                                                } else {
                                                    btnLst[i2].classList.remove("btn-primary");
                                                }
                                            }
                                            
                                            fc_incomeRequestsGetAll(page__extract_unilevel__buttons[i].getAttribute("data-tab"));
                                        });
                                    }
                                }
                            </script>
                        </div>
                    </div>
                    -->
                </div>
            </div>
        </div>
    </div>
</div>
<div class="page-body">
    <!-- -->
</div>

<script>
    function fc_incomeRequestsGetAll(status = "", listType){
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        $.ajax({
            type: 'GET',
            {{#if system.isadmin}}
            url: CFG__API_URL + CFG__API_VERSION + "/income/requests",
            {{else}}
            url: CFG__API_URL + CFG__API_VERSION + "/income/requests?account_id={{system.userdata._id}}",
            {{/if}}
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
            console.log('aqui');
                if (response.success === true) {
                    var arr = response.data;
                    var tbodyHTML = '';
                    
                    if (arr.length > 0) {
                        for (var i = 0; i < arr.length; i++){
                            var id = arr[i]._id,
                                date = datetimeToString(arr[i]._created_at, true, true),
                                amount = fmtMoney(arr[i]._amount),
                                received = fmtMoney(arr[i]._received);
                            
                            var statusStr = '';
                            switch(arr[i]._status){
                                case 'pending':
                                    statusStr = '<span class="badge bg-yellow">In progress</span>';
                                break;
                                case 'effected':
                                    statusStr = '<span class="badge bg-green">Received</span>';
                                break;
                            }
                            
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td data-label="Name">'
                                + '        <div class="d-flex py-1 align-items-center">'
                                //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                                + '            <div class="flex-fill">'
                                + '                <div class="font-weight-medium">' + arr[i]._name + '</div>'
                                //+ '                <div class="text-muted"></div>'
                                + '            </div>'
                                + '        </div>'
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Date">'
                                + '        ' + date
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Amount">'
                                + '        ' + amount
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Received amount">'
                                + '        ' + received
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Status">'
                                + '        ' + statusStr
                                + '    </td>'
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
                            + '                                 <th>Reference</th>'
                            //+ '                                 <th>Tipo</th>'
                            + '                                 <th class="text-center">Date</th>'
                            + '                                 <th class="text-center">Amount</th>'
                            + '                                 <th class="text-center">Received amount</th>'
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
                        page__income__loadClear();
                    }
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                page__income__loadClear();
            }
        });
    }
    
    function page__income__loadClear() {
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
    
    fc_incomeRequestsGetAll("*");
</script>
