<!--class="antialiased border-top-wide border-primary d-flex flex-column"-->
<div class="page page-center">
    <div class="container-tight py-4">
        <div class="text-center mb-4">
            <a href="."><img class="n-logo" src="./static/logo-white.png" src="./static/logo-white.svg" height="36" alt="" /></a>
        </div>
        <div class="card card-md">
            <div class="card-body text-center py-4 p-sm-5">
                <img src="https://cdn.brauntech.com.br/ajax/libs/tabler/1.0.0-beta9/demo/static/illustrations/undraw_sign_in_e6hj.svg" height="128" class="mb-n2" height="120" alt="" />
                <h1 class="mt-5">Bem-vindo!</h1>
                <p class="text-muted">Para começar, vamos passar algumas informações úteis e concluir seu cadastro com as informações necessárias sobre você.</p>
            </div>
            
            <div id="title" class="hr-text hr-text-center hr-text-spaceless">conclusão de cadastro</div>
            
            <div class="card-body">
                <form id="formFirstAccess" name="formFirstAccess">
                    <section id="step1">
                        <div class="mb-3">
                            <label class="form-label">Sua URL de indicação <a class="btn btn-link" href="javascript:;" onclick="copyLink('{{settings.__app_url}}/criar-conta/{{system.userdata._username}}');">Copiar link</a></label>
                            <div class="input-group input-group-flat">
                                <span class="input-group-text">
                                    <!--{{settings.__app_url}}-->/criar-conta/
                                </span>
                                <input type="text" class="form-control ps-1" autocomplete="off" value="{{system.userdata._username}}" readonly />
                            </div>
                            <div class="form-hint">A sua URL de indicação é pessoal e intransferível. Use-a para indicar pessoas para construção da sua rede.</div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Fuso horário</label>
                            <select class="form-select mb-0" disabled>
                                <option value="DST">(UTC-12:00) International Date Line West</option>
                                <option value="U">(UTC-11:00) Coordinated Universal Time-11</option>
                                <option value="HST">(UTC-10:00) Hawaii</option>
                                <option value="AKDT">(UTC-09:00) Alaska</option>
                                <option value="PDT">(UTC-08:00) Baja California</option>
                                <option value="PDT">(UTC-07:00) Pacific Time (US & Canada)</option>
                                <option value="PST">(UTC-08:00) Pacific Time (US & Canada)</option>
                                <option value="UMST">(UTC-07:00) Arizona</option>
                                <option value="MDT">(UTC-07:00) Chihuahua, La Paz, Mazatlan</option>
                                <option value="MDT">(UTC-07:00) Mountain Time (US & Canada)</option>
                                <option value="CAST">(UTC-06:00) Central America</option>
                                <option value="CDT">(UTC-06:00) Central Time (US & Canada)</option>
                                <option value="CDT">(UTC-06:00) Guadalajara, Mexico City, Monterrey</option>
                                <option value="CCST">(UTC-06:00) Saskatchewan</option>
                                <option value="SPST">(UTC-05:00) Bogota, Lima, Quito</option>
                                <option value="EDT">(UTC-05:00) Eastern Time (US & Canada)</option>
                                <option value="UEDT">(UTC-05:00) Indiana (East)</option>
                                <option value="VST">(UTC-04:30) Caracas</option>
                                <option value="PYT">(UTC-04:00) Asuncion</option>
                                <option value="ADT">(UTC-04:00) Atlantic Time (Canada)</option>
                                <option value="CBST">(UTC-04:00) Cuiaba</option>
                                <option value="SWST">(UTC-04:00) Georgetown, La Paz, Manaus, San Juan</option>
                                <option value="PSST">(UTC-04:00) Santiago</option>
                                <option value="NDT">(UTC-03:30) Newfoundland</option>
                                <option value="ESAST" selected>(UTC-03:00) Brasilia</option>
                                <option value="AST">(UTC-03:00) Buenos Aires</option>
                                <option value="SEST">(UTC-03:00) Cayenne, Fortaleza</option>
                                <option value="GDT">(UTC-03:00) Greenland</option>
                                <option value="MST">(UTC-03:00) Montevideo</option>
                                <option value="BST">(UTC-03:00) Salvador</option>
                                <option value="U">(UTC-02:00) Coordinated Universal Time-02</option>
                                <option value="MDT">(UTC-02:00) Mid-Atlantic - Old</option>
                                <option value="ADT">(UTC-01:00) Azores</option>
                                <option value="CVST">(UTC-01:00) Cape Verde Is.</option>
                                <option value="MDT">(UTC) Casablanca</option>
                                <option value="UTC">(UTC) Coordinated Universal Time</option>
                                <option value="GMT">(UTC) Edinburgh, London</option>
                                <option value="BST">(UTC+01:00) Edinburgh, London</option>
                                <option value="GDT">(UTC) Dublin, Lisbon</option>
                                <option value="GST">(UTC) Monrovia, Reykjavik</option>
                                <option value="WEDT">(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna</option>
                                <option value="CEDT">(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague</option>
                                <option value="RDT">(UTC+01:00) Brussels, Copenhagen, Madrid, Paris</option>
                                <option value="CEDT">(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb</option>
                                <option value="WCAST">(UTC+01:00) West Central Africa</option>
                                <option value="NST">(UTC+01:00) Windhoek</option>
                                <option value="GDT">(UTC+02:00) Athens, Bucharest</option>
                                <option value="MEDT">(UTC+02:00) Beirut</option>
                                <option value="EST">(UTC+02:00) Cairo</option>
                                <option value="SDT">(UTC+02:00) Damascus</option>
                                <option value="EEDT">(UTC+02:00) E. Europe</option>
                                <option value="SAST">(UTC+02:00) Harare, Pretoria</option>
                                <option value="FDT">(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius</option>
                                <option value="TDT">(UTC+03:00) Istanbul</option>
                                <option value="JDT">(UTC+02:00) Jerusalem</option>
                                <option value="LST">(UTC+02:00) Tripoli</option>
                                <option value="JST">(UTC+03:00) Amman</option>
                                <option value="AST">(UTC+03:00) Baghdad</option>
                                <option value="KST">(UTC+02:00) Kaliningrad</option>
                                <option value="AST">(UTC+03:00) Kuwait, Riyadh</option>
                                <option value="EAST">(UTC+03:00) Nairobi</option>
                                <option value="MSK">(UTC+03:00) Moscow, St. Petersburg, Volgograd, Minsk</option>
                                <option value="SAMT">(UTC+04:00) Samara, Ulyanovsk, Saratov</option>
                                <option value="IDT">(UTC+03:30) Tehran</option>
                                <option value="AST">(UTC+04:00) Abu Dhabi, Muscat</option>
                                <option value="ADT">(UTC+04:00) Baku</option>
                                <option value="MST">(UTC+04:00) Port Louis</option>
                                <option value="GET">(UTC+04:00) Tbilisi</option>
                                <option value="CST">(UTC+04:00) Yerevan</option>
                                <option value="AST">(UTC+04:30) Kabul</option>
                                <option value="WAST">(UTC+05:00) Ashgabat, Tashkent</option>
                                <option value="YEKT">(UTC+05:00) Yekaterinburg</option>
                                <option value="PKT">(UTC+05:00) Islamabad, Karachi</option>
                                <option value="IST">(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi</option>
                                <option value="SLST">(UTC+05:30) Sri Jayawardenepura</option>
                                <option value="NST">(UTC+05:45) Kathmandu</option>
                                <option value="CAST">(UTC+06:00) Nur-Sultan (Astana)</option>
                                <option value="BST">(UTC+06:00) Dhaka</option>
                                <option value="MST">(UTC+06:30) Yangon (Rangoon)</option>
                                <option value="SAST">(UTC+07:00) Bangkok, Hanoi, Jakarta</option>
                                <option value="NCAST">(UTC+07:00) Novosibirsk</option>
                                <option value="CST">(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi</option>
                                <option value="NAST">(UTC+08:00) Krasnoyarsk</option>
                                <option value="MPST">(UTC+08:00) Kuala Lumpur, Singapore</option>
                                <option value="WAST">(UTC+08:00) Perth</option>
                                <option value="TST">(UTC+08:00) Taipei</option>
                                <option value="UST">(UTC+08:00) Ulaanbaatar</option>
                                <option value="NAEST">(UTC+08:00) Irkutsk</option>
                                <option value="JST">(UTC+09:00) Osaka, Sapporo, Tokyo</option>
                                <option value="KST">(UTC+09:00) Seoul</option>
                                <option value="CAST">(UTC+09:30) Adelaide</option>
                                <option value="ACST">(UTC+09:30) Darwin</option>
                                <option value="EAST">(UTC+10:00) Brisbane</option>
                                <option value="AEST">(UTC+10:00) Canberra, Melbourne, Sydney</option>
                                <option value="WPST">(UTC+10:00) Guam, Port Moresby</option>
                                <option value="TST">(UTC+10:00) Hobart</option>
                                <option value="YST">(UTC+09:00) Yakutsk</option>
                                <option value="CPST">(UTC+11:00) Solomon Is., New Caledonia</option>
                                <option value="VST">(UTC+11:00) Vladivostok</option>
                                <option value="NZST">(UTC+12:00) Auckland, Wellington</option>
                                <option value="U">(UTC+12:00) Coordinated Universal Time+12</option>
                                <option value="FST">(UTC+12:00) Fiji</option>
                                <option value="MST">(UTC+12:00) Magadan</option>
                                <option value="KDT">(UTC+12:00) Petropavlovsk-Kamchatsky - Old</option>
                                <option value="TST">(UTC+13:00) Nuku'alofa</option>
                                <option value="SST">(UTC+13:00) Samoa</option>
                            </select>
                        </div>
                    </section>
                    
                    <section id="step2" style="display: none;">
                        <div class="mb-3">
                            <label class="form-label">Escolha seu plano:</label>
                            <select id="firstAccess-plan" name="plan" class="form-select">
                                <option value="--">- Selecione -</option>
                            </select>
                        </div>
                    </section>
                </form>
            </div>
        </div>
        
        <div class="row">
            <div class="error-msg"></div>
        </div>
        
        <div class="row align-items-center mt-3">
            <div class="col-4">
                <div id="firstAccess-progress" class="progress">
                    <div class="progress-bar" style="width: 25%;" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                        <span class="visually-hidden">25% Completo</span>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="btn-list justify-content-end">
                    <a href="javascript:;" class="btn btn-link link-secondary disabled">
                        Configurar mais tarde
                    </a>
                    <button id="btn-next" class="btn btn-primary" onclick="firstAccessNext();">
                        Continuar
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!--
<div class="content">
    <div class="row g12">
        <div id="plans_items" class="flex g12"></div>
    </div>
</div>
-->

<script>
    function copyLink(_link){
        navigator.clipboard.writeText(_link).then(function() {
            //demo.showNotification('Link copiado para <b>área de transfência</b>.', 'success');
        }, function(err) {
            //demo.showNotification('Não foi possível copiar seu link. Use <b>Ctrl+C</b> para copiar o link.', 'danger');
        });
    }
    
    var step = 1;
    function firstAccessNext() {
        if (step < 3) step++;
        switch(step){
            case 2:
                //document.querySelector("#step1").style.display = "none";
                document.querySelector("#step1").style.opacity = "0.7";
                document.querySelector("#step1").pointerevents = "none";
                document.querySelector("#step2").style.display = "block";
                document.querySelector("#firstAccess-progress .progress-bar").style.width = "75%";
                document.getElementById("btn-next").innerHTML = "Concluir";
            break;
            case 3:
                formFirstAccess__Save();
            break;
        }
    }
    
    var formFirstAccess = document.getElementById('formFirstAccess');
    formFirstAccess.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formFirstAccess__Save();
    }
    
    function formFirstAccess__Save() {
        //Controller.passwordUpdate('formFirstAccess');
        
        var plan = document.querySelector('#formFirstAccess select[name="plan"]').value,
            payment_mode = document.querySelector('#formFirstAccess select[name="plan"]')[document.querySelector('#formFirstAccess select[name="plan"]').selectedIndex].getAttribute("data-paymentmode");
        
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
                document.querySelector('#formFirstAccess select[name="plan"]').innerHTML = '';
                
                for (var i = 0; i < list.length; i++) {
                    if (list[i].just_upgrade == false) {
                        /**var disabled = true;
                        
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
                            document.querySelector('#formFirstAccess select[name="plan"]').innerHTML += '<option value="' + list[i].__seq + '" data-paymentmode="' + list[i].payment_mode + '" disabled="">' + list[i].name + ', valor de ' + fmtMoney(list[i].amount) + '</option>';
                        } else {**/
                            //document.getElementById("plans_items").innerHTML +=
                            document.querySelector('#formFirstAccess select[name="plan"]').innerHTML += '<option value="' + list[i].__seq + '" data-paymentmode="' + list[i].payment_mode + '">' + list[i].name + ', valor de ' + fmtMoney(list[i].amount) + '</option>';
                            qtItems++;
                        /**}**/
                    }
                }
                
                if (qtItems > 0) {
                    //document.getElementById("btn-upgrade").disabled = false;
                } else {
                    document.querySelector('#formFirstAccess select[name="plan"]').innerHTML = '<option value="*" selected="" disabled="">- Nenhum plano disponível -</option>';
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
        
        var planSelected = document.querySelector('#formFirstAccess select[name="plan"]').value;
        if (planSelected == "" || planSelected == "*") {
            App.alert('Atenção', "Você deve escolher um plano.", null);
            return;
        }
        
        alertOpen({
                title: "Confirmação",
                text: "Confirma a escolha do plano?",
                type: "danger",
                confirmButtonText: "Sim",
                cancelButtonText: "Não"
            },
            function(){
                document.querySelector("#firstAccess-progress .progress-bar").style.width = "100%";
                document.getElementById("btn-next").disabled = true;
                
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
                        App.alert('Atenção', "Não foi possível escolher um plano.", null);
                        document.getElementById("btn-next").disabled = false;
                    }
                }).catch(function (error) {
                    App.alert('Erro', error[0].message, null);
                    document.getElementById("btn-next").disabled = false;
                });
            }
        );
    }
    
    /**setTimeout(function(){
        document.querySelector('#formFirstAccess select[name="plan"]').focus();
    }, 500);*/
</script>
