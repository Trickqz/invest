<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-title">Share with friends</div>
                <div>To make it easier, you can share by QRCode. Just ask your friend to scan the code below.</div>
            </div>
            <div class="modal-body">
                <div class="row">
                    <style>
                        #qrcode img {
                            border: solid 8px #fff;
                        }
                    </style>
                    <div id="qrcode" style="width: 160px;margin: 0 auto;"></div>
                    <script type="text/javascript">
                        //new QRCode(document.getElementById("qrcode"), "{{settings.__app_url}}/criar-conta/{{system.userdata._username}}");
                        
                        var qrcode = new QRCode("qrcode", {
                            text: "{{settings.__app_url}}/create-account/{{system.userdata._username}}",
                            width: 160,
                            height: 160,
                            colorDark : "#000000",
                            colorLight : "#ffffff",
                            correctLevel : QRCode.CorrectLevel.H
                        });
                    </script>
                </div>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="mb-3">
                            <label class="form-label">Copy and share: <a class="btn btn-link" href="javascript:;" onclick="copyLink('{{settings.__app_url}}/create-account/{{system.userdata._username}}');">Copy link</a></label>
                            <div class="input-group input-group-flat">
                                <span class="input-group-text">
                                    <!--{{settings.__app_url}}-->/create-account/
                                </span>
                                <input type="text" class="form-control ps-0" value="{{system.userdata._username}}" autocomplete="off" readonly>
                            </div>
                        </div>
                    </div>
                </div>
                
                <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;">
                
                <div class="row">
                    <div class="col-lg-12">
                        <ul class="list list-timeline list-timeline-simple">
                            <li>
                                <div class="list-timeline-icon bg-twitter">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                        <path
                                            d="M22 4.01c-1 .49 -1.98 .689 -3 .99c-1.121 -1.265 -2.783 -1.335 -4.38 -.737s-2.643 2.06 -2.62 3.737v1c-3.245 .083 -6.135 -1.395 -8 -4c0 0 -4.182 7.433 4 11c-1.872 1.247 -3.739 2.088 -6 2c3.308 1.803 6.913 2.423 10.034 1.517c3.58 -1.04 6.522 -3.723 7.651 -7.742a13.84 13.84 0 0 0 .497 -3.753c-.002 -.249 1.51 -2.772 1.818 -4.013z"
                                        ></path>
                                    </svg>
                                </div>
                                <div class="list-timeline-content">
                                    <div class="list-timeline-time"></div>
                                    <p class="list-timeline-title">Twitter</p>
                                    <p class="text-muted">Click <a class="btn-link" target="_blank" href="https://twitter.com/intent/tweet?text=Be part of {{settings.office.name}} with me, register: {{settings.__app_url}}/create-account/{{system.userdata._username}}">here</a> to share.</p>
                                </div>
                            </li>
                            <li>
                                <div class="list-timeline-icon bg-facebook">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                        <path d="M7 10v4h3v7h4v-7h3l1 -4h-4v-2a1 1 0 0 1 1 -1h3v-4h-3a5 5 0 0 0 -5 5v2h-3"></path>
                                    </svg>
                                </div>
                                <div class="list-timeline-content">
                                    <div class="list-timeline-time"></div>
                                    <p class="list-timeline-title">Facebook</p>
                                    <p class="text-muted">Click <a class="btn-link" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u={{settings.__app_url}}/create-account/{{system.userdata._username}}">here</a> to share.</p>
                                </div>
                            </li>
                            <li>
                                <div class="list-timeline-icon bg-success">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-brand-whatsapp" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                       <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                       <path d="M3 21l1.65 -3.8a9 9 0 1 1 3.4 2.9l-5.05 .9"></path>
                                       <path d="M9 10a0.5 .5 0 0 0 1 0v-1a0.5 .5 0 0 0 -1 0v1a5 5 0 0 0 5 5h1a0.5 .5 0 0 0 0 -1h-1a0.5 .5 0 0 0 0 1"></path>
                                    </svg>
                                </div>
                                <div class="list-timeline-content">
                                    <div class="list-timeline-time"></div>
                                    <p class="list-timeline-title">WhatsApp</p>
                                    <p class="text-muted">Click <a class="btn-link" target="_blank" href="https://api.whatsapp.com/send?text=Be part of *{{settings.__app_url}}* with me, register: {{settings.__app_url}}/create-account/{{system.userdata._username}}">here</a> to share.</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <div class="error-msg"></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    function copyLink(_link){
        navigator.clipboard.writeText(_link).then(function() {
            //demo.showNotification('Link copiado para <b>área de transfência</b>.', 'success');
        }, function(err) {
            //demo.showNotification('Não foi possível copiar seu link. Use <b>Ctrl+C</b> para copiar o link.', 'danger');
        });
    }
</script>
