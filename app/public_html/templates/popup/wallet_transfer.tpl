<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-body">
            <div class="modal-title">Transfer between accounts</div>
            <div>You can transfer values at any time to another user. Just have an account balance and know the username that will receive the amounts.</div>
        </div>
        <form id="formWalletTransferNew" name="formWalletTransferNew" method="post" onsubmit="return formWalletTransferNewProcess();">
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="mb-3">
                            <label class="form-label">Which user will receive the transfer?</label>
                            <input name="to_username" type="text" class="form-control" placeholder="Username" minlength="4" maxlength="20" pattern="[a-zA-Z0-9._]+" autocomplete="off" onkeyup="formAccountCheckAvailableUser();" onblur="formAccountCheckAvailableUser();" required />
                            <input name="full_name" type="hidden">
                            <div id="to_username--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                </div>
                
                <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;">
                
                <div id="section-user-div" class="row">
                    <!-- -->
                </div>
                
                <hr id="section-user-div-hr" style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;display: none;">
                
                <div id="section-amount-div" class="row" style="display: none;margin-top: 16px;">
                    <div class="col-lg-12">
                        <div class="card card-sm">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <span class="bg-green text-white avatar">
                                            <!-- Download SVG icon from http://tabler-icons.io/i/currency-dollar -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                <path d="M16.7 8a3 3 0 0 0 -2.7 -2h-4a3 3 0 0 0 0 6h4a3 3 0 0 1 0 6h-4a3 3 0 0 1 -2.7 -2"></path>
                                                <path d="M12 3v3m0 12v3"></path>
                                            </svg>
                                        </span>
                                    </div>
                                    <div class="col">
                                        <div class="font-weight-medium">
                                            {{tmp.available_str}}
                                        </div>
                                        <div class="text-muted">
                                            Balance available for transfer
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div id="section-amount" class="row" style="display: none;margin-top: 16px;margin-bottom: 16px;">
                    <div class="col-lg-12">
                        <div class="mb-3">
                            <label class="form-label">What amount do you want to transfer?</label>
                            <input id="amount" name="amount" type="text" class="form-control" placeholder="Amount" autocomplete="off" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" onkeyup="formWalletTransferCheckAvailableBalance();" required="" />
                            <div id="amount--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="error-msg"></div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <button id="formWalletTransferNewBtnTransfer" type="button" class="btn btn-danger" onclick="formWalletTransferNewProcess();" disabled="">Transfer</button>
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    var availableValue = {{tmp._total}};
    
    function formAccountCheckAvailableUser(){
        if ((document.querySelector('#formWalletTransferNew input[name="to_username"]').value == "") || 
            (document.querySelector('#formWalletTransferNew input[name="to_username"]').value.length < 4)){
            document.querySelector('#formWalletTransferNew input[name="to_username"]').focus();
            return;
        }
        
        /*if (_Virtual.Session.Account.Username == document.querySelector('#formWalletTransferNew input[name="to_username"]').value) {
            View.showNotification('Não pode ser realizado transferência para você mesmo.', 'danger');
            document.querySelector('#formWalletTransferNew input[name="to_username"]').focus();
            return;
        }*/
        
        
        var wallet_sud = document.getElementById("section-user-div");
        var wallet_sud_hr = document.getElementById("section-user-div-hr");
        var wallet_sectionAmount_div = document.getElementById("section-amount-div");
        var wallet_sectionAmount = document.getElementById("section-amount");
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/get-username",
            data: {
                username: document.querySelector('#formWalletTransferNew input[name="to_username"]').value
            },
            success: function(response){
                var arr = response.data;
                
                if (arr != null) {
                    var full_name = arr._name,
                        location = '';
                    
                    var state = '',
                            city = '';
                    
                    if (arr.address != null) {
                        location = arr.address[0].city + "/" + arr.address[0].state
                    }
                    
                    wallet_sud.innerHTML = 
                          '<div class="g12">'
                        + '    <div class="g12" style="font-size: 13px;height: auto;overflow: hidden;">'
                        + '        <img style="width: 64px;height: 64px;float: left;margin-right: 12px;border-radius: 50%;" src="background-image: url(\''+CFG__API_URL+'/d/uploads/accounts/'+arr._id+'/profile/picture/'+arr._picture_src+'\'), url(\'../assets/img/picker_account.png\');" alt="">'
                        + '        <span style="width: calc(100% - 76px);display: inline-block;text-align: left;padding: 8px 12px;">'
                        + '            <span>'+full_name+'</span><br />'
                        + '            <span>'+location+'</span>'
                        + '        </span>'
                        + '    </div>'
                        + '</div>';
                    
                    wallet_sud_hr.style.display = "block";
                    
                    document.querySelector('#formWalletTransferNew input[name="full_name"]').value = full_name;
                    document.querySelector('#formWalletTransferNew input[name="to_username"]').classList.remove("is-invalid");
                    
                    wallet_sectionAmount_div.style.display = "block";
                    wallet_sectionAmount.style.display = "block";
                    document.formWalletTransferNew.amount.focus();
                } else {
                    document.querySelector('#formWalletTransferNew input[name="to_username"]').focus();
                    wallet_sud.innerHTML = '';
                    wallet_sud_hr.style.display = "none";
                    wallet_sectionAmount_div.style.display = "none";
                    wallet_sectionAmount.style.display = "none";
                    document.querySelector('#formWalletTransferNew input[name="to_username"]').classList.add("is-invalid");
                    document.getElementById('to_username--invalid-feedback').innerHTML = "User not found or not available to be receive transfer";
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                console.log(jsonResponse)
                
                wallet_sud.innerHTML = '';
                wallet_sud_hr.style.display = "none";
                wallet_sectionAmount_div.style.display = "none";
                wallet_sectionAmount.style.display = "none";
                document.querySelector('#formWalletTransferNew input[name="to_username"]').classList.add("is-invalid");
                document.getElementById('to_username--invalid-feedback').innerHTML = "User not found or not available to be receive transfer";
            }
        });
    }
    
    function formWalletTransferCheckAvailableBalance(){
        var elAmount = document.querySelector('#formWalletTransferNew input[name="amount"]');
        
        if ((parseFloat(justNumber(elAmount.value)/100.0)) <= parseFloat(justNumber(availableValue))) {
            document.querySelector('#formWalletTransferNewBtnTransfer').disabled = false;
        } else {
            document.querySelector('#formWalletTransferNewBtnTransfer').disabled = true;
        }
    }
    
    function formWalletTransferNewProcess(){
        var elTo_username = document.querySelector('#formWalletTransferNew input[name="to_username"]');
        var elFull_name = document.querySelector('#formWalletTransferNew input[name="full_name"]');
        var elAmount = document.querySelector('#formWalletTransferNew input[name="amount"]');
        
        if (elTo_username.value == "") {
            document.querySelector('#formWalletTransferNew input[name="to_username"]').classList.add("is-invalid");
            document.querySelector('#formWalletTransferNew input[name="to_username"]').focus();
            document.getElementById('to_username--invalid-feedback').innerHTML = "A user must be informed to be receive the transfer";
            return;
        }
        if (elAmount.value == "") {
            document.querySelector('#formWalletTransferNew input[name="amount"]').classList.add("is-invalid");
            document.querySelector('#formWalletTransferNew input[name="amount"]').focus();
            document.getElementById('amount--invalid-feedback').innerHTML = "A transfer amount must be provided";
            return;
        }
        
        Controller.walletTransfer(elTo_username.value, elFull_name.value, justNumber(elAmount.value));
    }
    
    setTimeout(function(){
        document.formWalletTransferNew.to_username.focus();
    }, 500);
</script>
