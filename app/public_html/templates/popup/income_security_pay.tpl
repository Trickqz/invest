<div class="modal-dialog modal-md modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-body" style="/*margin-bottom: 0;padding-bottom: 0;*/padding-bottom: 12px;">
            <div class="modal-title">Pay income</div>
            <div>
                The <b>payable amount</b> will be used proportionally paid to open orders.
            </div>
        </div>
        
        <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;/*display: none;*/">
        
        <form id="formIncomeSecurityPay" name="formIncomeSecurityPay" method="post" onsubmit="return formIncomeSecurityPayProcess();">
            <div class="modal-body" style="padding-top: 12px;">
                <div id="section-amount" class="row" style="/*display: none;margin-top: 16px;*/margin-bottom: 16px;">
                    <div class="col-lg-6">
                        <div class="mb-3">
                            Current value pending: <b>{{formatmoney_br tmp.value}}</b>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Amount to pay</label>
                            <input id="amount" name="amount" type="text" class="form-control" placeholder="0,00" autocomplete="off" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" required="" />
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
            <button id="formWalletMoneyAddConfirmBtn1" type="button" class="btn btn-danger" onclick="formIncomeSecurityPayProcess(false);">Pay income</button>
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    function formIncomeSecurityPayProcess(close = true){
        document.querySelectorAll('.invalid-feedback').forEach(elem => {
            var el = elem.parentElement.querySelector('.form-control');
            if (el != null) {
                el.classList.remove("is-invalid");
            }
        });
        
        var elAmount = document.querySelector('#formIncomeSecurityPay input[name="amount"]');
        if (elAmount.value == "") {
            elAmount.classList.add("is-invalid");
            document.getElementById('amount--invalid-feedback').innerHTML = "An amount to be paid must be provided";
            elAmount.focus();
            return;
        }
        
        document.getElementById("formWalletMoneyAddConfirmBtn1").disabled = true;
        
        $.ajax({
            type: 'POST',
            url: CFG__API_URL + CFG__API_VERSION + "/income/spoon/pay",
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            data: {
                amount: elAmount.value
            },
            success: function(response) {
                if (response.success === true) {
                    if (router.current[0].url == "") {
                        if (typeof indexLoadData === "function") {
                            indexLoadData();
                        }
                    } else {
                        if (typeof fc_incomeGetAll === "function") {
                            fc_incomeGetAll();
                        }
                    }
                    
                    document.getElementById("formWalletMoneyAddConfirmBtn1").disabled = false;
                    dialogClose();
                } else {
                    App.alert('Warning', response.message, null);
                }
            }
        });
        
        return false;
    }
    
    setTimeout(function(){
        document.formIncomeSecurityPay.amount.focus();
    }, 1000);
</script>
