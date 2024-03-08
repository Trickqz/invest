<div class="modal-dialog modal-md modal-dialog-centered" role="document">
    <div class="modal-content">
        <!--<div class="modal-body">
            <div class="modal-title">Alterar foto de perfil</div>
        </div>-->
        <div class="modal-body">
            <form id="formProfilePictureEdit" name="formProfilePictureEdit">
                <div class="row">
                    <div class="col-12">
                        <div class="mb-4" style="text-align: center;">
                            <!--<img id="formProfilePictureEdit-image" src="https://api.spaces.brauntech.com.br/{{settings.__spaces_bucket}}/customers/{{system.userdata._id}}/profile/picture/{{system.userdata.profile.picture.src}}" onerror="imageLoaderError();" style="/*display: none;*/">-->
                            <img id="formProfilePictureEdit-image" src="" onerror="imageLoaderError();" style="/*display: none;*/">
                            <!--<span id="formProfilePictureEdit-profile_picture2" class="avatar avatar-xl avatar-rounded mb-3" style="background-image: url('https://api.spaces.brauntech.com.br/{{settings.__spaces_bucket}}/customers/{{system.userdata._id}}/profile/picture/{{system.userdata.profile.picture.src}}'), url('assets/img/picker_account.png');"></span><br />
                            <img id="formProfilePictureEdit-profile_picture" src="https://api.spaces.brauntech.com.br/{{settings.__spaces_bucket}}/customers/{{system.userdata._id}}/profile/picture/{{system.userdata.profile.picture.src}}" onerror="this.src='../assets/img/picker_account.png';" style="/*display: none;*/">-->
                            <input id="formProfilePictureEdit-selectedFile" type="file" name="selectedFile" style="display: none;" accept="image/*,capture=camera" /> <!--onchange="loadPicture();" accept=".jpg,.jpeg"-->
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="error-msg"></div>
                </div>
                
                <div id="result" style="display: none;"></div>
            </form>
            
            <!--<form id="upload_form" enctype="multipart/form-data" method="post" action="upload.php">
                <div style="display: none;">
                    <div><label for="files">Please select image file</label></div>
                    <div><input type="file" name="files" id="files" onchange="fileSelected();" multiple /></div>
                </div>
                <div id="preview">
                    <img />
                </div>
                <div id="fileinfo">
                    <div id="filename"></div>
                    <div id="filesize"></div>
                    <div id="filetype"></div>
                    <div id="filedim"></div>
                </div>
                <div class="clear_both"></div>
                
                <div class="form-group g4">
                    <div id="progress_info">
                        <div id="progress-bar">
                            <div id="progress"></div>
                        </div>
                        <div class="clear_both"></div>
                        <div class="upload-status">
                            <div id="b_transfered">&nbsp;</div>
                            <div id="speed">&nbsp;</div>
                            <div id="remaining">&nbsp;</div>
                            <div id="progress_percent">&nbsp;</div>
                            <div class="clear_both"></div>
                        </div>
                    </div>
                    <div id="upload_message"></div>
                </div>
                
                <div class="form-group g4" style="margin-top: 0;text-align: right;margin-bottom: 16px;">
                    <input id="filesSelect" type="button" value="Selecionar arquivos..." onclick="document.querySelector('#files').click();" />
                    <input type="button" value="Cancelar" onclick="cancelUploadFile()" />
                </div>
            </form>-->
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" onclick="document.getElementById('formProfilePictureEdit-selectedFile').click();">Search...</button>
            <button id="formProfilePictureEdit-remove" type="button" class="btn btn-danger">Remove</button>
            <button id="formProfilePictureEdit-save" type="button" class="btn btn-primary">Save</button>
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div>
</div>

<style>
    .container {
        margin: 20px auto;
        max-width: 640px;
    }

    img {
        max-width: 100%;
    }

    .cropper-view-box,
    .cropper-face {
        border-radius: 50%;
    }
</style>

<script>
    /**var formPasswordEdit = document.getElementById('formPasswordEdit');
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
    }, 500);*/
</script>

