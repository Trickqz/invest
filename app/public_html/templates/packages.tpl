<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Packs
                </h2>
            </div>
            <div class="col-auto ms-auto d-print-none">
                <div class="btn-list">
                    <div class="form-group">
                        <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormPackages(null, 'insertion');">
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                <line x1="12" y1="5" x2="12" y2="19" />
                                <line x1="5" y1="12" x2="19" y2="12" />
                            </svg>
                            New pack
                        </a>
                    </div>
                    <div class="form-group" style="/*max-width: 140px;*/">
                        <div class="form-group">
                            <div id="extract_unilevel--btn-group" class="btn-group w-100">
                                <button type="button" class="btn btn-primary" data-tab="*">All</button>
                                <button type="button" class="btn" data-tab="active">Active</button>
                                <button type="button" class="btn" data-tab="inactive">Inactive</button>
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
                                            
                                            fc_donations_modelGetAll(page__extract_unilevel__buttons[i].getAttribute("data-tab"));
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
</div>
<div class="page-body">
    <!-- -->
</div>

<script>
    function fc_donations_modelGetAll(status = "", listType){
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/donations_model?status="+status,
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
                                amount = fmtMoney(arr[i]._amount),
                                income = fmtMoney(arr[i]._income);
                            
                            var _type = '';
                            if (arr[i]._type == 'plan') {
                                _type = '<span class="badge">Pack primary</span>';
                            } else if (arr[i]._type == 'extra') {
                                _type = '<span class="badge bg-green">Pack extra</span>';
                            }
                            
                            var _status = '';
                            if (arr[i]._status == 'active') {
                                _status = '<span class="badge bg-green">Active</span>';
                            } else if (arr[i]._status == 'inactive') {
                                _status = '<span class="badge">Inactive</span>';
                            }
                            
                            var buttons = '';
                            buttons = 
                                    '<span class="dropdown">'
                                  + '    <button class="btn dropdown-toggle align-text-top" data-bs-boundary="viewport" data-bs-toggle="dropdown" aria-expanded="false">Actions</button>'
                                  + '    <div class="dropdown-menu dropdown-menu-end" style="">'
                                  + '        <a class="dropdown-item" href="javascript:;" onclick="View.openFormPackages(\'' + arr[i]._id + '\', \'edition\');">'
                                  + '            Edit'
                                  + '        </a>';
                        
                            if (arr[i]._status == "active") {
                                buttons += 
                                      '        <hr style="padding: 0;margin: 0;">'
                                    + '        <a class="dropdown-item" href="javascript:;" onclick="fc_packagesSetStatus(\'' + arr[i]._id + '\', \'inactive\');">'
                                    + '            Inactive'
                                    + '        </a>';
                            } else {
                                buttons += 
                                      '        <hr style="padding: 0;margin: 0;">'
                                    + '        <a class="dropdown-item" href="javascript:;" onclick="fc_packagesSetStatus(\'' + arr[i]._id + '\', \'active\');">'
                                    + '            Active'
                                    + '        </a>';
                            }
                            
                            buttons += 
                                  '        <hr style="padding: 0;margin: 0;">'
                                + '        <a class="dropdown-item text-danger" href="javascript:;" onclick="fc_packagesDelete(\'' + arr[i]._id + '\');">'
                                + '            Delete'
                                + '        </a>'
                                + '    </div>'
                                + '</span>';
                            
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td data-label="Name">'
                                + '        <div class="d-flex py-1 align-items-center">'
                                //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                                + '            <div class="flex-fill">'
                                + '                <div class="font-weight-medium">' + arr[i]._name + '</div>'
                                + '                <div class="text-muted">' + arr[i]._description + '</div>'
                                + '            </div>'
                                + '        </div>'
                                + '    </td>'
                                //+ '    <td class="text-muted" data-label="Tipo">'
                                //+ '        ' + _type
                                //+ '    </td>'
                                + '    <td class="text-muted text-center" data-label="Amount / Income">'
                                + '        ' + amount + '<br />' + income
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Date">'
                                + '        ' + created_at
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Status">'
                                + '        ' + _status
                                + '    </td>'
                                + '    <td>'
                                + '        <div class="btn-list flex-nowrap">'
                                + '             <button type="button" class="btn btn-primary" onclick="View.openFormPackages(\'' + arr[i]._id + '\', \'edition\');">'
                                + '                 <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-pencil" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                + '                    <path d="M4 20h4l10.5 -10.5a1.5 1.5 0 0 0 -4 -4l-10.5 10.5v4"></path>'
                                + '                    <line x1="13.5" y1="6.5" x2="17.5" y2="10.5"></line>'
                                + '                 </svg>'
                                + '                 Edit'
                                + '             </button>'
                                +               buttons
                                + '        </div>'
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
                            + '                                 <th>History</th>'
                            //+ '                                 <th>Tipo</th>'
                            + '                                 <th class="text-center">Amount / Income</th>'
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
                        page__donations_model__loadClear();
                    }
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                page__donations_model__loadClear();
            }
        });
    }
    
    function page__donations_model__loadClear() {
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
    
    function fc_packagesSetStatus(_id, status) {
        alertOpen({
                title: "Confirm",
                text: "Set pack status?",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                $.ajax({
                    type: 'POST',
                    url: CFG__API_URL + CFG__API_VERSION + "/donations_model/"+_id+"/setStatus",
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    data: { status: status },
                    success: function(response) {
                        if (response.success === true) {
                            fc_donations_modelGetAll("*");
                        }
                    }
                });
            }
        );
    }
    
    function fc_packagesDelete(_id) {
        alertOpen({
                title: "Confirm",
                text: "Delete pack?<br /><b>Atenção:</b> The pack will be permanently deleted!",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                //$('.btn_register_tranfer').attr('disabled','disabled').html("Aguarde...")
				$.ajax({
                    type: 'DELETE',
                    url: CFG__API_URL + CFG__API_VERSION + "/donations_model/"+_id,
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    data: {},
                    success: function(response) {
                        if (response.success === true) {
                            fc_donations_modelGetAll("*");
                        } else {
                            showError(response.message);
                        }
                    }
                });
            }
        );
    }
    
    fc_donations_modelGetAll("*");
</script>
