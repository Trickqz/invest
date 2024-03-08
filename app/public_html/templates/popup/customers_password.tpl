<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-title">Change password of <b>{{tmp.username}}</b></div>
                <div>We recommend that you use a secure password to maintain account reliability.</div>
            </div>
            <div class="modal-body">
                <form id="formCustomersPasswordEdit" name="formCustomersPasswordEdit">
                    <input name="username" type="hidden" value="{{tmp.username}}">
                    <div class="row">
                        <!--<div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Senha antiga</label>
                                <input name="password" type="text" class="form-control" placeholder="Senha antiga" required />
                                <div id="password--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Sua nova senha</label>
                                <input name="new_password" type="text" class="form-control" placeholder="Senha" maxlength="40" required />
                                <div id="new_password--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>-->
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">New password</label>
                                <input name="new_password" type="text" class="form-control" placeholder="New password" maxlength="40" required />
                                <div id="password_confirm--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="error-msg"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="formCustomersPassword__Save();">Alter password</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    var formCustomersPasswordEdit = document.getElementById('formCustomersPasswordEdit');
    formCustomersPasswordEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formCustomersPassword__Save();
    }
    
    function formCustomersPassword__Save() {
        //Controller.passwordUpdate('formCustomersPasswordEdit');
        
        //var formCustomersPasswordEdit = document.getElementById('formCustomersPasswordEdit');
        
        var usernameObj = formCustomersPasswordEdit.querySelector("input[name='username']");
        
        var new_passwordObj = formCustomersPasswordEdit.querySelector("input[name='new_password']");
        if ((new_passwordObj.value == "") || (new_passwordObj.value.length < 6)){
            new_passwordObj.focus();
            return false;
        }
        
        
        $.ajax({
            type: 'POST',
            url: CFG__API_URL + CFG__API_VERSION + "/auth/password",
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            data: {
                username: usernameObj.value,
                new_password: new_passwordObj.value
            },
            success: function(response) {
                if (response.success === true) {
                    dialogClose();
                } else {
                    showError(response.message);
                }
            }
        });
        
        return false;
    }
    
    setTimeout(function(){
        document.querySelector('#formCustomersPasswordEdit input[name="new_password"]').focus();
    }, 1000);
</script>
