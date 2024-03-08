<style>
    #upload_form {
        width:100%;
    }
    #preview {
        display: none;
        float: left;
        padding: 8px;
    }
    #preview img {
        background-color:#fff;
        display:block;
        float:right;
        width:200px;
    }
    #upload_form > div {
        margin-bottom:10px;
    }
    .upload-status {
        color: #444444;
        padding-top: 4px;
        font-size: 11px;
    }
    #speed,#remaining {
        float:left;
        width:100px;
        padding: 0 6px;
    }
    #speed {
        text-align: right;
    }
    #b_transfered {
        float:left;
        text-align:left;
    }
    .clear_both {
        clear:both;
    }
    #image_file {
        width:400px;
    }
    #progress_info {
        font-size:10pt;
    }
    #fileinfo {
        padding: 8px;
        float: left;
    }
    #fileinfo,#upload_message {
        color:#444444;
        display:none;
        font-size:10pt;
        margin-top:10px;
    }
    #progress-bar {
        display: block;
        width: 100%;
        /* border: 1px solid #002262; */
        float: left;
        height: 10px;
        background: #eee;
    }
    #progress {
        display: none;
        /* float: left; */
        height: 100%;
        background: #002262;
        position: relative;
    }
    #progress_percent {
        float:right;
    }
</style>

<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-md modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-title" style="margin-bottom: 0;">Send file</div>
                <div>Select file to send.</div>
            </div>
            <form id="upload_form" enctype="multipart/form-data" method="post" action="upload.php">
                <div class="modal-body" style="margin-bottom: 0;padding: 12px 24px 12px 24px;">
                    <div style="display: none;">
                        <div><label for="files">Select file</label></div>
                        <div><input type="file" name="files[]" id="files" onchange="fileSelected();" multiple /></div>
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
                </div>
                <div class="modal-footer" style="/*margin-top: 0;text-align: right;margin-bottom: 16px;*/">
                    <!--<button type="button" class="btn btn-danger" onclick="formPassword__Save();"></button>-->
                    <input id="filesSelect" type="button" class="btn /*btn-link link-secondary me-auto*/" value="Select file..." onclick="document.querySelector('#files').click();" />
                    <!--<button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>-->
                    <input type="button" class="btn /*btn-link link-secondary me-auto*/" value="Cancelar" onclick="cancelUploadFile()" />
                </div>
            </form>
        </div>
    </div>
<!--</div>-->

<script type="text/javascript">
    document.querySelector('#files').click();
</script>
