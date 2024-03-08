<style>
    :disabled, .disabled {
        opacity: 0.5 !important;
        pointer-events: none !important;
    }
</style>

<!--class="antialiased border-top-wide border-primary d-flex flex-column"-->
<div class="page page-center">
    <div class="container-tight py-4">
        <div class="text-center mb-4">
            <a href="."><img class="n-logo" src="/assets/img/logo-white.png" srcset="/assets/img/logo-white.svg" alt="" style="max-width: 200px;height: auto;width: auto;" /></a>
        </div>
        <form id="frmRegister" name="frmRegister" class="card card-md">
            <div class="card-body">
                <h2 class="card-title text-center mb-4">Create new account</h2>
                
                <div class="mb-3">
                    <span>Sponsor:</span>
                    
                    <div id="dataIndicator" style="margin-top: 12px;margin-bottom: 28px;height: auto;max-height: 260px;background: #151c2a;padding: 8px;font-size: 14px;border-radius: 4px;">
                        Checking your referral...
                    </div>
                    
                    <input name="sponsor" type="hidden" value="">
                </div>
                
                <section id="register" class="disabled">
                    <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 12px 5%; display: none;">
                    
                    <div class="mb-3"  style="display: none;">
                        <div class="form-label">Type</div>
                        <div>
                            <label class="form-check form-check-inline">
                                <input name="person_type" class="form-check-input" type="radio" value="natural_person" onchange="setPersonType('natural_person')" />
                                <span class="form-check-label">Natural person</span>
                            </label>
                            <label class="form-check form-check-inline">
                                <input name="person_type" class="form-check-input" type="radio" value="legal_person" onchange="setPersonType('legal_person')" />
                                <span class="form-check-label">Legal person</span>
                            </label>
                            <label class="form-check form-check-inline">
                                <input name="person_type" class="form-check-input" type="radio" value="foreign_person" onchange="setPersonType('foreign_person')" checked="" />
                                <span class="form-check-label">Foreign person</span>
                            </label>
                        </div>
                    </div>
                    
                    <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 12px 5%;">
                    
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input name="name" type="text" class="form-control" placeholder="Full name" required="" />
                        <div id="name--invalid-feedback" class="invalid-feedback"></div>
                    </div>
                    
                    
                    <!-- -->
                    <section id="person_type_1" style="display: none;">
                        <div class="mb-3">
                            <label class="form-label">CNPJ</label>
                            <input name="cnpj" type="text" class="form-control" placeholder="CNPJ" data-inputmask="'mask': '99.999.999/9999-99'" onblur="frmRegisterCheckCNPJ()" inputmode="numeric" autocomplete="off" />
                            <div id="cnpj--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </section>
                    <section id="person_type_2">
                        <div class="mb-3" style="display: none;">
                            <label class="form-label">CPF</label>
                            <input name="cpf" type="text" class="form-control" placeholder="CPF" data-inputmask="'mask': '999.999.999-99'" onblur="frmRegisterCheckCPF()" inputmode="numeric" autocomplete="off" />
                            <div id="cpf--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Birthdate</label>
                            <input name="birthdate" type="text" name="input-mask" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" autocomplete="off">
                        </div>
                        
                        <div class="mb-3">
                            <div class="form-label">Sex</div>
                            <select name="sex" class="form-select">
                                <option value="">- Select -</option>
                                <option value="masc">Male</option>
                                <option value="fem">Female</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                    </section>
                    <!-- -->
                    
                    
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input name="email" type="email" class="form-control" placeholder="Email" onblur="frmRegisterCheckEmail(this.value);" required />
                        <div id="email--invalid-feedback" class="invalid-feedback"></div>
                    </div>
                    
                    <style>
                        .iti {
                            width: 100%;
                        }
                    </style>
                    <div class="mb-3">
                        <label class="form-label">Mobile phone</label>
                        <!--<input id="mobile_phone" name="mobile_phone" type="text" class="form-control" placeholder="Digite seu celular" data-inputmask="'mask': '(99) 99999-9999'" inputmode="numeric" autocomplete="off" required />-->
                        <input id="mobile_phone" name="mobile_phone" type="tel" class="form-control" inputmode="numeric" autocomplete="off" onkeyup="setInputMask(this);" required />
                        <!--<div id="mobile_phone--invalid-feedback" class="invalid-feedback"></div>-->
                        <div id="mobile_phone--invalid-feedback" class="invalid-feedback" style="display: none;"></div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Sponsor Side Binary Key</label>
                    
                        <input id="binary_key" name="binary_key" type="text" class="form-control" disabled />
                    
                    </div>
                    
                    <script>
                        const phoneInputField = document.querySelector("#mobile_phone");
                        //const phoneInput = window.intlTelInput(phoneInputField, {
                        //    utilsScript:
                        //    "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
                        //});
                        //const phoneInput = window.intlTelInput(phoneInputField, {
                        //    initialCountry: "auto",
                        //    geoIpLookup: getIp,
                        //    utilsScript:
                        //        "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
                        //});
                        const phoneInput = window.intlTelInput(phoneInputField, {
                            preferredCountries: ["br", "us", "co", "in", "de"],
                            utilsScript:
                                "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
                        });
                        
                        /** **/
                        /*const info = document.getElementById("mobile_phone--invalid-feedback");
                        function process(event) {
                            event.preventDefault();
                            
                            const phoneNumber = phoneInput.getNumber();
                            
                            info.style.display = "";
                            info.innerHTML = 'Phone number in E.164 format: <strong>${phoneNumber}</strong>';
                        }*/
                        
                        /** **/
                        /*function getIp(callback) {
                         fetch('https://ipinfo.io/json?token=<your token>', { headers: { 'Accept': 'application/json' }})
                           .then((resp) => resp.json())
                           .catch(() => {
                             return {
                               country: 'us',
                             };
                           })
                           .then((resp) => callback(resp.country));
                        }*/
                        
                        /** **/
                        function setInputMask(el) {
                            var str = el.placeholder;
                            str = str.replace(/0/g, "9");
                            str = str.replace(/1/g, "9");
                            str = str.replace(/2/g, "9");
                            str = str.replace(/3/g, "9");
                            str = str.replace(/4/g, "9");
                            str = str.replace(/5/g, "9");
                            str = str.replace(/6/g, "9");
                            str = str.replace(/7/g, "9");
                            str = str.replace(/8/g, "9");
                            
                            var im = new Inputmask(str);
                            im.mask(el);
                        }
                     </script>
                    
                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input name="username" type="text" class="form-control" placeholder="Username" minlength="6" maxlength="40" pattern="[a-zA-Z0-9._]+" autocomplete="off" onblur="frmRegisterCheckUsername(this.value);" onkeypress="return ApenasLetras(event,this);" required />
                        <div id="username--invalid-feedback" class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <!--<div class="input-group input-group-flat">-->
                            <input name="password" type="password" class="form-control" placeholder="Password" minlength="6" maxlength="40" autocomplete="off" required />
                            <!--<span class="input-group-text">
                                <a href="#" class="link-secondary" title="Show password" data-bs-toggle="tooltip">
                                    <!-- Download SVG icon from http://tabler-icons.io/i/eye --><!--
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <circle cx="12" cy="12" r="2" />
                                        <path d="M22 12c-2.667 4.667 -6 7 -10 7s-7.333 -2.333 -10 -7c2.667 -4.667 6 -7 10 -7s7.333 2.333 10 7" />
                                    </svg>
                                </a>
                            </span>-->
                            <div id="password--invalid-feedback" class="invalid-feedback"></div>
                        <!--</div>-->
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Confirm password</label>
                        <!--<div class="input-group input-group-flat">-->
                            <input name="password_confirm" type="password" class="form-control" placeholder="Confirm password" minlength="6" maxlength="40" autocomplete="off" required />
                            <!--<span class="input-group-text">
                                <a href="#" class="link-secondary" title="Show password" data-bs-toggle="tooltip">
                                    <!-- Download SVG icon from http://tabler-icons.io/i/eye --><!--
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <circle cx="12" cy="12" r="2" />
                                        <path d="M22 12c-2.667 4.667 -6 7 -10 7s-7.333 -2.333 -10 -7c2.667 -4.667 6 -7 10 -7s7.333 2.333 10 7" />
                                    </svg>
                                </a>
                            </span>-->
                            <div id="password_confirm--invalid-feedback" class="invalid-feedback"></div>
                        <!--</div>-->
                    </div>
                    <div class="mb-3">
                        <label class="form-check">
                            <input id="basic_checkbox_1" type="checkbox" class="form-check-input" onchange="activeNewRegister(this);" />
                            <span class="form-check-label">I agree with <a href="/uploads/terms-and-policy.pdf" tabindex="-1" target="_blank">terms and policy</a>.</span>
                        </label>
                    </div>
                    <div class="form-footer">
                        <div id="msg"></div>
                        <button id="newRegister" type="submit" class="btn btn-primary w-100" disabled="">Create account</button>
                    </div>
                </section>
            </div>
        </form>
        
        <style>
            a.gflag {
                margin: 4px;
                display: none;
            }
        </style>
        <div style="height: 44px;padding: 12px;margin: 6px;text-align: center;">
            <!-- GTranslate: https://gtranslate.io/ -->
            <a href="#" onclick="doGTranslate('en|en');return false;" title="English" class="gflag nturl" style="background-position:-0px -0px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="English" /></a><a href="#" onclick="doGTranslate('en|fr');return false;" title="French" class="gflag nturl" style="background-position:-200px -100px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="French" /></a><a href="#" onclick="doGTranslate('en|de');return false;" title="German" class="gflag nturl" style="background-position:-300px -100px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="German" /></a><a href="#" onclick="doGTranslate('en|it');return false;" title="Italian" class="gflag nturl" style="background-position:-600px -100px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="Italian" /></a><a href="#" onclick="doGTranslate('en|pt');return false;" title="Portuguese" class="gflag nturl" style="background-position:-300px -200px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="Portuguese" /></a><a href="#" onclick="doGTranslate('en|ru');return false;" title="Russian" class="gflag nturl" style="background-position:-500px -200px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="Russian" /></a><a href="#" onclick="doGTranslate('en|es');return false;" title="Spanish" class="gflag nturl" style="background-position:-600px -200px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="Spanish" /></a>

            <style type="text/css">
            <!--
            a.gflag {vertical-align:middle;font-size:16px;padding:1px 0;background-repeat:no-repeat;background-image:url(//gtranslate.net/flags/16.png);}
            a.gflag img {border:0;}
            a.gflag:hover {background-image:url(//gtranslate.net/flags/16a.png);}
            #goog-gt-tt {display:none !important;}
            .goog-te-banner-frame {display:none !important;}
            .goog-te-menu-value:hover {text-decoration:none !important;}
            body {top:0 !important;}
            #google_translate_element2 {display:none!important;}
            -->
            </style>

            <br />
            <select onchange="doGTranslate(this);">
                <option value="">Select Language</option>
                <option value="en|af">Afrikaans</option>
                <option value="en|sq">Albanian</option>
                <option value="en|ar">Arabic</option>
                <option value="en|hy">Armenian</option>
                <option value="en|az">Azerbaijani</option>
                <!--<option value="en|eu">Basque</option>-->
                <option value="en|be">Belarusian</option>
                <option value="en|bg">Bulgarian</option>
                <!--<option value="en|ca">Catalan</option>-->
                <option value="en|zh-CN">Chinese (Simplified)</option>
                <option value="en|zh-TW">Chinese (Traditional)</option>
                <option value="en|hr">Croatian</option>
                <option value="en|cs">Czech</option>
                <option value="en|da">Danish</option>
                <option value="en|nl">Dutch</option>
                <option value="en|en">English</option>
                <option value="en|et">Estonian</option>
                <option value="en|tl">Filipino</option>
                <option value="en|fi">Finnish</option>
                <option value="en|fr">French</option>
                <!--<option value="en|gl">Galician</option>-->
                <option value="en|ka">Georgian</option>
                <option value="en|de">German</option>
                <option value="en|el">Greek</option>
                <option value="en|ht">Haitian Creole</option>
                <!--<option value="en|iw">Hebrew</option>-->
                <option value="en|hi">Hindi</option>
                <option value="en|hu">Hungarian</option>
                <!--<option value="en|is">Icelandic</option>-->
                <option value="en|id">Indonesian</option>
                <!--<option value="en|ga">Irish</option>-->
                <option value="en|it">Italian</option>
                <option value="en|ja">Japanese</option>
                <option value="en|ko">Korean</option>
                <option value="en|lv">Latvian</option>
                <option value="en|lt">Lithuanian</option>
                <option value="en|mk">Macedonian</option>
                <!--<option value="en|ms">Malay</option>
                <option value="en|mt">Maltese</option>-->
                <option value="en|no">Norwegian</option>
                <option value="en|fa">Persian</option>
                <option value="en|pl">Polish</option>
                <option value="en|pt">Portuguese</option>
                <option value="en|ro">Romanian</option>
                <option value="en|ru">Russian</option>
                <option value="en|sr">Serbian</option>
                <option value="en|sk">Slovak</option>
                <option value="en|sl">Slovenian</option>
                <option value="en|es">Spanish</option>
                <option value="en|sw">Swahili</option>
                <option value="en|sv">Swedish</option>
                <option value="en|th">Thai</option>
                <option value="en|tr">Turkish</option>
                <option value="en|uk">Ukrainian</option>
                <option value="en|ur">Urdu</option>
                <option value="en|vi">Vietnamese</option>
                <option value="en|cy">Welsh</option>
                <option value="en|yi">Yiddish</option>
            </select>
            <div id="google_translate_element2"></div>
            <script type="text/javascript">
            function googleTranslateElementInit2() {new google.translate.TranslateElement({pageLanguage: 'en',autoDisplay: false}, 'google_translate_element2');}
            </script><script type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit2"></script>


            <script type="text/javascript">
            /* <![CDATA[ */
            eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('6 7(a,b){n{4(2.9){3 c=2.9("o");c.p(b,f,f);a.q(c)}g{3 c=2.r();a.s(\'t\'+b,c)}}u(e){}}6 h(a){4(a.8)a=a.8;4(a==\'\')v;3 b=a.w(\'|\')[1];3 c;3 d=2.x(\'y\');z(3 i=0;i<d.5;i++)4(d[i].A==\'B-C-D\')c=d[i];4(2.j(\'k\')==E||2.j(\'k\').l.5==0||c.5==0||c.l.5==0){F(6(){h(a)},G)}g{c.8=b;7(c,\'m\');7(c,\'m\')}}',43,43,'||document|var|if|length|function|GTranslateFireEvent|value|createEvent||||||true|else|doGTranslate||getElementById|google_translate_element2|innerHTML|change|try|HTMLEvents|initEvent|dispatchEvent|createEventObject|fireEvent|on|catch|return|split|getElementsByTagName|select|for|className|goog|te|combo|null|setTimeout|500'.split('|'),0,{}))
            /* ]]> */
            </script>
        </div>
        
        <div class="text-center text-muted mt-3">Already have an account? <a href="javascript:router.navigate('login');" tabindex="-1">Sign-in</a></div>
    </div>
</div>

<script>
    var qs = urlQueryObj();
    var frmRegister = document.getElementById('frmRegister');
    
    /**if (qs["mn"] != undefined) {
        frmLogin.querySelector("input[name='username']").value = qs["mn"];
    }
    
    if (qs["error"] != undefined) {
        var elementsErrorMessage = frmLogin.parentElement.querySelector(".error-message");
        elementsErrorMessage.innerHTML = qs["error"];
        elementsErrorMessage.classList.add("visible");
    }
    
    frmLogin.querySelector("input[name='username']").focus();**/
    
    
    var url  = window.location.href; 
    var absoluto = url.split("/")[url.split("/").length -1];
    
    var elDataIndicator = document.getElementById("dataIndicator");
    if (url == "{{settings.__app_url}}/create-account/"+absoluto && absoluto != "" && absoluto != "create-account") {
    //if (url == "https://app.sevencapital.developer.brauntech.com.br/create-account/"+absoluto && absoluto != "" && absoluto != "create-account") {
        checkSponsorAccount(absoluto);
    } else {
        elDataIndicator.innerHTML = "Your indicator was not informed.<br />Please contact us and request a link to register.";

        frmRegister.querySelector("input[name='binary_key']").value = 'right';
    }
    
    function checkSponsorAccount(username){
        if ((username == "") || (username.length < 4)){
            /**var fullName = document.getElementsByClassName('dataProfileFullName');
            for (var i = 0; i < fullName.length; i++) {
                fullName[i].innerHTML = '<b>- não definido -</b>';
            }*/
            elDataIndicator.innerHTML = '<b>- Undefined indicator -</b>';
            return;
        }
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/check-indicator",
            data: {
                username: username
            },
            success: function(response){
                if (response.data != null) {
                    frmRegister.querySelector("input[name='sponsor']").value = response.data._username;

                    frmRegister.querySelector("input[name='binary_key']").value = response.data._binary_key;
                    
                    var _info = '',
                        _social = '';
                    
                    if (!!response.data._name){
                        _info += '<b>' + response.data._name + '</b><br />';
                    }
                    
                    if (!!response.data._username){
                        _info += response.data._username + '<br />';
                    }
                    
                    if (!!response.data._mobile_phone){
                        //_info += Inputmask.format(response.data._mobile_phone, { mask: "(99) 99999-9999" }) + '<br />'; ///_maskMobile_phone)+
                        _info += formatMobilePhone(response.data._mobile_phone, response.data._country_phone_mask) + '<br />'; ///_maskMobile_phone)+
                    }
                    
                    if (!!response.data._email){
                        _info += response.data._email + '<br />';
                    }
                    
                    
                    ///for (var dataInfo of document.querySelectorAll('.dataInfo')) {
                        elDataIndicator.innerHTML = 
                              '<div style="width: 100%;display: block;position: relative;height: 60px;">'
                            + '    <div style="width: 60px;display: block;position: absolute;height: 60px;">'
                            + '        <img src="../assets/img/picker_account.png" style="height: 40px;width: 40px;border-radius: 50%;display: block;margin: 0 auto;padding: 0;margin-top: 6px;">'
                            + '    </div>'
                            + '    <div style="width: calc(100% - 60px);display: block;position: absolute;height: 60px;left: 60px;padding: 4px;">'
                            +          _info
                            + '    </div>'
                            + '</div>';
                    ///}
                    
                    document.getElementById("register").classList.remove("disabled");
                    frmRegister.name.focus();
                } else {
                    alert('Sponsor not found or not available.');
                    
                    var fullName = document.getElementsByClassName('dataProfileFullName');
                    for (var i = 0; i < fullName.length; i++) {
                        fullName[i].innerHTML = '<b>- undefined -</b>';
                    }
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                // response is originally response.errors of query result
                console.log(error);
                
                elDataIndicator.innerHTML = "It was not possible to search for your sponsor.<br />Please wait a while and try again.";
            }
        });
    }
    
    
    function setPersonType(personType) {
        switch(personType){
            case 'natural_person':
                document.getElementById('person_type_1').style.display = 'none';
                document.getElementById('person_type_2').style.display = 'block';
            break;
            case 'legal_person':
                document.getElementById('person_type_1').style.display = 'block';
                document.getElementById('person_type_2').style.display = 'none';
            break;
            case 'foreign_person':
                document.getElementById('person_type_1').style.display = 'none';
                document.getElementById('person_type_2').style.display = 'none';
            break;
        }
        
        frmRegister.name.focus();
    }
    
    function activeNewRegister(el) {
        if (el.checked == true) {
            document.getElementById('newRegister').disabled = false;
        } else {
            document.getElementById('newRegister').disabled = true;
        }
    }
    
    
    var frm_accountCreate = document.getElementById('frmRegister');
    
    /**frm_accountCreate.addEventListener("keydown", function(e){
        e.target.classList.remove("error");
        e.target.parentElement.classList.remove("error");
        
        /*var sections = document.querySelectorAll('.visible');
        for (i = 0; i < sections.length; i++){
            sections[i].classList.remove('visible');
        }*/
    /**});*/
    
    function frmRegisterCheckCPF() {
        var elCpf = frm_accountCreate.querySelector("input[name='cpf']");
        
        document.querySelectorAll('.is-invalid').forEach(elem => {
            elem.classList.remove("is-invalid");
        });
        
        if (elCpf.value.length > 0) {
            $.ajax({
                type: "POST",
                url: CFG__API_URL + CFG__API_VERSION + "/accounts/check-cpf-available",
                data: {
                    cpf: elCpf.value
                },
                success: function(response){
                    if (response.success == false) {
                        elCpf.classList.add("is-invalid");
                        document.getElementById("cpf--invalid-feedback").innerHTML = response.message;
                    }
                    
                    /**frmLogin.querySelectorAll('button').forEach(elem => {
                        elem.removeAttribute('disabled');
                    });*/
                    
                    //hideElementPreloader();
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                    
                    // response is originally response.errors of query result
                    console.log(error);
                    
                    elCpf.classList.add("is-invalid");
                    document.getElementById("cpf--invalid-feedback").innerHTML = jsonResponse.message;
                }
            });
        } else {
            elCpf.classList.add("is-invalid");
            document.getElementById("cpf--invalid-feedback").innerHTML = 'CPF must be informed!';
        }
    }
    
    function frmRegisterCheckCNPJ() {
        var elCnpj = frm_accountCreate.querySelector("input[name='cnpj']");
        
        document.querySelectorAll('.is-invalid').forEach(elem => {
            elem.classList.remove("is-invalid");
        });
        
        if (elCnpj.value.length > 0) {
            $.ajax({
                type: "POST",
                url: CFG__API_URL + CFG__API_VERSION + "/accounts/check-cnpj-available",
                data: {
                    cnpj: elCnpj.value
                },
                success: function(response){
                    if (response.success == false) {
                        elCnpj.classList.add("is-invalid");
                        document.getElementById("cnpj--invalid-feedback").innerHTML = response.message;
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                    
                    // response is originally response.errors of query result
                    console.log(error);
                    
                    elCnpj.classList.add("is-invalid");
                    document.getElementById("cnpj--invalid-feedback").innerHTML = jsonResponse.message;
                }
            });
        } else {
            elCnpj.classList.add("is-invalid");
            document.getElementById("cnpj--invalid-feedback").innerHTML = 'CNPJ must be informed!';
        }
    }
    
    function frmRegisterCheckUsername() {
        var elUsername = document.querySelector("#frmRegister input[name='username']");
        
        elUsername.classList.remove("is-invalid");
        
        var usernameOK = validateUsername(elUsername.value);
        if (usernameOK == false) {
            elUsername.classList.add("is-invalid");
            document.getElementById("username--invalid-feedback").innerHTML = 'The username can only contain letter, number, dash (_) and period (.).!';
            
            elUsername.focus();
            return false;
        }
        
        if (elUsername.value.length >= 4) {
            $.ajax({
                type: "POST",
                url: CFG__API_URL + CFG__API_VERSION + "/accounts/check-username-available",
                data: {
                    username: elUsername.value
                },
                success: function(response){
                    /*
                    frmLogin.querySelectorAll('button').forEach(elem => {
                        elem.removeAttribute('disabled');
                    });
                    */
                    
                    document.querySelectorAll('.is-invalid').forEach(elem => {
                        elem.classList.remove("is-invalid");
                    });
                    
                    if (response.is_available == true) {
                        return true;
                    } else {
                        elUsername.classList.add("is-invalid");
                        document.getElementById("username--invalid-feedback").innerHTML = 'The entered username is already in use. Use another username!';
                        
                        elUsername.focus();
                        return false;
                    }
                    
                    //hideElementPreloader();
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                    
                    // response is originally response.errors of query result
                    console.log(error);
                    
                    elUsername.classList.add("is-invalid");
                    document.getElementById("username--invalid-feedback").innerHTML = 'Could not verify username, please try again!';
                    return false;
                }
            });
        } else {
            elUsername.classList.add("is-invalid");
            document.getElementById("username--invalid-feedback").innerHTML = 'The username must contain at least 4 digits!';
        }
    }
    
    function frmRegisterCheckEmail() {
        var elEmail = document.querySelector("#frmRegister input[name='email']");
        
        elEmail.classList.remove("is-invalid");
        
        if (elEmail.value.length >= 1) {
            $.ajax({
                type: "POST",
                url: CFG__API_URL + CFG__API_VERSION + "/accounts/check-email-available",
                data: {
                    email: elEmail.value
                },
                success: function(response){
                    /*
                    frmLogin.querySelectorAll('button').forEach(elem => {
                        elem.removeAttribute('disabled');
                    });
                    */
                    
                    document.querySelectorAll('.is-invalid').forEach(elem => {
                        elem.classList.remove("is-invalid");
                    });
                    
                    if (response.is_available == true) {
                        return true;
                    } else {
                        elEmail.classList.add("is-invalid");
                        document.getElementById("email--invalid-feedback").innerHTML = 'The email provided is already in use!';
                        
                        elEmail.focus();
                        return false;
                    }
                    
                    //hideElementPreloader();
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                    
                    // response is originally response.errors of query result
                    console.log(error);
                    
                    elEmail.classList.add("is-invalid");
                    document.getElementById("email--invalid-feedback").innerHTML = 'Could not verify email, please try again!';
                    return false;
                }
            });
        } else {
            elEmail.classList.add("is-invalid");
            document.getElementById("email--invalid-feedback").innerHTML = 'Please provide a valid email!';
        }
    }
    
    function frmRegisterCheckPassword() {
        var elPassword = document.querySelector("#frmRegister input[name='password']");
        var elPassword_confirm = document.querySelector("#frmRegister input[name='password_confirm']");
        
        if ((elPassword.value != "") && (elPassword.value.length >= 6)) {
            if (elPassword.value != elPassword_confirm.value) {
                elPassword_confirm.classList.add("is-invalid");
                document.getElementById("password_confirm--invalid-feedback").innerHTML = 'Passwords do not match!';
                
                elPassword_confirm.focus();
                return false;
            } else {
                return true;
            }
        } else {
            elPassword_confirm.classList.add("is-invalid");
            document.getElementById("password_confirm--invalid-feedback").innerHTML = 'The password must be longer than 6 digits.';
            
            elPassword.focus();
            return false;
        }
    }
    
    frmRegister.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.is-invalid').forEach(elem => {
            elem.classList.remove("is-invalid");
        });
        
        var elPerson_type = document.querySelector("#frmRegister input[name='person_type']");
        var personType = 'foreign_person';  //elPerson_type.value;
        
        var elSponsor = document.querySelector("#frmRegister input[name='sponsor']");
        var elName = document.querySelector("#frmRegister input[name='name']");
        var elSex = document.querySelector("#frmRegister select[name='sex']");
        var elBirthdate = document.querySelector("#frmRegister input[name='birthdate']");
        var elCPF = document.querySelector("#frmRegister input[name='cpf']");
        var elCNPJ = document.querySelector("#frmRegister input[name='cnpj']");
        var elMobile_phone = document.querySelector("#frmRegister input[name='mobile_phone']");
        var elEmail = document.querySelector("#frmRegister input[name='email']");
        var elUsername = document.querySelector("#frmRegister input[name='username']");
        var elPassword = document.querySelector("#frmRegister input[name='password']");
        //var elStore_sponsor = document.querySelector("#frmRegister input[name='store_sponsor']");
        
        if (elName.value == "") {
            elName.classList.add("is-invalid");
            document.getElementById("password--invalid-feedback").innerHTML = 'The name is mandatory!';
            
            elName.focus();
            return;
        }
        if (elEmail.value == "") {
            elEmail.classList.add("is-invalid");
            document.getElementById("password--invalid-feedback").innerHTML = 'The email is mandatory!';
            
            elEmail.focus();
            return;
        }
        
        const phoneNumber = phoneInput.getNumber();
        var countryData = phoneInput.getSelectedCountryData();
        
        if (phoneNumber == "") {
            elMobile_phone.classList.add("is-invalid");
            document.getElementById("password--invalid-feedback").innerHTML = 'The phone is mandatory!';
            
            elMobile_phone.focus();
            return;
        }
        if (elUsername.value == "") {
            elUsername.classList.add("is-invalid");
            document.getElementById("password--invalid-feedback").innerHTML = 'The username is mandatory!';
            
            elUsername.focus();
            return;
        }
        
        if (personType == "natural_person") {
            if (elCPF.value == "") {
                elCPF.classList.add("is-invalid");
                document.getElementById("password--invalid-feedback").innerHTML = 'The CPF is mandatory!';
                
                elCPF.focus();
                return;
            }
            
            /**if (!validaCpfCnpj(elCPF.value)) {
                var msg = '<div class="alert alert-danger alert-dismissible">' +
                        '    <button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="this.parentElement.remove();">'+
                        '        <span aria-hidden="true">&times;</span>'+
                        '    </button>' +
                        '    <div class="content">' +
                        '        O CPF informado é inválido!' +
                        '    </div>'+
                        '</div>';
                
                frm_accountCreate.querySelector("#msg").innerHTML = msg;
                elCPF.focus();
                return;
            }*/
        } else if (personType == "legal_person") {
            if (elCNPJ.value == "") {
                elCNPJ.classList.add("is-invalid");
                document.getElementById("password--invalid-feedback").innerHTML = 'The CNPJ is mandatory!';
                
                elCNPJ.focus();
                return;
            }
            
            /**if (!validaCpfCnpj(elCNPJ.value)) {
                var msg = '<div class="alert alert-danger alert-dismissible">' +
                        '    <button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="this.parentElement.remove();">'+
                        '        <span aria-hidden="true">&times;</span>'+
                        '    </button>' +
                        '    <div class="content">' +
                        '        O CNPJ informado é inválido!' +
                        '    </div>'+
                        '</div>';
                
                frm_accountCreate.querySelector("#msg").innerHTML = msg;
                elCNPJ.focus();
                return;
            }*/
        } else if (personType == "foreign_person") {
            // no validate
        }
        
        //submit if fail never got set to true
        if (!frmRegisterCheckPassword()) {
            return;
        }
        
        /** **/
        const phoneInputField = document.querySelector("#mobile_phone");
        var phone_mask = phoneInputField.placeholder;
        phone_mask = phone_mask.replace(/0/g, "9");
        phone_mask = phone_mask.replace(/1/g, "9");
        phone_mask = phone_mask.replace(/2/g, "9");
        phone_mask = phone_mask.replace(/3/g, "9");
        phone_mask = phone_mask.replace(/4/g, "9");
        phone_mask = phone_mask.replace(/5/g, "9");
        phone_mask = phone_mask.replace(/6/g, "9");
        phone_mask = phone_mask.replace(/7/g, "9");
        phone_mask = phone_mask.replace(/8/g, "9");
        /** **/
        
        document.getElementById("newRegister").disabled = true;
        
        /* create account ****************************************************************************** */
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/accounts",
            data: {
                type: personType,
                name: elName.value,
                sex: elSex.value,
                birthdate: FormatStringDate(elBirthdate.value),
                cpf: elCPF.value,
                cnpj: elCNPJ.value,
                //mobile_phone: elMobile_phone.value,
                mobile_phone: phoneNumber,
                email: elEmail.value,
                username: elUsername.value,
                password: elPassword.value,
                sponsor: elSponsor.value,
                country_dial_code: countryData.dialCode,
                country_phone_mask: phone_mask,
                country_iso2: countryData.iso2,
                country_name: countryData.name
                //indicator: elStore_sponsor.value
            },
            success: function(response){
                /*
                frmLogin.querySelectorAll('button').forEach(elem => {
                    elem.removeAttribute('disabled');
                });
                */
                
                document.querySelectorAll('.alert').forEach(elem => {
                    elem.remove();
                });
                
                if (response.data) {
                    $.ajax({
                        type: "POST",
                        url: CFG__API_URL + CFG__API_VERSION + "/auth",
                        data: {
                            username: elUsername.value,
                            password: elPassword.value
                        },
                        success: function(response_login){
                            /* if (document.getElementById("basic_checkbox_1").checked == true) {
                                cookieSet("remember", usernameObj.value, 365, "<?=$cookieDomain?>");
                            } else {
                                cookieErase("remember", "<?=$cookieDomain?>");
                            } */
                            
                            
                            if (response_login.data.role == "user") {
                                var decoded = jwt_decode(response.data.token);
                                cookieSetJwt('__utmo', response_login.data.token, decoded.exp, CFG__COOKIE_DOMAIN);
                                
                                window.location.replace(_appData.settings.__app_url);
                            }
                            
                            frm_accountCreate.querySelectorAll('button').forEach(elem => {
                                elem.removeAttribute('disabled');
                            });
                            
                            hideElementPreloader();
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                            
                            console.log(error)
                            
                            frm_accountCreate.querySelectorAll('button').forEach(elem => {
                                elem.removeAttribute('disabled');
                            });
                            
                            //frmLogin.parentElement.querySelector(".error-message").innerHTML = error.message;
                            //frmLogin.parentElement.classList.add("error");
                            
                            //$("#msgError").html(error.message);
                            
                            var newItem = document.createElement("div");
                            newItem.className = 'alert alert-danger alert-dismissible';
                            
                            var newItem_button = document.createElement("button");
                            newItem_button.className = 'close';
                            newItem_button.setAttribute("data-dismiss", 'alert');
                            newItem_button.setAttribute("aria-label", 'Close');
                            newItem_button.setAttribute("onclick", 'this.parentElement.remove();');
                            
                            var newItem_button_span = document.createElement("span");
                            newItem_button_span.ariaHidden = 'true';
                            newItem_button_span.innerHTML = '&times';
                            
                            var newItem_content = document.createElement("div");
                            newItem_content.className = 'content';
                            newItem_content.innerHTML = error.message;
                            
                            newItem_button.appendChild(newItem_button_span);
                            newItem.appendChild(newItem_button);
                            newItem.appendChild(newItem_content);
                            
                            frm_accountCreate.insertAdjacentElement('beforeBegin', newItem);
                            
                            hideElementPreloader();
                        }
                    });
                } else {
                    frm_accountCreate.querySelector("#msg").insertAdjacentHTML('beforeBegin', 
                          '<div class="alert alert-danger alert-dismissible" role="alert">'
                        + '    <div class="d-flex">'
                        + '        <div>'
                        //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                        + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                        + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                        + '                <circle cx="12" cy="12" r="9"></circle>'
                        + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                        + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                        + '            </svg>'
                        + '        </div>'
                        + '        <div>'
                        + '            <h4 class="alert-title">Sorry...</h4>'
                        + '            <div class="text-muted">Error creating your login account.</div>'
                        + '        </div>'
                        + '    </div>'
                        + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                        + '</div>'
                    );
                    
                    document.getElementById("newRegister").disabled = true;
                }
                
                //hideElementPreloader();
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                // response is originally response.errors of query result
                console.log(error);
                /**
                // response is originally response.errors of query result
                console.log(error)
                
                frmLogin.querySelectorAll('button').forEach(elem => {
                    elem.removeAttribute('disabled');
                });
                
                //frmLogin.parentElement.querySelector(".error-message").innerHTML = error.message;
                //frmLogin.parentElement.classList.add("error");
                
                //$("#msgError").html(error.message);
                
                var msg = '<div class="alert alert-danger alert-dismissible">' +
                        '    <button type="button" class="close" data-dismiss="alert" aria-label="Close" onclick="this.parentElement.remove();">'+
                        '        <span aria-hidden="true">&times;</span>'+
                        '    </button>' +
                        '    <div class="content">' +
                            error.message +
                        '    </div>'+
                        '</div>';
                
                frmLogin.insertAdjacentHTML('beforeBegin', msg);
                
                hideElementPreloader();
                */
                
                frm_accountCreate.querySelector("#msg").insertAdjacentHTML('beforeBegin', 
                      '<div class="alert alert-danger alert-dismissible" role="alert">'
                    + '    <div class="d-flex">'
                    + '        <div>'
                    //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                    + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                    + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                    + '                <circle cx="12" cy="12" r="9"></circle>'
                    + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                    + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                    + '            </svg>'
                    + '        </div>'
                    + '        <div>'
                    + '            <h4 class="alert-title">Sorry...</h4>'
                    + '            <div class="text-muted">' + error.message + '</div>'
                    + '        </div>'
                    + '    </div>'
                    + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                    + '</div>'
                );
                
                document.getElementById("newRegister").disabled = true;
                
                elUsername.focus();
                return false;
            }
        });
        /* end ******************************************************************************************* */
        
    }
    
    /*$('.date-picker').each(function(){
        $(this).datepicker({
            templates:{
                leftArrow: '<i class="now-ui-icons arrows-1_minimal-left"></i>',
                rightArrow: '<i class="now-ui-icons arrows-1_minimal-right"></i>'
            }
        }).on('show', function() {
                $('.datepicker').addClass('open');

                datepicker_color = $(this).data('datepicker-color');
                if( datepicker_color.length != 0){
                    $('.datepicker').addClass('datepicker-'+ datepicker_color +'');
                }
            }).on('hide', function() {
                $('.datepicker').removeClass('open');
            });
    });*/
    
    function validaCpfCnpj(val) {
        if (val.length == 14) {
            var cpf = val.trim();
         
            cpf = cpf.replace(/\./g, '');
            cpf = cpf.replace('-', '');
            cpf = cpf.split('');
            
            var v1 = 0;
            var v2 = 0;
            var aux = false;
            
            for (var i = 1; cpf.length > i; i++) {
                if (cpf[i - 1] != cpf[i]) {
                    aux = true;   
                }
            } 
            
            if (aux == false) {
                return false; 
            } 
            
            for (var i = 0, p = 10; (cpf.length - 2) > i; i++, p--) {
                v1 += cpf[i] * p; 
            } 
            
            v1 = ((v1 * 10) % 11);
            
            if (v1 == 10) {
                v1 = 0; 
            }
            
            if (v1 != cpf[9]) {
                return false; 
            } 
            
            for (var i = 0, p = 11; (cpf.length - 1) > i; i++, p--) {
                v2 += cpf[i] * p; 
            } 
            
            v2 = ((v2 * 10) % 11);
            
            if (v2 == 10) {
                v2 = 0; 
            }
            
            if (v2 != cpf[10]) {
                return false; 
            } else {   
                return true; 
            }
        } else if (val.length == 18) {
            var cnpj = val.trim();
            
            cnpj = cnpj.replace(/\./g, '');
            cnpj = cnpj.replace('-', '');
            cnpj = cnpj.replace('/', ''); 
            cnpj = cnpj.split(''); 
            
            var v1 = 0;
            var v2 = 0;
            var aux = false;
            
            for (var i = 1; cnpj.length > i; i++) { 
                if (cnpj[i - 1] != cnpj[i]) {  
                    aux = true;   
                } 
            } 
            
            if (aux == false) {  
                return false; 
            }
            
            for (var i = 0, p1 = 5, p2 = 13; (cnpj.length - 2) > i; i++, p1--, p2--) {
                if (p1 >= 2) {  
                    v1 += cnpj[i] * p1;  
                } else {  
                    v1 += cnpj[i] * p2;  
                } 
            } 
            
            v1 = (v1 % 11);
            
            if (v1 < 2) { 
                v1 = 0; 
            } else { 
                v1 = (11 - v1); 
            } 
            
            if (v1 != cnpj[12]) {  
                return false; 
            } 
            
            for (var i = 0, p1 = 6, p2 = 14; (cnpj.length - 1) > i; i++, p1--, p2--) { 
                if (p1 >= 2) {  
                    v2 += cnpj[i] * p1;  
                } else {   
                    v2 += cnpj[i] * p2; 
                } 
            }
            
            v2 = (v2 % 11); 
            
            if (v2 < 2) {  
                v2 = 0;
            } else { 
                v2 = (11 - v2); 
            } 
            
            if (v2 != cnpj[13]) {   
                return false; 
            } else {  
                return true; 
            }
        } else {
            return false;
        }
    }
    
    function ApenasLetras(e, t) {
        try {
            if (window.event) {
                var charCode = window.event.keyCode;
            } else if (e) {
                var charCode = e.which;
            } else {
                return true;
            }
            if (
                (charCode == 46) ||
                (charCode == 95) ||
                (charCode >= 48 && charCode <= 57) || 
                (charCode > 64 && charCode < 91) || 
                (charCode > 96 && charCode < 123)
                //(charCode > 191 && charCode <= 255) // letras com acentos
            ){
                return true;
            } else {
                return false;
            }
        } catch (err) {
            alert(err.Description);
        }
    }
    
    function validateUsername(str){
        var nameRegex = /^[a-zA-Z0-9._]+$/;
        var validUsername = str.match(nameRegex);
        if (validUsername != null){
            return true;
        }
        
        return false;
    }
    
    
    function showElementPreloader(){
        var elemDivHolder = document.createElement('div');
        elemDivHolder.className = 'holder';
        elemDivHolder.style.cssText = 'position: absolute; left: 0px; top: 0px; bottom: 0px; right: 0px; width: 100%; height: 100%; background-color: #ffffff; z-index: 9999; opacity: 0.9;';
        var elemDivPreloaderImg = document.createElement('img');
        elemDivPreloaderImg.className = 'preloader';
        elemDivPreloaderImg.style.cssText = 'display: block; width: 60px; height: 60px; margin: auto; position: absolute; top: 0; left: 0; bottom: 0; right: 0;';
        elemDivPreloaderImg.src = '../assets/img/loading.gif';
        
        elemDivHolder.appendChild(elemDivPreloaderImg);
        window.document.body.insertBefore(elemDivHolder, window.document.body.firstChild);
    }
    
    function hideElementPreloader(){
        setTimeout(function(){
            document.querySelectorAll('.holder').forEach(function(a){
                a.remove()
            });
        }, 250);
    }
    
    
    document.querySelectorAll("input[name='name']").focus();
</script>
