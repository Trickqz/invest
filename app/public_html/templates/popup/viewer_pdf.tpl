<div class="modal-dialog modal-full-width modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h5 id="title" class="modal-title">PDF viewer</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body" style="padding: 0;">
            <iframe id="printf" name="printf" src="" style="border:none;/*top: 52px;position: absolute;height: calc(100% - 52px);*/width: 100%;overflow: hidden;background: #f2f2f2;height: calc(100vh - 155px);"></iframe>
        </div>
        <div class="modal-footer">
            <a href="javascript:;" class="btn btn-primary ms-auto" onclick="printIframe('printf');">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-printer" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                   <path d="M17 17h2a2 2 0 0 0 2 -2v-4a2 2 0 0 0 -2 -2h-14a2 2 0 0 0 -2 2v4a2 2 0 0 0 2 2h2"></path>
                   <path d="M17 9v-4a2 2 0 0 0 -2 -2h-6a2 2 0 0 0 -2 2v4"></path>
                   <rect x="7" y="13" width="10" height="8" rx="2"></rect>
                </svg>
                Print
            </a>
            <a href="javascript:;" class="btn btn-primary" onclick="popup__pdf_viewFileDownload();">
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

<script>
    function print() {
        //document.getElementById('printf').contentWindow.print();
        
        window.frames["printf"].focus();
        window.frames["printf"].print();
    }
    
    function printIframe(id) {
        var iframe = document.frames ? document.frames[id] : document.getElementById(id);
        var ifWin = iframe.contentWindow || iframe;
        iframe.focus();
        ifWin.print();
        return false;
    }
    
    function popup__pdf_viewFileDownload() {
        //var fileURL = currentDialogFormObj.file;
        //var fileName = fileURL.substr(fileURL.lastIndexOf('/') + 1);
        //download_file(fileURL, fileName); //call function
        
        /**
        window.open(currentDialogFormObj.file + "?ContentDisposition=attachment", "_top");
        **/
        
        /*
        x.setRequestHeader("X-Api-Key", CFG__API_KEY);
        x.setRequestHeader("Authorization", cookieGet('__utmo'));
        */
        
        
        xhrpubDown(currentDialogFormObj.file + "?ContentDisposition=attachment");
    }
    
    
    var formList = document.querySelectorAll(".modal");
    /* if (formList.length > 0) {
        formList[formList.length-1].classList.add("disabled");
    } */
    var currentDialogForm = formList[formList.length - 1];
    var currentDialogFormSrc = currentDialogForm.getAttribute('data-src');
    var currentDialogFormObj = JSON.parse(currentDialogFormSrc);
    //var image_viewImg = document.getElementById('image_view-img');
    var viewPDF = document.getElementById('printf');
    viewPDF.src = './modules/viewer/web/viewer.html?file=' + currentDialogFormObj.file + '&api_key=' + CFG__API_KEY + '&authorization=' + cookieGet('__utmo');
    
    var titlePDF = document.getElementById('title');
    if (currentDialogFormObj.title != "") {
        titlePDF.innerHTML = currentDialogFormObj.title;
    }
    
    /*setTimeout(function(){
        image_viewImg.style.display = 'none';
        image_viewImg.classList.remove('loadingSpinner');
        image_viewImg.src = currentDialogFormObj.file;
        image_viewImg.classList.add('image_v');
        image_viewImg.style.display = 'flex';
    }, 150);*/
</script>
