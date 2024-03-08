<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-title">Enviar arquivo</div>
                <div>Selecione o(s) arquivo(s) para enviar.</div>
            </div>
            <div class="modal-body">
                
                
                
                
                
                
                <div class="form-group g4" style="margin-top: 16px;">
                <h3>Carregando para o Spaces</h3>
                <span>Esta janela será fechada após a conclusão do carregamento.</span>
            </div>
            
            <form id="upload_form" enctype="multipart/form-data" method="post" action="upload.php">
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
                
                <!--
                    <label for="">Nome da categoria</label>
                    <input name="name" type="text" class="form-control" placeholder="Nomeie sua categoria" value="{{name}}" required="">
                </div>-->
                
                <div class="form-group g4" style="margin-top: 0;text-align: right;margin-bottom: 16px;">
                    <input id="filesSelect" type="button" value="Selecionar arquivos..." onclick="document.querySelector('#files').click();" />
                    <input type="button" value="Cancelar" onclick="cancelUploadFile()" />
                </div>
            </form>
                
                
                
                
                
                
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="formPassword__Save();">Alterar minha senha</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script type="text/javascript">
    document.querySelector('#files').click();
</script>
