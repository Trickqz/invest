<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Materiais
                </h2>
            </div>

            <div class="col-auto ms-auto d-print-none">
                <div class="btn-list">
                    {{#if system.isadmin}}
                        <div class="form-group">
                            <a href="javascript:;" class="btn btn-primary /*d-none d-sm-inline-block*/" onclick="page__materials__uploadFile();">
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>
                                Enviar aquivo
                            </a>
                        </div>
                    {{else}}
                    {{/if}}
                    
                    <div class="form-group">
                        <div id="materials--btn-group" class="btn-group w-100">
                            <button type="button" class="btn btn-primary" data-tab="documents">Documentos</button>
                            <button type="button" class="btn" data-tab="visual_identity">Identidade visual</button>
                            <button type="button" class="btn" data-tab="legal">Jurídico</button>
                            <button type="button" class="btn" data-tab="miscellaneous">Diversos</button>
                            <!--<div class="btn-group" role="group">
                                <button id="btnGroupDrop1" type="button" class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Outros
                                </button>
                                <div class="dropdown-menu dropdown-menu-end" style="">
                                    <a class="dropdown-item" href="#" style="">
                                        Diversos
                                    </a>
                                </div>
                            </div>-->
                        </div>
                        <script>
                            if (typeof page__materials__buttons === 'undefined') {
                                let page__materials__buttons = document.querySelectorAll('#materials--btn-group .btn');
                                for(let i = 0; i<page__materials__buttons.length; i++){
                                    page__materials__buttons[i].addEventListener('click', () => {
                                        var btnLst = document.querySelectorAll('#materials--btn-group .btn');
                                        for(var i2 = 0; i2<btnLst.length; i2++){
                                            if (page__materials__buttons[i].getAttribute("data-tab") == btnLst[i2].getAttribute("data-tab")) {
                                                page__materials__buttons[i].classList.add("btn-primary");
                                            } else {
                                                btnLst[i2].classList.remove("btn-primary");
                                            }
                                        }
                                        
                                        page__materials__loadFiles(page__materials__buttons[i].getAttribute("data-tab"));
                                    });
                                }
                            }
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="page-body">
    <!-- -->
</div>

<script>
    var CFG__API_REST_SPACES_FILEPATH = '/uploads/materials/documents/';
    var _type = 'documents';
    
    function page__materials__loadFiles(type) {
        /* documents, visual_identity, legal, miscellaneous */
        if (type != null) {
            _type = type;
        }
        
        CFG__API_REST_SPACES_FILEPATH = '/uploads/materials/' + _type + '/';
        
        
        document.querySelector(".page-body").innerHTML = 
              '<div class="empty">'
            + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
            + '</div>';
        
        xdr('GET', 'https://api.spaces.brauntech.com.br/'+_appData.settings.__spaces_bucket+CFG__API_REST_SPACES_FILEPATH.substring(0, CFG__API_REST_SPACES_FILEPATH.length - 1),
            null,
            function callback(data){
                var response = JSON.parse(data);
                var tbodyHTML = '';
                
                if (isObjEmpty(response.error)) {
                    for (var i = 0; i < response.length; i++){
                        var thumbIcon = "",
                            fileType = "",
                            fileOpenClick =   //'<a href="' + 'https://api.spaces.brauntech.com.br/'+_appData.settings.__spaces_bucket+CFG__API_REST_SPACES_FILEPATH + response[i].filename + '"> '
                                            '    <p class="table-row__name">' + response[i].filename + '</p>';
                                            //+ '</a>';
                        
                        switch (response[i].contentType) {
                            case "image/jpg":
                            case "image/jpeg": thumbIcon += "jpg"; fileType = "JPG/JPEG";
                            break;
                            case "text/html": thumbIcon += "html"; fileType = "HTML";
                            break;
                            case "application/pdf": thumbIcon += "pdf"; fileType = "PDF";
                            break;
                            case "text/plain": thumbIcon += "txt"; fileType = "TXT";
                            break;
                            case "image/png": thumbIcon += "png"; fileType = "PNG";
                            break;
                            case "application/wps-office.doc":
                            case "application/wps-office.docx": thumbIcon += "doc"; fileType = "DOC/DOCX";
                            break;
                            case "application/zip": thumbIcon += "zip"; fileType = "ZIP";
                            break;
                            default:
                                thumbIcon += "file"; fileType = "ARQUIVO";
                        }
                        
                        var contentType = response[i].contentType;
                        if (contentType.includes("image") || contentType.includes("pdf") || contentType.includes("text")) {
                            fileOpenClick = //'<a href="javascript:;" onclick="OpenFile(\'' + CFG__API_REST_SPACES_FILEPATH + '/' + response[i].filename + '\', \'' + contentType + '\');"> '
                                            '    <p class="table-row__name">' + response[i].filename + '</p>';
                                            //+ '</a>';
                        }
                        
                        tbodyHTML +=
                              '<tr>'
                            + '    <td data-label="Name">'
                            + '        <div class="d-flex py-1 align-items-center">'
                            + '            <span class="avatar me-2" style="background-image: url(/assets/img/icons/file-types/png/' + thumbIcon + '.png);background-color: unset;"></span>'
                            + '            <div class="flex-fill">'
                            + '                <div class="font-weight-medium"><a href="javascript:OpenFile(\'/uploads/materials/' + _type + '/' + response[i].filename + '\', \'' + response[i].contentType + '\');" class="text-reset">' + response[i].filename + '</a></div>'
                            + '                <div class="text-muted">Arquivo no formato <b>' + fileType + '</b></div>'
                            + '            </div>'
                            + '        </div>'
                            + '    </td>'
                            + '    <td class="text-muted" data-label="Tamanho">'
                            + '        ' + formatBytes(response[i].length, 2)
                            + '    </td>'
                            + '    <td>'
                            + '        <div class="btn-list flex-nowrap">'
                            + '            <a href="javascript:OpenFile(\'/uploads/materials/' + _type + '/' + response[i].filename + '\', \'' + response[i].contentType + '\');" class="btn btn-primary">'
                            + '                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-search" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '                   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '                   <circle cx="10" cy="10" r="7"></circle>'
                            + '                   <line x1="21" y1="21" x2="15" y2="15"></line>'
                            + '                </svg>'
                            + '                Visualizar'
                            + '            </a>'
                            + '            <a href="javascript:window.open(\'https://api.spaces.brauntech.com.br/' + _appData.settings.__spaces_bucket + '/uploads/materials/' + _type + '/' + response[i].filename + '?ContentDisposition=attachment\');" class="btn btn-primary">'
                            + '                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-download" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '                   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '                   <path d="M4 17v2a2 2 0 0 0 2 2h12a2 2 0 0 0 2 -2v-2"></path>'
                            + '                   <polyline points="7 11 12 16 17 11"></polyline>'
                            + '                   <line x1="12" y1="4" x2="12" y2="16"></line>'
                            + '                </svg>'
                            + '                Baixar'
                            + '            </a>'
                            
                            {{#if system.isadmin}}
                                + '            <a href="javascript:;" onclick="page__materials__deleteFile(\'' + response[i].filename + '\');" class="btn btn-danger">'
                                + '                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-trash" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                + '                    <line x1="4" y1="7" x2="20" y2="7"></line>'
                                + '                    <line x1="10" y1="11" x2="10" y2="17"></line>'
                                + '                    <line x1="14" y1="11" x2="14" y2="17"></line>'
                                + '                    <path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12"></path>'
                                + '                    <path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3"></path>'
                                + '                </svg>'
                                + '                Excluir'
                                + '            </a>'
                            {{else}}
                            {{/if}}
                            
                            + '        </div>'
                            + '    </td>'
                            + '</tr>';
                    }
                    
                    document.querySelector(".page-body").innerHTML = 
                          ' <div class="container-xl">'
                        + '     <div class="row row-cards">'
                        + '         <div class="col-12">'
                        + '             <div class="card">'
                        + '                 <div class="table-responsive">'
                        + '                     <table class="table table-vcenter table-mobile-md card-table">'
                        + '                         <thead>'
                        + '                             <tr>'
                        + '                                 <th>Nome</th>'
                        + '                                 <th>Tamanho</th>'
                        + '                                 <th class="w-1"></th>'
                        + '                             </tr>'
                        + '                         </thead>'
                        + '                         <tbody>'
                        +                               tbodyHTML                                
                        + '                         </tbody>'
                        + '                     </table>'
                        + '                 </div>'
                        + '             </div>'
                        + '         </div>'
                        + '     </div>'
                        + ' </div>';
                } else {
                    page__materials__loadClear(_type);
                }
            },
            function errback(err){
                page__materials__loadClear(_type);
            }
        );
    }
    
    function page__materials__loadClear(_type) {
        document.querySelector(".page-body").innerHTML = 
              '<div class="container-xl d-flex flex-column justify-content-center">'
            + '    <div class="empty">'
            + '        <div class="empty-img"><img src="https://cdn.brauntech.com.br/ajax/libs/tabler/1.0.0-beta9/demo/static/illustrations/undraw_printing_invoices_5r4r.svg" height="128" alt="" /></div>'
            + '        <p class="empty-title">Nenhum resultado encontrado</p>'
            + '        <p class="empty-subtitle text-muted">'
            + '            Tente mudar sua pesquisa ou filtro para encontrar o que procura.'
            + '        </p>'
            + '    </div>'
            + '</div>';
    }
    
    
    function page__materials__uploadFile(){
        //var source = getBackofficeURL('templates/popup-orders_print.html');
        //var template = Handlebars.compile(source);
        //var html = template(_data);
        
        //App.form('popup__upload', 'fit-content', "540px");  //"900px");
        dialogOpen('templates/popup/upload.tpl', null, null);
    }
    
    function page__materials__deleteFile(filename){
        alertOpen({
                title: "Confirmação",
                text: "Confirma a exclusão do arquivo?",
                type: "danger",
                confirmButtonText: "Sim",
                cancelButtonText: "Não"
            },
            function(){
                xdr('DELETE', 'https://api.spaces.brauntech.com.br/' + _appData.settings.__spaces_bucket + CFG__API_REST_SPACES_FILEPATH + filename,
                    null,
                    function callback(data){
                        page__materials__loadFiles(null);
                    },
                    function errback(err){
                        console.log(err);
                    }
                );
            }
        );
    }
    
    function execUploadFinished(){
        page__materials__loadFiles(null);
    }
    
    page__materials__loadFiles('documents');
</script>