<script type="text/javascript">
    /*
    function checkPicture() {
        //.bmp,.doc,.docx,.gif,.jpg,.jpeg,.pdf,.png,.rtf,.tga,.tif,.txt,.xls,.xlsx,.odf,.ods,.odt,.opt,.ots,.ott
        var fup = document.getElementById('txFoto');
        var fileName = fup.value;
        var ext = fileName.substring(fileName.lastIndexOf('.') + 1);
        
        if (fileName != "") {
            if (ext=="jpg"||ext=="jpeg"||ext=="JPG"||ext=="JPEG") {
            
                if (fup.files[0].size > 1048576) {
                    alert("O arquivo é maior que o tamanho permitido!");
                    fup.focus();
                    return false;
                } else {
                    return true;
                }
            } else {
                alert("Selecione uma foto com formato e tamanho válido!");
                fup.focus();
                return false;
            }
        } else {
            alert('Selecione uma imagem para enviar!');
            return false;
        }
    }*/
    
    function getRoundedCanvas(sourceCanvas) {
        var canvas = document.createElement('canvas');
        var context = canvas.getContext('2d');
        var width = sourceCanvas.width;
        var height = sourceCanvas.height;

        canvas.width = width;
        canvas.height = height;
        context.imageSmoothingEnabled = true;
        context.drawImage(sourceCanvas, 0, 0, width, height);
        context.globalCompositeOperation = 'destination-in';
        context.beginPath();
        context.arc(width / 2, height / 2, Math.min(width, height) / 2, 0, 2 * Math.PI, true);
        context.fill();
        return canvas;
    }

    //window.addEventListener('DOMContentLoaded', function () {
        var formProfilePictureEditImage = document.getElementById('formProfilePictureEdit-image');
        var formProfilePictureEditSave = document.getElementById('formProfilePictureEdit-save');
        var formProfilePictureEditRemove = document.getElementById('formProfilePictureEdit-remove');
        var formProfilePictureEditSelectedFile = document.getElementById('formProfilePictureEdit-selectedFile');
        var result = document.getElementById('result');
        var croppable = false;
        var cropper = null;
        
        function setCropper() {
            setTimeout(function(){
                cropper = new Cropper(formProfilePictureEditImage, {
                    aspectRatio: 1,
                    viewMode: 1,
                    cropBoxResizable: false,
                    ready: function () {
                        croppable = true;
                    },
                });
            }, 500);
        }
        
        formProfilePictureEditSelectedFile.onchange = function () {
            var input = document.getElementById("formProfilePictureEdit-selectedFile");
            var fReader = new FileReader();
            fReader.readAsDataURL(input.files[0]);
            fReader.onloadend = function(event) {
                //$image.cropper('replace', event.target.result);
                //formProfilePictureEditImage.src = event.target.result;
                //cropper('replace', event.target.result);
                
                cropper.replace(event.target.result);
            }
        };

        formProfilePictureEditSave.onclick = function () {
            var croppedCanvas;
            //var roundedCanvas;
            var roundedImage;

            if (!croppable) {
                return;
            }

            // Crop
            croppedCanvas = cropper.getCroppedCanvas({
                width: 160,
                height: 160
            });

            // Round
            //roundedCanvas = getRoundedCanvas(croppedCanvas);

            // Show
            roundedImage = document.createElement('img');
            //roundedImage.src = roundedCanvas.toDataURL()
            roundedImage.src = croppedCanvas.toDataURL()
            result.innerHTML = '';
            result.appendChild(roundedImage);
            
            // Save
            ///Controller.saveAccountProfilePicture(roundedCanvas.toDataURL());
            
            
            croppedCanvas.toBlob(function(blob) {
                /**
                $.ajax({
                    type: 'POST',
                    url: CFG__API_URL + CFG__API_VERSION + "/upload/gen-key",
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    data: {
                        path: "/customers/{{system.userdata._id}}/profile/picture/",
                        permission: 6
                    },
                    success: function(response) {
                        if (response.success === true) {
                            //localStorage.setItem('tmp__spacesKey', response.spaces__genKey.key);
                            var accessKeyId = response.data.key;
                            
                            //var formData = new FormData();
                            //formData.append('avatar', blob, 'avatar.jpg');
                            
                            
                            // cleanup all temp states
                            ///iPreviousBytesLoaded = 0;
                            ///document.getElementById('upload_message').style.display = 'none';
                            ///document.getElementById('progress_percent').innerHTML = '';
                            ///var oProgress = document.getElementById('progress');
                            ///oProgress.style.display = 'block';
                            ///oProgress.style.width = '0px';
                            // get form data for POSTing
                            //var vFD = document.getElementById('upload_form').getFormData(); // for FF3
                            ///var vFD = new FormData(document.getElementById('upload_form'));
                **/
                            var vFD = new FormData();
                            var filename = generateUUID() + '.jpg';
                            vFD.append('files[]', blob, filename);
                            
                            // create XMLHttpRequest object, adding few event listeners, and POSTing our data
                            //var oXHR = new XMLHttpRequest();
                            oXHR = new XMLHttpRequest();
                            ///oXHR.upload.addEventListener('progress', uploadProgress, false);
                            ///oXHR.addEventListener('load', uploadFinish, false);
                            ///oXHR.addEventListener('error', uploadError, false);
                            ///oXHR.addEventListener('abort', uploadAbort, false);
                            //oXHR.open('POST', 'upload.php');
                            //oXHR.open('PUT', CFG__API_REST_SPACES_URL + CFG__API_REST_SPACES_FILEPATH);
                            oXHR.addEventListener('load', function(){
                                        // set as default
                                        $.ajax({
                                            type: "POST",
                                            url: CFG__API_URL + CFG__API_VERSION + "/session/account/profile/picture",
                                            data: {
                                                picture_src: filename
                                            },
                                            beforeSend: function (xhr){ 
                                                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                                            },
                                            success: function(response) {
                                                if (response.success === true) {
                                                    dialogClose();
                                                    fgUpdateUserData();
                                                }
                                            },
                                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                                                App.alert('Error', error.message, null);
                                            }
                                        });
                                    },
                                false);
                            ///oXHR.open('PUT', "{{CFG__API_URL}}/{{settings.__spaces_bucket}}/customers/{{system.userdata._id}}/profile/picture/");
                            oXHR.open('POST', CFG__API_URL+CFG__API_VERSION+"/uploads/accounts/{{system.userdata._id}}/profile/picture/");
                            //req.setRequestHeader('Authorization', 'Basic [base64 encoded password here]' );
                            oXHR.setRequestHeader('Authorization', cookieGet('__utmo'));
                            ///oXHR.setRequestHeader('Access-Key-Id', accessKeyId);
                            oXHR.send(vFD);
                /**
                        } else {
                            App.alert('Warning', response.message, null);
                        }
                    }
                });
                **/
                
                // set inner timer
                ///oTimer = setInterval(doInnerUpdates, 300);
                
                /**$.ajax('https://jsonplaceholder.typicode.com/posts', {
                    method: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,

                    xhr: function() {
                        var xhr = new XMLHttpRequest();

                        xhr.upload.onprogress = function(e) {
                            var percent = '0';
                            var percentage = '0%';

                            if (e.lengthComputable) {
                                percent = Math.round((e.loaded / e.total) * 100);
                                percentage = percent + '%';
                                $progressBar.width(percentage).attr('aria-valuenow', percent).text(percentage);
                            }
                        };

                        return xhr;
                    },

                    success: function() {
                        $alert.show().addClass('alert-success').text('Upload success');
                    },

                    error: function() {
                        avatar.src = initialAvatarURL;
                        $alert.show().addClass('alert-warning').text('Upload error');
                    },

                    complete: function() {
                        $progress.hide();
                    },
                });*/
            });
        };
        
        formProfilePictureEditRemove.onclick = function () {
            document.getElementById("formProfilePictureEdit-selectedFile").value = "";
            formProfilePictureEditImage.src = "../assets/img/picker_account.png";
            cropper.replace('../assets/img/picker_account.png');
        };
        
        function imageLoaderError() {
            formProfilePictureEditImage.src='../assets/img/picker_account.png';
            setCropper();
        }
        
        function generateUUID() { // Public Domain/MIT
            var d = new Date().getTime();//Timestamp
            var d2 = ((typeof performance !== 'undefined') && performance.now && (performance.now()*1000)) || 0;//Time in microseconds since page-load or 0 if unsupported
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
                var r = Math.random() * 16;//random number between 0 and 16
                if(d > 0){//Use timestamp until depleted
                    r = (d + r)%16 | 0;
                    d = Math.floor(d/16);
                } else {//Use microseconds since page-load if supported
                    r = (d2 + r)%16 | 0;
                    d2 = Math.floor(d2/16);
                }
                return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
            });
        }
    //});
    
    
    
    /**
    // common variables
    var oXHR;
    var iBytesUploaded = 0;
    var iBytesTotal = 0;
    var iPreviousBytesLoaded = 0;
    var iMaxFilesize = 16777216; // 16MB
    var oTimer = 0;
    var sResultFileSize = '';
    var previewEnabled = false;

    function secondsToTime(secs) { // we will use this function to convert seconds in normal time format
        var hr = Math.floor(secs / 3600);
        var min = Math.floor((secs - (hr * 3600))/60);
        var sec = Math.floor(secs - (hr * 3600) -  (min * 60));
        if (hr < 10) {hr = "0" + hr; }
        if (min < 10) {min = "0" + min;}
        if (sec < 10) {sec = "0" + sec;}
        if (hr) {hr = "00";}
        return hr + ':' + min + ':' + sec;
    };

    function bytesToSize(bytes) {
        var sizes = ['Bytes', 'KB', 'MB'];
        if (bytes == 0) return 'n/a';
        var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
        return (bytes / Math.pow(1024, i)).toFixed(1) + ' ' + sizes[i];
    };

    function fileSelected() {
        // hide different warnings
        document.getElementById('filesSelect').style.display = 'none';
        document.getElementById('upload_message').style.display = 'none';
        
        // get selected file element
        var oFile = document.getElementById('files').files[0];
        
        // little test for filesize
        if (oFile.size > iMaxFilesize) {
            document.getElementById('upload_message').innerHTML = 'O arquivo selecionado é muito grande e não podemos fazer o envio.<br />Selecione um arquivo menor.';
            document.getElementById('upload_message').style.display = 'block';
            return;
        }
        
        // filter for image files
        var rFilter = /^(image\/bmp|image\/gif|image\/jpeg|image\/png|image\/tiff)$/i;
        if (! rFilter.test(oFile.type)) {
            document.getElementById('preview').style.display = 'none';
            document.getElementById('fileinfo').style.display = 'none';
            
            isImage = false;
            
            //document.getElementById('error').innerHTML = 'You should select valid image files only!';
            //document.getElementById('error').style.display = 'block';
            //return;
        } else {
            if (previewEnabled) {
                // get preview element
                var oImage = document.querySelector('#preview img');
                
                // prepare HTML5 FileReader
                var oReader = new FileReader();
                    oReader.onload = function(e){
                    // e.target.result contains the DataURL which we will use as a source of the image
                    oImage.src = e.target.result;
                    oImage.onload = function () { // binding onload event
                        // we are going to display some custom image information here
                        sResultFileSize = bytesToSize(oFile.size);
                        document.getElementById('fileinfo').style.display = 'block';
                        document.getElementById('filename').innerHTML = 'Name: ' + oFile.name;
                        document.getElementById('filesize').innerHTML = 'Size: ' + sResultFileSize;
                        document.getElementById('filetype').innerHTML = 'Type: ' + oFile.type;
                        document.getElementById('filedim').innerHTML = 'Dimension: ' + oImage.naturalWidth + ' x ' + oImage.naturalHeight;
                    };
                };
                
                document.getElementById('preview').style.display = 'block';
                
                // read selected file as DataURL
                oReader.readAsDataURL(oFile);
            }
        }
        
        // send files
        startUploading();
    }

    function startUploading() {
        // cleanup all temp states
        iPreviousBytesLoaded = 0;
        document.getElementById('upload_message').style.display = 'none';
        document.getElementById('progress_percent').innerHTML = '';
        var oProgress = document.getElementById('progress');
        oProgress.style.display = 'block';
        oProgress.style.width = '0px';
        // get form data for POSTing
        //var vFD = document.getElementById('upload_form').getFormData(); // for FF3
        var vFD = new FormData(document.getElementById('upload_form'));
        // create XMLHttpRequest object, adding few event listeners, and POSTing our data
        //var oXHR = new XMLHttpRequest();
        oXHR = new XMLHttpRequest();
        oXHR.upload.addEventListener('progress', uploadProgress, false);
        oXHR.addEventListener('load', uploadFinish, false);
        oXHR.addEventListener('error', uploadError, false);
        oXHR.addEventListener('abort', uploadAbort, false);
        //oXHR.open('POST', 'upload.php');
        //oXHR.open('PUT', CFG__API_REST_SPACES_URL + CFG__API_REST_SPACES_FILEPATH);
        oXHR.open('PUT', "https://api.spaces.brauntech.com.br/" + _appData.settings.__spaces_bucket + CFG__API_REST_SPACES_FILEPATH);
        //req.setRequestHeader('Authorization', 'Basic [base64 encoded password here]' );
        oXHR.setRequestHeader('Authorization', cookieGet('__utmo'));
        oXHR.send(vFD);
        // set inner timer
        oTimer = setInterval(doInnerUpdates, 300);
    }

    function doInnerUpdates() { // we will use this function to display upload speed
        var iCB = iBytesUploaded;
        var iDiff = iCB - iPreviousBytesLoaded;
        // if nothing new loaded - exit
        if (iDiff == 0)
            return;
        iPreviousBytesLoaded = iCB;
        iDiff = iDiff * 2;
        
        var iBytesRem = iBytesTotal - iPreviousBytesLoaded;
        var secondsRemaining = iBytesRem / iDiff;
        // update speed info
        var iSpeed = iDiff.toString() + ' B/s';
        if (iDiff > 1024 * 1024) {
            iSpeed = (Math.round(iDiff * 100/(1024*1024))/100).toString() + ' MB/s';
        } else if (iDiff > 1024) {
            iSpeed =  (Math.round(iDiff * 100/1024)/100).toString() + ' KB/s';
        }
        
        document.getElementById('speed').innerHTML = iSpeed;
        document.getElementById('remaining').innerHTML = secondsToTime(secondsRemaining);
    }

    function uploadProgress(e) { // upload process in progress
        var elProgressBar = document.getElementById('progress-bar');
        var elProgressBarStyle = window.getComputedStyle(elProgressBar);
        var elProgressBarW = (elProgressBar.offsetWidth - parseFloat(elProgressBarStyle.paddingLeft) - parseFloat(elProgressBarStyle.paddingRight) - parseFloat(elProgressBarStyle.borderLeft) - parseFloat(elProgressBarStyle.borderRight) - parseFloat(elProgressBarStyle.marginLeft) - parseFloat(elProgressBarStyle.marginRight)) / 100;
        
        if (e.lengthComputable) {
            iBytesUploaded = e.loaded;
            iBytesTotal = e.total;
            var iPercentComplete = Math.round(e.loaded * 100 / e.total);
            var iBytesTransfered = bytesToSize(iBytesUploaded);
            document.getElementById('progress_percent').innerHTML = iPercentComplete.toString() + '%';
            document.getElementById('progress').style.width = (iPercentComplete * elProgressBarW).toString() + 'px';
            document.getElementById('b_transfered').innerHTML = iBytesTransfered;
            if (iPercentComplete == 100) {
                var oUploadResponse = document.getElementById('upload_message');
                oUploadResponse.innerHTML = 'Aguarde, o seu arquivo está sendo processado...';
                oUploadResponse.style.display = 'block';
            }
        } else {
            document.getElementById('progress').innerHTML = 'unable to compute';
        }
    }

    function uploadFinish(e) { // upload successfully finished
        var oUploadResponse = document.getElementById('upload_message');
        /* oUploadResponse.innerHTML = e.target.responseText; */
