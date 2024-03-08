<div class="modal-dialog modal-md modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-body" style="/*margin-bottom: 0;padding-bottom: 0;*/padding-bottom: 12px;">
            <div class="modal-title">Generate income</div>
            <div>
                <b>Attention:</b> This action can only be performed once a day and the values may vary if there is a total receipt of any license.
            </div>
        </div>
        
        <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;/*display: none;*/">
        
        <form id="formIncomeGet" name="formIncomeGet" method="post" onsubmit="return formIncomeGetProcess();">
            <div class="modal-body" style="padding-top: 12px;">
                <div id="section-amount" class="row" style="/*display: none;margin-top: 16px;*/margin-bottom: 16px;">
                    <div class="row" style="border-bottom: solid 1px #eee;margin: 0 16px 16px 16px;width: calc(100% - 32px);">
                        <div class="col-12 text-center">
                            <div class="mb-3">
                                <span style="font-size: 30px;">{{tmp.donations.count}} licenses</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4 text-center">
                            <div class="mb-3">
                                <label class="form-label">Income</label>
                                <span style="font-weight: bold;">{{formatpercentage tmp.income}}</span>
                            </div>
                        </div>
                        <div class="col-4 text-center">
                            <div class="mb-3">
                                <label class="form-label">Amount in license</label>
                                <span style="font-weight: bold;">{{formatmoney_br tmp.donations.amount '#.##0,00'}}</span>
                            </div>
                        </div>
                        <div class="col-4 text-center">
                            <div class="mb-3">
                                <label class="form-label">Amount to generate</label>
                                <span style="font-weight: bold;">{{formatmoney_br tmp.to_receive '#.##0,00'}}</span>
                            </div>
                        </div>
                    </div>
                    <!--
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label class="form-label">Porcentagem a adicionar</label>
                            <input id="bid" name="bid" type="text" class="form-control" placeholder="0,00" autocomplete="off" inputmode="numeric" data-inputmask="'alias': 'percentage'" required="" />
                            <div id="bid--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label class="form-label">Data e hora</label>
                            <input id="date" name="date" type="datetime-local" class="form-control" autocomplete="off" required="" />
                            <div id="date--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                    -->
                </div>
                <div class="row">
                    <div class="error-msg"></div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <button id="formIncomeGetConfirmBtn1" type="button" class="btn btn-danger" onclick="formIncomeGetProcess();">Generate income</button>
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    function formIncomeGetProcess(){
        document.querySelectorAll('.invalid-feedback').forEach(elem => {
            var el = elem.parentElement.querySelector('.form-control');
            if (el != null) {
                el.classList.remove("is-invalid");
            }
        });
        
        /*var elBid = document.querySelector('#formIncomeGet input[name="bid"]');
        var elDate = document.querySelector('#formIncomeGet input[name="date"]');
        
        
        if (elBid.value == "") {
            elBid.classList.add("is-invalid");
            document.getElementById('bid--invalid-feedback').innerHTML = "Deve ser informado um valor para ser adicionado";
            elBid.focus();
            return;
        }*/
        
        document.getElementById("formIncomeGetConfirmBtn1").disabled = true;
        
        $.ajax({
            type: 'POST',
            url: CFG__API_URL + CFG__API_VERSION + "/income/spoon",
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            data: {},
            success: function(response) {
                if (response.success === true) {
                    document.getElementById("formIncomeGetConfirmBtn1").disabled = false;
                    dialogClose();
                } else {
                    App.alert('Warning', response.message, null);
                }
            }
        });
        
        return false;
    }
    
    setTimeout(function(){
        document.formIncomeGet.bid.focus();
    }, 1000);
</script>
