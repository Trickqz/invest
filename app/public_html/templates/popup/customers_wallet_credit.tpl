<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-title">Add money <b>{{tmp.username}}</b></div>
                <div>We recommend that you use a secure password to maintain the reliability of your account.</div>
            </div>
            <div class="modal-body">
                <form id="formCustomersWalletCreditEdit" name="formCustomersWalletCreditEdit">
                    <input name="id" type="hidden" value="{{tmp.id}}">
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="mb-3">
                                <div class="form-label">Type</div>
                                <select name="type" class="form-select">
                                    <option value="credit" selected="">Credit</option>
                                    <option value="insertion">Insertion</option>
                                    <option value="bonus">Bonus</option>
                                    <option value="profit">Profit</option>
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
                <button type="button" class="btn btn-danger" onclick="formCustomersWalletCredit__Save();">Add credit</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    var formCustomersWalletCreditEdit = document.getElementById('formCustomersWalletCreditEdit');
    formCustomersWalletCreditEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formCustomersWalletCredit__Save();
    }
    
    function formCustomersWalletCredit__Save() {
        //Controller.passwordUpdate('formCustomersWalletCreditEdit');
        
        //var formCustomersWalletCreditEdit = document.getElementById('formCustomersWalletCreditEdit');
        
        /*var usernameObj = formCustomersWalletCreditEdit.querySelector("input[name='username']");
        
        var new_passwordObj = formCustomersWalletCreditEdit.querySelector("input[name='new_password']");
        if ((new_passwordObj.value == "") || (new_passwordObj.value.length < 6)){
            new_passwordObj.focus();
            return false;
        }*/
        
        var idObj = formCustomersWalletCreditEdit.querySelector("input[name='id']");
        var typeObj = formCustomersWalletCreditEdit.querySelector("select[name='type']");
        var amountObj = formCustomersWalletCreditEdit.querySelector("input[name='amount']");
        var descriptionObj = formCustomersWalletCreditEdit.querySelector("input[name='description']");
        
        
        $.ajax({
            type: 'POST',
            url: CFG__API_URL + CFG__API_VERSION + "/wallet/credit",
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
        document.querySelector('#formCustomersWalletCreditEdit input[name="amount"]').focus();
    }, 1000);
</script>
