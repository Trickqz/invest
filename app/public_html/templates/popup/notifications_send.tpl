<div class="modal-dialog modal-md modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-body" style="/*margin-bottom: 0;padding-bottom: 0;*/padding-bottom: 12px;">
            <div class="modal-title">Send notification</div>
            <div>
                Tell a user to send notification or asterisk (<b style="font-weight: bold;">*</b>) to send notification to all users.
            </div>
        </div>
        
        <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;/*display: none;*/">
        
        <form id="formNotification" name="formNotification" method="post" action="">
            <!--<input type="hidden" name="user_type" value="{{tmp.params.user_type}}">-->
            <div class="modal-body" style="padding-top: 12px;">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="type">Type</label>
                            <select name="type" class="form-control" tabindex="-1" style="width: 100%;">
                                <!--<option value="success">Sucesso</option>
                                <option value="danger">Perigo</option>-->
                                <option value="warning">Warning</option>
                                <option value="info" selected="">Information</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="display_type">Display mode</label>
                            <select name="display_type" class="form-control" tabindex="-1" style="width: 100%;">
                                <!--<option value="none"></option>-->
                                <option value="normal">Normal</option>
                                <option value="enter">On enter</option>
                                <option value="enter_popup">On enter [popup]</option>
                                <!--<option value="leave"></option>-->
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input id="to" name="to" type="text" class="form-control" autocomplete="off" value="*" required="" />
                            <div id="to--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="mb-3">
                        <label class="form-label">Title</label>
                        <input id="subject" name="subject" type="text" class="form-control" autocomplete="off" required="" />
                        <div id="subject--invalid-feedback" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="mb-3">
                        <div class="form-label">Notification type</div>
                        <div>
                            <label class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="notification_tipe" checked="" onchange="setNotificationType('text');" />
                                <span class="form-check-label">Text</span>
                            </label>
                            <label class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="notification_tipe" onchange="setNotificationType('image');" />
                                <span class="form-check-label">Image</span>
                            </label>
                        </div>
                    </div>
                </div>

                <div id="notification-text" class="col-lg-12">
                    <div class="mb-3">
                        <label class="form-label">Content</label>
                        <textarea name="content" rows="4" cols="80" class="form-control" maxlength="400" placeholder="Text or html content" style="width: 100%;height: 120px;"></textarea>
                        <div id="content--invalid-feedback" class="invalid-feedback"></div>
                    </div>
                </div>
                
                <!--
                <div class="col-lg-12">
                    <div class="mb-3">
                        <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="page__raffle__images__uploadFile();">
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                            Upload de arquivo
                        </a>
                    </div>
                </div>
                -->
                <div id="notification-image" class="col-lg-12" style="display: none;">
                    <div class="mb-3">
                        <label class="form-label">Notification as image</label>
                        <div id="file-list" class="row g-2" style="max-height: 240px; overflow-y: auto;">
                            <!--<div class="col-6 col-sm-4">
                                <label class="form-imagecheck mb-2">
                                    <input name="img_src" type="radio" value="/d/uploads/images/S0EoiZGps5BgkTSmzNxzFFovy4g2QgRndsIuLmAz.jpg" class="form-imagecheck-input" onchange="setItemValue(0, 'image', this);" />
                                    <span class="form-imagecheck-figure"> <img src="/d/uploads/images/S0EoiZGps5BgkTSmzNxzFFovy4g2QgRndsIuLmAz.jpg" alt="" class="form-imagecheck-image" style="max-height: 100px;" /> </span>
                                </label>
                            </div>-->
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="error-msg"></div>
                </div>
            </div>
        </form>
        
        <div class="modal-footer">
            <button id="notificationBtnSend" type="button" class="btn btn-danger" onclick="formNotifications__Send();">Send</button>
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    var formNotification = document.getElementById('formNotification');
    
    formNotification.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formNotifications__Send();
    }
    
    function formNotifications__Send() {
        var elNotificationBtnSend = document.getElementById("notificationBtnSend");
        
        var elTo = document.querySelector('#formNotification input[name="to"]');
        if (elTo.value == "") {
            //App.alert('Atenção', "Você deve informar um usuário!", elTo.focus());
            return;
        }
        
        
        var jsonData = JSON.parse(formToJSONString('formNotification'));
        elNotificationBtnSend.disabled = true;
        
        $.ajax({
            type: 'POST',
            url: CFG__API_URL + CFG__API_VERSION + "/notifications",
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            data: jsonData,
            success: function(response) {
                if (response.success === true) {
                    //App.alert('Atenção', "O plano de {{tmp.profile.full_name}} foi ativado.", dialogClose());
                    
                    /**if (typeof fc_customersGetAll === 'function') {
                        //fc_customersGetAll();
                        fc_customersUpdateItem('{{tmp._id}}');
                    }*/
                    
                    elNotificationBtnSend.disabled = false;
                    dialogClose();
                } else {
                    App.alert('Warning', response.message, elTo.focus());
                }
            }
        });
    }
    
    
    /** **/
    var CFG__API_REST_SPACES_FILEPATH = '/uploads/images/';
    var _type = 'images';
    
    /**function page__raffle__images__uploadFile(){
        //var source = getBackofficeURL('templates/popup-orders_print.html');
        //var template = Handlebars.compile(source);
        //var html = template(_data);
        
        //App.form('popup__upload', 'fit-content', "540px");  //"900px");
        dialogOpen('templates/popup/upload.tpl', null, null);
    }**/
    
    function page__notifications_send__images__loadFiles(type) {
        /* documents, images, miscellaneous */
        if (type != null) {
            _type = type;
        }
        
        CFG__API_REST_SPACES_FILEPATH = '/uploads/' + _type + '/';
        
        
        document.querySelector("#file-list").innerHTML = '';
        
        xdr('GET', CFG__API_URL+CFG__API_VERSION+CFG__API_REST_SPACES_FILEPATH.substring(0, CFG__API_REST_SPACES_FILEPATH.length - 1),
            null,
            function callback(data){
                var response = JSON.parse(data);
                var tbodyHTML = '';
                
                if (isObjEmpty(response.error)) {
                    for (var i = 0; i < response.length; i++){
                        var contentType = response[i].contentType;
                        if (contentType.includes("image")) {
                            var checked = '';
                            if (CFG__API_URL+'/d/uploads/images/'+response[i].filename == '{{tmp._thumb}}') {
                                checked = 'checked=""';
                            }
                            
                            tbodyHTML +=
                                  '<div class="col-6 col-sm-4">'
                                + '    <label class="form-imagecheck mb-2">'
                                + '        <input name="img_src" type="radio" value="'+CFG__API_URL+'/d/uploads/images/'+response[i].filename+'" class="form-imagecheck-input" '+checked+' />'
                                + '        <span class="form-imagecheck-figure">'
                                + '            <img src="'+CFG__API_URL+response[i].path+'" alt="" class="form-imagecheck-image" style="max-height: 100px;" />'
                                + '        </span>'
                                + '    </label>'
                                + '</div>';
                        }
                    }
                    
                    document.querySelector("#file-list").innerHTML = tbodyHTML;
                } else {
                    page__raffle__images__loadClear(_type);
                }
            },
            function errback(err){
                page__raffle__images__loadClear(_type);
            }
        );
    }
    
    function page__raffle__images__loadClear(_type) {
        document.querySelector("#file-list").innerHTML = '';
    }
    
    page__notifications_send__images__loadFiles('images');
    /** **/
    
    
    function setNotificationType(type) {
        if (type == 'image') {
            document.getElementById("notification-text").style.display = "none";
            document.getElementById("notification-image").style.display = "block";
        } else {
            document.getElementById("notification-text").style.display = "block";
            document.getElementById("notification-image").style.display = "none";
        }
    }
    
    setTimeout(function(){
        document.querySelector('#formNotification input[name="to"]').focus();
    }, 1000);
</script>
