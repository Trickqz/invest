<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                {{#contains "edition" tmp.mode}}
                    <div class="modal-title">Edit user</div>
                {{else}}
                    <div class="modal-title">New user</div>
                {{/contains}}
                
                <!--<div></div>-->
            </div>
            <div class="modal-body">
                <form id="formUsersEdit" name="formUsersEdit">
                    <input name="id" type="hidden" value="{{tmp._id}}">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Name</label>
                                <input name="name" type="text" class="form-control" placeholder="Name" value="{{tmp._name}}" required />
                                <div id="name--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input name="email" type="text" class="form-control" placeholder="Email"  value="{{tmp._email}}" />
                                <div id="email--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <div class="form-label">Type</div>
                                <select name="role" class="form-select">
                                    {{#selected tmp._role}}
                                        <option value="administrator">Administrator</option>
                                        <option value="financial">Financial</option>
                                        <option value="support">Support</option>
                                    {{/selected}}
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <input name="username" type="text" class="form-control" placeholder="Username" value="{{tmp._username}}" required />
                                <div id="username--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input name="password" type="password" class="form-control" placeholder="Password" minlength="6" maxlength="40" autocomplete="off" />
                                <div id="password--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="error-msg"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="btn--save" type="button" class="btn btn-danger" onclick="formUsersEdit__Save();">Save</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    var formUsersEdit = document.getElementById('formUsersEdit');
    formUsersEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formUsersEdit__Save();
    }
    
    function formUsersEdit__Save() {
        //Controller.formUsersEditUpdate('formUsersEdit');
        
        var jsonData = JSON.parse(formToJSONString('formUsersEdit'));
        
        document.getElementById("btn--save").disabled = true;
        
        {{#contains "edition" tmp.mode}}
            $.ajax({
                type: 'POST',
                url: CFG__API_URL + CFG__API_VERSION + "/users/{{tmp._id}}",
                beforeSend: function (xhr){ 
                    xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                },
                data: jsonData,
                success: function(response) {
                    if (response.success === true) {
                        dialogClose();
                        fc_users_modelGetAll("*");
                    } else {
                        App.alert('Warning', response.message, null);
                        document.getElementById("btn--save").disabled = false;
                    }
                }
            });
        {{else}}
            $.ajax({
                type: 'POST',
                url: CFG__API_URL + CFG__API_VERSION + "/users",
                beforeSend: function (xhr){ 
                    xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                },
                data: jsonData,
                success: function(response) {
                    if (response.success === true) {
                        dialogClose();
                        fc_users_modelGetAll("*");
                    } else {
                        App.alert('Warning', response.message, null);
                        document.getElementById("btn--save").disabled = false;
                    }
                }
            });
        {{/contains}}
        
        return false;
    }
    
    setTimeout(function(){
        document.querySelector('#formUsersEdit input[name="username"]').focus();
    }, 1000);
</script>
