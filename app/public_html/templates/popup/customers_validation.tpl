<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-title">Account validation of <b>{{tmp._username}}</b></div>
                <div>
                    <span>For security, the document sent by clicking on the link.</span><br />
                    <ul style="margin-top: 8px;">
                        <li>
                            Request document that contains the KYC;
                        </li>
                    </ul>
                </div>
                <!--<div style="/*margin-top: 8px;*/">
                    Accepted formats: <b>JPEG, GIF, PNG e PDF</b>
                </div>
                <div style="/*margin-top: 8px;*/">
                    Max file size: <b>1MB</b>
                </div>-->
            </div>
            <div class="modal-body">
                <form id="formCustomersValidationEdit" name="formCustomersValidationEdit">
                    <input name="id" type="hidden" value="{{tmp._id}}">
                    <input name="username" type="hidden" value="{{tmp._username}}">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">File</label>
                                {{tmp._verification_file}}<br />
                                <a href="javascript:;" onclick="window.open(CFG__API_URL+'/d/uploads/accounts/{{tmp._id}}/profile/documents/{{tmp._verification_file}}');">OPEN FILE</a>
                            </div>
                        </div>
                        
                        <div class="row" style="margin-top: 16px;">
                            <div class="col-lg-12">
                                <div class="mb-3">
                                    <label class="form-label">Change status:</label>
                                    <select id="customers_validation__status" name="customers_validation__status" class="form-select">
                                        {{#selected tmp._verification_status}}
                                            <option value="waiting">Waiting</option>
                                            <option value="validating">Validating</option>
                                            <option value="invalidated">Invalidated</option>
                                            <option value="validated">Validated</option>
                                        {{/selected}}
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="error-msg"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="formCustomersValidation__Save();">Change status</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    var formCustomersValidationEdit = document.getElementById('formCustomersValidationEdit');
    formCustomersValidationEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formCustomersValidation__Save();
    }
    
    function formCustomersValidation__Save() {
        //Controller.passwordUpdate('formCustomersValidationEdit');
        
        //var formCustomersValidationEdit = document.getElementById('formCustomersValidationEdit');
        
        var idObj = formCustomersValidationEdit.querySelector("input[name='id']");
        var usernameObj = formCustomersValidationEdit.querySelector("input[name='username']");
        var customers_validation__statusObj = formCustomersValidationEdit.querySelector("select[name='customers_validation__status']");
        
        
        $.ajax({
            type: 'POST',
            url: CFG__API_URL + CFG__API_VERSION + "/account/validation/status/"+idObj.value,
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            data: {
                status: customers_validation__statusObj.value
            },
            success: function(response) {
                if (response.success === true) {
                    if (typeof fc__customersGetAll === 'function') {
                        fc__customersGetAll("*");
                    }
                    
                    dialogClose();
                } else {
                    showError(response.message);
                }
            }
        });
        
        return false;
    }
    
    /*setTimeout(function(){
        document.querySelector('#formCustomersValidationEdit input[name="new_password"]').focus();
    }, 1000);*/
</script>
