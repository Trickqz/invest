<!--class="antialiased border-top-wide border-primary d-flex flex-column"-->
<div class="page page-center">
    <div class="container-tight py-4">
        <div class="text-center mb-4">
            <a href="."><img class="n-logo" src="/assets/img/logo-white.png" srcset="/assets/img/logo-white.svg" alt="" style="max-width: 200px;height: auto;width: auto;" /></a>
        </div>
        <form id="frmLogin" name="frmLogin" class="card card-md" autocomplete="off">
            <div class="card-body">
                <h2 class="card-title text-center mb-4">Sign-in</h2>
                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input name="username" type="text" class="form-control" placeholder="Username" minlength="4" maxlength="80" required />
                    <div id="invalid-feedback" class="invalid-feedback"></div>
                </div>
                <div class="mb-2">
                    <label class="form-label">
                        Password
                        <span class="form-label-description">
                            <a href="javascript:router.navigate('/password/reset');">Forgot my password</a>
                        </span>
                    </label>
                    <div class="input-group input-group-flat">
                        <input name="password" type="password" class="form-control" placeholder="Password" minlength="4" maxlength="40" autocomplete="off" required />
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
                    </div>
                </div>
                <div class="mb-2">
                    <label class="form-check">
                        <input id="basic_checkbox_1" type="checkbox" class="form-check-input" onchange="activeNewRegister(this);" />
                        <span class="form-check-label">Remember me on this device</span>
                    </label>
                </div>
                <div class="form-footer">
                    <button type="submit" class="btn btn-primary w-100">Sign-in</button>
                </div>
            </div>
            <!--<div class="hr-text">or</div>
            <div class="card-body">
                <div class="row">
                    <div class="col">
                        <a href="#" class="btn btn-white w-100">
                            <!-- Download SVG icon from http://tabler-icons.io/i/brand-github --><!--
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon text-github" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path
                                    d="M9 19c-4.3 1.4 -4.3 -2.5 -6 -3m12 5v-3.5c0 -1 .1 -1.4 -.5 -2c2.8 -.3 5.5 -1.4 5.5 -6a4.6 4.6 0 0 0 -1.3 -3.2a4.2 4.2 0 0 0 -.1 -3.2s-1.1 -.3 -3.5 1.3a12.3 12.3 0 0 0 -6.2 0c-2.4 -1.6 -3.5 -1.3 -3.5 -1.3a4.2 4.2 0 0 0 -.1 3.2a4.6 4.6 0 0 0 -1.3 3.2c0 4.6 2.7 5.7 5.5 6c-.6 .6 -.6 1.2 -.5 2v3.5"
                                />
                            </svg>
                            Login with Github
                        </a>
                    </div>
                    <div class="col">
                        <a href="#" class="btn btn-white w-100">
                            <!-- Download SVG icon from http://tabler-icons.io/i/brand-twitter --><!--
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon text-twitter" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path
                                    d="M22 4.01c-1 .49 -1.98 .689 -3 .99c-1.121 -1.265 -2.783 -1.335 -4.38 -.737s-2.643 2.06 -2.62 3.737v1c-3.245 .083 -6.135 -1.395 -8 -4c0 0 -4.182 7.433 4 11c-1.872 1.247 -3.739 2.088 -6 2c3.308 1.803 6.913 2.423 10.034 1.517c3.58 -1.04 6.522 -3.723 7.651 -7.742a13.84 13.84 0 0 0 .497 -3.753c-.002 -.249 1.51 -2.772 1.818 -4.013z"
                                />
                            </svg>
                            Login with Twitter
                        </a>
                    </div>
                </div>
            </div>-->
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
        
    </div>
</div>

