<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="formReportBalance" name="formReportBalance">
                <div class="modal-body">
                    <div class="modal-title">Licenses report</div>
                    <div>Use filters to generate the report.</div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Report type:</label>
                                <select id="report_people__report_model" name="report_people__report_model" class="form-select" onchange="/*report_balance__report_modelChange();*/">
                                    <!--<option value="all_balance" disabled="">Balanço geral</option>
                                    <option value="all_balance_details" disabled="">Balanço detalhado</option>
                                    <option value="single" selected="">Usuário simples</option>
                                    <option value="details">Usuário detalhado</option>-->
                                    <option value="single" selected="">Single</option>
                                    <option value="details">Details</option>
                                    <!--<option value="" disabled="">Pagamentos com saldo</option>
                                    <option value="" disabled="">Saques</option>-->
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="mb-3">
                                <label class="form-label">Date of</label>
                                <!--<input id="report_balance__date_of" type="text" class="form-control" placeholder="01/01/2000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="01/01/2000" autocomplete="off">
                                <input name="report_balance__date_of" type="hidden" class="form-control" value="01/01/2000">-->
                                <input id="report_balance__date_of" name="report_balance__date_of" type="date" class="form-control" value="2000-01-01" disabled="">
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="mb-3">
                                <label class="form-label">Date until</label>
                                <!--<input id="report_balance__date_until" type="text" class="form-control" placeholder="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}" autocomplete="off">
                                <input name="report_balance__date_until" type="hidden" class="form-control" value="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}">-->
                                <input id="report_balance__date_until" name="report_balance__date_until" type="date" class="form-control" value="{{system.curYear}}-{{system.curMonth}}-{{system.lastDayOfMonth}}" disabled="">
                            </div>
                        </div>
                    </div>
                    
                    
                    <div class="row">
                        <div class="error-msg"></div>
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="report_balance__generateReport();">Generate report</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script type="text/javascript">
    var elReportModel = document.getElementById("report_people__report_model");
    
    var elDate_of = document.getElementById("report_balance__date_of");
    var elDate_until = document.getElementById("report_balance__date_until");
    
    /*function report_balance__report_modelChange(){
        if (elReportModel.value == "details") {
            elDate_of.disabled = false;
            elDate_until.disabled = false;
        } else {
            elDate_of.disabled = true;
            elDate_until.disabled = true;
        }
    }*/
    
    function report_balance__generateReport(){
        if (elDate_of.value != "" && elDate_until.value != "") {
            setTimeout(function(){
                OpenFileReport(CFG__API_URL+CFG__API_VERSION + '/reports/donations/balance.pdf?report_model='+elReportModel.value+'&date_of='+elDate_of.value+'&date_until='+elDate_until.value, 'Licenses report');
            }, 500);
        } else {
            setTimeout(function(){
                OpenFileReport(CFG__API_URL+CFG__API_VERSION + '/reports/donations/balance.pdf?report_model='+elReportModel.value, 'Licenses report');
            }, 500);
        }
        
        dialogClose();
    }
</script>
