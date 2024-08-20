<style>

canvas {
  width: 100%;
  height: 100%;
}

#particle-container {
    position: absolute;
    width: 100%;
    height: 152px;
    overflow: hidden;
    z-index: 1;
}

.particle {
    position: absolute;
    bottom: 2px;
    width: 4px;
    height: 4px;
    background-color: #bb9e73;
    border-radius: 50%;
    filter: blur(5px);
    animation: move 10s linear infinite;
    opacity: 0;
}

@keyframes move {
    0% {
        transform: translateY(100%);
        opacity: 1;
    }
    100% {
        transform: translateY(-5000%);
        opacity: 0;
    }
}

.card-1-1 {
    position: relative;
    height: 154px;
    width: 100%;
    border-radius: 15px;
    background-color: rgba(255, 255, 255, 0.08);
    overflow: hidden;
    z-index: 2;
}

.logo img,
.chip img,
.number,
.name,
.from,
.to,
.ring {
  position: absolute;
}

.logo img {
  bottom: 20px;
  right: 20px;
  width: 100px;
  height: auto;
  opacity: 0.8;
}

.name {
  left: 26px;
  top: 20px;
}

.number {
  left: 26px;
  top: 35px;
  font-size: 1.5rem;
  font-weight: 500;
}

.from {
  font-size: 0.5rem;
  bottom: 35px;
  right: 110px;
}

.to {
  font-size: 0.5rem;
  bottom: 35px;
  right: 40px;
}

.ring {
  height: 500px;
  width: 500px;
  border-radius: 50%;
  background: transparent;
  border: 50px solid #bb9e7320;
  bottom: -250px;
  right: -250px;
  box-sizing: border-box;
}

.ring::after {
  content: "";
  position: absolute;
  height: 600px;
  width: 600px;
  border-radius: 50%;
  background: transparent;
  border: 30px solid #bb9e7320;
  bottom: -80px;
  right: -110px;
  box-sizing: border-box;
}

.progress-bar33-color {
    background-color: #bb9e73;
}

.progress-bar22-color {
    background-color: #16334f;
}

.btn-primary {
    --tblr-btn-color: #bb9e73 !important;
    --tblr-btn-color-interactive: #bb9e7370 !important;
    --tblr-btn-color-text: #fafbfc !important
}

body {
    background-color: rgba(9, 20, 31, 1) !important;
}

.theme-dark .navbar {
    background-color: rgba(20, 31, 41, 1)
}

.theme-dark .alert:not(.alert-important), .theme-dark .card, .theme-dark .card-footer, .theme-dark .card-stacked::after, .theme-dark .dropdown-menu, .theme-dark .footer:not(.footer-transparent), .theme-dark .modal-content, .theme-dark .modal-header {
    background-color: rgba(20, 31, 41, 1);
    color: inherit;
}

.btn {
    --tblr-btn-color-text-rgb: var(--tblr-body-color-rgb);
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border-color: rgba(187, 158, 115, 0.10);
    white-space: nowrap;
    background-color: rgba(187, 158, 115, 0.79);
    color: var(--tblr-btn-color-text);
}

.theme-dark .form-check-input:not(:checked), .theme-dark .form-control, .theme-dark .form-file-text, .theme-dark .form-imagecheck-figure:before, .theme-dark .form-select, .theme-dark .form-selectgroup-check, .theme-dark .form-selectgroup-label {
    background-color: rgba(187, 158, 115, 0.79);
    color: #fafbfc;
    border-color: #2c3c56;
}

.viewreporttext {
    font-size: 10px;
    font-weight: 400;
    margin-top: 5px
}

.welcomewidthpx {
    font-size: 28px !important;
}

@media (max-width: 575px) {
    .card-1-1 {
        height: 300px;
        width: 100%;
    }

    .borderlinedivision {
        display: block !important;
    }
}
.borderlinedivision {
    margin-top: 20px !important;
    margin-bottom: 20px !important;
    width: 100%;
    height: 1px;
    background-color: rgba(255, 255, 255, 0.08);
}
</style>