<script>
    var qs = urlQueryObj();
    var frmLogin = document.getElementById('frmLogin');
    
    frmLogin.onsubmit = function(e){
        e.preventDefault();
        
        var usernameObj = frmLogin.querySelector("input[name='username']");
        var passwdObj = frmLogin.querySelector("input[name='password']");
        
        if ((usernameObj.value == "") || (usernameObj.value.length < 4)){
            usernameObj.focus();
            return;
        }
        
        if ((passwdObj.value == "") || (passwdObj.value.length < 6)) {
            passwdObj.focus();
            return;
        }
        
        
        
        document.querySelectorAll('button').forEach(elem => {
            elem.disabled = true;
        });
        
        document.querySelectorAll('.is-invalid').forEach(elem => {
            elem.classList.remove("is-invalid");
        });
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/auth",
            crossDomain: true,
            data: {
                username: usernameObj.value,
                password: passwdObj.value
            },
            success: function(response){
                if (document.getElementById("basic_checkbox_1").checked == true) {
                    cookieSet("remember", usernameObj.value, 365, CFG__COOKIE_DOMAIN);
                    cookieSet("remember", usernameObj.value, 365, CFG__COOKIE_ADMIN_DOMAIN);
                } else {
                    cookieErase("remember", CFG__COOKIE_DOMAIN);
                    cookieErase("remember", CFG__COOKIE_ADMIN_DOMAIN);
                }
                
                
                if (response.success === true) {
                    if (response.data.role == "developer" || response.data.role == "administrator" || response.data.role == "financial" || response.data.role == "support") {
                        window.location.replace(CFG__APP_ADMIN_URL+"/?token=" + response.data.token);
                    } else if (response.data.role == "user" || response.data.role == "customer") {
                        //cookieSetJwt('__utmo', response.data.token, response.data.expires, CFG__COOKIE_DOMAIN);
                        //window.location.replace(_appData.settings.__app_url);
                        
                        var decoded = jwt_decode(response.data.token);
                        
                        cookieSetJwt('__utmo', response.data.token, decoded.exp, CFG__COOKIE_DOMAIN);
                        //window.location.replace(_appData.settings.store.url + "/?token=" + response.auth__login.authorization.token);
                        window.location.replace("/");
                    }
                }
                
                document.querySelectorAll('button').forEach(elem => {
                    elem.removeAttribute('disabled');
                });
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                document.querySelectorAll('button').forEach(elem => {
                    elem.removeAttribute('disabled');
                });
                
                
                //var newItem = document.createElement("div");
                //newItem.className = 'alert alert-danger';
                //newItem.innerHTML = error[0].message;
                
                //frmLogin.insertAdjacentElement('afterbegin', newItem);
                
                usernameObj.classList.add("is-invalid");
                document.getElementById("invalid-feedback").innerHTML = jsonResponse.message;
            }
        });
    }
    
    frmLogin.addEventListener("keydown", function(e){
        e.target.classList.remove("error");
        e.target.parentElement.classList.remove("error");
        
        /*var sections = document.querySelectorAll('.visible');
        for (i = 0; i < sections.length; i++){
            sections[i].classList.remove('visible');
        }*/
    });
    
    /**const inputs = document.querySelectorAll("input, select, textarea");
    inputs.forEach(input => {
        input.addEventListener(
            "invalid",
            event => {
                input.classList.add("error");
            },
            false
        );
        input.addEventListener(
            "valid",
            event => {
                input.classList.remove("error");
            },
            false
        );
        input.addEventListener(
            "blur",
            function() {
                input.checkValidity();
            }
        );
    });**/
    
    if (qs["mn"] != undefined) {
        frmLogin.querySelector("input[name='username']").value = qs["mn"];
    }
    
    if (qs["error"] != undefined) {
        var newItem = document.createElement("div");
        newItem.className = 'alert alert-danger';
        newItem.innerHTML = qs["error"];
        
        frmLogin.insertAdjacentElement('afterbegin', newItem);
    }
    
    if (cookieGet('remember') != "") {
        frmLogin.querySelector("input[name='username']").value = cookieGet('remember');
        document.getElementById("basic_checkbox_1").checked = true;
        frmLogin.querySelector("input[name='password']").focus();
    } else {
        frmLogin.querySelector("input[name='username']").focus();
    }
</script>
