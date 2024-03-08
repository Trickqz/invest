<div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title">My profile</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
            <div class="row row-cards">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-3">
                                    <div class="mb-2" style="text-align: center;">
                                        <span class="avatar avatar-xl avatar-rounded mb-3" style="background-image: url('{{CFG__API_URL}}/d/uploads/accounts/{{system.userdata._id}}/profile/picture/{{system.userdata._picture_src}}'), url('../assets/img/picker_account.png');"></span>
                                        <!--<h3>{{system.userdata._name}}</h3>-->
                                        <br />
                                        <a href="javascript:View.openFormProfilePictureEdit();" style="/*cursor: no-drop;pointer-events: none;opacity: 0.7;*/">Alter picture</a>
                                    </div>
                                </div>
                                <div class="col-9">
                                    <!--<h3 class="card-title">Conta e dados pessoais</h3>
                                    <div class="card-subtitle">Card subtitle</div>-->
                                    <p>
                                        <span style="width: 100%;display: inline-block;"><b>Name:</b> {{system.userdata._name}}</span><br />
                                        <span style="width: 100%;display: inline-block;"><b>Username:</b> {{system.userdata._username}}</span><br />
                                        {{#contains "natural_person" system.userdata._type}}
                                            <span style="width: 100%;display: inline-block;"><b>CPF:</b> {{system.userdata._cpf}}</span><br /><br />
                                        {{else}}
                                        {{/contains}}
                                        {{#contains "legal_person" system.userdata._type}}
                                            <span style="width: 100%;display: inline-block;"><b>CNPJ:</b> {{system.userdata._cnpj}}</span><br /><br />
                                        {{else}}
                                        {{/contains}}
                                        <span style="width: 100%;display: inline-block;"><b>Mobile phone:</b> {{system.userdata._mobile_phone}}</span><br />
                                        <span style="width: 100%;display: inline-block;"><b>Email:</b> {{system.userdata._email}}</span><br />
                                        <span style="width: 100%;display: inline-block;"><b>Coinbase Account (email):</b> {{system.userdata._coinbase_email}}</span><br />
                                        
                                        {{#if system.isadmin}}
                                        {{else}}
                                            <span style="width: 100%;display: inline-block;"><b>Sponsor:</b> {{system.userdata._sponsorname}}</span><br />
                                        {{/if}}
                                        
                                        {{#if settings.use_account_validation}}
                                            {{#contains "waiting" system.userdata._verification_status}}
                                                <span style="margin-top: 8px;display: inline-block;"><span class="badge bg-red">Pending validation</span>&nbsp;&nbsp;<a href="javascript:View.openFormProfileDocumentsEdit();">Send documents</a></span>
                                            {{else}}
                                                {{#contains "validating" system.userdata._verification_status}}
                                                    <span style="margin-top: 8px;display: inline-block;"><span class="badge bg-yellow">Validation in progress</span></span>
                                                {{else}}
                                                    {{#contains "invalidated" system.userdata._verification_status}}
                                                        <span style="margin-top: 8px;display: inline-block;"><span class="badge bg-red">Account not validated</span>&nbsp;&nbsp;<a href="javascript:View.openFormProfileDocumentsEdit();">Resend documents</a></span>
                                                    {{else}}
                                                        {{#contains "validated" system.userdata._verification_status}}
                                                            <span style="margin-top: 8px;display: inline-block;"><span class="badge bg-green">Account validated</span></span>
                                                        {{else}}
                                                        {{/contains}}
                                                    {{/contains}}
                                                {{/contains}}
                                            {{/contains}}
                                        {{else}}
                                        {{/if}}
                                    </p>
                                    <a href="javascript:View.openFormProfilePersonalDataEdit();">Alter personal data</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="card-title">Crypto wallet</h3>
                            <div class="card-subtitle">Your crypto wallet</div>
                            <p>
                                <span style="width: 100%;display: inline-block;"><b>Wallet:</b> {{system.userdata._crypto_wallet}}</span><br />
                            </p>
                            <p>
                                <span style="width: 100%;display: inline-block;"><b>Network:</b> {{system.userdata._crypto_wallet_network}}</span><br />
                            </p>
                            <a href="javascript:View.openFormProfileCryptoWalletEdit('{{tmp._id}}');">Edit crypto wallet</a>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="card-title">Address</h3>
                            <div class="card-subtitle">Your main address</div>
                            <p>
                                {{system.userdata._address_street}}, nº {{system.userdata._address_number}}, {{system.userdata._address_district}}, {{system.userdata._address_city}} - {{system.userdata._address_state}}
                            </p>
                            <a href="javascript:View.openFormProfileAddressEdit();">Alter address</a>
                        </div>
                    </div>
                </div>
                <div class="col-12" style="display: none;">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="card-title">Bank account</h3>
                            <div class="card-subtitle">Your bank account</div>
                            <p>
                                <span style="width: 70px;display: inline-block;"><b>Bank:</b></span> {{system.userdata._bank_bank_number}}&nbsp;&nbsp;{{system.userdata._bank_bank_name}}<br />
                                <span style="width: 70px;display: inline-block;"><b>Agency:</b></span> {{system.userdata._bank_agency_number}}&nbsp;&nbsp;{{system.userdata._bank_agency_digit}}<br />
                                <span style="width: 70px;display: inline-block;"><b>Account:</b></span> {{system.userdata._bank_account_number}}&nbsp;&nbsp;{{system.userdata._bank_account_digit}}<br />
                                <span style="width: 70px;display: inline-block;"><b>Type:</b></span> 
                                {{#contains "cc" system.userdata._bank_account_type}}
                                    Current account
                                {{else}}
                                    {{#contains "cp" system.userdata._bank_account_type}}
                                        Savings account
                                    {{else}}
                                    {{/contains}}
                                {{/contains}}
                            </p>
                            <p>
                                <span style="width: 70px;display: inline-block;"><b>Holder:</b></span>{{system.userdata._bank_holder_name}}<br />
                                <span style="width: 70px;display: inline-block;"><b>DOC:</b></span>{{formatdoc system.userdata._bank_holder_doc}}
                            </p>
                            <a href="javascript:View.openFormProfileBankEdit();">Alter bank account</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <a href="#" class="btn" data-bs-dismiss="modal">
                Close
            </a>
        </div>
    </div>
</div>

<script>
    /** **/
</script>
