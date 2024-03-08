<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <!-- Page pre-title -->
                <div class="page-pretitle">
                    Dashboard
                </div>
                <h2 class="page-title">
                    Overview
                </h2>
            </div>
            <!-- Page title actions -->
            <div class="col-auto ms-auto d-print-none">
                <div class="btn-list">
                    {{#if system.isadmin}}
                        {{#contains "administrator" system.userdata._role}}
                            <span class="d-none d-sm-inline">
                                <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormIncomeAdd();">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <line x1="12" y1="5" x2="12" y2="19" />
                                        <line x1="5" y1="12" x2="19" y2="12" />
                                    </svg>
                                    Add quotas
                                </a>
                            </span>
                            <span class="d-none d-sm-inline">
                                <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormIncomeSecurityPay();">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <line x1="12" y1="5" x2="12" y2="19" />
                                        <line x1="5" y1="12" x2="19" y2="12" />
                                    </svg>
                                    Pay income
                                </a>
                            </span>
                        {{else}}
                        {{/contains}}
                        
                        {{#contains "true" settings.transfer_service_enabled}}
                            <span class="d-none d-sm-inline">
                                <a href="javascript:;" class="btn btn-white /*d-none d-sm-inline-block*/" onclick="View.openFormWalletTransfer();">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <line x1="12" y1="5" x2="12" y2="19" />
                                        <line x1="5" y1="12" x2="19" y2="12" />
                                    </svg>
                                    Transfer
                                </a>
                            </span>
                        {{else}}
                        {{/contains}}
                    {{else}}
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
                        <span class="d-none d-sm-inline">
                            <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormIncomeGet2();">
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-exchange" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                    <circle cx="5" cy="18" r="2" />
                                    <circle cx="19" cy="6" r="2" />
                                    <path d="M19 8v5a5 5 0 0 1 -5 5h-3l3 -3m0 6l-3 -3" />
                                    <path d="M5 16v-5a5 5 0 0 1 5 -5h3l-3 -3m0 6l3 -3" />
                                </svg>
                                Generate balance
                            </a>
                        </span>
                        
                        {{#contains "true" settings.money_add_service_enabled}}
                            <span class="d-none d-sm-inline">
                                <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormWalletMoneyAdd();">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-currency-dollar" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                       <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                       <path d="M16.7 8a3 3 0 0 0 -2.7 -2h-4a3 3 0 0 0 0 6h4a3 3 0 0 1 0 6h-4a3 3 0 0 1 -2.7 -2"></path>
                                       <path d="M12 3v3m0 12v3"></path>
                                    </svg>
                                    Add money
                                </a>
                            </span>
                        {{else}}
                        {{/contains}}
                        
                        {{#contains "true" settings.transfer_service_enabled}}
                            <span class="d-none d-sm-inline">
                                <a href="javascript:;" class="btn btn-white /*d-none d-sm-inline-block*/" onclick="View.openFormWalletTransfer();">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <line x1="12" y1="5" x2="12" y2="19" />
                                        <line x1="5" y1="12" x2="19" y2="12" />
                                    </svg>
                                    Transfer
                                </a>
                            </span>
                        {{else}}
                        {{/contains}}
                        
                        {{#contains "true" settings.cashout_service_enabled}}
                            <span class="d-none d-sm-inline">
                                <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="View.openFormWalletWithdrawal();">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <line x1="12" y1="5" x2="12" y2="19" />
                                        <line x1="5" y1="12" x2="19" y2="12" />
                                    </svg>
                                    Withdrawal
                                </a>
                            </span>
                        {{else}}
                        {{/contains}}
                        <!--<a href="#" class="btn btn-primary d-sm-none btn-icon" data-bs-toggle="modal" data-bs-target="#modal-report" aria-label="Create new report">
                            <!--<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <line x1="12" y1="5" x2="12" y2="19" />
                                <line x1="5" y1="12" x2="19" y2="12" />
                            </svg>
                        </a>-->
                    {{/if}}
                    
                    {{#if system.isadmin}}
                    {{else}}
                        <div class="btn-list">
                            <div class="form-group">
                                <div id="binary--btn-group" class="btn-group w-100">
                                    {{#contains "left" system.userdata._binary_key}}
                                        <button type="button" class="btn btn-primary" data-tab="left" title="Set binary left">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-arrow-left" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                               <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                               <line x1="5" y1="12" x2="19" y2="12"></line>
                                               <line x1="5" y1="12" x2="11" y2="18"></line>
                                               <line x1="5" y1="12" x2="11" y2="6"></line>
                                            </svg>
                                            <!--Left-->
                                        </button>
                                        <button type="button" class="btn" data-tab="right" title="Set binary right">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-arrow-right" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                               <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                               <line x1="5" y1="12" x2="19" y2="12"></line>
                                               <line x1="13" y1="18" x2="19" y2="12"></line>
                                               <line x1="13" y1="6" x2="19" y2="12"></line>
                                            </svg>
                                            <!--Right-->
                                        </button>
                                    {{else}}
                                        <button type="button" class="btn" data-tab="left" title="Set binary left">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-arrow-left" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                               <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                               <line x1="5" y1="12" x2="19" y2="12"></line>
                                               <line x1="5" y1="12" x2="11" y2="18"></line>
                                               <line x1="5" y1="12" x2="11" y2="6"></line>
                                            </svg>
                                            <!--Left-->
                                        </button>
                                        <button type="button" class="btn btn-primary" data-tab="right" title="Set binary right">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-arrow-right" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                               <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                               <line x1="5" y1="12" x2="19" y2="12"></line>
                                               <line x1="13" y1="18" x2="19" y2="12"></line>
                                               <line x1="13" y1="6" x2="19" y2="12"></line>
                                            </svg>
                                            <!--Right-->
                                        </button>
                                    {{/contains}}
                                </div>
                                <script>
                                    if (typeof page__index__binaryButtons === 'undefined') {
                                        let page__index__binaryButtons = document.querySelectorAll('#binary--btn-group .btn');
                                        for(let i = 0; i<page__index__binaryButtons.length; i++){
                                            page__index__binaryButtons[i].addEventListener('click', () => {
                                                var btnLst = document.querySelectorAll('#binary--btn-group .btn');
                                                for(var i2 = 0; i2<btnLst.length; i2++){
                                                    if (page__index__binaryButtons[i].getAttribute("data-tab") == btnLst[i2].getAttribute("data-tab")) {
                                                        page__index__binaryButtons[i].classList.add("btn-primary");
                                                    } else {
                                                        btnLst[i2].classList.remove("btn-primary");
                                                    }
                                                }
                                                
                                                if (page__index__binaryButtons[i].getAttribute("data-tab") == "left") {
                                                    fc_setBinaryKey('left');
                                                } else if (page__index__binaryButtons[i].getAttribute("data-tab") == "right") {
                                                    fc_setBinaryKey('right');
                                                }
                                            });
                                        }
                                    }
                                    
                                    function fc_setBinaryKey(key) {
                                        $.ajax({
                                            type: 'POST',
                                            url: CFG__API_URL + CFG__API_VERSION + "/session/account/binary/key",
                                            beforeSend: function (xhr){ 
                                                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                                            },
                                            data: {
                                                "key": key
                                            },
                                            success: function(response) {
                                                if (response.success === true) {
                                                    //
                                                } else {
                                                    App.alert('Warning', response.message, null);
                                                }
                                            }
                                        });
                                    }
                                </script>
                            </div>
                        </div>
                    {{/if}}
                </div>
            </div>
        </div>
    </div>
</div>
<div class="page-body">
    <section id="system--notification-area">
        <!-- -->
    </section>
    
    {{#if system.isadmin}}
    {{else}}
        {{#if settings.use_account_validation}}
            {{#contains "waiting" system.userdata._verification_status}}
                <div class="container-xl data--validation-status--alert">
                    <div class="row row-cards flex-center">
                        <div class="col-sm-10 col-lg-8">
                            <div class="container-xl">
                                <div class="alert alert-danger alert-dismissible" role="alert">
                                    <h3 class="mb-1">Validation pending</h3>
                                    <p>
                                        Your account validation is pending! <b>:(</b><br />
                                        You must submit the documents required to validate your account.
                                    </p>
                                    <div class="btn-list">
                                        <a href="javascript:;" class="btn btn-danger" onclick="View.openFormProfileDocumentsEdit();">Send documents</a>
                                        <a class="btn" data-bs-dismiss="alert" aria-label="close">Close</a>
                                    </div>
                                    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {{else}}
                {{#contains "validating" system.userdata._verification_status}}
                    <div class="container-xl data--validation-status--alert">
                        <div class="row row-cards flex-center">
                            <div class="col-sm-10 col-lg-8">
                                <div class="container-xl">
                                    <div class="alert alert-warning alert-dismissible" role="alert">
                                        <h3 class="mb-1">Validation in progress</h3>
                                        <p>Your account validation is in progress!</p>
                                        <div class="btn-list">
                                            <a class="btn" data-bs-dismiss="alert" aria-label="close">Close</a>
                                        </div>
                                        <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                {{else}}
                    {{#contains "invalidated" system.userdata._verification_status}}
                        <div class="container-xl data--validation-status--alert">
                            <div class="row row-cards flex-center">
                                <div class="col-sm-10 col-lg-8">
                                    <div class="container-xl">
                                        <div class="alert alert-danger alert-dismissible" role="alert">
                                            <h3 class="mb-1">Account not validated</h3>
                                            <p>
                                                Your account validation failed! <b>:(</b><br />
                                                You can resubmit the documents required to validate your account.
                                            </p>
                                            <div class="btn-list">
                                                <a href="javascript:;" class="btn btn-danger" onclick="View.openFormProfileDocumentsEdit();">Resend documents</a>
                                                <a class="btn" data-bs-dismiss="alert" aria-label="close">Close</a>
                                            </div>
                                            <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {{else}}
                        {{#contains "validated" system.userdata._verification_status}}
                            <!--Conta validada-->
                        {{else}}
                        {{/contains}}
                    {{/contains}}
                {{/contains}}
            {{/contains}}
        {{else}}
        {{/if}}
        
        {{#if system.firstPurchase}}
            <!--<div class="g12" style="padding: 12px;">
                <div style="margin-left: 28px;margin-right: 28px;margin-top: 28px;margin-bottom: 28px;background: #e05555;color: #fff;padding: 10px;border-radius: 3px;margin: 0 auto;max-width: 840px;">
                    <div class="text">
                        <h3 style="text-transform: uppercase;margin-top: 8px;font-size: 13px !important;font-weight: bold;margin: 4px 0 0 0 !important;">ATENÇÃO:</h3>
                        <p style="font-size: 14px;margin: 8px 0 4px 0 !important;">
                            Você deve realizar sua primeira compra para ativar seu escritório e receber bônus!<br />
                            Clique abaixo para fazer sua compra.
                        </p>
                    </div>
                    <div class="controls" style="margin-top: 10px;">
                        <a class="btn" href="{{settings.store.url}}/primeira-compra">
                            <span class="">Fazer primeira compra</span>
                        </a>
                    </div>
                </div>
            </div>-->
        {{else}}
            {{#if system.isuserinactive}}
                <div class="container-xl">
                    <div class="row row-cards flex-center">
                        <div class="col-sm-10 col-lg-8">
                            <div class="container-xl">
                                <div class="alert alert-danger alert-dismissible" role="alert">
                                    <h3 class="mb-1">Pending monthly activation</h3>
                                    <p>
                                        You haven't performed your monthly activation yet! <b>:(</b><br />
                                        Click below to make your purchase and activate.
                                    </p>
                                    <div class="btn-list">
                                        <a href="javascript:;" class="btn btn-danger" onclick="location.href='{{settings.store.url}}';">Make my purchase</a>
                                        <a class="btn" data-bs-dismiss="alert" aria-label="close">Close</a>
                                    </div>
                                    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {{else}}
            {{/if}}
        {{/if}}
        {{#if system.invoices.pending_payment}}
            <div class="container-xl">
                <div class="row row-cards flex-center">
                    <div class="col-sm-10 col-lg-8">
                        <div class="container-xl">
                            <div class="alert alert-warning alert-dismissible" role="alert">
                                <h3 class="mb-1">Pending payment</h3>
                                <p>You have a pending payment order!</p>
                                <div class="btn-list">
                                    <a href="javascript:;" class="btn btn-warning" onclick="location.href='{{settings.store.url}}/compras';">Make payment</a>
                                    <a class="btn" data-bs-dismiss="alert" aria-label="close">Close</a>
                                </div>
                                <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {{else}}
        {{/if}}
    {{/if}}
    
    
    <div class="container-xl">
        <div class="row row-deck row-cards">
            {{#contains "financial" system.userdata._role}}
                <div class="col-sm-6 col-lg-3" style="display: none;">
            {{else}}
                {{#contains "support" system.userdata._role}}
                    <div class="col-sm-6 col-lg-3" style="display: none;">
                {{else}}
                    <div class="col-sm-6 col-lg-3">
                {{/contains}}
            {{/contains}}
                <div id="card1" class="card">
                    <div class="row g-0 align-items-center">
                        <div class="col">
                            <div class="card-body">
                                <div class="skeleton-heading"></div>
                                <div class="skeleton-line"></div>
                                <div class="skeleton-line"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {{#contains "financial" system.userdata._role}}
                <div class="col-sm-6 col-lg-3" style="display: none;">
            {{else}}
                {{#contains "support" system.userdata._role}}
                    <div class="col-sm-6 col-lg-3" style="display: none;">
                {{else}}
                    <div class="col-sm-6 col-lg-3">
                {{/contains}}
            {{/contains}}
                <div id="card2" class="card">
                    <div class="row g-0 align-items-center">
                        <div class="col">
                            <div class="card-body">
                                <div class="skeleton-heading"></div>
                                <div class="skeleton-line"></div>
                                <div class="skeleton-line"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {{#contains "financial" system.userdata._role}}
                <div class="col-sm-6 col-lg-3" style="display: none;">
            {{else}}
                {{#contains "support" system.userdata._role}}
                    <div class="col-sm-6 col-lg-3" style="display: none;">
                {{else}}
                    <div class="col-sm-6 col-lg-3">
                {{/contains}}
            {{/contains}}
                <div id="card3" class="card">
                    <div class="row g-0 align-items-center">
                        <div class="col">
                            <div class="card-body">
                                <div class="skeleton-heading"></div>
                                <div class="skeleton-line"></div>
                                <div class="skeleton-line"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                
                {{#if system.isadmin}}
                {{else}}
                    <div class="col-sm-6 col-lg-3">
                        <div id="card2-a" class="card">
                            <div class="row g-0 align-items-center">
                                <div class="col">
                                    <div class="card-body">
                                        <div class="skeleton-heading"></div>
                                        <div class="skeleton-line"></div>
                                        <div class="skeleton-line"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                {{/if}}
                
                <div class="col-sm-6 col-lg-3" style="display: none;">
                    <div id="card5" class="card">
                        <div class="row g-0 align-items-center">
                            <div class="col">
                                <div class="card-body">
                                    <div class="skeleton-heading"></div>
                                    <div class="skeleton-line"></div>
                                    <div class="skeleton-line"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-3">
                    <div id="card6" class="card">
                        <div class="row g-0 align-items-center">
                            <div class="col">
                                <div class="card-body">
                                    <div class="skeleton-heading"></div>
                                    <div class="skeleton-line"></div>
                                    <div class="skeleton-line"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                {{#contains "financial" system.userdata._role}}
                    <div class="col-sm-6 col-lg-3" style="display: none;">
                {{else}}
                    {{#contains "support" system.userdata._role}}
                        <div class="col-sm-6 col-lg-3" style="display: none;">
                    {{else}}
                        <div class="col-sm-6 col-lg-3">
                    {{/contains}}
                {{/contains}}
                    <div id="card4" class="card">
                        <div class="row g-0 align-items-center">
                            <div class="col">
                                <div class="card-body">
                                    <div class="skeleton-heading"></div>
                                    <div class="skeleton-line"></div>
                                    <div class="skeleton-line"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                {{#contains "financial" system.userdata._role}}
                    <div class="col-lg-6" style="display: none;">
                {{else}}
                    {{#contains "support" system.userdata._role}}
                        <div class="col-lg-6" style="display: none;">
                    {{else}}
                        <div class="col-lg-6">
                    {{/contains}}
                {{/contains}}
                <div class="row row-cards">
                    <div class="col-12">
                        <div id="card7" class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <div class="skeleton-line"></div>
                                        <div class="skeleton-line"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <script type="text/javascript">
                            function setDataPointsGraduationType(graduationType) {
                                const nDataPointsGraduationType = document.querySelectorAll('.data--points-graduation-estimate');
                                
                                if (nDataPointsGraduationType != null) {
                                    nDataPointsGraduationType.forEach(
                                        p => {
                                            console.log(p.style.display);
                                            if (graduationType == 'points') {
                                                //p.style.display = "none";
                                                p.style.setProperty("display", "none", "important");
                                            } else if (graduationType == 'estimate') {
                                                //p.style.display = "inline-block";
                                                p.style.setProperty("display", "inline-block", "important");
                                            }
                                        }
                                    );
                                }
                                
                                if (graduationType == 'points') {
                                    document.getElementById("setDataPointsGraduationType-points").classList.add("active");
                                    document.getElementById("setDataPointsGraduationType-estimate").classList.remove("active");
                                    
                                    document.getElementById("setDataPointsGraduationType-text").text = document.getElementById("setDataPointsGraduationType-points").text;
                                } else if (graduationType == 'estimate') {
                                    document.getElementById("setDataPointsGraduationType-points").classList.remove("active");
                                    document.getElementById("setDataPointsGraduationType-estimate").classList.add("active");
                                    
                                    document.getElementById("setDataPointsGraduationType-text").text = document.getElementById("setDataPointsGraduationType-estimate").text;
                                }
                            }
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container-xl" style="min-height: 16px;"></div>
    {{#if system.isadmin}}
    <div class="container-xl">
        <div class="row row-deck row-cards">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-header border-0">
                        <div class="card-title">Network</div>
                    </div>
                    <div class="position-relative">
                        <div class="position-absolute top-0 left-0 px-3 mt-1 w-50">
                            <div class="row g-2">
                                <div class="col-auto">
                                    <div class="chart-sparkline chart-sparkline-square" id="sparkline-activity"></div>
                                </div>
                                <div id="networkBasicInfo" class="col">
                                    <!--
                                    <div>Nenhum cadastro hoje</div>
                                    <div class="text-muted">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-inline text-green" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                            <polyline points="3 17 9 11 13 15 21 7" />
                                            <polyline points="14 7 21 7 21 14" />
                                        </svg>
                                        +5% a mais
                                    </div>
                                    -->
                                </div>
                            </div>
                        </div>
                        <div id="chart-development-activity"></div>
                    </div>
                    {{#if system.isadmin}}
                    <div class="card-table table-responsive">
                        <table class="table table-vcenter">
                            <thead>
                                <tr>
                                    <th>&nbsp;</th>
                                    <th>Reference</th>
                                    <th class="text-center">Date</th>
                                </tr>
                            </thead>
                            <tbody id="data--fc_index_indications">
                                <!-- -->
                            </tbody>
                        </table>
                    </div>
                    {{/if}}
                </div>
            </div>
        </div>
    </div>
    {{/if}}
</div>

<!--
<footer class="footer footer-transparent d-print-none">
  <div class="container">
    <div class="row text-center align-items-center flex-row-reverse">
      <div class="col-lg-auto ms-lg-auto">
        <ul class="list-inline list-inline-dots mb-0">
          <li class="list-inline-item"><a href="./docs/index.html" class="link-secondary">Documentation</a></li>
          <li class="list-inline-item"><a href="./license.html" class="link-secondary">License</a></li>
          <li class="list-inline-item"><a href="https://github.com/tabler/tabler" target="_blank" class="link-secondary" rel="noopener">Source code</a></li>
          <li class="list-inline-item">
            <a href="https://github.com/sponsors/codecalm" target="_blank" class="link-secondary" rel="noopener">
              <!-- Download SVG icon from http://tabler-icons.io/i/heart -->
<!--
                <svg xmlns="http://www.w3.org/2000/svg" class="icon text-pink icon-filled icon-inline" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M19.5 13.572l-7.5 7.428l-7.5 -7.428m0 0a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572" /></svg>
              Sponsor
            </a>
          </li>
        </ul>
      </div>
      <div class="col-12 col-lg-auto mt-3 mt-lg-0">
        <ul class="list-inline list-inline-dots mb-0">
          <li class="list-inline-item">
            Copyright &copy; 2021
            <a href="." class="link-secondary">Tabler</a>.
            All rights reserved.
          </li>
          <li class="list-inline-item">
            <a href="./changelog.html" class="link-secondary" rel="noopener">v1.0.0-beta5</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</footer>
-->

<script>
    function indexLoadData(){
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/session/account/resume",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                // // //
                //var arr = response.wallet__getBalance;
                var arr = response.data;
                
    /**            var voucher = "";
                if (arr.voucher.available > 0) {
                    voucher = "+" + fmtMoney(arr.voucher.available);
                }
    **/
                
                /**if (arr.available > 0) {
                    document.getElementById("page__home___available").innerHTML = fmtMoney(arr.available) + voucher;
                } else {
                    document.getElementById("page__home___available").innerHTML = "- " + fmtMoney(arr.available) + voucher;
                    //document.getElementById("page__home___available").style.color = "#CC0000";
                }
                
                if (arr.credit.month > 0) {
                    document.getElementById("page__home___total_month").innerHTML = fmtMoney(arr.credit.month);
                } else {
                    document.getElementById("page__home___total_month").innerHTML = "USD 0,00";
                }
                
                if (arr.credit.total > 0) {
                    document.getElementById("page__home___general_earnings").innerHTML = fmtMoney(arr.credit.total);
                } else {
                    document.getElementById("page__home___general_earnings").innerHTML = "USD 0,00";
                }*/
                
                var chargesStr = '<div>';
                if (arr.count.charges == 1) {
                    chargesStr += '<span title="Outstanding balance entry processing"><svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-corner-left-down-double" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><desc>Download more icon variants from https://tabler-icons.io/i/corner-left-down-double</desc><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M18 4h-6a3 3 0 0 0 -3 3v7" /><path d="M13 10l-4 4l-4 -4m8 5l-4 4l-4 -4" /></svg> ' + arr.count.charges + ' Crypto credit</span>';
                } else if (arr.count.charges > 1) {
                    chargesStr += '<span title="Outstanding balance entry processing"><svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-corner-left-down-double" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><desc>Download more icon variants from https://tabler-icons.io/i/corner-left-down-double</desc><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M18 4h-6a3 3 0 0 0 -3 3v7" /><path d="M13 10l-4 4l-4 -4m8 5l-4 4l-4 -4" /></svg> ' + arr.count.charges + ' Crypto credit</span>';
                }
                
                chargesStr += '</div>';
                
                document.getElementById("card1").innerHTML = 
                      '<div class="card-body">'
                    + '    <div class="d-flex align-items-center">'
                    + '        <div class="subheader">Balance</div>'
                    //        <!--<div class="ms-auto lh-1">
                    //            <div class="dropdown">
                    //                <a class="dropdown-toggle text-muted" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Últimos 7 dias</a>
                    //                <div class="dropdown-menu dropdown-menu-end">
                    //                    <a class="dropdown-item active" href="#">Últimos 7 dias</a>
                    //                    <a class="dropdown-item" href="#">Últimos 30 dias</a>
                    //                    <a class="dropdown-item" href="#">Últimos 3 meses</a>
                    //                </div>
                    //            </div>
                    //        </div>-->
                    + '    </div>'
                    + '    <div class="d-flex align-items-baseline">'
                    + '        <div class="h1 mb-0 me-2">' + fmtMoney(arr.wallet.balance.total) + '</div>'
                    + '        <div class="me-auto">'
                    + '            <span class="text-red d-inline-flex align-items-center lh-1">'
                    +                  chargesStr
    ///                +              voucher
                    //                <!-- Download SVG icon from http://tabler-icons.io/i/trending-up -->
                    //+ '                <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                    //+ '                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />'
                    //+ '                    <polyline points="3 17 9 11 13 15 21 7" />'
                    //+ '                    <polyline points="14 7 21 7 21 14" />'
                    //+ '                </svg>'
                    + '            </span>'
                    + '        </div>'
                    + '    </div>'
                    + '</div>'
                    + '<div id="chart-revenue-bg" class="chart-sm" style="/*display: none;*/"></div>';
                
                var blockedStr = '<div>';
                if (arr.personal_income.available > 0) {
                    blockedStr += '<span title="Aid income released" class="text-green"><svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-bolt-off" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><desc>Download more icon variants from https://tabler-icons.io/i/bolt-off</desc><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="3" y1="3" x2="21" y2="21" /><path d="M15.212 15.21l-4.212 5.79v-7h-6l3.79 -5.21m1.685 -2.32l2.525 -3.47v6m1 1h5l-2.104 2.893" /></svg> ' + fmtMoney(arr.personal_income.available) + '</span><br />';
                }
                if (arr.personal_income.blocked > 0) {
                    blockedStr += '<span title="Aid income blocked"><svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-bolt-off" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><desc>Download more icon variants from https://tabler-icons.io/i/bolt-off</desc><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="3" y1="3" x2="21" y2="21" /><path d="M15.212 15.21l-4.212 5.79v-7h-6l3.79 -5.21m1.685 -2.32l2.525 -3.47v6m1 1h5l-2.104 2.893" /></svg> ' + fmtMoney(arr.personal_income.blocked) + '</span><br />';
                }
                
                document.getElementById("card2").innerHTML = 
                      '<div class="card-body">'
                    + '    <div class="d-flex align-items-center">'
                    + '        <div class="subheader">Gain</div>'
                    //         <!--<div class="ms-auto lh-1">
                    //             <div class="dropdown">
                    //                 <a class="dropdown-toggle text-muted" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Últimos 7 dias</a>
                    //                 <div class="dropdown-menu dropdown-menu-end">
                    //                     <a class="dropdown-item active" href="#">Últimos 7 dias</a>
                    //                     <a class="dropdown-item" href="#">Últimos 30 dias</a>
                    //                     <a class="dropdown-item" href="#">Últimos 3 meses</a>
                    //                 </div>
                    //             </div>
                    //         </div>-->
                    + '    </div>'
    //                + '    <div class="h1 mb-3">' + fmtMoney(arr.credit.total) + '</div>'
                    + '    <div class="h1 mb-3" title="Total gain">' + fmtMoney(arr.wallet.gain.total) + '</div>'
                    + '    <div class="d-flex /*mb-2*/">'
                    + '        <div class="text-green">'
                    + '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-calendar-event" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                    + '  <desc>Download more icon variants from https://tabler-icons.io/i/calendar-event</desc>'
                    + '  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>'
                    + '  <rect x="4" y="5" width="16" height="16" rx="2" />'
                    + '  <line x1="16" y1="3" x2="16" y2="7" />'
                    + '  <line x1="8" y1="3" x2="8" y2="7" />'
                    + '  <line x1="4" y1="11" x2="20" y2="11" />'
                    + '  <rect x="8" y="15" width="2" height="2" />'
                    + '</svg> '
    //                +              fmtMoney(arr.credit.month) + ' no mês'
                    +              fmtMoney(arr.wallet.gain.month) + ' / avaliable for balance<br />'
                    + '            <span class="text-red d-inline-flex align-items-center lh-1">'
                    +                  blockedStr
    ///                +              voucher
                    //                <!-- Download SVG icon from http://tabler-icons.io/i/trending-up -->
                    //+ '                <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                    //+ '                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />'
                    //+ '                    <polyline points="3 17 9 11 13 15 21 7" />'
                    //+ '                    <polyline points="14 7 21 7 21 14" />'
                    //+ '                </svg>'
                    + '            </span>'
                    + '        </div>'
                    + '    </div>'
                    + '    <div id="previsionGain" class="d-flex mb-2">'
                    + '        <div class="skeleton-line"></div>'
                    + '    </div>'
                    //+ '    <div class="progress progress-sm">'
                    //+ '        <div class="progress-bar bg-blue" style="width: 75%;" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">'
                    //+ '            <span class="visually-hidden">75% Complete</span>'
                    //+ '        </div>'
                    //+ '    </div>'
                    + '</div>';
                
                
    /**            if (_appData.system.isadmin == false) {
                        var arr2 = response2.unilevel__getResume;
                        
                        /* GRADUATION */
                        /**if (document.querySelector(".data--graduation") != null) {
                            document.querySelector(".data--graduation").style.backgroundImage = "url('https://api.spaces.brauntech.com.br/{{settings.__spaces_bucket}}/uploads/commerce_files/userapp/images/pins/" + arr2.extra__data.graduation.graduation__seq + ".png')";
                            document.querySelector(".data--graduation").title = arr2.extra__data.graduation.name;
                        }*/
                        
                        
                        /* STATUS */
    /**                    var activation_last_date = datetimeToString(arr2.network.active_until, true, false),
                            activation_status = '',
                            activation_status__color = '',
                            activation_status__info = '';
                        if (arr2.network.active_until != undefined) {
                            var n1 = newActivationStatus2B(arr2.network.active_until);
                            if (n1[0] == false) {
                                activation_status = 'Inativo';
                                activation_status__color = 'red';
                                activation_status__info = '<p>ZIP Code must be US or CDN format. You can use an extended ZIP+4 code to determine address more accurately.</p><p class=\'mb-0\'><a href=\'\'>USP ZIP codes lookup tools</a></p>';
                            } else {
                                activation_status = 'Ativo';
                                activation_status__info = '<p>ZIP Code must be US or CDN format. You can use an extended ZIP+4 code to determine address more accurately.</p><p class=\'mb-0\'><a href=\'\'>USP ZIP codes lookup tools</a></p>';
                            }
                        }
                        
                        
                        /* DAYS */
    /**                    var actStatus = newActivationStatus2B(arr2.network.active_until);
                        var activation_status__days = '';
                        var activation_status__days_txt = '';
                        if (actStatus[1] == 0) {
                            activation_status__days_txt = "Amanhã";
                        } else if (actStatus[1] > 0) {
                            var days_txt = actStatus[1] + " dia";
                            
                            if (actStatus[1] > 1) {
                                days_txt = actStatus[1] + " dias";
                            } else {
                                days_txt = actStatus[1] + " dia";
                            }
                            
                            activation_status__days = actStatus[1];
                            activation_status__days_txt = days_txt;
                        }
                        
                        /* PROGRESS */
    /**                    var activation_status__progress = '';
                        if (actStatus[0] === true && actStatus[1] >= 0) { // && _Virtual.Session.Account.security.account_check.first_confirmation === false) {
                            var days_perc = ((30/100)*actStatus[1])*10;
                            //render_Activation_value[i].style.width = days_perc+"%";
                            activation_status__progress = days_perc;
                            
                            /**if (actStatus[1] != null && actStatus[1] < 30) {
                                document.getElementById("status-activation").style.display = "block";
                            }*/
    /**                    } else {
                            // window.location.replace(STORE_URL+"/comprar-ativacao");
                            /// NOT RELOAD
                            ///window.location.replace(STORE_URL);
                        }
                        
                        if (activation_status__days > 0) {
                            if (days_perc >= 30) {
                                activation_status__color = 'green';
                            } else if (days_perc < 30) {
                                activation_status__color = 'yellow';
                            }
                        }
                        
                        
                        
                        var perc = (arr2.extra__data.downline_grid.count.active + arr2.extra__data.downline_grid.count.inactive)/100;
                        var perc_chart = arr2.extra__data.downline_grid.count.active / perc;
                        if (isNaN(perc_chart)) {
                            perc_chart = 0;
                        } else {
                            perc_chart = perc_chart.toFixed(2);
                        }
    */                    
                        document.getElementById("card3").innerHTML = 
                              '<div class="card-body">'
                            + '    <div class="d-flex align-items-center">'
                            {{#if system.isadmin}}
                            + '        <div class="subheader">REGISTRATIONS</div>'
                            {{else}}
                            + '        <div class="subheader">RECOMMENDATIONS</div>'
                            {{/if}}
                            //        <!--<div class="ms-auto lh-1">
                            //            <div class="dropdown">
                            //                <a class="dropdown-toggle text-muted" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Últimos 7 dias</a>
                            //                <div class="dropdown-menu dropdown-menu-end">
                            //                    <a class="dropdown-item active" href="#">Últimos 7 dias</a>
                            //                    <a class="dropdown-item" href="#">Últimos 30 dias</a>
                            //                    <a class="dropdown-item" href="#">Últimos 3 meses</a>
                            //                </div>
                            //            </div>
                            //        </div>-->
                            + '    </div>'
                            + '    <div class="d-flex align-items-baseline">'
                            + '        <div class="h1 mb-3 me-2">' + arr.count.accounts.total + '</div>'
                            + '        <div class="me-auto">'
                            + '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-users" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '    <path d="M9 7m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0"></path>'
                            + '    <path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2"></path>'
                            + '    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>'
                            + '    <path d="M21 21v-2a4 4 0 0 0 -3 -3.85"></path>'
                            + '    </svg>'
                            //+ '            <span class="text-yellow d-inline-flex align-items-center lh-1">'
                            //+                  arr.count.accounts.in_month + ' in month'
                            //                <!-- Download SVG icon from http://tabler-icons.io/i/minus -->
                            //+ '                <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            //+ '                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />'
                            //+ '                    <line x1="5" y1="12" x2="19" y2="12" />'
                            //+ '                </svg>'
                            //+ '            </span>'
                            + '        </div>'
                            + '    </div>'
                            + '    <div id="chart-new-clients" class="chart-sm" style="/*display: none;*/"></div>'
                            + '</div>';
                        
                        
                        {{#if system.isadmin}}
                        {{else}}
                            var binaryStatus = '<span class="text-red d-inline-flex align-items-center lh-1">Inactive</span>';
                            if (arr.binary.active == true) {
                                binaryStatus = '<span class="text-yellow d-inline-flex align-items-center lh-1">Active</span>';
                            }
                            
                            binaryStatus += '&nbsp;//&nbsp;';
                            
                            if (arr.binary.receiving == true) {
                                binaryStatus += '<span class="text-yellow d-inline-flex align-items-center lh-1">qualified</span>';
                            } else {
                                binaryStatus += '<span class="text-red d-inline-flex align-items-center lh-1">unqualified</span>';
                            }
                            
                            var binaryLeft = 0,
                                binaryRight = 0,
                                totalBinaryLeft = 0,
                                totalBinaryRight = 0,
                                binaryPaid_pts = 0;
                            
                            if (arr.binary.left > 0) {
                                binaryLeft = parseFloat(arr.binary.left); //.toFixed(2)
                            }
                            if (arr.binary.right > 0) {
                                binaryRight = parseFloat(arr.binary.right); //.toFixed(2)
                            }
                            if (arr.binary.totalLeft > 0) {
                                totalBinaryLeft = parseFloat(arr.binary.totalLeft); //.toFixed(2)
                            }
                            if (arr.binary.totalLeft > 0) {
                                totalBinaryRight = parseFloat(arr.binary.totalRight); //.toFixed(2)
                            }
                            if (arr.binary.paid_pts > 0) {
                                binaryPaid_pts = parseFloat(arr.binary.paid_pts); //.toFixed(2)
                            }
                            
                            document.getElementById("card2-a").innerHTML = 
                                  '<div class="card-body">'
                                + '    <div class="d-flex align-items-center">'
                                + '        <div class="subheader">Binary</div>'
                                //         <!--<div class="ms-auto lh-1">
                                //             <div class="dropdown">
                                //                 <a class="dropdown-toggle text-muted" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Últimos 7 dias</a>
                                //                 <div class="dropdown-menu dropdown-menu-end">
                                //                     <a class="dropdown-item active" href="#">Últimos 7 dias</a>
                                //                     <a class="dropdown-item" href="#">Últimos 30 dias</a>
                                //                     <a class="dropdown-item" href="#">Últimos 3 meses</a>
                                //                 </div>
                                //             </div>
                                //         </div>-->
                                + '    </div>'
                //                + '    <div class="h1 mb-3">' + fmtMoney(arr.credit.total) + '</div>'
                                + '    <div class="h1 mb-3" title="Total Left / Right [Paid]: ' + totalBinaryLeft + ' / ' + totalBinaryRight + ' ['+binaryPaid_pts+']">' + binaryLeft + '&nbsp;|&nbsp;' + binaryRight + '</div>'
                                + '    <div class="d-flex /*mb-2*/">'
                                + '        <div class="text-green">'
                                + '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-calendar-event" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '  <desc>Download more icon variants from https://tabler-icons.io/i/calendar-event</desc>'
                                + '  <path stroke="none" d="M0 0h24v24H0z" fill="none"/>'
                                + '  <rect x="4" y="5" width="16" height="16" rx="2" />'
                                + '  <line x1="16" y1="3" x2="16" y2="7" />'
                                + '  <line x1="8" y1="3" x2="8" y2="7" />'
                                + '  <line x1="4" y1="11" x2="20" y2="11" />'
                                + '  <rect x="8" y="15" width="2" height="2" />'
                                + '</svg> '
                //                +              fmtMoney(arr.credit.month) + ' no mês'
                                +              fmtMoney(arr.binary.gain) + ' gain<br />'
                ///                + '            <span class="text-red d-inline-flex align-items-center lh-1">'
                ///                +                  blockedStr
                ///                +              voucher
                                //                <!-- Download SVG icon from http://tabler-icons.io/i/trending-up -->
                                //+ '                <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                //+ '                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />'
                                //+ '                    <polyline points="3 17 9 11 13 15 21 7" />'
                                //+ '                    <polyline points="14 7 21 7 21 14" />'
                                //+ '                </svg>'
                ///                + '            </span>'
                                + '        </div>'
                                + '    </div>'
                                + '    <div class="d-flex mb-2 mt-2">'
                                + '        <div class="skeleton-line">' + binaryStatus + '</div>'
                                + '    </div>'
                                //+ '    <div class="progress progress-sm">'
                                //+ '        <div class="progress-bar bg-blue" style="width: 75%;" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">'
                                //+ '            <span class="visually-hidden">75% Complete</span>'
                                //+ '        </div>'
                                //+ '    </div>'
                                + '</div>';
                        {{/if}}
                        
                        
                        /** CHARGES **/
                        /**var elSystemNotificationArea = document.getElementById("system--notification-area");
                        if (arr.count.charges > 0) {
                            if (elSystemNotificationArea != null) {
                                //elSystemNotificationArea.innerHTML = "";
                                
                                elSystemNotificationArea.innerHTML += 
                                      '<div class="container-xl data--validation-status--alert" id="system--notifications__charge">'
                                    + '    <div class="row row-cards flex-center">'
                                    + '        <div class="col-sm-10 col-lg-8">'
                                    + '            <div class="container-xl">'
                                    + '                <div class="alert alert-info alert-dismissible" role="alert">'
                                    + '                    <h3 class="mb-1">Inserção de saldo em andamento</h3>'
                                    + '                    <p>'
                                    + '                        Existe '+arr.count.charges+' inserções de saldo em andamento!'
                                    + '                    </p>'
                                    + '                    <div class="btn-list">'
                                    //+ '                        <a href="javascript:;" class="btn btn-info" onclick="f_notificationsSetRead(\''+currentObject._id+'\');">Marcar como lido</a>'
                                    + '                        <a class="btn" data-bs-dismiss="alert" aria-label="close">Fechar</a>'
                                    + '                    </div>'
                                    + '                    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                                    + '                </div>'
                                    + '            </div>'
                                    + '        </div>'
                                    + '    </div>'
                                    + '</div>';
                            }
                        }*/
                        /** **/
                        
                        
                        var variation = arr.quotations.bid - arr.quotations.open,
                            variationStr = '';
                        if (variation == 0) {
                            variationStr = 
                                  '<span class="text-yellow d-inline-flex align-items-center lh-1" title="">'
                                + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-minus" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                + '        <line x1="5" y1="12" x2="19" y2="12"></line>'
                                + '    </svg>'
                                + '    &nbsp;' + parseFloat(variation).toFixed(2)
                                + '</span>';
                        } else if (variation > 0) {
                            variationStr = 
                                  '<span class="text-green d-inline-flex align-items-center lh-1" title="">'
                                + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '        <path stroke="none" d="M0 0h24v24H0z" fill="none" />'
                                + '        <polyline points="3 17 9 11 13 15 21 7" />'
                                + '        <polyline points="14 7 21 7 21 14" />'
                                + '    </svg>'
                                + '    &nbsp;' + parseFloat(variation).toFixed(2)
                                + '</span>';
                        } else {
                            variationStr = 
                                  '<span class="text-red d-inline-flex align-items-center lh-1" title="">'
                                + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-trending-down" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                + '        <polyline points="3 7 9 13 13 9 21 17"></polyline>'
                                + '        <polyline points="21 10 21 17 14 17"></polyline>'
                                + '    </svg>'
                                + '    &nbsp;' + parseFloat(variation).toFixed(2)
                                + '</span>';
                        }
                        
                        document.getElementById("card5").innerHTML = 
                              '<div class="card-body">'
                            + '    <div class="d-flex align-items-center">'
                            + '        <div class="subheader">Dollar / Real</div>'
                            //        <!--<div class="ms-auto lh-1">
                            //            <div class="dropdown">
                            //                <a class="dropdown-toggle text-muted" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Últimos 7 dias</a>
                            //                <div class="dropdown-menu dropdown-menu-end">
                            //                    <a class="dropdown-item active" href="#">Últimos 7 dias</a>
                            //                    <a class="dropdown-item" href="#">Últimos 30 dias</a>
                            //                    <a class="dropdown-item" href="#">Últimos 3 meses</a>
                            //                </div>
                            //            </div>
                            //        </div>-->
                            + '    </div>'
                            + '    <div class="d-flex align-items-baseline">'
                            + '        <div class="h1 mb-3 me-2">' + arr.quotations.bid + '</div>'
                            + '        <div class="me-auto">'
                            +              variationStr
                            + '        </div>'
                            + '    </div>'
                            + '    <div class="d-flex">'
                            +          fmtMoneyBRL(arr.wallet.balance.total*arr.quotations.bid) + ' balance'
                            + '    </div>'
                            + '</div>'
                            + '<div id="chart-new-clients2" class="chart-sm"></div>';
                        
                        
                        var variationIncome = arr.income.bid - arr.income.open,
                            variationIncomeStr = '';
                        if (variationIncome == 0) {
                            variationIncomeStr = 
                                  '<span class="text-yellow d-inline-flex align-items-center lh-1" title="">'
                                + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-minus" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                + '        <line x1="5" y1="12" x2="19" y2="12"></line>'
                                + '    </svg>'
                                + '    &nbsp;' + parseFloat(variationIncome).toFixed(2)
                                + '</span>';
                        } else if (variationIncome > 0) {
                            variationIncomeStr = 
                                  '<span class="text-green d-inline-flex align-items-center lh-1" title="">'
                                + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '        <path stroke="none" d="M0 0h24v24H0z" fill="none" />'
                                + '        <polyline points="3 17 9 11 13 15 21 7" />'
                                + '        <polyline points="14 7 21 7 21 14" />'
                                + '    </svg>'
                                + '    &nbsp;' + parseFloat(variationIncome).toFixed(2)
                                + '</span>';
                        } else {
                            variationIncomeStr = 
                                  '<span class="text-red d-inline-flex align-items-center lh-1" title="">'
                                + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-trending-down" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                + '        <polyline points="3 7 9 13 13 9 21 17"></polyline>'
                                + '        <polyline points="21 10 21 17 14 17"></polyline>'
                                + '    </svg>'
                                + '    &nbsp;' + parseFloat(variationIncome).toFixed(2)
                                + '</span>';
                        }
                        
                        document.getElementById("card6").innerHTML = 
                              '<div class="card-body">'
                            + '    <div class="d-flex align-items-center">'
                            + '        <div class="subheader">SEVEN CAPITAL Quote (DAILY INCOME)</div>'
                            //        <!--<div class="ms-auto lh-1">
                            //            <div class="dropdown">
                            //                <a class="dropdown-toggle text-muted" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Últimos 7 dias</a>
                            //                <div class="dropdown-menu dropdown-menu-end">
                            //                    <a class="dropdown-item active" href="#">Últimos 7 dias</a>
                            //                    <a class="dropdown-item" href="#">Últimos 30 dias</a>
                            //                    <a class="dropdown-item" href="#">Últimos 3 meses</a>
                            //                </div>
                            //            </div>
                            //        </div>-->
                            + '    </div>'
                            + '    <div class="d-flex align-items-baseline">'
                            + '        <div class="h1 mb-3 me-2">' + arr.income.bid + '%</div>'
                            + '        <div class="me-auto">'
                            +              variationIncomeStr
                            + '        </div>'
                            + '    </div>'
                            + '    <div class="d-flex">'
                            + '        '
                            + '    </div>'
                            + '    <div id="chart-new-clients3" class="chart-sm"></div>'
                            + '</div>';
                        
                        
                        /**var perc_rel = (arr2.extra__data.prevision.graduation.next.ve + arr2.extra__data.prevision.graduation.next.points_required) / 100.00,  //arr2.extra__data.prevision.graduation.next.ve / 100.00,
                            perc_vp = arr2.extra__data.prevision.vp / perc_rel,
                            perc_vme = arr2.extra__data.prevision.vt / perc_rel;
                        */
                        
                        var perc_rec_rel = arr.donations.income / 100.0,
                            perc_income = arr.donations.income / perc_rec_rel,
                            perc_received = arr.donations.received / perc_rec_rel;
                        
                        document.getElementById("card7").innerHTML = 
                            '<div class="card-body">'
                        
                        
                            + '    <div class="d-flex align-items-center">'
                            + '        <div class="subheader">License progress</div>'
                            //+ '         <div class="ms-auto lh-1">'
                            //+ '             <div class="dropdown">'
                            //+ '                 <a id="setDataPointsGraduationType-text" class="dropdown-toggle text-muted" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Exibir pontos</a>'
                            //+ '                 <div class="dropdown-menu dropdown-menu-end">'
                            //+ '                     <a id="setDataPointsGraduationType-points" class="dropdown-item active" href="javascript:;" onclick="setDataPointsGraduationType(\'points\');">Exibir pontos</a>'
                            //+ '                     <a id="setDataPointsGraduationType-estimate" class="dropdown-item" href="javascript:;" onclick="setDataPointsGraduationType(\'estimate\');">Exibir estimativa</a>'
                            //+ '                 </div>'
                            //+ '             </div>'
                            //+ '         </div>'
                            + '    </div>'
                        
                        
                          //+ '      <p class="mb-3">' + (arr2.extra__data.prevision.vt / 100.00) + ' pts / <strong>' + ((arr2.extra__data.prevision.graduation.next.ve - arr2.extra__data.prevision.vt) / 100.00) + ' pts</strong> para <strong>' + arr2.extra__data.prevision.graduation.next.name + '</strong></p>'
                          ///+ '      <p class="mb-3">' + (arr2.extra__data.prevision.vt / 100.00) + ' pts <span class="data--points-graduation-estimate" style="display: none !important;"> / <strong>' + (arr2.extra__data.prevision.graduation.next.points_required / 100.00) + ' pts</strong> para <strong>' + arr2.extra__data.prevision.graduation.next.name + '</span></strong></p>'
                          //+ '      <p class="mb-3">10 pts <span class="data--points-graduation-estimate" style="display: none !important;"> / <strong>' + (arr2.extra__data.prevision.graduation.next.points_required / 100.00) + ' pts</strong> para <strong>' + arr2.extra__data.prevision.graduation.next.name + '</span></strong></p>'
                          + '      <p class="mb-3">'+fmtMoney(arr.donations.amount)+' <span class="data--points-graduation-estimate" style="/*display: none !important;*/"> / <strong>'+fmtMoney(arr.donations.income-arr.donations.received)+'</strong> to <strong>'+fmtMoney(arr.donations.income)+'</span></strong></p>'
                          + '      <div class="progress progress-separated mb-3">'
                          + '          <div class="progress-bar bg-info" role="progressbar" style="width: ' + perc_received + '%;"></div>'
                          + '          <div class="progress-bar bg-primary" role="progressbar" style="width: ' + perc_income + '%;"></div>'
                          + '      </div>'
                          + '      <div class="row">'
                          + '          <div class="col-auto d-flex align-items-center px-2">'
                          + '              <span class="legend me-2 bg-info"></span>'
                          + '              <span>Gain</span>'
                          //+ '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted">' + (arr2.extra__data.prevision.vme / 100.00) + 'pts</span>'
                          + '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted"></span>'
                          + '          </div>'
                          + '          <div class="col-auto d-flex align-items-center pe-2">'
                          + '              <span class="legend me-2 bg-primary"></span>'
                          + '              <span>To be receive</span>'
                          //+ '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted">' + (arr2.extra__data.prevision.vp / 100.00) + 'pts</span>'
                          + '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted"></span>'
                          + '          </div>'
                          //+ '          <div class="col-auto d-flex align-items-center ps-2 data--points-graduation-estimate" style="display: none !important;">'
                          //+ '              <span class="legend me-2"></span>'
                          //+ '              <span>Próx. graduação</span>'
                          //+ '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted">' + ((arr2.extra__data.prevision.graduation.next.ve - arr2.extra__data.prevision.vt) / 100.00) + 'pts</span>'
                          //+ '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted">' + (arr2.extra__data.prevision.graduation.next.points_required / 100.00) + 'pts</span>'
                          //+ '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted">60pts</span>'
                          //+ '          </div>'
                          + '    </div>'
                          + '</div>';
                        
                  
                        document.getElementById("card4").innerHTML = 
                              '<div class="card-body">'
                            + '    <div class="d-flex align-items-center">'
                            + '        <div class="subheader">Licenses</div>'
                            //         <!--<div class="ms-auto lh-1">
                            //             <div class="dropdown">
                            //                 <a class="dropdown-toggle text-muted" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Últimos 7 dias</a>
                            //                 <div class="dropdown-menu dropdown-menu-end">
                            //                     <a class="dropdown-item active" href="#">Últimos 7 dias</a>
                            //                     <a class="dropdown-item" href="#">Últimos 30 dias</a>
                            //                     <a class="dropdown-item" href="#">Últimos 3 meses</a>
                            //                 </div>
                            //             </div>
                            //         </div>-->
                            + '    </div>'
            //                + '    <div class="h1 mb-3">' + fmtMoney(arr.credit.total) + '</div>'
                            + '    <div class="h1 mb-3">' + arr.count.donations.total + '</div>'
                            + '    <div class="d-flex /*mb-2*/">'
                            + '        <div class="text-green">'
            //                +              fmtMoney(arr.credit.month) + ' no mês'
                            +              arr.count.donations.receiving + ' active'
                            + '        </div>'
                            + '    </div>'
                            + '    <div id="previsionGain1" class="d-flex mb-2">'
                            + '        <div class="skeleton-line"></div>'
                            + '    </div>'
                            //+ '    <div class="progress progress-sm">'
                            //+ '        <div class="progress-bar bg-blue" style="width: 75%;" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100">'
                            //+ '            <span class="visually-hidden">75% Complete</span>'
                            //+ '        </div>'
                            //+ '    </div>'
                            + '    <div id="chart-active-users" class="chart-sm" style="/*display: none;*/"></div>'
                            + '</div>';


                        
    /**                    
                        if (arr2.extra__data.prevision.gain.estimated > 0) {
                            document.getElementById("previsionGain").innerHTML = 
                                  '<div class="text-green">Ganho previsto em <strong>' + fmtMoney(arr2.extra__data.prevision.gain.estimated) + '*</strong></div>';
                        } else {
                            //document.getElementById("previsionGain").innerHTML = "";
                        }
                        
                        document.getElementById("card6").innerHTML = 
                                  '<div class="card-body">'
                                + '    <div class="d-flex align-items-center">'
                                + '        <div class="subheader">Plano</div>'
                                //         <!--<div class="ms-auto lh-1">
                                //             <div class="dropdown">
                                //                 <a class="dropdown-toggle text-muted" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Últimos 7 dias</a>
                                //                 <div class="dropdown-menu dropdown-menu-end">
                                //                     <a class="dropdown-item active" href="#">Últimos 7 dias</a>
                                //                     <a class="dropdown-item" href="#">Últimos 30 dias</a>
                                //                     <a class="dropdown-item" href="#">Últimos 3 meses</a>
                                //                 </div>
                                //             </div>
                                //         </div>-->
                                + '    </div>'
                                + '    <div class="h1 mb-3">'
                                +          arr2.extra__data.plan.name
                                + '        <a class="btn btn-link" href="javascript:;" onclick="View.openFormPlanSelect();">Mudar plano</a>'
                                + '     </div>'
                                + '    <div class="d-flex mb-2">'
                                + '        <div>Status</div>'
                                + '        <div class="ms-auto">'
                                + '            <span class="text-' + activation_status__color + ' d-inline-flex align-items-center lh-1" title="Ativo até ' + activation_last_date + '">'
                                +                  activation_status
                                + '                &nbsp;<span class="form-help" data-bs-toggle="popover" data-bs-placement="top" data-bs-html="true" data-bs-content="' + activation_status__info + '">?</span>'
                                //                 <!-- Download SVG icon from http://tabler-icons.io/i/trending-up -->
                                //                 <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                //                     <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                //                     <polyline points="3 17 9 11 13 15 21 7" />
                                //                     <polyline points="14 7 21 7 21 14" />
                                //                 </svg>
                                + '            </span>'
                                + '        </div>'
                                + '    </div>'
                                + '    <div class="progress progress-sm">'
                                + '        <div class="progress-bar bg-' + activation_status__color + '" style="width: ' + activation_status__progress + '%;" role="progressbar" aria-valuenow="' + activation_status__progress + '" aria-valuemin="0" aria-valuemax="100">'
                                + '            <span class="visually-hidden">' + activation_status__progress + '% Completo</span>'
                                + '        </div>'
                                + '    </div>'
                                + '</div>';
                        
                        var perc_rel = (arr2.extra__data.prevision.graduation.next.ve + arr2.extra__data.prevision.graduation.next.points_required) / 100.00,  //arr2.extra__data.prevision.graduation.next.ve / 100.00,
                            perc_vp = arr2.extra__data.prevision.vp / perc_rel,
                            perc_vme = arr2.extra__data.prevision.vt / perc_rel;
                        
                        document.getElementById("card7").innerHTML = 
                                '<div class="card-body">'
                            
                            
                                + '    <div class="d-flex align-items-center">'
                                + '        <div class="subheader">Pontuação para graduação</div>'
                                + '         <div class="ms-auto lh-1">'
                                + '             <div class="dropdown">'
                                + '                 <a id="setDataPointsGraduationType-text" class="dropdown-toggle text-muted" href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Exibir pontos</a>'
                                + '                 <div class="dropdown-menu dropdown-menu-end">'
                                + '                     <a id="setDataPointsGraduationType-points" class="dropdown-item active" href="javascript:;" onclick="setDataPointsGraduationType(\'points\');">Exibir pontos</a>'
                                + '                     <a id="setDataPointsGraduationType-estimate" class="dropdown-item" href="javascript:;" onclick="setDataPointsGraduationType(\'estimate\');">Exibir estimativa</a>'
                                + '                 </div>'
                                + '             </div>'
                                + '         </div>'
                                + '    </div>'
                            
                            
                              //+ '      <p class="mb-3">' + (arr2.extra__data.prevision.vt / 100.00) + ' pts / <strong>' + ((arr2.extra__data.prevision.graduation.next.ve - arr2.extra__data.prevision.vt) / 100.00) + ' pts</strong> para <strong>' + arr2.extra__data.prevision.graduation.next.name + '</strong></p>'
                              + '      <p class="mb-3">' + (arr2.extra__data.prevision.vt / 100.00) + ' pts <span class="data--points-graduation-estimate" style="display: none !important;"> / <strong>' + (arr2.extra__data.prevision.graduation.next.points_required / 100.00) + ' pts</strong> para <strong>' + arr2.extra__data.prevision.graduation.next.name + '</span></strong></p>'
                              + '      <div class="progress progress-separated mb-3">'
                              + '          <div class="progress-bar bg-info" role="progressbar" style="width: ' + perc_vme + '%;"></div>'
                              + '          <div class="progress-bar bg-primary" role="progressbar" style="width: ' + perc_vp + '%;"></div>'
                              + '      </div>'
                              + '      <div class="row">'
                              + '          <div class="col-auto d-flex align-items-center px-2">'
                              + '              <span class="legend me-2 bg-info"></span>'
                              + '              <span>Pts grupo</span>'
                              + '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted">' + (arr2.extra__data.prevision.vme / 100.00) + 'pts</span>'
                              + '          </div>'
                              + '          <div class="col-auto d-flex align-items-center pe-2">'
                              + '              <span class="legend me-2 bg-primary"></span>'
                              + '              <span>Pts pessoais</span>'
                              + '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted">' + (arr2.extra__data.prevision.vp / 100.00) + 'pts</span>'
                              + '          </div>'
                              + '          <div class="col-auto d-flex align-items-center ps-2 data--points-graduation-estimate" style="display: none !important;">'
                              + '              <span class="legend me-2"></span>'
                              + '              <span>Próx. graduação</span>'
                              //+ '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted">' + ((arr2.extra__data.prevision.graduation.next.ve - arr2.extra__data.prevision.vt) / 100.00) + 'pts</span>'
                              + '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted">' + (arr2.extra__data.prevision.graduation.next.points_required / 100.00) + 'pts</span>'
                              + '          </div>'
                              + '    </div>'
                              + '</div>';
                        
                        
                        /*if (document.querySelector(".data--graduation") != null) {
                            document.querySelector(".data--graduation").style.backgroundImage = "url('https://api.spaces.brauntech.com.br/{{settings.__spaces_bucket}}/uploads/commerce_files/userapp/images/pins/" + arr2.extra__data.graduation.graduation__seq + ".png')";
                            document.querySelector(".data--graduation").title = arr2.extra__data.graduation.name;
                        }*/
                // // //
                
                
                
                var arrIndications = response.data.chart.indications.last15;
                var tbodyHTML = '';
                
                if (arrIndications.length > 0) {
                    for (var i = 0; i < arrIndications.length; i++){
                        if (i <= 7) {
                            var dateAtTxt = "",
                                cityTxt = "",
                                badge = '<div class="badge bg-primary"></div>';
                            
                            /**if (arrIndications[i]._address_city != "") {
                                cityTxt = ", morador da cidade de <strong>" + arrIndications[i].address_city + "</strong> ";
                            }*/
                            
                            var n1 = newActivationStatus2B(arrIndications[i]._created_at);
                            if (n1[1] == 0) {
                                dateAtTxt = 'today';
                            } else if (n1[1] == 1) {
                                dateAtTxt = 'yesterday';
                            } else if (n1[1] > 1) {
                                dateAtTxt = +n1[1]+' days ago';
                                
                                if (n1[1] > 7) {
                                    badge = '';
                                }
                                
                                if (n1[1] >= 30) {
                                    dateAtTxt = 'more than a month ago';
                                    badge = '';
                                }
                                
                                if (n1[1] >= 60) {
                                    dateAtTxt = 'more than two months ago';
                                }
                                
                                if (n1[1] >= 90) {
                                    dateAtTxt = 'more than 3 months ago';
                                }
                                
                                if (n1[1] >= 365) {
                                    dateAtTxt = 'more than a year ago';
                                }
                            }
                            
                            var picture__src = '../assets/img/picker_account.png';
                            if (arrIndications[i]._picture_src != null) {
                                picture__src = CFG__API_URL+'/d/uploads/accounts/'+arrIndications[i]._id+'/profile/picture/'+arrIndications[i]._picture_src;
                            }
                            
                            //getInitials(arrIndications[i]._name)
                            tbodyHTML += 
                                  '<tr>'
                                + '    <td class="w-1">'
                                + '        <span class="avatar avatar-sm avatar-rounded" style="background-image: url(\''+picture__src+'\');"></span>'
                                + '    </td>'
                                + '    <td class="td-truncate">'
                                + '        <div class="text-truncate">'
                                + '            <strong>' + arrIndications[i]._name + '</strong> ⇒ ' + cityTxt + ' registered on the network.'
                                + '        </div>'
                                + '    </td>'
                                + '    <td class="text-nowrap text-muted text-center">'+ badge + '&nbsp;&nbsp;' + dateAtTxt + '</td>'
                                + '</tr>';
                        }
                    }
                    
                    {{#if system.isadmin}}                    
                    document.getElementById("data--fc_index_indications").innerHTML = tbodyHTML;
                    {{/if}}
                } else {
                    document.getElementById("data--fc_index_indications").innerHTML = 
                          '<div class="container-xl d-flex flex-column justify-content-center">'
                        + '    <div class="empty">'
                        + '        <div class="empty-img"><img src="https://cdn.brauntech.com.br/ajax/libs/tabler/1.0.0-beta9/demo/static/illustrations/undraw_printing_invoices_5r4r.svg" height="128" alt="" /></div>'
                        + '        <p class="empty-title">No indication found</p>'
                        + '    </div>'
                        + '</div>';
                }
                
                
                /** CHART **/
                    /** **/
                    const statisticsWallet = response.data.chart.wallet.balance.last30;
                    var chartDataWallet = [],
                        chartLabelsWallet = [];
                    
                    for (var i = 0; i < statisticsWallet.length; i++) {
                    //for (var i = statisticsPlan.length-1; i >= 0; i--) {
                        //let value = statisticsWallet[i]._value;
                        //let result = fmtMoneyBRL(value.replace(".", ","));
                        
                        chartDataWallet.push(statisticsWallet[i]._value);
                        chartLabelsWallet.push(statisticsWallet[i]._date);
                    }
                    /** **/
                    
                    // @formatter:off
                    //document.addEventListener("DOMContentLoaded", function () {
                    window.ApexCharts &&
                        new ApexCharts(document.getElementById("chart-revenue-bg"), {
                            chart: {
                                type: "area",
                                fontFamily: "inherit",
                                height: 40.0,
                                //width: parseFloat(chartDataWalletCount*12),
                                sparkline: {
                                    enabled: true,
                                },
                                animations: {
                                    enabled: false,
                                },
                            },
                            dataLabels: {
                                enabled: false,
                            },
                            fill: {
                                opacity: 0.16,
                                type: "solid",
                            },
                            stroke: {
                                width: 2,
                                lineCap: "round",
                                curve: "smooth",
                            },
                            series: [
                                {
                                    name: "Crédito",
                                    data: chartDataWallet.reverse(),
                                },
                            ],
                            grid: {
                                strokeDashArray: 4,
                            },
                            xaxis: {
                                labels: {
                                    padding: 0,
                                },
                                tooltip: {
                                    enabled: false,
                                },
                                axisBorder: {
                                    show: false,
                                },
                                type: "string",
                            },
                            yaxis: {
                                labels: {
                                    padding: 4,
                                },
                            },
                            labels: chartLabelsWallet.reverse(),
                            colors: ["#206bc4"],
                            legend: {
                                show: false,
                            },
                        }).render();
                    //});
                    // @formatter:on
                    
                    
                    /** **/
                    const statisticsUsers = response.data.chart.indications.direct.last30;
                    var chartDataUsers = [],
                        chartLabelsUsers = [];
                    
                    for (var i = 0; i < statisticsUsers.length; i++) {
                    //for (var i = statisticsPlan.length-1; i >= 0; i--) {
                        chartDataUsers.push(parseInt(statisticsUsers[i]._count));
                        chartLabelsUsers.push(statisticsUsers[i]._date);
                    }
                    /** **/
                    
                    // @formatter:off
                    //document.addEventListener("DOMContentLoaded", function () {
                    window.ApexCharts &&
                        new ApexCharts(document.getElementById("chart-new-clients"), {
                            chart: {
                                type: "line",
                                fontFamily: "inherit",
                                height: 40.0,
                                //width: parseFloat(chartDataPlanCount*12),
                                sparkline: {
                                    enabled: true,
                                },
                                animations: {
                                    enabled: false,
                                },
                            },
                            fill: {
                                opacity: 1,
                            },
                            stroke: {
                                width: [2, 1],
                                dashArray: [0, 3],
                                lineCap: "round",
                                curve: "smooth",
                            },
                            series: [
                                {
                                    name: "Registrations",
                                    data: chartDataUsers.reverse(),
                                }
                            ],
                            grid: {
                                strokeDashArray: 4,
                            },
                            xaxis: {
                                labels: {
                                    padding: 0,
                                },
                                tooltip: {
                                    enabled: false,
                                },
                                type: "string",
                            },
                            yaxis: {
                                labels: {
                                    padding: 4,
                                },
                            },
                            labels: chartLabelsUsers.reverse(),
                            colors: ["#206bc4"],  //"#a8aeb7"
                            legend: {
                                show: false,
                            },
                        }).render();
                    //});
                    // @formatter:on
                    
                    
                    /** **/
                    const statisticsQuotations = response.data.chart.quotations.balance.last30;
                    var chartDataQuotations = [],
                        chartLabelsQuotations = [];
                    
                    for (var i = 0; i < statisticsQuotations.length; i++) {
                        chartDataQuotations.push(statisticsQuotations[i]._value);
                        chartLabelsQuotations.push(statisticsQuotations[i]._date);
                    }
                    /** **/
                    
                    // @formatter:off
                    //document.addEventListener("DOMContentLoaded", function () {
                    window.ApexCharts &&
                        new ApexCharts(document.getElementById("chart-new-clients2"), {
                            chart: {
                                type: "area",
                                fontFamily: "inherit",
                                height: 40.0,
                                //width: parseFloat(chartDataWalletCount*12),
                                sparkline: {
                                    enabled: true,
                                },
                                animations: {
                                    enabled: false,
                                },
                            },
                            dataLabels: {
                                enabled: false,
                            },
                            fill: {
                                opacity: 0.16,
                                type: "solid",
                            },
                            stroke: {
                                width: 2,
                                lineCap: "round",
                                curve: "smooth",
                            },
                            series: [
                                {
                                    name: "Credit",
                                    data: chartDataQuotations.reverse(),
                                },
                            ],
                            grid: {
                                strokeDashArray: 4,
                            },
                            xaxis: {
                                labels: {
                                    padding: 0,
                                },
                                tooltip: {
                                    enabled: false,
                                },
                                axisBorder: {
                                    show: false,
                                },
                                type: "string",
                            },
                            yaxis: {
                                labels: {
                                    padding: 4,
                                },
                            },
                            labels: chartLabelsQuotations.reverse(),
                            colors: ["#2fb344"],
                            legend: {
                                show: false,
                            },
                        }).render();
                    //});
                    // @formatter:on
                    
                    
                    
                    /** **/
                    const statisticsIncome = response.data.chart.income.last30;
                    var chartDataIncome = [],
                        chartLabelsIncome = [];
                    
                    for (var i = 0; i < statisticsIncome.length; i++) {
                    //for (var i = statisticsPlan.length-1; i >= 0; i--) {
                        chartDataIncome.push(statisticsIncome[i]._value);
                        chartLabelsIncome.push(statisticsIncome[i]._date);
                    }
                    /** **/
                    
                    // @formatter:off
                    //document.addEventListener("DOMContentLoaded", function () {
                    window.ApexCharts &&
                        new ApexCharts(document.getElementById("chart-new-clients3"), {
                            chart: {
                                type: "line",
                                fontFamily: "inherit",
                                height: 40.0,
                                //width: parseFloat(chartDataPlanCount*12),
                                sparkline: {
                                    enabled: true,
                                },
                                animations: {
                                    enabled: false,
                                },
                            },
                            fill: {
                                opacity: 1,
                            },
                            stroke: {
                                width: [2, 1],
                                dashArray: [0, 3],
                                lineCap: "round",
                                curve: "smooth",
                            },
                            series: [
                                {
                                    name: "License",
                                    data: chartDataIncome.reverse(),
                                }
                            ],
                            grid: {
                                strokeDashArray: 4,
                            },
                            xaxis: {
                                labels: {
                                    padding: 0,
                                },
                                tooltip: {
                                    enabled: false,
                                },
                                type: "string",
                            },
                            yaxis: {
                                labels: {
                                    padding: 4,
                                },
                            },
                            labels: chartLabelsIncome.reverse(),
                            colors: ["#df5716"],  //"#206bc4","#a8aeb7"
                            legend: {
                                show: false,
                            },
                        }).render();
                    //});
                    // @formatter:on
                    
                    
                    
                    /** **/
                    const statisticsDonations = response.data.chart.donations.balance.last30;
                    var chartDataDonations = [],
                        chartLabelsDonations = [];
                    
                    for (var i = 0; i < statisticsDonations.length; i++) {
                    //for (var i = statisticsPlan.length-1; i >= 0; i--) {
                        chartDataDonations.push(statisticsDonations[i]._value);
                        chartLabelsDonations.push(statisticsDonations[i]._date);
                    }
                    /** **/
                    
                    
                    // @formatter:off
                    //document.addEventListener("DOMContentLoaded", function () {
                    window.ApexCharts &&
                        new ApexCharts(document.getElementById("chart-active-users"), {
                            chart: {
                                type: "bar",
                                fontFamily: "inherit",
                                height: 40.0,
                                width: parseFloat(statisticsDonations.length*12),
                                sparkline: {
                                    enabled: true,
                                },
                                animations: {
                                    enabled: false,
                                },
                            },
                            plotOptions: {
                                bar: {
                                    columnWidth: "50%",
                                },
                            },
                            dataLabels: {
                                enabled: false,
                            },
                            fill: {
                                opacity: 1,
                            },
                            series: [
                                {
                                    name: "License",
                                    data: chartDataDonations.reverse(),
                                    //data: chartData.reverse(),
                                },
                            ],
                            grid: {
                                strokeDashArray: 4,
                            },
                            xaxis: {
                                labels: {
                                    padding: 0,
                                },
                                tooltip: {
                                    enabled: false,
                                },
                                axisBorder: {
                                    show: false,
                                },
                                type: "string",
                            },
                            yaxis: {
                                labels: {
                                    padding: 4,
                                },
                            },
                            //labels: chartLabels.reverse(),
                            labels: chartLabelsDonations.reverse(),
                            colors: ["#f59f00"],
                            legend: {
                                show: false,
                            },
                        }).render();
                    //});
                    // @formatter:on
                    
                    
                    
                    /** **/
                    var countIn_yesterday = response.data.chart.indications.indirect.in_yesterday,
                        countIn_day = response.data.chart.indications.indirect.in_day,
                        variationIn_yesterdayStr = '',
                        countIn_dayStr = 'No registration today',
                        variationIn_day = response.data.chart.indications.indirect.in_day - response.data.chart.indications.indirect.in_yesterday;
                    
                    if (countIn_day > 1) {
                        countIn_dayStr = countIn_day + ' registration today';
                    }
                    if (countIn_day >= 2) {
                        countIn_dayStr = countIn_day + ' registrations today';
                    }
                    
                    if (variationIn_day == 0) {
                        variationIn_yesterdayStr = 
                              '<span class="text-yellow d-inline-flex align-items-center lh-1" title="">'
                            + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-minus" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '        <line x1="5" y1="12" x2="19" y2="12"></line>'
                            + '    </svg>'
                            + '    &nbsp;' + parseFloat(variationIn_day).toFixed(0) + ' stable'
                            + '</span>';
                    } else if (variationIn_day > 0) {
                        variationIn_yesterdayStr = 
                              '<span class="text-green d-inline-flex align-items-center lh-1" title="">'
                            + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '        <path stroke="none" d="M0 0h24v24H0z" fill="none" />'
                            + '        <polyline points="3 17 9 11 13 15 21 7" />'
                            + '        <polyline points="14 7 21 7 21 14" />'
                            + '    </svg>'
                            + '    &nbsp;' + parseFloat(variationIn_day).toFixed(0) + ' there is more'
                            + '</span>';
                    } else {
                        variationIn_yesterdayStr = 
                              '<span class="text-red d-inline-flex align-items-center lh-1" title="">'
                            + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-trending-down" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '        <polyline points="3 7 9 13 13 9 21 17"></polyline>'
                            + '        <polyline points="21 10 21 17 14 17"></polyline>'
                            + '    </svg>'
                            + '    &nbsp;' + parseFloat(variationIn_day).toFixed(0) + ' there is less'
                            + '</span>';
                    }
                    
                    var elNetworkBasicInfo = document.getElementById("networkBasicInfo");
                    elNetworkBasicInfo.innerHTML = 
                          '<div>' + countIn_dayStr + '</div>'
                        + '<div class="text-muted">'
                        +      variationIn_yesterdayStr
                        + '</div>';
                    /** **/
                    const statisticsNetworkUsers = response.data.chart.indications.indirect.last30;
                    var chartDataNetworkUsers = [],
                        chartLabelsNetworkUsers = [];
                    
                    for (var i = 0; i < statisticsNetworkUsers.length; i++) {
                    //for (var i = statisticsPlan.length-1; i >= 0; i--) {
                        chartDataNetworkUsers.push(parseInt(statisticsNetworkUsers[i]._count));
                        chartLabelsNetworkUsers.push(statisticsNetworkUsers[i]._date);
                    }
                    /** **/
                    
                    // @formatter:off
                    //document.addEventListener("DOMContentLoaded", function () {
                    window.ApexCharts &&
                        new ApexCharts(document.getElementById("chart-development-activity"), {
                            chart: {
                                type: "area",
                                fontFamily: "inherit",
                                height: 142,  //192
                                sparkline: {
                                    enabled: true,
                                },
                                animations: {
                                    enabled: false,
                                },
                            },
                            dataLabels: {
                                enabled: false,
                            },
                            fill: {
                                opacity: 0.16,
                                type: "solid",
                            },
                            stroke: {
                                width: 2,
                                lineCap: "round",
                                curve: "smooth",
                            },
                            series: [
                                {
                                    name: "Purchases",
                                    data: chartDataNetworkUsers.reverse(),
                                },
                            ],
                            grid: {
                                strokeDashArray: 4,
                            },
                            xaxis: {
                                labels: {
                                    padding: 0,
                                },
                                tooltip: {
                                    enabled: false,
                                },
                                axisBorder: {
                                    show: false,
                                },
                                type: "string",
                            },
                            yaxis: {
                                labels: {
                                    padding: 4,
                                },
                            },
                            labels: chartLabelsNetworkUsers.reverse(),
                            colors: ["#206bc4"],
                            legend: {
                                show: false,
                            },
                            point: {
                                show: false,
                            },
                        }).render();
                    //});
                    // @formatter:on
                /** END **/
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                //
            }
        });
    }
    
    setTimeout(function(){ indexLoadData(); }, 400);
</script>
