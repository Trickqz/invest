<div class="modal-dialog modal-full-width modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h5 id="title" class="modal-title">Image viewer</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" style="padding: 0;">
            <div style="
                background: #000;
                /*display: block;*/
                width: 100%;
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: center; /* Centering y-axis */
                align-items :center; /* Centering x-axis */
                
                /*border: none;*/
                /*top: 52px;*/
                /*position: absolute;*/
                /*height: calc(100% - 52px);*/
                width: 100%;
                overflow: hidden;
                /*background: #f2f2f2;*/
                border: none;
                height: calc(100vh - 155px);"
                >
                <!--<img class="loadingSpinner" id="image_view-img" src="./assets/img/loading.svg" alt="Visualização da imagem" style="
                    /* max-width: 94%; */
                    /*display: block;
                    margin: 0 auto;
                    max-height: 96%;
                    padding: 3%;*/">-->
                
                <!--<table width="100%" height="100%" align="center" valign="center" style="display: block;">
                    <tbody style="width: 100%;display: block;height: 100%;">
                        <tr style="width: 100%;display: block;height: 100%;">
                            <td style="width: 100%;display: block;height: 100%;text-align: center;">-->
                                <img id="image_view-img" class="loadingSpinner" src="/assets/img/loading.svg" alt="" />
                            <!--</td>
                        </tr>
                    </tbody>
                </table>-->
            </div>
        </div>
        <div class="modal-footer">
            <a href="javascript:;" class="btn btn-primary" onclick="popup__image_viewFileDownload();">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-download" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                   <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2"></path>
                   <polyline points="7 11 12 16 17 11"></polyline>
                   <line x1="12" y1="4" x2="12" y2="16"></line>
                </svg>
                Download
            </a>
            <a href="#" class="btn" data-bs-dismiss="modal">
                Close
            </a>
        </div>
    </div>
</div>

<script type="text/javascript">
    function popup__image_viewFileDownload() {
        //var fileURL = currentDialogFormObj.file;
        //var fileName = fileURL.substr(fileURL.lastIndexOf('/') + 1);
        //download_file(fileURL, fileName); //call function
        
        window.open(currentDialogFormObj.file + "?ContentDisposition=attachment", "_top");
    }
    
    /* Helper function */
    function download_file(fileURL, fileName) {
        // for non-IE
        if (!window.ActiveXObject) {
            var save = document.createElement('a');
            save.href = fileURL;
            save.target = '_blank';
            var filename = fileURL.substring(fileURL.lastIndexOf('/')+1);
            save.download = fileName || filename;
               if ( navigator.userAgent.toLowerCase().match(/(ipad|iphone|safari)/) && navigator.userAgent.search("Chrome") < 0) {
                    document.location = save.href; 
                    // window event not working here
                }else{
                    var evt = new MouseEvent('click', {
                        'view': window,
                        'bubbles': true,
                        'cancelable': false
                    });
                    save.dispatchEvent(evt);
                    (window.URL || window.webkitURL).revokeObjectURL(save.href);
                }	
        }

        // for IE < 11
        else if ( !! window.ActiveXObject && document.execCommand)     {
            var _window = window.open(fileURL, '_blank');
            _window.document.close();
            _window.document.execCommand('SaveAs', true, fileName || fileURL)
            _window.close();
        }
    }
    
    
    
    var formList = document.querySelectorAll(".modal");
    /* if (formList.length > 0) {
        formList[formList.length-1].classList.add("disabled");
    } */
    var currentDialogForm = formList[formList.length - 1];
    var currentDialogFormSrc = currentDialogForm.getAttribute('data-src');
    var currentDialogFormObj = JSON.parse(currentDialogFormSrc);
    var image_viewImg = document.getElementById('image_view-img');
    
    var titleIMAGE = document.getElementById('title');
    if (currentDialogFormObj.title != "") {
        titleIMAGE.innerHTML = currentDialogFormObj.title;
    }
    
    setTimeout(function(){
        image_viewImg.style.display = 'none';
        image_viewImg.classList.remove('loadingSpinner');
        image_viewImg.src = currentDialogFormObj.file;
        image_viewImg.classList.add('image_v');
        image_viewImg.style.display = 'flex';
    }, 150);
</script>

<style>
    .image_v {
        /*display: block;
        margin: 0 auto;*/
        max-height: 96%;
        padding: 3%;
    }
</style>
