<div class="modal-dialog modal-md modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-body" style="/*margin-bottom: 0;padding-bottom: 0;*/padding-bottom: 12px;">
            <div class="modal-title">Add quote</div>
            <div>
                The <b>quote value</b> used is the last value with the date less than the current date and time.
            </div>
        </div>
        
        <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;/*display: none;*/">
        
        <form id="formIncomeAdd" name="formIncomeAdd" method="post" onsubmit="return formIncomeAddProcess();">
            <div class="modal-body" style="padding-top: 12px;">
                <div id="section-amount" class="row" style="/*display: none;margin-top: 16px;*/margin-bottom: 16px;">
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label class="form-label">Percentage to add</label>
                            <input id="bid" name="bid" type="text" class="form-control" placeholder="0,00" autocomplete="off" inputmode="numeric" data-inputmask="'alias': 'percentage'" required="" />
                            <div id="bid--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label class="form-label">Date and time</label>
                            <input id="date" name="date" type="datetime-local" class="form-control" autocomplete="off" required="" />
                            <div id="date--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="error-msg"></div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <button id="formWalletMoneyAddConfirmBtn1" type="button" class="btn btn-danger" onclick="formIncomeAddProcess(false);">Add</button>
            <button id="formWalletMoneyAddConfirmBtn2" type="button" class="btn btn-danger" onclick="formIncomeAddProcess();">Add and close</button>
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    function formIncomeAddProcess(close = true){
        document.querySelectorAll('.invalid-feedback').forEach(elem => {
            var el = elem.parentElement.querySelector('.form-control');
            if (el != null) {
                el.classList.remove("is-invalid");
            }
        });
        
        var elBid = document.querySelector('#formIncomeAdd input[name="bid"]');
        var elDate = document.querySelector('#formIncomeAdd input[name="date"]');
        
        
        if (elBid.value == "") {
            elBid.classList.add("is-invalid");
            document.getElementById('bid--invalid-feedback').innerHTML = "A value must be entered to be added";
            elBid.focus();
            return;
        }
        
        document.getElementById("formWalletMoneyAddConfirmBtn1").disabled = true;
        document.getElementById("formWalletMoneyAddConfirmBtn2").disabled = true;
        
        $.ajax({
            type: 'POST',
            url: CFG__API_URL + CFG__API_VERSION + "/income",
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            data: {
                bid: elBid.value,
                date: elDate.value
            },
            success: function(response) {
                if (response.success === true) {
                    if (close == true) {
                        dialogClose();
                    }
                    
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
                    document.getElementById("formWalletMoneyAddConfirmBtn2").disabled = false;
                } else {
                    App.alert('Warning', response.message, null);
                }
            }
        });
        
        return false;
    }
    
    setTimeout(function(){
        document.formIncomeAdd.bid.focus();
    }, 1000);
</script>
