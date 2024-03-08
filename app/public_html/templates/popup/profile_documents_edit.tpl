<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-body">
            <div class="modal-title">Documents</div>
            <div>
                <span>For your security, we ask that you send some documents to guarantee the reliability of the account:</span><br />
                <ul style="margin-top: 8px;">
                    <li>
                        Any document that contains the KYC;
                    </li>
                    <!--<li>
                        Proof of residence (telephone, water or energy) with a maximum of 60 days;
                    </li>-->
                </ul>
            </div>
            <div style="/*margin-top: 8px;*/">
                Accepted formats: <b>JPEG, GIF, PNG e PDF</b>
            </div>
            <div style="/*margin-top: 8px;*/">
                Max file size: <b>1MB</b>
            </div>
        </div>
        <div class="modal-body">
            <div class="mb-3">
                <div class="form-label">Identification document</div>
                <input id="file1" type="file" class="form-control" accept="image/*,capture=camera,.pdf">
            </div>
            <!--<div class="mb-3">
                <div class="form-label">Proof of address</div>
                <input id="file2" type="file" class="form-control" accept="image/*,capture=camera,.pdf">
            </div>-->
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-primary" onclick="profileDocumentsEditUpload();">Send documents</button>
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Close</button>
        </div>
    </div>
</div>

<script>
    function profileDocumentsEditUpload() {
        var vFD = new FormData();
        ///vFD.append('files', blob, filename);
        var file1 = document.getElementById("file1").files[0];
        ///var file2 = document.getElementById("file2").files[0];
        
        vFD.append('files[]', file1);
        ///vFD.append('files', file2);
        
        // create XMLHttpRequest object, adding few event listeners, and POSTing our data
        oXHR = new XMLHttpRequest();
        oXHR.addEventListener('load', function(){
                    $.ajax({
                        type: 'POST',
                        url: CFG__API_URL + CFG__API_VERSION + "/session/account/validation/status",
                        beforeSend: function (xhr){ 
                            xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                        },
                        data: {
                            "filename": file1.name,
                            "status": "validating"
                        },
                        success: function(response) {
                            if (response.success == true) {
                                ///dialogClose();
                                ///fgUpdateUserData();
                                location.reload();
                            }
                        }
                    });
                },
            false);
        oXHR.open('POST', CFG__API_URL+CFG__API_VERSION+"/uploads/accounts/{{system.userdata._id}}/profile/documents");
        oXHR.setRequestHeader('Authorization', cookieGet('__utmo'));
        oXHR.send(vFD);
    }
</script>
