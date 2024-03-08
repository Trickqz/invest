<!--<div class="modal modal-blur fade" id="modal-feedback" tabindex="-1" role="dialog" aria-hidden="true">-->
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">System settings</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form class="form-default" id="formSettingEdit" name="formSettingEdit" method="post" action="" role="form">
                <div class="modal-body">
                    <!--<div class="mb-3">
                        <label class="form-label">Name</label>
                        <input type="text" class="form-control" name="example-text-input" placeholder="Your report name" />
                    </div>-->
                    <!--<label class="form-label">Tipo</label>-->
                    <!--
                    <div class="form-selectgroup-boxes row mb-3">
                        <div class="col-lg-6">
                            <label class="form-selectgroup-item">
                                <input type="radio" name="type" value="1" class="form-selectgroup-input" checked />
                                <span class="form-selectgroup-label d-flex align-items-center p-3">
                                    <span class="me-3">
                                        <span class="form-selectgroup-check"></span>
                                    </span>
                                    <span class="form-selectgroup-label-content">
                                        <span class="form-selectgroup-title strong mb-1">Elogio / sugestão</span>
                                        <span class="d-block text-muted">Desejo fazer um elogio ou sugestão de melhoria</span>
                                    </span>
                                </span>
                            </label>
                        </div>
                        <div class="col-lg-6">
                            <label class="form-selectgroup-item">
                                <input type="radio" name="type" value="1" class="form-selectgroup-input" />
                                <span class="form-selectgroup-label d-flex align-items-center p-3">
                                    <span class="me-3">
                                        <span class="form-selectgroup-check"></span>
                                    </span>
                                    <span class="form-selectgroup-label-content">
                                        <span class="form-selectgroup-title strong mb-1">Crítica / problema</span>
                                        <span class="d-block text-muted">Desejo fazer uma crítica ou reportar um problema</span>
                                    </span>
                                </span>
                            </label>
                        </div>
                    </div>
                    -->
                    
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="mb-3">
                                <label class="form-label">Maintenance mode?</label>
                                <select name="maintenance_mode" class="form-select">
                                    {{#selected settings.maintenance_mode}}
                                        <option value="true">Yes</option>
                                        <option value="false">No</option>
                                    {{/selected}}
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h3 class="card-title">Registration</h3>
                                <div class="card-subtitle">Members basic registration settings</div>
                                
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Enabled?</label>
                                            <select name="accounts_service_enabled" class="form-select">
                                                {{#selected settings.accounts_service_enabled}}
                                                    <option value="true">Yes</option>
                                                    <option value="false">No</option>
                                                {{/selected}}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <br />
                    
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h3 class="card-title">Financial</h3>
                                <div class="card-subtitle">Members wallet and financial settings</div>
                                
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Tranfer enabled?</label>
                                            <select name="transfer_service_enabled" class="form-select">
                                                {{#selected settings.transfer_service_enabled}}
                                                    <option value="true">Yes</option>
                                                    <option value="false">No</option>
                                                {{/selected}}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Cashout enabled?</label>
                                            <select name="cashout_service_enabled" class="form-select">
                                                {{#selected settings.cashout_service_enabled}}
                                                    <option value="true">Yes</option>
                                                    <option value="false">No</option>
                                                {{/selected}}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Cashout minimum</label>
                                            <input name="cashout_minimum_value" type="text" class="form-control" placeholder="USD 0,00" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" value="{{formatmoney_br settings.cashout_minimum_value 'USD #.##0,00'}}" required />
                                            <div id="cashout_minimum_value--invalid-feedback" class="invalid-feedback"></div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Cashout maximum</label>
                                            <input name="cashout_maximum_value" type="text" class="form-control" placeholder="USD 0,00" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" value="{{formatmoney_br settings.cashout_maximum_value 'USD #.##0,00'}}" required />
                                            <div id="cashout_maximum_value--invalid-feedback" class="invalid-feedback"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Cashout service fee (USD)</label>
                                            <input name="cashout_service_fee" type="text" class="form-control" placeholder="USD 0,00" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" value="{{formatmoney_br settings.cashout_service_fee 'USD #.##0,00'}}" required />
                                            <div id="cashout_service_fee--invalid-feedback" class="invalid-feedback"></div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Cashout service fee (%)</label>
                                            <input name="cashout_service_fee_perc" type="text" class="form-control" placeholder="0,00 %" inputmode="numeric" data-inputmask="'alias': 'percentage'" value="{{formatpercentage settings.cashout_service_fee_perc}}" required />
                                            <div id="cashout_service_fee_perc--invalid-feedback" class="invalid-feedback"></div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Money insertion enabled?</label>
                                            <select name="money_add_service_enabled" class="form-select">
                                                {{#selected settings.money_add_service_enabled}}
                                                    <option value="true">Yes</option>
                                                    <option value="false">No</option>
                                                {{/selected}}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Minimum value</label>
                                            <input name="money_add_minimum_value" type="text" class="form-control" placeholder="USD 0,00" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" value="{{formatmoney_br settings.money_add_minimum_value 'USD #.##0,00'}}" required />
                                            <div id="money_add_minimum_value--invalid-feedback" class="invalid-feedback"></div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Maximum value</label>
                                            <input name="money_add_maximum_value" type="text" class="form-control" placeholder="USD 0,00" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" value="{{formatmoney_br settings.money_add_maximum_value 'USD #.##0,00'}}" required />
                                            <div id="money_add_maximum_value--invalid-feedback" class="invalid-feedback"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <br />
                    
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h3 class="card-title">Licenses & income</h3>
                                <div class="card-subtitle">Licenses and incomes basic settings</div>
                                
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Acquisition enabled?</label>
                                            <select name="donations_service_enabled" class="form-select">
                                                {{#selected settings.donations_service_enabled}}
                                                    <option value="true">Yes</option>
                                                    <option value="false">No</option>
                                                {{/selected}}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Licenses actives limit</label>
                                            <input name="__accounts_max_contracts_active" type="number" class="form-control" inputmode="numeric" value="{{settings.__accounts_max_contracts_active}}" required />
                                            <div id="__accounts_max_contracts_active--invalid-feedback" class="invalid-feedback"></div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Licenses value (USD)</label>
                                            <input name="contracts_value_usd" type="text" class="form-control" placeholder="USD 0,00" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" value="{{formatmoney_br settings.contracts_value_usd 'USD #.##0,00'}}" required />
                                            <div id="contracts_value_usd--invalid-feedback" class="invalid-feedback"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Repurchase (% reach)</label>
                                            <input name="__accounts_contracts_percentage_repurchase" type="text" class="form-control" placeholder="0,00 %" inputmode="numeric" data-inputmask="'alias': 'percentage'" value="{{formatpercentage settings.__accounts_contracts_percentage_repurchase}}" required />
                                            <div id="__accounts_contracts_percentage_repurchase--invalid-feedback" class="invalid-feedback"></div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Income of reach goal</label>
                                            <select name="__accounts_contracts_block_percentage_reached" class="form-select" disabled="">
                                                {{#selected settings.__accounts_contracts_block_percentage_reached}}
                                                    <option value="true">Block</option>
                                                    <option value="false">Free</option>
                                                {{/selected}}
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-lg-4">
                                        <div class="mb-3">
                                            <label class="form-label">Repurchase (% licenses)</label>
                                            <input name="__accounts_contracts_percentage_to_repurchase" type="text" class="form-control" placeholder="0,00 %" inputmode="numeric" data-inputmask="'alias': 'percentage'" value="{{formatpercentage settings.__accounts_contracts_percentage_to_repurchase}}" required />
                                            <div id="__accounts_contracts_percentage_to_repurchase--invalid-feedback" class="invalid-feedback"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <br />
                    
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h3 class="card-title">CoinBase</h3>
                                <div class="card-subtitle">CoinBase settings</div>
                                
                                <div class="row">
                                    <div class="col-lg-10">
                                        <div class="mb-3">
                                            <label class="form-label">API KEY</label>
                                            <input name="coinbase__api_key" type="text" class="form-control" placeholder="API KEY" value="{{settings.coinbase__api_key}}" required />
                                            <div id="coinbase__api_key--invalid-feedback" class="invalid-feedback"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <a href="#" class="btn btn-link link-secondary" data-bs-dismiss="modal">
                    Cancelar
                </a>
                <a href="javascript:;" class="btn btn-primary ms-auto" onclick="formSettingEdit__Save();">
                    <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <line x1="12" y1="5" x2="12" y2="19" />
                        <line x1="5" y1="12" x2="19" y2="12" />
                    </svg>
                    Save
                </a>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    var formSettingEdit = document.getElementById('formSettingEdit');
    formSettingEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formSettingEdit__Save();
    }
    
    function formSettingEdit__Save() {
        //document.querySelector('#formSettingEdit input[name="birthdate"]').value = FormatStringDate(document.getElementById('birthdate').value);
        
        //Controller.accountsUpdate('formSettingEdit');
        
        var jsonData = JSON.parse(formToJSONString('formSettingEdit'));
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/settings",
            data: jsonData,
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    //fgUpdateUserData();
                    //fc__customersGetAll();
                    dialogClose();
                    location.reload();
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                App.alert('Error', 'An unexpected error occurred while requesting information.', null);
            }
        });
    }
    
    /*setTimeout(function(){
        document.querySelector('#formSettingEdit input[name="name"]').focus();
    }, 500);*/
</script>
