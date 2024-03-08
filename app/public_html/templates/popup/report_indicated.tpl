<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="formReportIndicated" name="formReportIndicated">
                <div class="modal-body">
                    <div class="modal-title">Indicated report</div>
                    <div>Use filters to generate the report.</div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Report type:</label>
                                <select id="report_indicated__subtype" name="report_indicated__subtype" class="form-select">
                                    <option value="direct" selected="">Direct indicated</option>
                                    <!--<option value="indirect">Indicados indiretos</option>-->
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    {{#if system.isadmin}}
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="mb-3">
                                    <label class="form-label">Username:</label>
                                    <input id="report_indicated__username" name="report_indicated__username" type="text" class="form-control" required="">
                                </div>
                            </div>
                        </div>
                    {{else}}
                        <input id="report_indicated__username" name="report_indicated__username" type="hidden" class="form-control" value="{{system.userdata._username}}">
                    {{/if}}
                    
                    <div class="row">
                        <div class="col-md-6 col-lg-6">
                            <div class="mb-3">
                                <label class="form-label">Date of</label>
                                <!--<input id="report_balance__date_of" type="text" class="form-control" placeholder="01/01/2000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="01/01/2000" autocomplete="off">
                                <input name="report_balance__date_of" type="hidden" class="form-control" value="01/01/2000">-->
                                <input id="report_indicated__date_of" name="report_indicated__date_of" type="date" class="form-control" value="2000-01-01">
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-6">
                            <div class="mb-3">
                                <label class="form-label">Date until</label>
                                <!--<input id="report_balance__date_until" type="text" class="form-control" placeholder="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}" autocomplete="off">
                                <input name="report_balance__date_until" type="hidden" class="form-control" value="{{system.lastDayOfMonth}}/{{system.curMonth}}/{{system.curYear}}">-->
                                <input id="report_indicated__date_until" name="report_indicated__date_until" type="date" class="form-control" value="{{system.curYear}}-{{system.curMonth}}-{{system.lastDayOfMonth}}">
                            </div>
                        </div>
                    </div>
                    
                    
                    <div class="row">
                        <div class="error-msg"></div>
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="report_indicated__generateReport();">Generate report</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script type="text/javascript">
    var elSubtype = document.getElementById("report_indicated__subtype");
    var elUsername = document.getElementById("report_indicated__username");
    var elDate_of = document.getElementById("report_indicated__date_of");
    var elDate_until = document.getElementById("report_indicated__date_until");
    
    function report_indicated__generateReport(){
        {{#if system.isadmin}}
            if (elUsername.value == "") {
                elUsername.focus();
                return;
            }
        {{else}}
        {{/if}}
        
        if (elDate_of.value != "" && elDate_until.value != "") {
            setTimeout(function(){
                OpenFileReport(CFG__API_URL+CFG__API_VERSION + '/reports/accounts/indicated.pdf?type='+elSubtype.value+'&username='+elUsername.value+'&date_of='+elDate_of.value+'&date_until='+elDate_until.value, 'Indicated report');
            }, 500);
        } else {
            setTimeout(function(){
                OpenFileReport(CFG__API_URL+CFG__API_VERSION + '/reports/accounts/indicated.pdf?type='+elSubtype.value+'&username='+elUsername.value, 'Indicated report');
            }, 500);
        }
        
        dialogClose();
    }
</script>
