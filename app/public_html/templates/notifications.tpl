<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Notifications
                </h2>
                <!--<div class="text-muted mt-1">1-18 of 413 people</div>-->
            </div>
            <!-- Page title actions -->
            <!--<div class="col-auto ms-auto d-print-none">
                <div class="d-flex">
                    <input type="search" class="form-control d-inline-block w-9 me-3" placeholder="Search user…" />
                    <a href="#" class="btn btn-primary">
                        <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
            <!--            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <line x1="12" y1="5" x2="12" y2="19" />
                            <line x1="5" y1="12" x2="19" y2="12" />
                        </svg>
                        New user
                    </a>
                </div>
            </div>-->
        </div>
    </div>
</div>
<div class="page-body">
    <!-- -->
</div>

<script>
    function fc_notificationsGetAll() {
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        $.ajax({
            type: "GET",
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/notifications",
            data: {
                /*read: false*/
                order: 'desc'
            },
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response){
                var arr = response.data;
                var itemsHTML = '';
                
                if (arr.length > 0) {
                    for (var i = 0; i < arr.length; i++) {
                        var currentObject = arr[i];
                        var _date = new Date(currentObject._created_at);
                        
                        //›› ` + formatDate(_date, 'dd/MM/yyyy h:m:s')
                        //f_notificationsSetRead(' + currentObject._id + ');
                        
                                            var badgeBg = '';
                        switch(currentObject._type) {
                            case "success":
                                badgeBg = 'bg-green';
                            break;
                            case "danger":
                                badgeBg = 'bg-red';
                            break;
                            case "warning":
                                badgeBg = 'bg-yellow';
                            break;
                            case "info":
                                badgeBg = 'bg-blue';
                            break;
                        }
                        
                        var readAnimated = '',
                            btnSetRead = '';
                        if (currentObject._read == false) {
                            readAnimated = 'status-dot-animated';
                            btnSetRead = '<a href="javascript:;" onclick="f_notificationsSetRead(\''+currentObject._id+'\');" class="text-body d-block" style="margin-top: 8px;">Marcar como lido</a>';
                        }
                        
                        itemsHTML += 
                              '<div class="list-group-item" id="notifications__' + currentObject._id + '">'
                            + '    <div class="row align-items-center">'
                            + '        <div class="col-auto"><span class="status-dot '+readAnimated+' '+badgeBg+' d-block"></span></div>'
                            + '        <div class="col text-truncate">'
                            //+ '            <a href="javascript:;" class="text-body d-block">' + currentObject._subject + '</a>'
                            + '            <span class="text-body d-block">' + currentObject._subject + '</span>'
                            + '            <div class="d-block text-muted text-truncate mt-n1">'
                            +                  currentObject._content
                            + '            </div>'
                            +              btnSetRead
                            + '        </div>'
                            //+ '        <div class="col-auto">'
                            //+ '            <a href="#" class="list-group-item-actions">'
                            //+ '                <svg xmlns="http://www.w3.org/2000/svg" class="icon text-muted" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            //+ '                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            //+ '                    <path d="M12 17.75l-6.172 3.245l1.179 -6.873l-5 -4.867l6.9 -1l3.086 -6.253l3.086 6.253l6.9 1l-5 4.867l1.179 6.873z"></path>'
                            //+ '                </svg>'
                            //+ '            </a>'
                            //+ '        </div>'
                            + '    </div>'
                            + '</div>';
                    }
                    
                    document.querySelector(".page-body").innerHTML = 
                          ' <div class="container-xl">'
                        + '     <div class="row row-cards">'
                        +           itemsHTML
                        + '     </div>'
                        + ' </div>';
                } else {
                    page__notifications__loadClear();
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                console.log(jsonResponse);
                page__notifications__loadClear();
            }
        });
    }
    
    function page__notifications__loadClear() {
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
    
    fc_notificationsGetAll();
</script>
