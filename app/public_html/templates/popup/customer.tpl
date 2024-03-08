<div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title">Profile of <b>{{tmp._name}}</b></h5>
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
                                        <span class="avatar avatar-xl avatar-rounded mb-3" style="background-image: url('{{CFG__API_URL}}/d/uploads/accounts/{{tmp._id}}/profile/picture/{{tmp._picture_src}}'), url('../assets/img/picker_account.png');"></span>
                                        <!--<h3>{{tmp._name}}</h3>-->
                                        <!--<a href="javascript:View.openFormProfilePictureEdit();" style="/*cursor: no-drop;pointer-events: none;opacity: 0.7;*/">Alterar foto</a>-->
                                    </div>
                                </div>
                                <div class="col-9">
                                    <!--<h3 class="card-title">Conta e dados pessoais</h3>
                                    <div class="card-subtitle">Card subtitle</div>-->
                                    <p>
                                        <span style="width: 70px;display: inline-block;"><b>Name:</b></span> {{tmp._name}}<br />
                                        <span style="width: 70px;display: inline-block;"><b>Username:</b></span> {{tmp._username}}<br />
                                        {{#contains "natural_person" tmp._type}}
                                            <span style="width: 70px;display: inline-block;"><b>CPF:</b></span> {{tmp._cpf}}<br /><br />
                                        {{else}}
                                        {{/contains}}
                                        {{#contains "legal_person" tmp._type}}
                                            <span style="width: 70px;display: inline-block;"><b>CNPJ:</b></span> {{tmp._cnpj}}<br /><br />
                                        {{else}}
                                        {{/contains}}
                                        <span style="width: 70px;display: inline-block;"><b>Mobile phone:</b></span> {{tmp._mobile_phone}}<br />
                                        <span style="width: 70px;display: inline-block;"><b>Email:</b></span> {{tmp._email}}<br />
                                        <span style="width: 70px;display: inline-block;"><b>Wallet crypto:</b></span> {{tmp._coinbase_email}}<br />
                                        
                                        {{#if system.isadmin}}
                                        {{else}}
                                            <span style="width: 70px;display: inline-block;"><b>Sponsor:</b></span> {{tmp.network.sponsor}}<br />
                                        {{/if}}
                                        
                                        {{#if settings.use_account_validation}}
                                            {{#contains "waiting" tmp._verification_status}}
                                                <span style="margin-top: 8px;display: inline-block;"><span class="badge bg-red">Validation pending</span>&nbsp;&nbsp;<a href="javascript:View.openFormProfileDocumentsEdit();">Send documents</a></span>
                                            {{else}}
                                                {{#contains "validating" tmp._verification_status}}
                                                    <span style="margin-top: 8px;display: inline-block;"><span class="badge bg-yellow">Validation in progress</span></span>
                                                {{else}}
                                                    {{#contains "invalidated" tmp._verification_status}}
                                                        <span style="margin-top: 8px;display: inline-block;"><span class="badge bg-red">Account not validated</span>&nbsp;&nbsp;<a href="javascript:View.openFormProfileDocumentsEdit();">Resend documents</a></span>
                                                    {{else}}
                                                        {{#contains "validated" tmp._verification_status}}
                                                            <span style="margin-top: 8px;display: inline-block;"><span class="badge bg-green">Validated account</span></span>
                                                        {{else}}
                                                        {{/contains}}
                                                    {{/contains}}
                                                {{/contains}}
                                            {{/contains}}
                                        {{else}}
                                        {{/if}}
                                        
                                        {{#if tmp._joker_account}}
                                            <span style="width: 70px;display: inline-block;"><b>*Special:</b></span>
                                            <span id="joker--account">Joker account&nbsp;&nbsp;<a href="javascript:;" onclick="fc_setJokerAccount('false');">Set normal account</a></span><br />
                                        {{else}}
                                            <span style="width: 70px;display: inline-block;"><b>*Special:</b></span>
                                            <span id="joker--account">Normal account&nbsp;&nbsp;<a href="javascript:;" onclick="fc_setJokerAccount('true');">Set Joker account</a></span><br />
                                        {{/if}}
                                    </p>
                                    
                                    <script>
                                        function fc_setJokerAccount(key) {
                                            $.ajax({
                                                type: 'POST',
                                                url: CFG__API_URL + CFG__API_VERSION + "/account/joker/{{tmp._id}}",
                                                beforeSend: function (xhr){ 
                                                    xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                                                },
                                                data: {
                                                    "key": key
                                                },
                                                success: function(response) {
                                                    if (response.success === true) {
                                                        if (key == 'true') {
                                                            document.getElementById("joker--account").innerHTML = 'Joker account&nbsp;&nbsp;<a href="javascript:;" onclick="fc_setJokerAccount(\'false\');">Set normal account</a>';
                                                        } else {
                                                            document.getElementById("joker--account").innerHTML = 'Normal account&nbsp;&nbsp;<a href="javascript:;" onclick="fc_setJokerAccount(\'true\');">Set Joker account</a>';
                                                        }
                                                        
                                                        if (typeof fc__customersGetAll === 'function') {
                                                            fc__customersGetAll("*");
                                                        }
                                                    } else {
                                                        App.alert('Warning', response.message, null);
                                                    }
                                                }
                                            });
                                        }
                                    </script>
                                    
                                    <a href="javascript:View.openFormCustomersProfilePersonalDataEdit('{{tmp._id}}');">Edit personal data</a>
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
                                <span style="width: 70px;display: inline-block;"><b>Wallet:</b></span> {{tmp._crypto_wallet}}<br />
                            </p>
                            <a href="javascript:View.openFormCustomersProfileCryptoWalletEdit('{{tmp._id}}');">Edit crypto wallet</a>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="card-title">Address</h3>
                            <div class="card-subtitle">Your main address</div>
                            <p>
                                {{tmp._address_street}}, nº {{tmp._address_number}}, {{tmp._address_district}}, {{tmp._address_city}} - {{tmp._address_state}}
                            </p>
                            <a href="javascript:View.openFormCustomersProfileAddressEdit('{{tmp._id}}');">Edit address</a>
                        </div>
                    </div>
                </div>
                <div class="col-12" style="display: none;">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="card-title">Bank account</h3>
                            <div class="card-subtitle">Your bank account</div>
                            <p>
                                <span style="width: 70px;display: inline-block;"><b>Bank:</b></span> {{tmp._bank_bank_number}}&nbsp;&nbsp;{{tmp._bank_bank_name}}<br />
                                <span style="width: 70px;display: inline-block;"><b>Agency:</b></span> {{tmp._bank_agency_number}}&nbsp;&nbsp;{{tmp._bank_agency_digit}}<br />
                                <span style="width: 70px;display: inline-block;"><b>Account:</b></span> {{tmp._bank_account_number}}&nbsp;&nbsp;{{tmp._bank_account_digit}}<br />
                                <span style="width: 70px;display: inline-block;"><b>Type:</b></span> 
                                {{#contains "cc" tmp._bank_account_type}}
                                    Current account
                                {{else}}
                                    {{#contains "cp" tmp._bank_account_type}}
                                        Savings account
                                    {{else}}
                                    {{/contains}}
                                {{/contains}}
                            </p>
                            <p>
                                <span style="width: 70px;display: inline-block;"><b>Holder:</b></span>{{tmp._bank_holder_name}}<br />
                                <span style="width: 70px;display: inline-block;"><b>DOC:</b></span>{{formatdoc tmp._bank_holder_doc}}
                            </p>
                            <a href="javascript:View.openFormCustomersProfileBankEdit('{{tmp._id}}');">Edit account bank</a>
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