/**        oUploadResponse.innerHTML = "Envio de arquivo concluído.";
        oUploadResponse.style.display = 'block';
        document.getElementById('progress_percent').innerHTML = '100%';
        document.getElementById('progress').style.width = '100%';
        document.getElementById('filesize').innerHTML = sResultFileSize;
        document.getElementById('speed').innerHTML = '';
        document.getElementById('remaining').innerHTML = '';
        clearInterval(oTimer);
        
        if (typeof execUploadFinished === 'function') {
            execUploadFinished();
        }
        dialogClose();
    }

    function uploadError(e) { // upload error
        document.getElementById('upload_message').innerHTML = 'Ocorreu um erro ao fazer o envio do arquivo.';
        document.getElementById('upload_message').style.display = 'block';
        document.getElementById('speed').innerHTML = '';
        document.getElementById('remaining').innerHTML = '';
        
        clearInterval(oTimer);
    }

    function uploadAbort(e) { // upload abort
        document.getElementById('upload_message').innerHTML = 'O envio do arquivo foi cancelado.';
        document.getElementById('upload_message').style.display = 'block';
        document.getElementById('speed').innerHTML = '';
        document.getElementById('remaining').innerHTML = '';
        clearInterval(oTimer);
    }

    function cancelUploadFile() {
        if(oXHR){
            oXHR.abort();
        }
        
        dialogClose();
    }
    **/
</script>
