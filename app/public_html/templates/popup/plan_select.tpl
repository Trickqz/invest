<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="formPlanSelect" name="formPlanSelect">
                <div class="modal-body">
                    <div class="modal-title">Participation plan</div>
                    <div>You can upgrade your plan at any time, increasing your earning prospect.</div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            Your current plan is: <b>{{system.userdata.extra__data.plan.name}}</b>
                        </div>
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Upgrade to:</label>
                                <select id="formPlanSelect-plan" name="plan" class="form-select">
                                    <option value="--">- Select -</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="error-msg"></div>
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <button id="btn-upgrade" type="button" class="btn btn-danger" onclick="formPlanSelect__Save();" disabled="">Upgrade</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    var formPlanSelect = document.getElementById('formPlanSelect');
    formPlanSelect.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formPlanSelect__Save();
    }
    
    function formPlanSelect__Save() {
        //Controller.passwordUpdate('formPlanSelect');
        
        var plan = document.querySelector('#formPlanSelect select[name="plan"]').value,
            payment_mode = document.querySelector('#formPlanSelect select[name="plan"]')[document.querySelector('#formPlanSelect select[name="plan"]').selectedIndex].getAttribute("data-paymentmode");
        
        commissioning_plansSelect(plan, payment_mode);
    }
    
    commissioning_plansGetAll({
        enabled: true,
        limit: 40
    }).then(function (response) {
        var list = response.commissioning_plans__getAll;
        
        //document.getElementById("plans_items").innerHTML = '<div class="item" style="text-align: center;"><img src="/assets/img/E5qkx.gif" height="50" width="50" style="margin: 0; margin-left: auto; margin-right: auto; margin-top: 22px; margin-bottom: 22px;"></div>';
        
        if (list != null) {
            if (list.length > 0) {
                var qtItems = 0;
                
                //document.getElementById("plans_items").innerHTML = '';
                document.querySelector('#formPlanSelect select[name="plan"]').innerHTML = '';
                
                for (var i = 0; i < list.length; i++) {
                    var disabled = true;
                    
                    if (list[i].upgrade_of != null) {
                        for (var i2 = 0; i2 < list[i].upgrade_of.length; i2++) {
                            if (_appData.system.userdata.network.plan.current__seq == list[i].upgrade_of[i2]) {
                                if (list[i].upgrade_of[i2] <= _appData.system.userdata.network.plan.current__seq) {
                                    disabled = false;
                                }
                            }
                        }
                    }
                    
                    if (disabled == true) {
                        document.querySelector('#formPlanSelect select[name="plan"]').innerHTML += '<option value="' + list[i].__seq + '" data-paymentmode="' + list[i].payment_mode + '" disabled="">' + list[i].name + ', valor de ' + fmtMoney(list[i].amount) + '</option>';
                    } else {
                        //document.getElementById("plans_items").innerHTML +=
                        document.querySelector('#formPlanSelect select[name="plan"]').innerHTML += '<option value="' + list[i].__seq + '" data-paymentmode="' + list[i].payment_mode + '">' + list[i].name + ', valor de ' + fmtMoney(list[i].amount) + '</option>';
                        qtItems++;
                    }
                }
                
                if (qtItems > 0) {
                    document.getElementById("btn-upgrade").disabled = false;
                } else {
                    document.querySelector('#formPlanSelect select[name="plan"]').innerHTML = '<option value="*" selected="" disabled="">- No plans available -</option>';
                }
            } else {
                //document.getElementById("plans_items").innerHTML = '<div class="item" style="text-align: center;"><img src="/assets/img/img_546124.png" height="90" width="90" style="margin: 0; margin-left: auto; margin-right: auto; margin-top: 22px; margin-bottom: 22px;"><p style="font-size: 16px;">Desculpe, <strong>não foi possível carregar</strong> os planos.</p></div>';
            }
        } else {
            //document.getElementById("plans_items").innerHTML = '<div class="item" style="text-align: center;"><img src="/assets/img/img_546124.png" height="90" width="90" style="margin: 0; margin-left: auto; margin-right: auto; margin-top: 22px; margin-bottom: 22px;"><p style="font-size: 16px;">Desculpe, <strong>não foi possível carregar</strong> os planos.</p></div>';
        }
        
        if (_appData.system.userdata.network.plan.current__seq > 0) {
            if (document.getElementById("plan_selectClose") != null) {
                document.getElementById("plan_selectClose").style.display = "block";
            }
        }
    }).catch(function (error) {
        console.log(error);
        //document.getElementById("plans_items").innerHTML = '<div class="item" style="text-align: center;"><img src="/assets/img/img_546124.png" height="90" width="90" style="margin: 0; margin-left: auto; margin-right: auto; margin-top: 22px; margin-bottom: 22px;"><p style="font-size: 16px;">Desculpe, <strong>não foi possível carregar</strong> os planos.</p></div>';
    });
    
    function commissioning_plansSelect(plan, payment_mode) {
        var accountsSelectPlan = graph(`mutation ($username: String, $plan: Int!) {
                accounts__selectPlan(username: $username, plan: $plan) {
                    success
                }
            }`);
        
        alertOpen({
                title: "Confirm",
                text: "Confirm plan?",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                accountsSelectPlan({
                    plan: plan
                }).then(function (response) {
                    var _data = response.accounts__selectPlan;
                    
                    if (_data.success == true) {
                        //dialogClose();
                        if (payment_mode == "simplified") {
                            location.href = _appData.settings.store.url + "/compras";
                        } else {
                            location.href = _appData.settings.store.url + "/carrinho";
                        }
                    } else {
                        App.alert('Warning', "Unable to choose a plan.", null);
                    }
                }).catch(function (error) {
                    App.alert('Error', error[0].message, null);
                });
            }
        );
    }
    
    setTimeout(function(){
        document.querySelector('#formPlanSelect select[name="plan"]').focus();
    }, 500);
</script>
