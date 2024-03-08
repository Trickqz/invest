<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-title">Debit money of <b>{{tmp.username}}</b></div>
                <div>We recommend that you use a secure password to maintain the reliability of your account.</div>
            </div>
            <div class="modal-body">
                <form id="formCustomersWalletDebitEdit" name="formCustomersWalletDebitEdit">
                    <input name="id" type="hidden" value="{{tmp.id}}">
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="mb-3">
                                <div class="form-label">Type</div>
                                <select name="type" class="form-select">
                                    <option value="debit" selected="">Debit</option>
                                    <option value="purchase">Purchase</option>
                                    <option value="tariff">Tariff</option>
                                    <option value="withdraw">Withdraw</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Amount</label>
                                <input name="amount" type="text" class="form-control" placeholder="USD 0,00" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" required />
                                <div id="amount--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <input name="description" type="text" class="form-control" placeholder="Description" maxlength="200" />
                                <div id="description--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="error-msg"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="formCustomersWalletDebit__Save();">Add credit</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    var formCustomersWalletDebitEdit = document.getElementById('formCustomersWalletDebitEdit');
    formCustomersWalletDebitEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formCustomersWalletDebit__Save();
    }
    
    function formCustomersWalletDebit__Save() {
        //Controller.passwordUpdate('formCustomersWalletDebitEdit');
        
        //var formCustomersWalletDebitEdit = document.getElementById('formCustomersWalletDebitEdit');
        
        /*var usernameObj = formCustomersWalletDebitEdit.querySelector("input[name='username']");
        
        var new_passwordObj = formCustomersWalletDebitEdit.querySelector("input[name='new_password']");
        if ((new_passwordObj.value == "") || (new_passwordObj.value.length < 6)){
            new_passwordObj.focus();
            return false;
        }*/
        
        var idObj = formCustomersWalletDebitEdit.querySelector("input[name='id']");
        var typeObj = formCustomersWalletDebitEdit.querySelector("select[name='type']");
        var amountObj = formCustomersWalletDebitEdit.querySelector("input[name='amount']");
        var descriptionObj = formCustomersWalletDebitEdit.querySelector("input[name='description']");
        
        
        $.ajax({
            type: 'POST',
            url: CFG__API_URL + CFG__API_VERSION + "/wallet/debit",
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            data: {
                id: idObj.value,
                type: typeObj.value,
                amount: amountObj.value,
                description: descriptionObj.value
            },
            success: function(response) {
                if (response.success === true) {
                    dialogClose();
                } else {
                    App.alert('Warning', response.message, null);
                }
            }
        });
        
        return false;
    }
    
    setTimeout(function(){
        document.querySelector('#formCustomersWalletDebitEdit input[name="amount"]').focus();
    }, 1000);
</script>
