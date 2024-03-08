<!--class="antialiased border-top-wide border-primary d-flex flex-column"-->
<div class="page page-center">
    <div class="container-tight py-4">
        <div class="text-center mb-4">
            <a href="."><img class="n-logo" src="/assets/img/logo-white.png" srcset="/assets/img/logo-white.svg" alt="" style="max-width: 200px;height: auto;width: auto;" /></a>
        </div>
        <form id="frmReset" name="frmReset" class="card card-md">
            <input name="username" type="hidden">
            
            <div class="card-body">
                <h2 class="card-title text-center mb-4">Confirm the code received</h2>
                <p class="text-muted mb-4">We sent recovery information to your account email.</p>
                <div class="mb-3">
                    <label class="form-label">Enter the code received</label>
                    <input name="code" type="text" class="form-control" minlength="6" maxlength="6" pattern="[0-9]{6}" autocomplete="off" inputmode="numeric" required autofocus />
                </div>
                <div class="form-footer">
                    <div id="msg"></div>
                    <button type="submit" class="btn btn-primary w-100">
                        <!-- Download SVG icon from http://tabler-icons.io/i/mail -->
                        <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <rect x="3" y="5" width="18" height="14" rx="2" />
                            <polyline points="3 7 12 13 21 7" />
                        </svg>
                        Validate received code
                    </button>
                </div>
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
        
        <div class="text-center text-muted mt-3">I have access, <a href="javascript:router.navigate('login');">back</a> to login.</div>
    </div>
</div>

<script>
    var qs = urlQueryObj();
    var frmReset = document.getElementById('frmReset');
    
    frmReset.onsubmit = function(e){
        e.preventDefault();
        
        var usernameObj = frmReset.querySelector("input[name='username']");
        var codeObj = frmReset.querySelector("input[name='code']");
        
        if ((usernameObj.value == "") || (usernameObj.value.length < 4)){
            usernameObj.focus();
            return;
        }
        
        if ((codeObj.value == "") || (codeObj.value.length < 6)){
            codeObj.focus();
            return;
        }
        
        
        
        document.querySelectorAll('button').forEach(elem => {
            elem.disabled = true;
        });
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/auth/password/check-code",
            data: {
                username: usernameObj.value,
                recover_code: codeObj.value
            },
            success: function(response){
                if (response.success == true) {
                    //window.location.replace("<?=$site_settings->url->office?>/password/reset-password?wa=wsignin1.0&wreply=<?=$site_settings->url->office?>&lc=1046&mkt=pt-br&mn="+usernameObj.value+"&code="+codeObj.value);
                    router.navigate("/password/reset-password?wa=wsignin1.0&wreply={{settings.site.url}}&lc=1046&mkt=pt-br&mn="+usernameObj.value+"&code="+codeObj.value);
                } else {
                    frmReset.querySelector("#msg").insertAdjacentHTML('beforeBegin', 
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
                        + '            <div class="text-muted">The code provided is incorrect. Check your email for the code sent.</div>'
                        + '        </div>'
                        + '    </div>'
                        + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                        + '</div>'
                    );
                }
                
                document.querySelectorAll('button').forEach(elem => {
                    elem.removeAttribute('disabled');
                });
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                // response is originally response.errors of query result
                document.querySelectorAll('button').forEach(elem => {
                    elem.removeAttribute('disabled');
                });
                
                
                frmReset.querySelector("#msg").insertAdjacentHTML('beforeBegin', 
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
                    + '            <div class="text-muted">' + jsonResponse.message + '</div>'
                    + '        </div>'
                    + '    </div>'
                    + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                    + '</div>'
                );
            }
        });
    }
    
    /**frmReset.addEventListener("keydown", function(e){
        e.target.classList.remove("error");
        e.target.parentElement.classList.remove("error");
    });
    
    const frmReset_inputs = document.querySelectorAll("input, select, textarea");
    frmReset_inputs.forEach(input => {
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
    });*/
    
    if (qs["mn"] != undefined) {
        frmReset.querySelector("input[name='username']").value = qs["mn"];
    }
    
    if (qs["code"] != undefined) {
        frmReset.querySelector("input[name='code']").value = qs["code"];
    }
    
    frmReset.querySelector("input[name='code']").focus();
</script>