<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <!-- Page pre-title -->
                <div class="page-pretitle">
                    Welcome
                </div>
            <h2 class="page-title welcomewidthpx">Hi {{system.userdata._name}}, It's good to have you back!</h2>
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
                <div id="card1" class="card-1-1">
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
                <div class="borderlinedivision" style="display: none"></div>
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
                        <div class="col-sm-6">
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
                '<div class="card-group">'
            + '  <div class="card-1-1">'
            + '      <div id="particle-container"></div>'
            + '      <div class="logo"><img src="./assets/img/logocart.png" alt="Visa"></div>'
            + '      <div class="number">' + fmtMoney(arr.wallet.balance.total) + '</div>'
            + '      <div class="name subheader" style="display: flex; align-items: center;">'
            + '        <svg width="15" height="15" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">'
            + '            <path d="M19.5 6H0.5V8H19.5V6Z" fill="#fff"/>'
            + '            <path d="M8.5 13H3.5C3.22357 13 3 13.2236 3 13.5C3 13.7764 3.22357 14 3.5 14H8.5C8.77637 14 9 13.7764 9 13.5C9 13.2236 8.77637 13 8.5 13Z" fill="#fff"/>'
            + '            <path d="M18.2998 3H1.7002C0.7627 3 0 3.7627 0 4.7002V15.2998C0 16.2373 0.7627 17 1.7002 17H18.2998C19.2373 17 20 16.2373 20 15.2998V4.7002C20 3.7627 19.2373 3 18.2998 3ZM19 15.2998C19 15.686 18.6855 16 18.2998 16H1.7002C1.31446 16 1 15.686 1 15.2998V4.7002C1 4.31397 1.31445 4 1.7002 4H18.2998C18.6855 4 19 4.31396 19 4.7002V15.2998Z" fill="#fff"/>'
            + '        </svg>'
            + '        <div style="margin-left: 10px; color: #fff;">Balance</div>'
            + '       </div>'
            + '      <div class="ring"></div>'
            + '  </div>'
            + '</div>';


            const container = document.getElementById('particle-container');

            for (let i = 0; i < 50; i++) { // Reduzi o número de partículas para se adequar ao tamanho do cartão
                const particle = document.createElement('div');
                particle.classList.add('particle');
                particle.style.left = `${Math.random() * 100}%`;
                particle.style.animationDelay = `${Math.random() * 10}s`;
                particle.style.animationDuration = `${Math.random() * 5 + 5}s`;
                container.appendChild(particle);
            }

                var blockedStr = '<div>';
                if (arr.personal_income.available > 0) {
                    blockedStr += '<span title="Aid income released" class="text-green"><svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-bolt-off" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><desc>Download more icon variants from https://tabler-icons.io/i/bolt-off</desc><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="3" y1="3" x2="21" y2="21" /><path d="M15.212 15.21l-4.212 5.79v-7h-6l3.79 -5.21m1.685 -2.32l2.525 -3.47v6m1 1h5l-2.104 2.893" /></svg> ' + fmtMoney(arr.personal_income.available) + ' / avaliable for balance</span><br />';
                }
                if (arr.personal_income.blocked > 0) {
                    blockedStr += '<span title="Aid income blocked"><svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-bolt-off" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><desc>Download more icon variants from https://tabler-icons.io/i/bolt-off</desc><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="3" y1="3" x2="21" y2="21" /><path d="M15.212 15.21l-4.212 5.79v-7h-6l3.79 -5.21m1.685 -2.32l2.525 -3.47v6m1 1h5l-2.104 2.893" /></svg> ' + fmtMoney(arr.personal_income.blocked) + '</span><br />';
                }
                
                var blockedStr = '<div>';
                if (arr.personal_income.available > 0) {
                    blockedStr += '<span title="Aid income released" class="text-green"><svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-bolt-off" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><desc>Download more icon variants from https://tabler-icons.io/i/bolt-off</desc><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="3" y1="3" x2="21" y2="21" /><path d="M15.212 15.21l-4.212 5.79v-7h-6l3.79 -5.21m1.685 -2.32l2.525 -3.47v6m1 1h5l-2.104 2.893" /></svg> ' + fmtMoney(arr.personal_income.available) + ' / avaliable for balance</span><br />';
                }
                if (arr.personal_income.blocked > 0) {
                    blockedStr += '<span title="Aid income blocked"><svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-bolt-off" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><desc>Download more icon variants from https://tabler-icons.io/i/bolt-off</desc><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="3" y1="3" x2="21" y2="21" /><path d="M15.212 15.21l-4.212 5.79v-7h-6l3.79 -5.21m1.685 -2.32l2.525 -3.47v6m1 1h5l-2.104 2.893" /></svg> ' + fmtMoney(arr.personal_income.blocked) + '</span><br />';
                }
                
                document.getElementById("card2").innerHTML = 
                      '<div class="card-body">'
                    + '    <div class="d-flex align-items-center">'
                    + '        <svg width="15" height="15" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">'
                    + '            <path d="M13.5 5C13.2239 5 13 5.22386 13 5.5C13 5.77614 13.2239 6 13.5 6H18.2929L11.5 12.7929L6.85355 8.1465C6.65829 7.95124 6.34171 7.95124 6.14645 8.1465L0.146447 14.1465C-0.0488155 14.3418 -0.0488155 14.6583 0.146447 14.8536C0.341709 15.0489 0.658291 15.0489 0.853553 14.8536L6.5 9.20716L11.1464 13.8536C11.3417 14.0489 11.6583 14.0489 11.8536 13.8536L19 6.70716V11.5C19 11.7761 19.2239 12 19.5 12C19.7761 12 20 11.7761 20 11.5V5.5C20 5.22386 19.7761 5 19.5 5H13.5Z" fill="#fff"/>'
                    + '        </svg>'
                    + '        <div class="subheader" style="margin-left: 10px; color: #fff;">Gain</div>'
                    + '    </div>'
                    + '<div class="h1 mb-3 row" title="Total gain">'
                    + '<div class="col-sm-8">' + fmtMoney(arr.wallet.gain.total) + '</div>'
                    + '<div class="col-sm-4" style="flex-direction: column-reverse; align-items: center; display: flex;">'
                    + '<p class="viewreporttext">VIEW REPORT</p>'
                    + '<a href="javascript:router.navigate(`/income-extract`);">'
                    + '<button type="button" class="btn btn-primary " data-tab="left" title="Income [Extract]">'
                    + '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-arrow-autofit-down m-0" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                    + '<path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                    + '<path d="M12 20h-6a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 2 -2h8"></path>'
                    + '<path d="M18 4v17"></path>'
                    + '<path d="M15 18l3 3l3 -3"></path>'
                    + '</svg>'
                    + '</a>'
                    + '</div>'
                    + '</div>'
                    + '    <div class="d-flex /*mb-2*/">'
                    + '        <div class="text-green">'
                    + '            <span class="text-red d-inline-flex align-items-center lh-1">'
                    +                  blockedStr
                    + '            </span>'
                    + '        </div>'
                    + '    </div>'
                    + '    <div id="previsionGain" class="d-flex mb-2">'
                    + '        <div class="skeleton-line"></div>'
                    + '    </div>'
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
                            + '            <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">'
                            + '            <path fill-rule="evenodd" clip-rule="evenodd" d="M10.9914 13.0447C10.9755 13.1298 10.9475 13.2126 10.9086 13.2927C10.8012 13.513 10.6929 13.6965 10.5836 13.8488C10.4226 14.0732 10.475 14.3863 10.6998 14.5464C10.9242 14.7073 11.2365 14.6545 11.3971 14.4311C11.5346 14.2389 11.6717 14.0092 11.8075 13.7316C11.9074 13.5255 11.9723 13.3045 11.9964 13.0813C12.0567 12.558 11.6609 12.0844 11.1268 12.0522C10.6479 12.0221 9.90815 11.9057 9.39193 11.6255C9.14844 11.4943 8.84545 11.5843 8.7137 11.8264C8.58155 12.0694 8.67253 12.3728 8.91469 12.5045C9.52985 12.8377 10.3969 13.0003 10.9914 13.0447Z" fill="#fff"/>'
                            + '            <path d="M19.9378 16.2589C19.1839 14.8881 18.3553 14.7229 17.6888 14.5902C17.0711 14.4671 16.6248 14.3781 16.0931 13.2926C16.0433 13.1917 16.0273 13.1328 15.9922 13.0508C17.412 12.963 19.0144 12.4193 19.0144 11.1745C19.0144 10.9599 18.9573 10.7454 18.8401 10.5197C17.9485 8.79306 17.2352 6.03587 17.2269 6.00267C16.7283 4.15051 15.3001 3 13.4998 3C11.9573 2.99999 10.658 3.85576 10.0232 5.28935C9.91143 5.54185 10.0252 5.83714 10.2776 5.94895C10.5315 6.06144 10.826 5.94663 10.9373 5.69419C11.4144 4.6176 12.3479 3.99998 13.4998 3.99998C14.8475 3.99998 15.8797 4.84574 16.2596 6.25675C16.2898 6.37406 17.0076 9.15023 17.9519 10.9793C17.9935 11.0591 18.0144 11.1248 18.0144 11.1745C18.0144 11.6143 16.887 11.9906 15.8748 12.0531C15.6199 12.0692 15.3802 12.1901 15.2166 12.3853C15.054 12.5792 14.9773 12.8347 15.0057 13.0852C15.0311 13.3107 15.095 13.5288 15.1951 13.7329C15.9441 15.2621 16.803 15.4334 17.4935 15.5709C18.074 15.6865 18.532 15.7779 19.0618 16.7409C19.1945 16.9829 19.4998 17.0709 19.7405 16.938C19.9827 16.805 20.0711 16.501 19.9378 16.2589Z" fill="#fff"/>'
                            + '            <path fill-rule="evenodd" clip-rule="evenodd" d="M0.973471 16.6623C1.23249 15.9085 1.69352 15.6875 2.20556 15.5355C2.66459 15.3995 3.15763 15.3035 3.63166 15.0776C5.16077 14.3447 5.42979 12.324 4.32671 11.0382C3.57565 10.1633 3.00061 8.96854 3.00061 7.77572C3.00061 5.57206 4.33871 4.00131 6.00083 4.00131C7.66294 4.00131 9.00104 5.57206 9.00104 7.77572C9.00104 8.96854 8.426 10.1633 7.67495 11.0382C6.57187 12.324 6.84089 14.3447 8.36999 15.0776C8.84403 15.3035 9.33706 15.3995 9.79609 15.5355C10.3081 15.6875 10.7692 15.9085 11.0282 16.6623C11.1182 16.9233 11.4032 17.0623 11.6642 16.9723C11.9252 16.8823 12.0643 16.5973 11.9742 16.3364C11.5722 15.1696 10.8742 14.8116 10.0801 14.5767C9.66909 14.4557 9.22605 14.3777 8.80202 14.1757C7.86396 13.7268 7.75795 12.478 8.435 11.6881C9.33206 10.6413 10.0011 9.2045 10.0011 7.77572C10.0011 4.92916 8.14798 3.00146 6.00083 3.00146C3.85367 3.00146 2.00054 4.92916 2.00054 7.77572C2.00054 9.2045 2.66959 10.6413 3.56665 11.6881C4.2437 12.478 4.13769 13.7268 3.19963 14.1757C2.7756 14.3777 2.33257 14.4557 1.92154 14.5767C1.12748 14.8116 0.429432 15.1696 0.0274039 16.3364C-0.0626025 16.5973 0.0764073 16.8823 0.337426 16.9723C0.598444 17.0623 0.883465 16.9233 0.973471 16.6623Z" fill="#fff"/>'
                            + '            </svg>'
                            + '        <div class="subheader" style="color: white; margin-left: 10px">RECOMMENDATIONS</div>'
                            {{/if}}
                            + '    </div>'
                            + '    <div class="d-flex align-items-baseline">'
                            + '        <div class="h1 mb-3 me-2">' + arr.count.accounts.total + '</div>'
                            + '        <div class="me-auto">'
                            + '        </div>'
                            + '    </div>'
                            + '    <div id="chart-new-clients" class="chart-sm"></div>'
                            + '</div>';
                        
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
                            + '            <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">'
                            + '            <g clip-path="url(#clip0_19_3775)">'
                            + '            <path fill-rule="evenodd" clip-rule="evenodd" d="M0.5 0C0.776142 0 1 0.223858 1 0.5V18.2607C1 18.669 1.33101 19 1.73907 19H19.5C19.7761 19 20 19.2239 20 19.5C20 19.7761 19.7761 20 19.5 20H1.73907C0.778536 20 0 19.2211 0 18.2607V0.5C0 0.223858 0.223858 0 0.5 0Z" fill="#fff"/>'
                            + '            <path fill-rule="evenodd" clip-rule="evenodd" d="M4.5 11C4.77614 11 5 11.2239 5 11.5V16.5C5 16.7761 4.77614 17 4.5 17C4.22386 17 4 16.7761 4 16.5V11.5C4 11.2239 4.22386 11 4.5 11Z" fill="#fff"/>'
                            + '            <path fill-rule="evenodd" clip-rule="evenodd" d="M8.5 5C8.77614 5 9 5.22386 9 5.5V16.5C9 16.7761 8.77614 17 8.5 17C8.22386 17 8 16.7761 8 16.5V5.5C8 5.22386 8.22386 5 8.5 5Z" fill="#fff"/>'
                            + '            <path fill-rule="evenodd" clip-rule="evenodd" d="M12.5 8C12.7761 8 13 8.22386 13 8.5V16.5C13 16.7761 12.7761 17 12.5 17C12.2239 17 12 16.7761 12 16.5V8.5C12 8.22386 12.2239 8 12.5 8Z" fill="#fff"/>'
                            + '            <path fill-rule="evenodd" clip-rule="evenodd" d="M16.5 1C16.7761 1 17 1.22386 17 1.5V16.5C17 16.7761 16.7761 17 16.5 17C16.2239 17 16 16.7761 16 16.5V1.5C16 1.22386 16.2239 1 16.5 1Z" fill="#fff"/>'
                            + '            </g>'
                            + '            <defs>'
                            + '            <clipPath id="clip0_19_3775">'
                            + '            <rect width="15" height="15" fill="white"/>'
                            + '            </clipPath>'
                            + '            </defs>'
                            + '            </svg>'
                            + '        <div class="subheader" style="margin-left: 10px; color: #fff;">AXEL DAILY INCOME</div>'
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
                        
                       var perc_income = 100,
                        perc_received = (arr.donations.received / arr.donations.income) * 100,
                        perc_gain = (arr.wallet.gain.total / arr.donations.income) * 100;

                        const totalGain = arr.wallet.gain.total;
                        const totalDonation = arr.donations.income - arr.donations.received;

                        const divisionResult = totalDonation - totalGain;
                        const formattedResult = fmtMoney(divisionResult);

                        document.getElementById("card7").innerHTML = 
                            '<div class="card-body">'                
                            + '    <div class="d-flex align-items-center">'
                            + '         <svg width="15" height="15" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">' 
                            + '         <path fill-rule="evenodd" clip-rule="evenodd" d="M9.5 9H13.5V10H9.5V9Z" fill="#fff"/>' 
                            + '         <path fill-rule="evenodd" clip-rule="evenodd" d="M7 3H5.5V2H7C8.65682 2 10 3.34316 10 5V15C10 16.1046 10.8954 17 12 17H13.5V18H12C10.3431 18 9 16.6568 9 15V5C9 3.89544 8.10454 3 7 3Z" fill="#fff"/>' 
                            + '         <path fill-rule="evenodd" clip-rule="evenodd" d="M3.5 1C2.67157 1 2 1.67157 2 2.5C2 3.32843 2.67157 4 3.5 4C4.32843 4 5 3.32843 5 2.5C5 1.67157 4.32843 1 3.5 1ZM1 2.5C1 1.11929 2.11929 0 3.5 0C4.88071 0 6 1.11929 6 2.5C6 3.88071 4.88071 5 3.5 5C2.11929 5 1 3.88071 1 2.5Z" fill="#fff"/>' 
                            + '         <path fill-rule="evenodd" clip-rule="evenodd" d="M15.5 16C14.6716 16 14 16.6716 14 17.5C14 18.3284 14.6716 19 15.5 19C16.3284 19 17 18.3284 17 17.5C17 16.6716 16.3284 16 15.5 16ZM13 17.5C13 16.1193 14.1193 15 15.5 15C16.8807 15 18 16.1193 18 17.5C18 18.8807 16.8807 20 15.5 20C14.1193 20 13 18.8807 13 17.5Z" fill="#fff"/>' 
                            + '         <path fill-rule="evenodd" clip-rule="evenodd" d="M15.5 8C14.6716 8 14 8.67157 14 9.5C14 10.3284 14.6716 11 15.5 11C16.3284 11 17 10.3284 17 9.5C17 8.67157 16.3284 8 15.5 8ZM13 9.5C13 8.11929 14.1193 7 15.5 7C16.8807 7 18 8.11929 18 9.5C18 10.8807 16.8807 12 15.5 12C14.1193 12 13 10.8807 13 9.5Z" fill="#fff"/>' 
                            + '         </svg>' 
                            + '        <div class="subheader" style="margin-left: 10px; color: #fff;">License progress</div>'
                            + '    </div>'
                            + '    <p class="mb-3">'+ fmtMoney(totalGain)+' <span class="data--points-graduation-estimate"> / <strong>' + formattedResult + '</strong> to <strong>' + fmtMoney(arr.donations.income) + '</strong></span></p>'
                            + '      <div class="progress progress-separated mb-3">'
                            + '          <div class="progress-bar22-color" role="progressbar" style="width: ' + perc_gain + '%;"></div>'  // Exibindo o ganho
                            + '          <div class="progress-bar33-color" role="progressbar" style="width: 100%;"></div>'
                            + '      </div>'
                            + '      <div class="row">'
                            + '          <div class="col-auto d-flex align-items-center px-2">'
                            + '              <span class="legend me-2 progress-bar22-color"></span>'
                            + '              <span>Gain</span>'
                            + '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted"></span>'
                            + '          </div>'
                            + '          <div class="col-auto d-flex align-items-center pe-2">'
                            + '              <span class="legend me-2 progress-bar33-color"></span>'
                            + '              <span>To be received</span>'
                            + '              <span class="d-none d-md-inline d-lg-none d-xxl-inline ms-2 text-muted"></span>'
                            + '          </div>'
                            + '    </div>'
                            + '</div>';


                            let totalDonations = arr.count.donations.total; 
                            let totalDonationsNumber = parseFloat(totalDonations);
                            let tenTimesDonations = totalDonationsNumber * 10;
                            let formattedTenTimesDonations = fmtMoney(tenTimesDonations);

                            document.getElementById("card4").innerHTML = 
                            '<div class="card-body">'
                            + '    <div class="d-flex align-items-center">'
                            + '            <svg width="15" height="15" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">'
                            + '            <path d="M5.5 0C5.22357 0 5 0.22363 5 0.5V3.5C5 3.77637 5.22357 4 5.5 4C5.77637 4 6 3.77637 6 3.5V0.5C6 0.22363 5.77637 0 5.5 0Z" fill="#fff"/>'
                            + '            <path d="M5.5 11C5.22357 11 5 11.2236 5 11.5V19.5C5 19.7764 5.22357 20 5.5 20C5.77637 20 6 19.7764 6 19.5V11.5C6 11.2236 5.77637 11 5.5 11Z" fill="#fff"/>'
                            + '            <path d="M14.5 0C14.2236 0 14 0.22363 14 0.5V5.5C14 5.77637 14.2236 6 14.5 6C14.7764 6 15 5.77637 15 5.5V0.5C15 0.22363 14.7764 0 14.5 0Z" fill="#fff"/>'
                            + '            <path d="M14.5 17C14.2236 17 14 17.2236 14 17.5V19.5C14 19.7764 14.2236 20 14.5 20C14.7764 20 15 19.7764 15 19.5V17.5C15 17.2236 14.7764 17 14.5 17Z" fill="#fff"/>'
                            + '            <path d="M6.2998 3H4.7002C3.7627 3 3 3.7627 3 4.7002V10.2998C3 11.2373 3.7627 12 4.7002 12H6.29981C7.23731 12 8.00001 11.2373 8.00001 10.2998V4.7002C8.00001 3.7627 7.2373 3 6.2998 3ZM7 10.2998C7 10.686 6.68549 11 6.2998 11H4.7002C4.31446 11 4 10.686 4 10.2998V4.7002C4 4.31397 4.31445 4 4.7002 4H6.29981C6.68549 4 7.00001 4.31396 7.00001 4.7002L7 10.2998Z" fill="#fff"/>'
                            + '            <path d="M15.2998 5H13.7002C12.7627 5 12 5.7627 12 6.7002V16.2998C12 17.2373 12.7627 18 13.7002 18H15.2998C16.2373 18 17 17.2373 17 16.2998V6.7002C17 5.7627 16.2373 5 15.2998 5ZM16 16.2998C16 16.686 15.6855 17 15.2998 17H13.7002C13.3145 17 13 16.686 13 16.2998V6.7002C13 6.31397 13.3144 6 13.7002 6H15.2998C15.6855 6 16 6.31396 16 6.7002V16.2998Z" fill="#fff"/>'
                            + '            </svg>'
                            + '        <div class="subheader" style="margin-left: 10px; color: #fff;">financial contribution</div>'
                            + '    </div>'
                            + '    <div class="h1 mb-3">' + formattedTenTimesDonations + '</div>'
                            + '    <div class="d-flex /*mb-2*/">'
                            + '        <div class="text-green">'+ formattedTenTimesDonations +' active'
                            + '        </div>'
                            + '    </div>'
                            + '    <div id="previsionGain1" class="d-flex mb-2">'
                            + '        <div class="skeleton-line"></div>'
                            + '    </div>'
                            + '    <div id="chart-active-users" class="chart-sm" style="display: none;"></div>'
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
                        + '        <div class="empty-img"><img src="/assets/js/libs/1.0.0-beta20/demo/static/illustrations/undraw_printing_invoices_5r4r.svg" height="128" alt="" /></div>'
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
                            colors: ["#bb9e73"],  //"#bb9e73"
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
                            colors: ["#bb9e73"],
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
                            colors: ["#bb9e73"],  //"#bb9e73","#bb9e73"
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
                            colors: ["#bb9e73"],
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