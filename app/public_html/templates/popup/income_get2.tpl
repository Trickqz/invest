<div class="modal-dialog modal-md modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-body" style="/*margin-bottom: 0;padding-bottom: 0;*/padding-bottom: 12px;">
            <div class="modal-title">Ask for help</div>
            <div>
                <b>Warning:</b> This action can only be performed once every 7 days.
            </div>
        </div>
        
        <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;/*display: none;*/">
        
        <form id="formIncomeGet2" name="formIncomeGet2" method="post" onsubmit="return formIncomeGet2Process();">
            <div class="modal-body" style="padding-top: 12px;">
                <div id="section-amount" class="row" style="/*display: none;margin-top: 16px;*/margin-bottom: 16px;">
                    <div class="row" style="border-bottom: solid 1px #eee;margin: 0 16px 16px 16px;width: calc(100% - 32px);">
                        <div class="col-12 text-center">
                            <div class="mb-3">
                                <span style="font-size: 30px;">{{formatmoney_br tmp.total '#.##0,00'}} total</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6 text-center">
                            <div class="mb-3">
                                <label class="form-label">Blocked</label>
                                <span style="font-weight: bold;">{{formatmoney_br tmp.blocked '#.##0,00'}}</span>
                            </div>
                        </div>
                        <div class="col-6 text-center">
                            <div class="mb-3">
                                <label class="form-label">Available</label>
                                <span style="font-weight: bold;">{{formatmoney_br tmp.available '#.##0,00'}}</span>
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
            {{#if tmp.available}}
                <button id="formIncomeGet2ConfirmBtn1" type="button" class="btn btn-danger" onclick="formIncomeGet2Process();">Ask for help</button>
            {{else}}
                <button id="formIncomeGet2ConfirmBtn1" type="button" class="btn btn-danger" onclick="formIncomeGet2Process();" disabled="">Ask for help</button>
            {{/if}}
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    function formIncomeGet2Process(){
        document.querySelectorAll('.invalid-feedback').forEach(elem => {
            var el = elem.parentElement.querySelector('.form-control');
            if (el != null) {
                el.classList.remove("is-invalid");
            }
        });
        
        /*var elBid = document.querySelector('#formIncomeGet2 input[name="bid"]');
        var elDate = document.querySelector('#formIncomeGet2 input[name="date"]');
        
        
        if (elBid.value == "") {
            elBid.classList.add("is-invalid");
            document.getElementById('bid--invalid-feedback').innerHTML = "Deve ser informado um valor para ser adicionado";
            elBid.focus();
            return;
        }*/
        
        document.getElementById("formIncomeGet2ConfirmBtn1").disabled = true;
        
        $.ajax({
            type: 'POST',
            url: CFG__API_URL + CFG__API_VERSION + "/income/spoon/requests",
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            data: {},
            success: function(response) {
                if (response.success === true) {
                    document.getElementById("formIncomeGet2ConfirmBtn1").disabled = false;
                    
                    if (typeof fc_incomeRequestsGetAll === "function") {
                        fc_incomeRequestsGetAll();
                    }
                    
                    dialogClose();
                } else {
                    App.alert('Warning', response.message, null);
                }
            }
        });
        
        return false;
    }
    
    /*setTimeout(function(){
        document.formIncomeGet2.bid.focus();
    }, 1000);*/
</script>
