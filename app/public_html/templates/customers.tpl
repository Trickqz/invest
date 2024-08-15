<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Members
                </h2>
            </div>

            <div class="col-auto ms-auto d-print-none">
                <div class="btn-list">
                    <div class="form-group" style="max-width: 240px;">
                              <div class="input-icon">
                                <input id="my_store__customers_q" name="my_store__customers_q" type="text" class="form-control" placeholder="Username, name or email...">
                                <span class="input-icon-addon">
                                  <!-- Download SVG icon from http://tabler-icons.io/i/search -->
                                  <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><circle cx="10" cy="10" r="7"></circle><line x1="21" y1="21" x2="15" y2="15"></line></svg>
                                </span>
                              </div>
                              </div>
                            <div class="form-group">
                        <div id="my_store__customers--btn-group" class="btn-group w-100">
                            <!-- 'pending_approval','active','suspended_by_admin','automatically_suspended' -->
                            <button type="button" class="btn btn-primary" data-tab="*">All</button>
                            <button type="button" class="btn" data-tab="active">Active</button>
                            <button type="button" class="btn" data-tab="suspended_by_admin">Suspended</button>
                            <button type="button" class="btn" data-tab="kyc">KYC Pending</button>
                            <!--<button type="button" class="btn" data-tab="automatically_suspended">Suspendido <sup>auto</sup></button>-->
                        </div>
                        <script>
                            if (typeof page__my_store__customers__buttons === 'undefined') {
                                let page__my_store__customers__buttons = document.querySelectorAll('#my_store__customers--btn-group .btn');
                                for(let i = 0; i<page__my_store__customers__buttons.length; i++){
                                    page__my_store__customers__buttons[i].addEventListener('click', () => {
                                        var btnLst = document.querySelectorAll('#my_store__customers--btn-group .btn');
                                        for(var i2 = 0; i2<btnLst.length; i2++){
                                            if (page__my_store__customers__buttons[i].getAttribute("data-tab") == btnLst[i2].getAttribute("data-tab")) {
                                                page__my_store__customers__buttons[i].classList.add("btn-primary");
                                            } else {
                                                btnLst[i2].classList.remove("btn-primary");
                                            }
                                        }
                                        
                                        fc__customersGetAll(page__my_store__customers__buttons[i].getAttribute("data-tab"));
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
    var elQ = document.getElementById("my_store__customers_q");
    //var elStatus = document.getElementById("my_store__customers_status");
    var my_store__customersStatus = "*";
    var my_store__customersAfter = 0;
    
    function fc__customersGetAll(status = "", listType, after = 0){

        var search_q = {
            limit: 8
        };
        
        if (after != null) {
            my_store__customersAfter = after;
        } else {
            my_store__customersAfter = 0;
        }
        
        if (elQ.value != "") {
            search_q['q'] = elQ.value;
        }
        
        /*if (elStatus.value != "") {
            search_q['status'] = elStatus.value;
        }*/
        
        if (status != "") my_store__customersStatus = status;
        if (my_store__customersStatus != "*") search_q['status'] = my_store__customersStatus;
        
        
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        
        /**
        my_store__customersGetAll__singleList(
            search_q
        ).then(function (response) {
            var arr = response.my_store__customers_getAll;
            var tbodyHTML = '';
            
            if (arr.length > 0) {
                for (var i = 0; i < arr.length; i++){
                    /*var id = arr[i]._id,
                        //date = formatDate(new Date(arr[i].created_at), 'dd/MM/yyyy hh:mm:ss'),
                        date = formatDate(new Date(arr[i].created_at), 'dd/MM/yyyy'),
                        shippingWithdrawalStr = "Retirada dos produtos não definida", //formatWalletType(arr[i].type),
                        amount = fmtMoney(arr[i].amount),
                        shipping_cost = '',
                        items_count = arr[i].purchase_details.items_count,
                        cancelInvoice = '',
                        payInvoice = '',
                        payment_provider = commerce__formatInvoicesPayment_provider(arr[i].transaction.payment_provider),
                        status = commerce__formatInvoicesStatus(arr[i].status);
                    
                    switch(arr[i].status){
                        case "waiting":
                            payInvoice = '<button type="button" class="btn success" onclick="Controller.my_store__customersPay(\'' + arr[i].code + '\');"><i class="now-ui-icons business_money-coins"></i>&nbsp;Pagar</button>';
                            cancelInvoice = '<button type="button" class="btn danger" onclick="Controller.my_store__customersCancel(\'' + id + '\', \'' + arr[i].code + '\');"><i class="now-ui-icons ui-1_simple-remove"></i>&nbsp;Cancelar</button>';
                            page__my_store__customers___sum_waiting += arr[i].amount;
                        break;
                        case "paid":
                            page__my_store__customers___sum_paid += arr[i].amount;
                        break;
                    }
                    
                    if (arr[i].status != "paid") {
                        payment_provider = "*";
                    }
                    
                    switch (arr[i].type){
                        case "adhesion":
                            shippingWithdrawalStr = "Adesão";
                        break;
                        case "activation":
                            shippingWithdrawalStr = "Ativação";
                        break;
                        case "purchase":
                            shippingWithdrawalStr = "Compra de produtos";
                        break;
                    }
                    
                    if (arr[i].shipping.cost > 0) {
                        shipping_cost = '<br /><span style="font-weight: normal;">Frete: ' + numberToRealHtml(arr[i].shipping.cost);
                    }*/
                    
              /**
                    var doc = '<span class="badge">Não informado</span>';
                    if (arr[i].type == 'natural_person') {
                        if (arr[i].profile.docs.cpf != null) {
                            doc = Inputmask.format(arr[i].profile.docs.cpf, { mask: "999.999.999-99" });
                        }
                    } else if (arr[i].type == 'legal_person') {
                        if (arr[i].profile.docs.cnpj != null) {
                            doc = Inputmask.format(arr[i].profile.docs.cnpj, { mask: "99.999.999/9999-99" });
                        }
                    } else if (arr[i].type == 'foreign') {
                        doc = 'Extrangeiro';
                    }
                    
                    tbodyHTML += 
                          '<tr>'
                        + '    <td data-label="Name">'
                        + '        <div class="d-flex py-1 align-items-center">'
                        //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                        + '            <div class="flex-fill">'
                        + '                <div class="font-weight-medium">' + arr[i]._name + '</div>'
                        + '                <div class="text-muted">' + arr[i]._username + '<br />' + Inputmask.format(arr[i].contact.mobile_phone, { mask: "(99) 99999-9999" }) + ' | <a href="mailto:' + arr[i]._email + '">' + arr[i]._email + '</a></div>'
                        + '            </div>'
                        + '        </div>'
                        + '    </td>'
                        + '    <td class="text-muted" data-label="DOC">'
                        + '        ' + doc
                        + '    </td>'
                        + '    <td class="text-muted" data-label="Data">'
                        + '        ' + formatDate(new Date(arr[i].created_at), 'dd/MM/yyyy')
                        + '    </td>'
                        + '    <td class="text-muted" data-label="Status">'
                        + '        ' + commerce__formatAccountStatus(arr[i].status)
                        + '    </td>'
                        + '    <td>'
                        + '        <div class="btn-list flex-nowrap">'
                        + '             <button type="button" class="btn btn-primary" onclick="View.openFormCustomer(\'' + arr[i]._username + '\');">'
                        + '                 <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-search" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                        + '                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                        + '                    <circle cx="10" cy="10" r="7"></circle>'
                        + '                    <line x1="21" y1="21" x2="15" y2="15"></line>'
                        + '                 </svg>'
                        + '                 Ver perfil'
                        + '             </button>'
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
                    + '                                 <th>Cliente</th>'
                    + '                                 <th>CPF / CNPJ</th>'
                    + '                                 <th>Cadastro</th>'
                    + '                                 <th>Status</th>'
                    + '                                 <th class="w-1"></th>'
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
                page__my_store__customers__loadClear();
            }
        }).catch(function (error) {
            console.log(error);
            page__my_store__customers__loadClear();
        });
        **/
        
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/accounts?q="+elQ.value+"&status="+status+"&limit="+search_q.limit+"&after="+my_store__customersAfter,
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            data: {},
            success: function(response) {
                /**
                if (response.success === true) {
                    document.getElementById('page__accounts___list').innerHTML = '';
                    
                    var arr = response.data;
                    $('#page__accounts___list').empty();
                    
                    for (var i = 0; i < arr.length; i++) {
                        var currentObject = arr[i];
                        var _date = new Date(currentObject._created_at);
                        var accountType = '';
                        
                        
                        var accountStatus = '';
                        var setChatBanned = '';
                        var setStatus = '';
                        var setCompanies = '';
                        
                        if (currentObject._role === "administrator") {
                            accountType = "Administrador";
                        } else {
                            accountType = "Usuário";
                        }
                        
                        if (currentObject._status === "active") {
                            accountStatus = '<span class="badge success">Ativo</span>';
                            setStatus = '<a class="dropdown-item" href="javascript:;" onclick="fc_accountsSetStatus(\'' + currentObject._id + '\', \'suspended_by_admin\');">Desabilitar</a>';
                        } else if (currentObject._status === "suspended_by_admin") {
                            accountStatus = '<span class="badge canceled">Suspendido<br /><span style="font-size: 11px;">ADM</span></span>';
                            setStatus = '<a class="dropdown-item" href="javascript:;" onclick="fc_accountsSetStatus(\'' + currentObject._id + '\', \'active\');">Halibitar</a>';
                        } else if (currentObject._status === "automatically_suspended") {
                            accountStatus = '<span class="badge canceled">Suspendido<br /><span style="font-size: 11px;">SISTEMA</span></span>';
                            setStatus = '<a class="dropdown-item" href="javascript:;" onclick="fc_accountsSetStatus(\'' + currentObject._id + '\', \'active\');">Habilitar</a>';
                        }
                        
                        if (currentObject._chat_banned === "true") {
                            setChatBanned = '<a class="dropdown-item" href="javascript:;" onclick="fc_accountsSetChatBanned(\'' + currentObject._id + '\', \'false\');">Habilitar no chat</a>';
                        } else if (currentObject._chat_banned === "false") {
                            setChatBanned = '<a class="dropdown-item text-danger" href="javascript:;" onclick="fc_accountsSetChatBanned(\'' + currentObject._id + '\', \'true\');">Bloquear no chat</a>';
                        }
                        
                        var options = "";
                        if (currentObject._role != "developer" && currentObject._role != "administrator") {
                            options = '&nbsp;&nbsp;|&nbsp;&nbsp;<a href="<?=$ini['APP_URL']?>/criar-conta/' + currentObject._username + '" target="_blank">Criar conta*</a>';
                        }
                        
                        if (currentObject._role == "developer" || currentObject._role == "administrator") {
                            setCompanies = '<a class="dropdown-item" href="javascript:;" onclick="fc_accountsCompaniesOpen(\'' + currentObject._id + '\', \'' + currentObject._username + '\', \'' + currentObject._name + '\');">Alterar empresa</a>';
                        }
                        
                        $('#page__accounts___list').append(`
                                <tr id="page__accounts___list__` + currentObject._id + `">
                                    <td style="width: 50px;padding-right: 2px;">
                                        <img src="<?=$ini['APP_URL']?>/uploads/accounts/img/` + currentObject._id + `.jpg" onerror="this.src='<?=$ini['APP_ADMIN_URL']?>/assets/img/theme/default-user.png';" height="40" class="thumbnail img-circle">
                                    </td>
                                    <th scope="row">
                                      <div class="media align-items-center">
                                        <!--<span class="avatar rounded-circle mr-3">
                                          <img alt="Image placeholder" src="./assets/img/theme/bootstrap.jpg">
                                          <i class="ni ni-notification-70"></i>
                                        </span>-->
                                        <div class="media-body">
                                          <a href="javascript:;" onclick="fc_accountsOpen('` + currentObject._id + `');">
                                            <span class="mb-0 text-sm">` + currentObject._name + `</span>
                                          </a>
                                          <br />
                                          <span><a href="mailto:` + currentObject._email + `">` + currentObject._email + `</a></span>
                                          <br />
                                          <span>` + currentObject._username + options + `</span>
                                        </div>
                                      </div>
                                    </th>
                                    <td class="text-center">
                                      ` + accountType + `
                                    </td>
                                    <td class="text-center">
                                      ` + formatDate(_date, 'dd/MM/yyyy hh:mm:ss') + `
                                    </td>
                                    <td class="text-center">
                                      ` + accountStatus + `
                                    </td>
                                    <td class="text-right">
                                      <div class="dropdown">
                                        <a class="btn btn-sm btn-icon-only text-light dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                          <i class="fa fa-ellipsis-v"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                                          <a class="dropdown-item" href="javascript:;" onclick="fc_accountsOpen('` + currentObject._id + `');">Editar</a>
                                          <hr style="margin-top: 0;margin-bottom: 0;">
                                          <!--<a class="dropdown-item text-success" href="javascript:;" onclick="fc_accountsAccess('` + currentObject._username + `');">ACESSAR CONTA</a>-->
                                          ` + setCompanies + `
                                          <a class="dropdown-item" href="javascript:;" onclick="fc_accountsPasswordOpen('` + currentObject._username + `', '` + currentObject._name + `');">Alterar senha</a>
                                          <!--<hr style="margin-top: 0;margin-bottom: 0;">
                                          ` + setChatBanned + `-->
                                          <hr style="margin-top: 0;margin-bottom: 0;">
                                          ` + setStatus + `
                                          <a class="dropdown-item text-danger" href="javascript:;" onclick="fc_accountsDelete('` + currentObject._id + `');">Excluir</a>
                                        </div>
                                      </div>
                                    </td>
                                </tr>
                            `);
                    }
                }
                **/
                
                var arr = response.data;
                var tbodyHTML = '';
                
                if (arr.length > 0) {
                    for (var i = 0; i < arr.length; i++){
                        /*var id = arr[i]._id,
                            //date = formatDate(new Date(arr[i].created_at), 'dd/MM/yyyy hh:mm:ss'),
                            date = formatDate(new Date(arr[i].created_at), 'dd/MM/yyyy'),
                            shippingWithdrawalStr = "Retirada dos produtos não definida", //formatWalletType(arr[i].type),
                            amount = fmtMoney(arr[i].amount),
                            shipping_cost = '',
                            items_count = arr[i].purchase_details.items_count,
                            cancelInvoice = '',
                            payInvoice = '',
                            payment_provider = commerce__formatInvoicesPayment_provider(arr[i].transaction.payment_provider),
                            status = commerce__formatInvoicesStatus(arr[i].status);
                        
                        switch(arr[i].status){
                            case "waiting":
                                payInvoice = '<button type="button" class="btn success" onclick="Controller.my_store__customersPay(\'' + arr[i].code + '\');"><i class="now-ui-icons business_money-coins"></i>&nbsp;Pagar</button>';
                                cancelInvoice = '<button type="button" class="btn danger" onclick="Controller.my_store__customersCancel(\'' + id + '\', \'' + arr[i].code + '\');"><i class="now-ui-icons ui-1_simple-remove"></i>&nbsp;Cancelar</button>';
                                page__my_store__customers___sum_waiting += arr[i].amount;
                            break;
                            case "paid":
                                page__my_store__customers___sum_paid += arr[i].amount;
                            break;
                        }
                        
                        if (arr[i].status != "paid") {
                            payment_provider = "*";
                        }
                        
                        switch (arr[i].type){
                            case "adhesion":
                                shippingWithdrawalStr = "Adesão";
                            break;
                            case "activation":
                                shippingWithdrawalStr = "Ativação";
                            break;
                            case "purchase":
                                shippingWithdrawalStr = "Compra de produtos";
                            break;
                        }
                        
                        if (arr[i].shipping.cost > 0) {
                            shipping_cost = '<br /><span style="font-weight: normal;">Frete: ' + numberToRealHtml(arr[i].shipping.cost);
                        }*/
                        
                        var doc = '<span class="badge">Não informado</span>';
                        if (arr[i]._type == 'natural_person') {
                            if (arr[i]._cpf != null && arr[i]._cpf != '') {
                                doc = Inputmask.format(arr[i]._cpf, { mask: "999.999.999-99" });
                            }
                        } else if (arr[i]._type == 'legal_person') {
                            if (arr[i]._cnpj != null && arr[i]._cnpj != '') {
                                doc = Inputmask.format(arr[i]._cnpj, { mask: "99.999.999/9999-99" });
                            }
                        } else if (arr[i]._type == 'foreign') {
                            doc = 'Extrangeiro';
                        }
                        
                        var phone = '';
                        if (arr[i]._mobile_phone != null && arr[i]._mobile_phone != '') {
                            //phone = Inputmask.format(arr[i]._mobile_phone, { mask: "(99) 99999-9999" }) + ' | ';
                            phone = formatMobilePhone(arr[i]._mobile_phone, arr[i]._country_phone_mask) + ' | ';
                        }
                        
                        var buttons = '';
                        
                        buttons = 
                                '<span class="dropdown">'
                              + '    <button class="btn dropdown-toggle align-text-top" data-bs-boundary="viewport" data-bs-toggle="dropdown" aria-expanded="false">Actions</button>'
                              + '    <div class="dropdown-menu dropdown-menu-end" style="">'
                              + '        <a class="dropdown-item" href="javascript:;" onclick="View.openFormCustomer(\'' + arr[i]._id + '\');">'
                              + '            View profile'
                              + '        </a>'
                              + '        <hr style="padding: 0;margin: 0;">'
                              + '        <a class="dropdown-item" href="javascript:;" onclick="fc_customersWalletCreditOpen(\'' + arr[i]._id + '\', \'' + arr[i]._username + '\');">'
                              + '            Credit money'
                              + '        </a>'
                              + '        <a class="dropdown-item" href="javascript:;" onclick="fc_customersWalletDebitOpen(\'' + arr[i]._id + '\', \'' + arr[i]._username + '\');">'
                              + '            Debit money'
                              + '        </a>'
                              + '        <hr style="padding: 0;margin: 0;">'
                              + '        <a class="dropdown-item" href="javascript:;" onclick="fc_customersPasswordOpen(\'' + arr[i]._username + '\', \'' + arr[i]._name + '\');">'
                              + '            Change password'
                              + '        </a>'
                              + '        <a class="dropdown-item" href="javascript:;" onclick="fc_customersValidationOpen(\'' + arr[i]._id + '\');">'
                              + '            Account validation'
                              + '        </a>'
                              + '        <hr style="padding: 0;margin: 0;">';
                        
                        if (arr[i]._status == "suspended_by_admin" || arr[i]._status == "automatically_suspended") {
                            buttons += 
                                '        <a class="dropdown-item" href="javascript:;" onclick="fc_customersSetStatus(\'' + arr[i]._id + '\', \'active\');">'
                              + '            Enable account'
                              + '        </a>';
                        } else {
                            buttons += 
                                '        <a class="dropdown-item" href="javascript:;" onclick="fc_customersAccess(\'' + arr[i]._username + '\');">'
                              + '            Access'
                              + '        </a>'
                              + '        <a class="dropdown-item" href="javascript:;" onclick="fc_customersSetStatus(\'' + arr[i]._id + '\', \'suspended_by_admin\');">'
                              + '            Block account'
                              + '        </a>';
                        }
                        
                        buttons += 
                                '        <hr style="padding: 0;margin: 0;">'
                              + '        <a class="dropdown-item text-danger" href="javascript:;" onclick="fc_customersDelete(\'' + arr[i]._id + '\');">'
                              + '            Delete account'
                              + '        </a>'
                              + '    </div>'
                              + '</span>';
                        
                        var joker = '';
                        if (arr[i]._joker_account == true) {
                            joker = 
                                  '<span title="Joker account" style="display: inline-block;margin-bottom: 2px;">'
                                + '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-trophy" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                + '   <line x1="8" y1="21" x2="16" y2="21"></line>'
                                + '   <line x1="12" y1="17" x2="12" y2="21"></line>'
                                + '   <line x1="7" y1="4" x2="17" y2="4"></line>'
                                + '   <path d="M17 4v8a5 5 0 0 1 -10 0v-8"></path>'
                                + '   <circle cx="5" cy="9" r="2"></circle>'
                                + '   <circle cx="19" cy="9" r="2"></circle>'
                                + '</svg>'
                                + '</span>'
                                + '</br>';
                        }
                        
                        var verification_status = '';
                        switch(arr[i]._verification_status){
                            case 'waiting':
                                verification_status = '<span class="badge bg-yellow">Waiting</span>';
                            break;
                            case 'validating':
                                verification_status = '<span class="badge bg-yellow">Validating</span>';
                            break;
                            case 'invalidated':
                                verification_status = '<span class="badge bg-red">Invalidated</span>';
                            break;
                            case 'validated':
                                verification_status = '<span class="badge bg-green">Validated</span>';
                            break;
                        }
                        
                        /** **/
                        var binaryStatus = '<span class="text-red d-inline-flex align-items-center lh-1">Inactive</span>';
                        if (arr[i].extra__data.binary.active == true) {
                            binaryStatus = '<span class="text-yellow d-inline-flex align-items-center lh-1">Active</span>';
                        }
                        
                        binaryStatus += '&nbsp;//&nbsp;';
                        
                        if (arr[i].extra__data.binary.receiving == true) {
                            binaryStatus += '<span class="text-yellow d-inline-flex align-items-center lh-1">qualified</span>';
                        } else {
                            binaryStatus += '<span class="text-red d-inline-flex align-items-center lh-1">unqualified</span>';
                        }
                        /** **/
                        
                        tbodyHTML += 
                              '<tr>'
                            + '    <td data-label="Name">'
                            + '        <div class="d-flex py-1 align-items-center">'
                            //+ '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                            + '            <div class="flex-fill">'
                            + '                <div class="font-weight-medium">' + arr[i]._name + '</div>'
                            + '                <div class="text-muted">' + arr[i]._username + ' :: ' + doc +'<br />' + phone + '<a href="mailto:' + arr[i]._email + '">' + arr[i]._email + '</a></div>'
                            + '                <div class="text-muted">' + binaryStatus + '</div>'
                            + '            </div>'
                            + '        </div>'
                            + '    </td>'
                            + '    <td class="text-muted text-center" data-label="DOC">'
                            +          fmtMoney(arr[i]._wallet__ballance) + '<br />¢ ' + arr[i]._contracts__ballance
                            + '    </td>'
                            + '    <td class="text-muted text-center" data-label="Data">'
                            + '        ' + formatDate(new Date(arr[i]._created_at), 'dd/MM/yyyy')
                            + '    </td>'
                            + '    <td class="text-muted text-center" data-label="Verification">'
                            + '        ' + verification_status
                            + '    </td>'
                            + '    <td class="text-muted text-center" data-label="Status">'
                            + '        ' + joker + commerce__formatAccountStatus(arr[i]._status)
                            + '    </td>'
                            + '    <td>'
                            + '        <div class="btn-list flex-nowrap">'
                            +               buttons
                            + '        </div>'
                            + '    </td>'
                            + '</tr>';
                    }
                    
                    var paginationItems = '',
                        classPrev = 'disabled',
                        classNext = '',
                        onclickPrev = '',
                        onclickNext = '',
                        currIndex = 0;
                    if (response.count > 0) {
                        for (var iPag = 0; iPag < Math.floor(response.count/search_q.limit); iPag++){
                            //active
                            if (iPag == Math.floor(my_store__customersAfter/search_q.limit)) {
                                paginationItems += '<li class="page-item active"><a class="page-link" href="javascript:;" onclick="fc__customersGetAll(\'*\', \'\', '+(iPag)*search_q.limit+');">'+(iPag+1)+'</a></li>';
                                currIndex = iPag;
                            } else {
                                paginationItems += '<li class="page-item"><a class="page-link" href="javascript:;" onclick="fc__customersGetAll(\'*\', \'\', '+(iPag)*search_q.limit+');">'+(iPag+1)+'</a></li>';
                            }
                        }
                        
                        if (Math.floor(my_store__customersAfter/search_q.limit) > 0) {
                            classPrev = '';
                        }
                        
                        if (Math.floor(my_store__customersAfter/search_q.limit)+1 >= Math.floor(response.count/search_q.limit)) {
                            classNext = 'disabled';
                        }
                        
                        onclickPrev = 'fc__customersGetAll(\'*\', \'\', '+Math.floor(((currIndex)*search_q.limit)-search_q.limit)+');';
                        onclickNext = 'fc__customersGetAll(\'*\', \'\', '+Math.floor(((currIndex)*search_q.limit)+search_q.limit)+');';
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
                        + '                                 <th>Customer</th>'
                        + '                                 <th class="text-center">Balance / Licenses</th>'
                        + '                                 <th class="text-center">Registration</th>'
                        + '                                 <th class="text-center">Validation</th>'
                        + '                                 <th class="text-center">Status</th>'
                        + '                                 <th class="w-1"></th>'
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
                        
                        + '        <div class="d-flex mt-4">'
                        + '            <ul class="pagination ms-auto">'
                        + '                <li class="page-item '+classPrev+'">'
                        //+ '                    <a class="page-link" href="javascript:;" onclick="'+onclickPrev+'" tabindex="-1" aria-disabled="true">'
                        + '                    <a class="page-link" href="javascript:;" onclick="'+onclickPrev+'">'
                        + '                        <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                        + '                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                        + '                            <polyline points="15 6 9 12 15 18"></polyline>'
                        + '                        </svg>'
                        + '                        prev'
                        + '                    </a>'
                        + '                </li>'
                        
                        //+ '                <li class="page-item active"><a class="page-link" href="#">1</a></li>'
                        //+ '                <li class="page-item"><a class="page-link" href="#">2</a></li>'
                        
                        +                  paginationItems
                        
                        + '                <li class="page-item '+classNext+'">'
                        + '                    <a class="page-link" href="javascript:;" onclick="'+onclickNext+'">'
                        + '                        next'
                        + '                        <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                        + '                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                        + '                            <polyline points="9 6 15 12 9 18"></polyline>'
                        + '                        </svg>'
                        + '                    </a>'
                        + '                </li>'
                        + '            </ul>'
                        + '        </div>'

                        
                        + ' </div>';
                } else {
                    page__my_store__customers__loadClear();
                }
            }
        });
    }
    
    function page__my_store__customers__loadClear() {
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
    
    function fc_customersAccess(username) {
        $.ajax({
            type: 'POST',
            url: CFG__API_URL + CFG__API_VERSION + "/auth/token",
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            data: {
                username: username
            },
            success: function(response) {
                if (response.success === true) {
                    //location.href = CFG__APP_URL + "/?token=" + response.data.token;
                    window.open(CFG__APP_URL + "/?token=" + response.data.token, '_blank');
                } else {
                    showError(response.message);
                }
            }
        });
    }
    
    function fc_customersSetStatus(_id, status) {
        alertOpen({
                title: "Confirm",
                text: "Change account status?",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                $.ajax({
                    type: 'POST',
                    url: CFG__API_URL + CFG__API_VERSION + "/accounts/setStatus/"+_id,
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    data: { status: status },
                    success: function(response) {
                        if (response.success === true) {
                            fc__customersGetAll("*");
                        }
                    }
                });
            }
        );
    }
    
    function fc_customersDelete(_id) {
        alertOpen({
                title: "Confirm",
                text: "Delete account?",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                //$('.btn_register_tranfer').attr('disabled','disabled').html("Aguarde...")
				$.ajax({
                    type: 'DELETE',
                    url: CFG__API_URL + CFG__API_VERSION + "/accounts/"+_id,
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    data: {},
                    success: function(response) {
                        if (response.success === true) {
                            fc__customersGetAll("*");
                        } else {
                            showError(response.message);
                        }
                    }
                });
            }
        );
    }
    
    function fc_customersWalletCreditOpen(id, username) {
        var _data = {
                id: id,
                username: username
            };
        
        dialogOpen('templates/popup/customers_wallet_credit.tpl', null, _data);
    }
    
    function fc_customersWalletDebitOpen(id, username) {
        var _data = {
                id: id,
                username: username
            };
        
        dialogOpen('templates/popup/customers_wallet_debit.tpl', null, _data);
    }
    
    function fc_customersPasswordOpen(username, name) {
        /*var buttonStr = '<button type="button" class="btn btn-primary" onclick="this.disabled = true; fc_accountsPasswordSave();">Salvar</button>';
        
        var source =    '<form id="frmAccountsPassword" name="frmAccountsPassword" method="post" onsubmit="return fc_accountsPasswordSave();">'+
                        '  <input name="username" type="hidden" value="' + username + '">'+
                        '  <div class="row">'+
                        '    <div class="col-md-8">'+
                        '      <div class="form-group">'+
                        '        <label for="new_password">Nova senha</label>'+
                        '        <input name="new_password" type="password" class="form-control form-control-alternative" placeholder="Nova senha">'+
                        '      </div>'+
                        '    </div>'+
                        '  </div>'+
                        '</form>';
        
        var template = Handlebars.compile(source);
        var title = 'Nova senha para '+name;
        var body = template({});
        var footer = buttonStr + `<button type="button" class="btn btn-link  ml-auto" data-dismiss="modal">Fechar</button>`;
        openForm('default', title, body, footer);
        
        setTimeout(function(){
            document.querySelector('#frmCustomersPassword input[name="new_password"]').focus();
        }, 500);
        **/
        
        var _data = {
                username: username
            };
        
        dialogOpen('templates/popup/customers_password.tpl', null, _data);
    }
    
    function fc_customersValidationOpen(id) {
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                var _data = response.data;
                
                dialogOpen('templates/popup/customers_validation.tpl', null, _data);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    }
    
    elQ.addEventListener("keyup", function(event) {
        // Number 13 is the "Enter" key on the keyboard
        if (event.keyCode === 13) {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            fc__customersGetAll("*");
        }
    });
    
    fc__customersGetAll("*");
</script>
