<style>
    body {
        overflow: hidden;
    }
</style>

<div class="divgerallingup">
    <div class="card-leftuplogin">
        <form id="frmRequestReset" name="frmRequestReset" class="card-md" autocomplete="off">
            <div class="card-body">
             <h1 class="text-singupleftuplogin" style="text-align: start;">Enter your username <br>to recover your password.</h1>
                <div class="labelforloginup">
                    <label class="labelloginuptextcolor">Username:</label>
                    <input id="username" name="username" type="text" class="inputpasswordusernameloginup" placeholder="Username" minlength="4" maxlength="80" required />
                <div>
                    <div id="msg"></div>
                    <button type="submit" class="buttonpasswordusernameloginup">submit password recovery</button>
                </div>
                    <h5 class="h5checkboxinputremember">I have access, <a href="javascript:router.navigate('login');" style="color: #26C57E;">back</a> to login.</h5>
                </div>
            </div>
        </form>
    </div>
    <div class="card-rightuplogin">
        <h1 class="h1-textwelcomeloginup">I forgot my <font style="color: #26C57E;"><br>password!</font></h1>         
        <img class="image-rightuplogin" src="/assets/img/grid.svg" alt="" srcset="">
        <svg class="svg-imagewelcomeloginup" width="1159" height="799" viewBox="0 0 1159 799" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path opacity="0.2" d="M-679.064 259.956C-782.649 371.698 -977.262 457.612 -1061.62 486.602V875.582H2093V96.56C1616.28 96.56 1610.39 765.956 1339.66 765.956C1068.93 765.956 1057.15 386.456 921.788 386.456C786.422 386.456 821.735 592.019 509.804 568.3C197.873 544.581 44.8505 310.029 -143.485 96.56C-330.807 -115.759 -547.24 117.738 -676.965 257.691L-679.064 259.956Z" fill="#26C57E"/>
            <path opacity="0.2" d="M-595.808 557.353C-694.653 471.796 -950.786 412.15 -1066.5 393.022V875.582H2093V768.636C1669.38 768.636 1357.55 366.937 1316.36 304.335C1275.18 241.733 1181.04 111.311 922.162 111.311C663.284 111.311 445.59 372.154 192.595 526.052C-60.3999 679.949 -178.072 674.733 -260.443 674.733C-342.813 674.733 -472.252 664.299 -595.808 557.353Z" fill="#009452"/>
            <ellipse cx="106.332" cy="383.367" rx="17.2727" ry="19.0561" fill="#26C57E"/>
            <ellipse cx="511.02" cy="573.117" rx="17.2727" ry="19.0561" fill="#26C57E"/>
            <ellipse cx="910.833" cy="388.638" rx="17.2727" ry="19.0561" fill="#26C57E"/>
        </svg>
    </div>
</div>

<script>
    var qs = urlQueryObj();
    var frmRequestReset = document.getElementById('frmRequestReset');
    
    frmRequestReset.onsubmit = function(e){
        e.preventDefault();
        
        var usernameObj = frmRequestReset.querySelector("input[name='username']");
        if ((usernameObj.value == "") || (usernameObj.value.length < 4)){
            usernameObj.focus();
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
            url: CFG__API_URL + CFG__API_VERSION + "/auth/password/reset",
            data: {
                username: usernameObj.value
            },
            success: function(response){
                if (response.success === true) {
                    router.navigate("/password/confirm-code?wa=wsignin1.0&wreply={{settings.site.url}}&lc=1046&mkt=pt-br&mn="+usernameObj.value);
                } else {
                    var alertHtml = 
                          '<div class="alert alertforgotpasswordlogin alert-danger alert-dismissible" role="alert">'
                        + '    <div class="d-flex">'
                        + '        <div>'
                        + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                        + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                        + '                <circle cx="12" cy="12" r="9"></circle>'
                        + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                        + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                        + '            </svg>'
                        + '        </div>'
                        + '        <div>'
                        + '            <h4 class="alert-title">Sorry...</h4>'
                        + '            <div class="text-muted">' + response.message + '</div>'
                        + '        </div>'
                        + '    </div>'
                        + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                        + '</div>';
                    frmRequestReset.querySelector("#msg").insertAdjacentHTML('beforeBegin', alertHtml);
                    // Remove alert after 5 seconds
                    setTimeout(function() {
                        var alertElement = document.querySelector('.alert');
                        if (alertElement) {
                            alertElement.remove();
                        }
                    }, 8000);
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
                
                var alertHtml = 
                      '<div class="alert alertforgotpasswordlogin alert-danger alert-dismissible" role="alert">'
                    + '    <div class="d-flex">'
                    + '        <div>'
                    + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                    + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                    + '                <circle cx="12" cy="12" r="9"></circle>'
                    + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                    + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                    + '            </svg>'
                    + '        </div>'
                    + '        <div>'
                    + '            <h4 class="alert-title">Desculpe...</h4>'
                    + '            <div class="text-muted">' + jsonResponse.message + '</div>'
                    + '        </div>'
                    + '    </div>'
                    + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                    + '</div>';
                frmRequestReset.querySelector("#msg").insertAdjacentHTML('beforeBegin', alertHtml);
                // Remove alert after 5 seconds
                setTimeout(function() {
                    var alertElement = document.querySelector('.alert');
                    if (alertElement) {
                        alertElement.remove();
                    }
                }, 8000);
            }
        });
    }
    
    if (qs["mn"] != undefined) {
        frmRequestReset.querySelector("input[name='username']").value = qs["mn"];
    }
    
    frmRequestReset.querySelector("input[name='username']").focus();
</script>