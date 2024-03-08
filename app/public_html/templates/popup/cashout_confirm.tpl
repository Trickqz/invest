<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-title">Withdrawal confirmation</div>
                <div>We recommend that you inform the withdrawal confirmation hash for greater transaction reliability.</div>
                <div>
                    Withdrawal request:<br />
                    Amount: <b>{{tmp._amount_str}}</b><br />
                    Fee: <b>{{tmp._service_fee_str}}</b><br />
                    To be paid: <b>{{tmp._net_amount_str}}</b>
                </div>
            </div>
            <div class="modal-body">
                <form id="formCashoutConfirm" name="formCashoutConfirm">
                    <input name="id" type="hidden" value="{{tmp.id}}">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Transaction code</label>
                                <input name="transaction_code" type="text" class="form-control" placeholder="Transaction code" required />
                                <div id="transaction_code--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="error-msg"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="formCashoutConfirm__Save();">Confirm</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    var formCashoutConfirm = document.getElementById('formCashoutConfirm');
    formCashoutConfirm.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formCashoutConfirm__Save();
    }
    
    function formCashoutConfirm__Save() {
        //Controller.formCashoutConfirmUpdate('formCashoutConfirm');
        
        var transaction_codeObj = formCashoutConfirm.querySelector("input[name='transaction_code']");
        
        $.ajax({
            type: 'POST',
            url: CFG__API_URL + CFG__API_VERSION + "/wallet/cashout/{{tmp._id}}/confirm",
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            data: {
                transaction_code: transaction_codeObj.value
            },
            success: function(response) {
                if (response.success === true) {
                    dialogClose();
                    fc__cashoutGetListing("*");
                } else {
                    App.alert('Warning', response.message, null);
                }
            }
        });
        
        return false;
    }
    
    setTimeout(function(){
        document.querySelector('#formCashoutConfirm input[name="transaction_code"]').focus();
    }, 1000);
</script>
