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
    $.ajax({
        type: 'POST',
        url: CFG__API_URL + CFG__API_VERSION + "/upload/gen-key",
        beforeSend: function (xhr){ 
            xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
        },
        data: {
            path: CFG__API_REST_SPACES_FILEPATH,
            permission: 6
        },
        success: function(response) {
            if (response.success === true) {
                //localStorage.setItem('tmp__spacesKey', response.spaces__genKey.key);
                
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
                oXHR.open('PUT', CFG__API_REST_SPACES_URL + "/" + _appData.settings.__spaces_bucket + CFG__API_REST_SPACES_FILEPATH);
                //req.setRequestHeader('Authorization', 'Basic [base64 encoded password here]' );
                oXHR.setRequestHeader('Authorization', cookieGet('__utmo'));
                oXHR.setRequestHeader('Access-Key-Id', response.data.key);
                oXHR.send(vFD);
                
                // set inner timer
                oTimer = setInterval(doInnerUpdates, 300);
            } else {
                App.alert('Atenção', response.message, null);
            }
        }
    });
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
    oUploadResponse.innerHTML = "Envio de arquivo concluído.";
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
