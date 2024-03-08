<div class="modal-dialog modal-md modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-body" style="/*margin-bottom: 0;padding-bottom: 0;*/padding-bottom: 12px;">
            <div class="modal-title">Pack details</div>
            <!--<div>
                <span></span>
            </div>-->
        </div>
        
        <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;/*display: none;*/">
        
        <form id="formIncomeAdd" name="formIncomeAdd" method="post" onsubmit="return formIncomeAddProcess();">
            <div class="modal-body" style="padding-top: 12px;">
                <div id="section-amount" class="row" style="/*display: none;margin-top: 16px;*/margin-bottom: 16px;">
                    <div class="row" style="border-bottom: solid 1px #eee;margin: 0 16px 16px 16px;width: calc(100% - 32px);">
                        <div class="col-12 text-center">
                            <div class="mb-3">
                                <span>Pack with</span><br />
                                <span style="font-size: 30px;">{{tmp._contracts}} licenses</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-4 text-center">
                            <div class="mb-3">
                                <label class="form-label">Amount applied</label>
                                <span style="font-weight: bold;">{{formatmoney_br tmp._amount '#.##0,00'}}</span>
                            </div>
                        </div>
                        <div class="col-4 text-center">
                            <div class="mb-3">
                                <label class="form-label">Amount return</label>
                                <span style="font-weight: bold;">{{formatmoney_br tmp._income '#.##0,00'}}</span>
                            </div>
                        </div>
                        <div class="col-4 text-center">
                            <div class="mb-3">
                                <label class="form-label">Amount returned</label>
                                <span style="font-weight: bold;">{{formatmoney_br tmp._received '#.##0,00'}}</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="error-msg"></div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <!--<button id="formWalletMoneyAddConfirmBtn1" type="button" class="btn btn-danger" onclick="formIncomeAddProcess();" disabled="">Gerar rendimentos</button>-->
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Close</button>
        </div>
    </div>
</div>
