<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Network {{custom_settings.names.unilevel.name}}
                </h2>
            </div>
            
            <div class="col-auto ms-auto d-print-none">
                <div class="btn-list">
                    <!--
                    <div class="form-group" style="max-width: 240px;">
                              <div class="input-icon">
                                <input id="my_store__customers_q" name="my_store__customers_q" type="text" class="form-control" placeholder="Usuário, nome ou e-mail...">
                                <span class="input-icon-addon">
                                  <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><circle cx="10" cy="10" r="7"></circle><line x1="21" y1="21" x2="15" y2="15"></line></svg>
                                </span>
                              </div>
                              </div>
                              -->
                            <div class="form-group">
                        <div id="my_store__customers--btn-group" class="btn-group w-100">
                            <button type="button" class="btn btn-primary" data-tab="unilevel">Show matrix</button>
                            <button type="button" class="btn" data-tab="binary">Show binary matrix</button>
                            <button type="button" class="btn" data-tab="downline">Show downline</button>
                        </div>
                        <script>
                            if (typeof page__network__buttons === 'undefined') {
                                let page__network__buttons = document.querySelectorAll('#my_store__customers--btn-group .btn');
                                for(let i = 0; i<page__network__buttons.length; i++){
                                    page__network__buttons[i].addEventListener('click', () => {
                                        var btnLst = document.querySelectorAll('#my_store__customers--btn-group .btn');
                                        for(var i2 = 0; i2<btnLst.length; i2++){
                                            if (page__network__buttons[i].getAttribute("data-tab") == btnLst[i2].getAttribute("data-tab")) {
                                                page__network__buttons[i].classList.add("btn-primary");
                                            } else {
                                                btnLst[i2].classList.remove("btn-primary");
                                            }
                                        }
                                        
                                        if (page__network__buttons[i].getAttribute("data-tab") == "unilevel") {
                                            rootUserPath = '{{system.userdata._username}}';
                                            lastUserPath = '';
                                            arrUsersPath = [];
                                            
                                            fc_unilevelGetDownline('{{system.userdata._username}}');
                                        } else if (page__network__buttons[i].getAttribute("data-tab") == "binary") {
                                            rootUserPath = '{{system.userdata._username}}';
                                            lastUserPath = '';
                                            arrUsersPath = [];
                                            
                                            {{#if system.isadmin}}
                                                fc_unilevelGetDownlineBinary('officialaccount');
                                            {{else}}
                                                fc_unilevelGetDownlineBinary('{{system.userdata._username}}');
                                            {{/if}}
                                        } else {
                                            {{#if system.isadmin}}
                                                fc_unilevelGetDownlineGrid('officialaccount');
                                            {{else}}
                                                fc_unilevelGetDownlineGrid('{{system.userdata._username}}');
                                            {{/if}}
                                        }
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
    var rootUserPath = '{{system.userdata._username}}',
        lastUserPath = '',
        arrUsersPath = [];
    
    function fc_unilevelGetDownline(username){
        /** USERS PATH **/
        var userPathHTML = '';
        if (lastUserPath == username) {
            return;
        }
        
        lastUserPath = username;
        
        if (username == rootUserPath) {
            arrUsersPath = [];
            arrUsersPath.push(username);
        } else {
            var new__arrUsersPath = [],
                new__arrUserPathStop = false;
            
            arrUsersPath.push(username);
            
            for (var i = 0; i < arrUsersPath.length; i++) {
                if (new__arrUserPathStop == false) {
                    new__arrUsersPath.push(arrUsersPath[i]);
                }
                
                if (username == arrUsersPath[i]) {
                    new__arrUserPathStop = true;
                }
            }
            
            arrUsersPath = new__arrUsersPath;
        }
        
        userPathHTML += '<li class="breadcrumb-item">Network</li>';
        for (var i = 0; i < arrUsersPath.length; i++) {
            if (i == arrUsersPath.length-1) {
                userPathHTML += '<li class="breadcrumb-item active" aria-current="page"><a href="javascript:fc_unilevelGetDownline(\'' + arrUsersPath[i] + '\');">' + arrUsersPath[i] + '</a></li>';
            } else {
                userPathHTML += '<li class="breadcrumb-item"><a href="javascript:fc_unilevelGetDownline(\'' + arrUsersPath[i] + '\');">' + arrUsersPath[i] + '</a></li>';
            }
        }
        /** END **/
        
        
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        /**
        unilevelGetDownline({
            username: username,
            limit: 1000
        }).then(function (response) {
            var arr = response.unilevel__getDownline;
            var tbodyHTML = '';
            
            if (arr.length > 0) {
                for (var i = 0; i < arr.length; i++){
                    var directOpt = '';
                    if (arr[i].extra__data.count.direct > 0) {
                        directOpt = '<a class="btn primary" href="javascript:fc_unilevelGetDownline(\'' + arr[i]._username + '\');" style="margin-top: 3px;height: 28px;line-height: 28px;">ver +' + arr[i].extra__data.count.direct + '</a>';
                    }
                    
                    var people_Activation_status = null;
                    if (arr[i].network.active_until != undefined) {
                        var n1 = newActivationStatus2B(arr[i].network.active_until);
                        
                        if (n1[0] == false) {
                            var n2Days = '';
                            if (n1[1] >= 30) {
                                if (n1[1] > 365) {
                                    n2Days = ' há mais de um ano';
                                } else {
                                    n2Days = ' há '+n1[1]+' dias';
                                }
                            }
                            
                            people_Activation_status = '<span style="background: red;display: inline-block;padding: 3px 6px;border-radius: 4px;font-size: 14px;color: #fff;line-height: normal;margin-top: 4px;">Inativo' + n2Days + '</span>';
                        } else {
                            people_Activation_status = '<span style="background: green;display: inline-block;padding: 3px 6px;border-radius: 4px;font-size: 14px;color: #fff;line-height: normal;margin-top: 4px;">Ativo</span>';
                        }
                    }
                    
                    
                    var state = '',
                        city = '';
                    
                    if (arr[i].address != null) {
                        state = arr[i].address[0].state;
                        state = arr[i].address[0].city;
                    }
                    
                    tbodyHTML += 
                          '<tr>'
                        + '    <td data-label="Name">'
                        + '        <div class="d-flex py-1 align-items-center">'
                        //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                        + '            <div class="flex-fill">'
                        + '                <div class="font-weight-medium">' + arr[i]._name + '</div>'
                        + '                <div class="text-muted">' + arr[i]._username + '</div>'
                        + '                <div class="text-muted">' + formatMobilePhone(arr[i].contact.mobile_phone, arr[i]._country_phone_mask) + ' || ' + arr[i]._email + '</div>'
                        + '                <div class="text-muted">' + directOpt + '</div>'
                        + '            </div>'
                        + '        </div>'
                        + '    </td>'
                        + '    <td class="text-muted" data-label="Endereço">'
                        + '         <b>' + state + '</b><br />'
                        +           city
                        + '    </td>'
                        + '    <td class="text-muted" data-label="Plano">'
                        +           arr[i].extra__data.plan.name + '<br />'
                        + '         <b>' + arr[i].extra__data.graduation.name + '</b><br />'
                        +           arr[i].extra__data.prevision.graduation.name + '</b><br />'
                        +           people_Activation_status
                        + '    </td>'
                        + '    <td class="text-muted" data-label="Pontos">'
                        + '        <b>VGP: </b>' + arr[i].extra__data.prevision.ve / 100.00 + '<br />'
                        + '        <b>VE: </b>' + arr[i].extra__data.prevision.vme / 100.00 + '<br />'
                        + '        <b>VT: </b>' + arr[i].extra__data.prevision.vt / 100.00
                        + '    </td>'
                        + '    <td class="text-muted" data-label="Data">'
                        + '        ' + formatDate(new Date(arr[i].created_at), 'dd/MM/yyyy hh:mm:ss')
                        + '    </td>'
                        //+ '    <td>'
                        //+ '        <div class="btn-list flex-nowrap">'
                        //+ '            <a href="="javascript:OpenFile(\'/uploads/materials/' + type + '/' + response[i].filename + '\', \'' + response[i].contentType + '\');" class="btn btn-white">'
                        //+ '                Visualizar'
                        //+ '            </a>'
                        //+ '        </div>'
                        //+ '    </td>'
                        + '</tr>';
                    
                    //page__points___sum_points++;
                }
                
                document.querySelector(".page-body").innerHTML = 
                      ' <div class="container-xl">'
                    
                    + '     <div class="row row-cards">'
                    + '         <div class="col-12">'
                    + '             <ol class="breadcrumb breadcrumb-arrows" aria-label="breadcrumbs">'
                    +                   userPathHTML
                    + '             </ol>'
                    + '         </div>'
                    + '         <div class="col-12">'
                    + '             <div class="card">'
                    + '                 <div class="table-responsive">'
                    + '                     <table class="table table-vcenter table-mobile-md card-table">'
                    + '                         <thead>'
                    + '                             <tr>'
                    + '                                 <th>Dados do usuário</th>'
                    + '                                 <th>Local</th>'
                    + '                                 <th>Plano / Graduação / Qualificação</th>'
                    + '                                 <th>Pontuação unilevel</th>'
                    + '                                 <th>Data de cadastro</th>'
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
                page__unilevel__loadClear();
            }
        }).catch(function (error) {
            console.log(error);
            page__unilevel__loadClear();
        });
        **/
        
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/session/account/unilevel/"+username+"/downline",
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
                            var directOpt = '';
                            if (arr[i]._count_direct > 0) {
                                directOpt = '<a class="btn primary" href="javascript:fc_unilevelGetDownline(\'' + arr[i]._username + '\');" style="margin-top: 3px;height: 28px;line-height: 28px;">show +' + arr[i]._count_direct + '</a>';
                            }
                            
                            /**
                            var people_Activation_status = null;
                            if (arr[i].network.active_until != undefined) {
                                var n1 = newActivationStatus2B(arr[i].network.active_until);
                                
                                if (n1[0] == false) {
                                    var n2Days = '';
                                    if (n1[1] >= 30) {
                                        if (n1[1] > 365) {
                                            n2Days = ' há mais de um ano';
                                        } else {
                                            n2Days = ' há '+n1[1]+' dias';
                                        }
                                    }
                                    
                                    people_Activation_status = '<span style="background: red;display: inline-block;padding: 3px 6px;border-radius: 4px;font-size: 14px;color: #fff;line-height: normal;margin-top: 4px;">Inativo' + n2Days + '</span>';
                                } else {
                                    people_Activation_status = '<span style="background: green;display: inline-block;padding: 3px 6px;border-radius: 4px;font-size: 14px;color: #fff;line-height: normal;margin-top: 4px;">Ativo</span>';
                                }
                            }**/
                            
                            
                            //var state = arr[i]._address_state,
                            //    city = arr[i]._address_city,
                            var mobile_phone = '',
                                contact = '';
                                
                            if (typeof arr[i]._mobile_phone != "undefined" && arr[i]._mobile_phone != "") {
                                mobile_phone = formatMobilePhone(arr[i]._mobile_phone, arr[i]._country_phone_mask);
                                contact = mobile_phone + ' || ';
                            }
                            
                            contact += arr[i]._email
                            
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td data-label="Name">'
                                + '        <div class="d-flex py-1 align-items-center">'
                                //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                                + '            <div class="flex-fill">'
                                + '                <div class="font-weight-medium">' + arr[i]._name + '</div>'
                                + '                <div class="text-muted">' + arr[i]._username + '</div>'
                                + '                <div class="text-muted">' + contact + '</div>'
                                + '                <div class="text-muted">' + directOpt + '</div>'
                                + '            </div>'
                                + '        </div>'
                                + '    </td>'
                                //+ '    <td class="text-muted" data-label="Endereço">'
                                //+ '         <b>' + state + '</b><br />'
                                //+           city
                                //+ '    </td>'
                                + '    <td class="text-muted text-center" data-label="Licenses">'
                                //+           arr[i].extra__data.plan.name + '<br />'
                                //+ '         <b>' + arr[i].extra__data.graduation.name + '</b><br />'
                                //+           arr[i].extra__data.prevision.graduation.name + '</b><br />'
                                //+           people_Activation_status
                                + '         ¢ ' + arr[i]._count_contracts
                                + '    </td>'
                                //+ '    <td class="text-muted" data-label="Pontos">'
                                //+ '        <b>VGP: </b>' + arr[i].extra__data.prevision.ve / 100.00 + '<br />'
                                //+ '        <b>VE: </b>' + arr[i].extra__data.prevision.vme / 100.00 + '<br />'
                                //+ '        <b>VT: </b>' + arr[i].extra__data.prevision.vt / 100.00
                                //+ '    </td>'
                                + '    <td class="text-muted text-center" data-label="Date">'
                                + '        ' + formatDate(new Date(arr[i]._created_at), 'dd/MM/yyyy')
                                + '    </td>'
                                //+ '    <td>'
                                //+ '        <div class="btn-list flex-nowrap">'
                                //+ '            <a href="="javascript:OpenFile(\'/uploads/materials/' + type + '/' + response[i].filename + '\', \'' + response[i].contentType + '\');" class="btn btn-white">'
                                //+ '                Visualizar'
                                //+ '            </a>'
                                //+ '        </div>'
                                //+ '    </td>'
                                + '</tr>';
                            
                            //page__points___sum_points++;
                        }
                        
                        document.querySelector(".page-body").innerHTML = 
                              ' <div class="container-xl">'
                            
                            + '     <div class="row row-cards">'
                            + '         <div class="col-12">'
                            + '             <ol class="breadcrumb breadcrumb-arrows" aria-label="breadcrumbs">'
                            +                   userPathHTML
                            + '             </ol>'
                            + '         </div>'
                            + '         <div class="col-12">'
                            + '             <div class="card">'
                            + '                 <div class="table-responsive">'
                            + '                     <table class="table table-vcenter table-mobile-md card-table">'
                            + '                         <thead>'
                            + '                             <tr>'
                            + '                                 <th>User data</th>'
                            //+ '                                 <th>Local</th>'
                            + '                                 <th class="text-center">Licenses</th>'
                            //+ '                                 <th>Pontuação unilevel</th>'
                            + '                                 <th class="text-center">Registration</th>'
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
                        page__unilevel__loadClear();
                    }
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                page__unilevel__loadClear();
            }
        });
    }
    
    function fc_unilevelGetDownlineBinary(username){
        /** USERS PATH **/
        var userPathHTML = '';
        if (lastUserPath == username) {
            return;
        }
        
        lastUserPath = username;
        
        if (username == rootUserPath) {
            arrUsersPath = [];
            arrUsersPath.push(username);
        } else {
            var new__arrUsersPath = [],
                new__arrUserPathStop = false;
            
            arrUsersPath.push(username);
            
            for (var i = 0; i < arrUsersPath.length; i++) {
                if (new__arrUserPathStop == false) {
                    new__arrUsersPath.push(arrUsersPath[i]);
                }
                
                if (username == arrUsersPath[i]) {
                    new__arrUserPathStop = true;
                }
            }
            
            arrUsersPath = new__arrUsersPath;
        }
        
        userPathHTML += '<li class="breadcrumb-item">Network</li>';
        for (var i = 0; i < arrUsersPath.length; i++) {
            if (i == arrUsersPath.length-1) {
                userPathHTML += '<li class="breadcrumb-item active" aria-current="page"><a href="javascript:fc_unilevelGetDownlineBinary(\'' + arrUsersPath[i] + '\');">' + arrUsersPath[i] + '</a></li>';
            } else {
                userPathHTML += '<li class="breadcrumb-item"><a href="javascript:fc_unilevelGetDownlineBinary(\'' + arrUsersPath[i] + '\');">' + arrUsersPath[i] + '</a></li>';
            }
        }
        /** END **/
        
        
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/session/account/binary/"+username+"/downline",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var arr = response.data;
                    var tbodyHTML = ''
                        tbodyHTMLTree = '';
                    
                    if (arr.length > 0) {
                        for (var i = 0; i < arr.length; i++){
                            var directOpt = '',
                                directOptTree = '';
                                

                            if (arr[i]._count_direct > 0) {
                                if(arr[i]._active) {
                                    binaryStatus = '<span align="center" class="text-yellow">Active</span>';
                                } else {
                                    binaryStatus = '<span align="center" class="text-red">Inactive</span>';
                                }

                                if(arr[i]._receiving) {
                                    receivingStatus = '<span align="center" class="text-yellow">Qualified</span>';
                                } else {
                                    receivingStatus = '<span align="center" class="text-red">Unqualified</span>';
                                }

                                directOpt = '<a class="btn primary" href="javascript:fc_unilevelGetDownlineBinary(\'' + arr[i]._username + '\');" style="margin-top: 3px;height: 28px;line-height: 28px;">show +' + arr[i]._count_direct + '</a>';
                                directOptTree = binaryStatus + receivingStatus;
                                directOptTree += '<a id="opt--' + arr[i]._username + '" class="opt" href="javascript:fc_unilevelGetDownlineBinarySub(\'' + arr[i]._username + '\');">+' + arr[i]._count_direct + '</a>';
                                
                            }
                            
                            
                            //var state = arr[i]._address_state,
                            //    city = arr[i]._address_city,
                            var mobile_phone = '',
                                contact = '';
                                
                            if (typeof arr[i]._mobile_phone != "undefined" && arr[i]._mobile_phone != "") {
                                mobile_phone = formatMobilePhone(arr[i]._mobile_phone, arr[i]._country_phone_mask);
                                contact = mobile_phone + ' || ';
                            }
                            
                            contact += arr[i]._email
                            
                            var binary_side = '';
                            if (arr[i]._binary_side == 'left') {
                                binary_side = '&nbsp;&nbsp;<span class="badge" style="background: #974255!important;">Left</span>';
                            } else if (arr[i]._binary_side == 'right') {
                                binary_side = '&nbsp;&nbsp;<span class="badge" style="background: #4b40a3!important;">Right</span>';
                            }
                            
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td data-label="Name">'
                                + '        <div class="d-flex py-1 align-items-center">'
                                //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                                + '            <div class="flex-fill">'
                                + '                <div class="font-weight-medium">' + arr[i]._name + binary_side + '</div>'
                                + '                <div class="text-muted">' + arr[i]._username + '</div>'
                                + '                <div class="text-muted">' + contact + '</div>'
                                + '                <div class="text-muted">' + directOpt + '</div>'
                                + '            </div>'
                                + '        </div>'
                                + '    </td>'
                                //+ '    <td class="text-muted" data-label="Endereço">'
                                //+ '         <b>' + state + '</b><br />'
                                //+           city
                                //+ '    </td>'
                                + '    <td class="text-muted text-center" data-label="Licenses">'
                                //+           arr[i].extra__data.plan.name + '<br />'
                                //+ '         <b>' + arr[i].extra__data.graduation.name + '</b><br />'
                                //+           arr[i].extra__data.prevision.graduation.name + '</b><br />'
                                //+           people_Activation_status
                                + '         ¢ ' + arr[i]._count_contracts
                                + '    </td>'
                                //+ '    <td class="text-muted" data-label="Pontos">'
                                //+ '        <b>VGP: </b>' + arr[i].extra__data.prevision.ve / 100.00 + '<br />'
                                //+ '        <b>VE: </b>' + arr[i].extra__data.prevision.vme / 100.00 + '<br />'
                                //+ '        <b>VT: </b>' + arr[i].extra__data.prevision.vt / 100.00
                                //+ '    </td>'
                                + '    <td class="text-muted text-center" data-label="Date">'
                                + '        ' + formatDate(new Date(arr[i]._created_at), 'dd/MM/yyyy')
                                + '    </td>'
                                //+ '    <td>'
                                //+ '        <div class="btn-list flex-nowrap">'
                                //+ '            <a href="="javascript:OpenFile(\'/uploads/materials/' + type + '/' + response[i].filename + '\', \'' + response[i].contentType + '\');" class="btn btn-white">'
                                //+ '                Visualizar'
                                //+ '            </a>'
                                //+ '        </div>'
                                //+ '    </td>'
                                + '</tr>';
                            
                            if (arr[i]._binary_side == 'left') {
                                tbodyHTMLTree += 
                                      '<li id="tree--' + arr[i]._username + '">'
                                    + '    <div title="' + arr[i]._name + '">'
                                    + '        <span class="left" style="background: url(\'{{CFG__API_URL}}/d/uploads/accounts/'+arr[i]._id+'/profile/picture/'+arr[i]._picture_src+'\'), url(\'/assets/img/149071.png\') no-repeat;background-size: contain;"></span>'
                                    + '        <span class="left-sub">'
                                    + '            <span>' + arr[i]._name + '</span>'
                                    + '            <span>' + arr[i]._username + '</span>'
                                    +              directOptTree
                                    + '        </span>'
                                    + '    </div>'
                                    + '</li>';
                            } else if (arr[i]._binary_side == 'right') {
                                tbodyHTMLTree += 
                                      '<li id="tree--' + arr[i]._username + '">'
                                    + '    <div title="' + arr[i]._name + '">'
                                    + '        <span class="right" style="background: url(\'{{CFG__API_URL}}/d/uploads/accounts/'+arr[i]._id+'/profile/picture/'+arr[i]._picture_src+'\'), url(\'/assets/img/149071.png\') no-repeat;background-size: contain;"></span>'
                                    + '        <span class="right-sub">'
                                    + '            <span>' + arr[i]._name + '</span>'
                                    + '            <span>' + arr[i]._username + '</span>'
                                    +              directOptTree
                                    + '        </span>'
                                    + '    </div>'
                                    + '</li>';
                            }
                                
                                /**`       <li>
                                            <div><span class="right">Joe Mighty 1601</span></div>
                                        </li>
                                        <li>
                                            <div><!--<span class="spacer"></span>--><span class="right"><span>-NAME-</span><span>-USERNAME-</span></span></div>
                                            <ul>
                                                <li>
                                                    <div></span><span class="left">Lily Sight 1633</span></div>
                                                    <ul>
                                                        <li>
                                                            <div><span class="left">Brie Snow 1653</span></div>
                                                        </li>
                                                        <li>
                                                            <div><span class="right">Ralf Snow 1651</span></div>
                                                        </li>
                                                    </ul>
                                                </li>
                                                <li>
                                                    <div><span class="right">John Snow 1635</span></div>
                                                </li>
                                            </ul>
                                        </li>`;*/
                            
                            //page__points___sum_points++;
                        }
                        
                        document.querySelector(".page-body").innerHTML = 
                              ' <div class="container-xl">'
                            
                            + '     <div class="row row-cards">'
                            + '         <div class="col-12">'
                            + '         <div class="row">'
                            + '             <div class="col-10">'
                            + '                 <ol id="binaryBreadcrumb" class="breadcrumb breadcrumb-arrows" aria-label="breadcrumbs">'
                            +                       userPathHTML
                            + '                 </ol>'
                            + '             </div>'
                            + '             <div class="col-2">'
                            
                            + '<div class="/*mb-3*/">'
                            //+ '    <div class="form-label">Modo</div>'
                            + '    <div>'
                            + '        <label class="form-check form-check-inline">'
                            + '            <input class="form-check-input" type="radio" name="radioBinaryMode" onchange="setBinaryMode(\'list\');" checked=" />'
                            + '            <span class="form-check-label">List</span>'
                            + '        </label>'
                            + '        <label class="form-check form-check-inline">'
                            + '            <input class="form-check-input" type="radio" name="radioBinaryMode" onchange="setBinaryMode(\'tree\');" />'
                            + '            <span class="form-check-label">Tree</span>'
                            + '        </label>'
                            + '    </div>'
                            + '</div>'
                            
                            + '             </div>'
                            + '         </div>'
                            + '         </div>'
                            + '         <div id="bodyHTMLList" class="col-12">'
                            + '             <div class="card">'
                            + '                 <div class="table-responsive">'
                            + '                     <table class="table table-vcenter table-mobile-md card-table">'
                            + '                         <thead>'
                            + '                             <tr>'
                            + '                                 <th>User data</th>'
                            //+ '                                 <th>Local</th>'
                            + '                                 <th class="text-center">Licenses</th>'
                            //+ '                                 <th>Pontuação unilevel</th>'
                            + '                                 <th class="text-center">Registration</th>'
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
                            + '         <div id="bodyHTMLTree" class="col-12" style="display: none;">'
                            + '             <div id="bodyHTMLTreeStartUl" class="tree" style="overflow: auto;width: max-content;">'
                            + '                 <ul>'
                            +                       tbodyHTMLTree
                            + '                 </ul>'
                            + '             </div>'
                            + '         </div>'
                            + '     </div>'
                            + ' </div>';
                    } else {
                        page__unilevel__loadClear();
                    }
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                page__unilevel__loadClear();
            }
        });
    }
    
    function fc_unilevelGetDownlineBinarySub(username){
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/session/account/binary/"+username+"/downline",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var arr = response.data;
                    var tbodyHTMLTree = '';
                    
                    if (arr.length > 0) {
                        tbodyHTMLTree += '<ul>';
                        
                        for (var i = 0; i < arr.length; i++){
                            var directOptTree = '';
                            if (arr[i]._count_direct > 0) {
                                directOptTree = '<a id="opt--' + arr[i]._username + '" class="opt" href="javascript:fc_unilevelGetDownlineBinarySub(\'' + arr[i]._username + '\');">+' + arr[i]._count_direct + '</a>';
                            }
                            
                            
                            var binary_side = '';
                            if (arr[i]._binary_side == 'left') {
                                binary_side = '&nbsp;&nbsp;<span class="badge" style="background: #974255!important;">Left</span>';
                            } else if (arr[i]._binary_side == 'right') {
                                binary_side = '&nbsp;&nbsp;<span class="badge" style="background: #4b40a3!important;">Right</span>';
                            }
                            
                            if (arr[i]._binary_side == 'left') {

                                if(arr[i]._active) {
                                    binaryStatus = '<span align="center" class="text-yellow">Active</span>';
                                } else {
                                    binaryStatus = '<span align="center" class="text-red">Inactive</span>';
                                }

                                if(arr[i]._receiving) {
                                    receivingStatus = '<span align="center" class="text-yellow">Qualified</span>';
                                } else {
                                    receivingStatus = '<span align="center" class="text-red">Unqualified</span>';
                                }

                                tbodyHTMLTree += 
                                      '<li id="tree--' + arr[i]._username + '">'
                                    + '    <div title="' + arr[i]._name + '">'
                                    + '        <span class="left" style="background: url(\'{{CFG__API_URL}}/d/uploads/accounts/'+arr[i]._id+'/profile/picture/'+arr[i]._picture_src+'\'), url(\'/assets/img/149071.png\') no-repeat;background-size: contain;"></span>'
                                    + '        <span class="left-sub">'
                                    + '            <span>' + arr[i]._name + '</span>'
                                    + '            <span>' + arr[i]._username + '</span>'
                                    +              binaryStatus + receivingStatus
                                    +              directOptTree
                                    + '        </span>'
                                    + '    </div>'
                                    + '</li>';
                            } else if (arr[i]._binary_side == 'right') {
                                tbodyHTMLTree += 
                                      '<li id="tree--' + arr[i]._username + '">'
                                    + '    <div title="' + arr[i]._name + '">'
                                    + '        <span class="right" style="background: url(\'{{CFG__API_URL}}/d/uploads/accounts/'+arr[i]._id+'/profile/picture/'+arr[i]._picture_src+'\'), url(\'/assets/img/149071.png\') no-repeat;background-size: contain;"></span>'
                                    + '        <span class="right-sub">'
                                    + '            <span>' + arr[i]._name + '</span>'
                                    + '            <span>' + arr[i]._username + '</span>'
                                    +               binaryStatus + receivingStatus
                                    +              directOptTree
                                    + '        </span>'
                                    + '    </div>'
                                    + '</li>';
                            }
                        }
                        
                        tbodyHTMLTree += '</ul>';
                        
                        document.getElementById("opt--"+username).innerHTML = '-'+arr.length;
                        document.getElementById("opt--"+username).href = 'javascript:fc_unilevelGetDownlineBinarySubRemove(\''+username+'\', '+arr.length+');';
                        document.getElementById("tree--"+username).innerHTML += tbodyHTMLTree;
                    }
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                console.log(jsonResponse);
            }
        });
    }
    
    function fc_unilevelGetDownlineBinarySubRemove(username, qtd) {
        document.getElementById("opt--"+username).innerHTML = '+'+qtd;
        document.getElementById("opt--"+username).href = 'javascript:fc_unilevelGetDownlineBinarySub(\''+username+'\');';
        document.querySelector("#tree--"+username+" ul").remove();
    }
    
    function setBinaryMode(mode) {
        if (mode == "list") {
            document.getElementById("binaryBreadcrumb").style.display = 'flex';
            document.getElementById("bodyHTMLList").style.display = 'block';
            document.getElementById("bodyHTMLTree").style.display = 'none';
        } else {
            document.getElementById("binaryBreadcrumb").style.display = 'none';
            document.getElementById("bodyHTMLList").style.display = 'none';
            document.getElementById("bodyHTMLTree").style.display = 'block';
        }
    }
    
    function fc_unilevelGetDownlineGrid(username){
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/session/account/unilevel/"+username+"/downline/grid",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var arr = response.data;
                    var tbodyHTML = '';
                    var page__unilevel_downline___sum_active = 0,
                        page__unilevel_downline___sum_inactive = 0,
                        page__unilevel_downline___sum_total = 0;
                    
                    if (arr.length > 0) {
                        for (var i = 0; i < arr.length; i++){
                            var name = 'st';
                            if (i > 1) {
                                name = 'nd';
                            }
                            
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td data-label="Name">'
                                + '        <div class="d-flex py-1 align-items-center">'
                                //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                                + '            <div class="flex-fill">'
                                + '                <div class="font-weight-medium"><b>' + (i+1) + name + ' <sup style="display: none;">' + i+1 + '</sup></b></div>'
                                //+ '                <div class="text-muted">Este pedido contém <b>' + items_count + '</b> item(s)<br />' + shippingWithdrawalStr + '</div>'
                                + '            </div>'
                                + '        </div>'
                                + '    </td>'
                                + '    <td class="text-muted text-center" data-label="Total">'
                                + '        ' + arr[i][i+1]
                                + '    </td>'
                                //+ '    <td>'
                                //+ '        <div class="btn-list flex-nowrap">'
                                //+ '            <a href="="javascript:OpenFile(\'/uploads/materials/' + type + '/' + response[i].filename + '\', \'' + response[i].contentType + '\');" class="btn btn-white">'
                                //+ '                Visualizar'
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
                            + '                                 <th>Downline</th>'
                            + '                                 <th class="text-center">Total</th>'
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
                        //page__unilevel_downline__loadClear();
                        page__unilevel__loadClear();
                    }
                    
                    //document.getElementById("page__unilevel_downline___sum_active").innerHTML = arr.count.active;
                    //document.getElementById("page__unilevel_downline___sum_inactive").innerHTML = arr.count.inactive;
                    //document.getElementById("page__unilevel_downline___sum_total").innerHTML = arr.count.total;
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                //page__unilevel_downline__loadClear();
                page__unilevel__loadClear();
            }
        });
        
        document.querySelector(".page-body").innerHTML = 
              ' <div class="container-xl">'
            + '     <div class="row row-cards">'
            + '         <div class="col-12">'
            + '             <ol class="breadcrumb breadcrumb-arrows" aria-label="breadcrumbs">'
            + '                 <li class="breadcrumb-item">Downline</li>'
            + '                 <li class="breadcrumb-item active" aria-current="page">{{system.userdata._username}}</li>'
            + '             </ol>'
            + '         </div>'
            + '         <div class="col-12">'
            + '             <div class="card">'
            + '                 <div class="table-responsive">'
            + '                     <table class="table table-vcenter table-mobile-md card-table">'
            + '                         <thead>'
            + '                             <tr>'
            + '                                 <th>Downline</th>'
            //+ '                                 <th>Ativos</th>'
            //+ '                                 <th>Inativos</th>'
            + '                                 <th>Registration</th>'
            //+ '                                 <th class="w-1"></th>'
            + '                             </tr>'
            + '                         </thead>'
            + '                         <tbody>'
            //+                               tbodyHTML                                
            + '                         </tbody>'
            + '                     </table>'
            + '                 </div>'
            + '             </div>'
            + '         </div>'
            + '     </div>'
            + ' </div>';
    }
    
    function page__unilevel__loadClear() {
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
        fc_unilevelGetDownline('officialaccount');
    {{else}}
        fc_unilevelGetDownline('{{system.userdata._username}}');
    {{/if}}
</script>
