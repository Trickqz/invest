<style>
    body {
        overflow: hidden;
    }

    .image-mapworld {
        position: absolute;
        top: -30px;
        left: 0;
        z-index: -1;
        background
        width: 100%;  /* ou um valor fixo */
        height: 400px;
        object-fit: cover;
    }

    @media only screen and (max-width: 1030px) {
        .image-mapworld {
            display: block !important;
        }
        .circle-div1 {
            display: block !important;
    }

    .circle-div1 {
        display: none;
        position: absolute;
        z-index: -1;
        top: 0px;
        left: 10%;
        width: 200px !important;
        height: 200px !important;
        border-radius: 100%;
        filter: blur(100px) !important;
        background-color: #bb9e73;
    }

    .circle-div2 {
        position: absolute;
        z-index: 0;
        bottom: 0px;
        left: 50%;
        width: 200px !important;
        height: 200px !important;
        border-radius: 100%;
        filter: blur(220px) !important;
        background-color: #fff;
    }
</style>

<div class="divgerallingup">
    <div class="card-leftuplogin">
    <img style="height: 40px" src="../assets/img/logo-white.png">
        <form id="frmLogin" name="frmLogin" class="card-md" autocomplete="off">
                <img class="image-mapworld" style="display: none" src="/assets/img/map-base1.svg">
                <div class="circle-div1"></div>
                <div class="circle-div2"></div>
            <div class="card-body">
                <h1 class="text-singupleftuplogin">Sign-in</h1>
                <div class="labelforloginup">
                    <label class="labelloginuptextcolor">Username:</label>
                    <input name="username" type="text" class="inputpasswordusernameloginup" placeholder="Username" minlength="4" maxlength="80" required />
                </div>
                <div class="labelforloginup">
                    <label class="labelloginuptextcolor">
                        Password
                        <span class="form-label-description">
                            <a href="javascript:router.navigate('/password/reset');" class="forgoutpasswordmy">Forgot my password</a>
                        </span>
                    </label>
                    <input name="password" type="password" class="inputpasswordusernameloginup" placeholder="Password" minlength="4" maxlength="40" autocomplete="off" required />
                </div>
                <div class="inputboxcheckboxinputremember">
                    <input id="basic_checkbox_1" type="checkbox" class="form-check-input" />
                    <label class="checkboxinputremember" for="basic_checkbox_1">Remember me on this device</label>
                </div>
                <div>
                    <button type="submit" class="buttonpasswordusernameloginup">Sign-in</button>
                </div>
            </div>
        </form>
    </div>
    <div class="card-rightuplogin">
        <h1 class="h1-textwelcomeloginup">I'm glad to see you <font style="color: #BB9E73;"><br>again!</font></h1>         
        <img class="image-rightuplogin" src="/assets/img/grid.svg" alt="" srcset="">
        <svg class="svg-imagewelcomeloginup" width="1159" height="799" viewBox="0 0 1159 799" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path opacity="0.2" d="M-679.064 259.956C-782.649 371.698 -977.262 457.612 -1061.62 486.602V875.582H2093V96.56C1616.28 96.56 1610.39 765.956 1339.66 765.956C1068.93 765.956 1057.15 386.456 921.788 386.456C786.422 386.456 821.735 592.019 509.804 568.3C197.873 544.581 44.8505 310.029 -143.485 96.56C-330.807 -115.759 -547.24 117.738 -676.965 257.691L-679.064 259.956Z" fill="#BB9E73"/>
            <path opacity="0.2" d="M-595.808 557.353C-694.653 471.796 -950.786 412.15 -1066.5 393.022V875.582H2093V768.636C1669.38 768.636 1357.55 366.937 1316.36 304.335C1275.18 241.733 1181.04 111.311 922.162 111.311C663.284 111.311 445.59 372.154 192.595 526.052C-60.3999 679.949 -178.072 674.733 -260.443 674.733C-342.813 674.733 -472.252 664.299 -595.808 557.353Z" fill="#BB9E73"/>
            <ellipse cx="106.332" cy="383.367" rx="17.2727" ry="19.0561" fill="#BB9E73"/>
            <ellipse cx="511.02" cy="573.117" rx="17.2727" ry="19.0561" fill="#BB9E73"/>
            <ellipse cx="910.833" cy="388.638" rx="17.2727" ry="19.0561" fill="#BB9E73"/>
        </svg>
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
