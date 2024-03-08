<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-title">Change Account Password</div>
                <div>We recommend that you use a secure password to maintain the reliability of your account.</div>
            </div>
            <div class="modal-body">
                <form id="formPasswordEdit" name="formPasswordEdit">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Old password</label>
                                <input name="password" type="text" class="form-control" placeholder="Old password" required />
                                <div id="password--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">New password</label>
                                <input name="new_password" type="text" class="form-control" placeholder="New password" maxlength="40" required />
                                <div id="new_password--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Repeat new password</label>
                                <input name="password_confirm" type="text" class="form-control" placeholder="Repeat new password" maxlength="40" required />
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
                <button type="button" class="btn btn-danger" onclick="formPassword__Save();">Alter password</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    var formPasswordEdit = document.getElementById('formPasswordEdit');
    formPasswordEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formPassword__Save();
    }
    
    function formPassword__Save() {
        Controller.passwordUpdate('formPasswordEdit');
    }
    
    setTimeout(function(){
        document.querySelector('#formPasswordEdit input[name="password"]').focus();
    }, 500);
</script>
