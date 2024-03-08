<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-body" style="/*margin-bottom: 0;padding-bottom: 0;*/padding-bottom: 12px;">
            <div class="modal-title">Add money</div>
            <div>
                The deadline for compensation, the <b>minimum and maximum amount</b> to be added is according to the company's rules.
                 <br /><br />Minimum amount: <b>{{formatmoney_br settings.money_add_minimum_value 'USD #.##0.00'}}</b>.
                 <br />Maximum amount: <b>{{formatmoney_br settings.money_add_maximum_value 'USD #.##0.00'}}</b>.<br />
                 Values may vary depending on the <b>network rate</b>.
            </div>
        </div>
        
        <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;/*display: none;*/">
        
        <form id="formWalletMoneyAdd" name="formWalletMoneyAdd" method="post" onsubmit="return formWalletMoneyAddProcess();">
            <div class="modal-body" style="padding-top: 12px;">
                <div id="section-amount" class="row" style="/*display: none;margin-top: 16px;*/margin-bottom: 16px;">
                    <div class="col-lg-12">
                        <div class="mb-3">
                            <label class="form-label">What value do you want to add?</label>
                            <input id="amount" name="amount" type="text" class="form-control" placeholder="USD 0,00" min="{{settings.money_add_minimum_value}}" max="{{settings.money_add_maximum_value}}" autocomplete="off" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" onkeyup="formWalletMoneyAddCheckAvailable();" required="" />
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
            <button id="formWalletMoneyAddConfirmBtn" type="button" class="btn btn-danger" onclick="formWalletMoneyAddProcess();" disabled="">Add money</button>
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    var money_add_minimum_value = _appData.settings.money_add_minimum_value,
        money_add_maximum_value = _appData.settings.money_add_maximum_value;
    
    function formWalletMoneyAddCheckAvailable(){
        var elAmount = document.querySelector('#formWalletMoneyAdd input[name="amount"]');
        
        if ((parseFloat(justNumber(elAmount.value)/100.0)) <= parseFloat(money_add_maximum_value) && parseFloat(justNumber(elAmount.value)/100.0) >= parseFloat(money_add_minimum_value)) {
            document.querySelector('#formWalletMoneyAddConfirmBtn').disabled = false;
        } else {
            document.querySelector('#formWalletMoneyAddConfirmBtn').disabled = true;
        }
    }
    
    function formWalletMoneyAddProcess(){
        document.querySelectorAll('.invalid-feedback').forEach(elem => {
            var el = elem.parentElement.querySelector('.form-control');
            if (el != null) {
                el.classList.remove("is-invalid");
            }
        });
        
        //var elUsd = document.querySelector('#formWalletMoneyAdd input[name="usd"]');
        var elAmount = document.querySelector('#formWalletMoneyAdd input[name="amount"]');
        
        
        if (elAmount.value == "") {
            elAmount.classList.add("is-invalid");
            document.getElementById('amount--invalid-feedback').innerHTML = "A value must be entered to be added";
            elAmount.focus();
            return;
        }
        
        if (!((parseFloat(justNumber(elAmount.value)/100.0)) <= parseFloat(money_add_maximum_value) && parseFloat(justNumber(elAmount.value)/100.0) >= parseFloat(money_add_minimum_value))) {
            elAmount.classList.add("is-invalid");
            document.getElementById('amount--invalid-feedback').innerHTML = "The minimum withdrawal amount is USD {{settings.cashout_minimum_value}}";
            elAmount.focus();
            return;
        }
        
        Controller.walletAddUSD(justNumber(elAmount.value));
    }
    
    setTimeout(function(){
        document.formWalletMoneyAdd.amount.focus();
    }, 1000);
</script>
