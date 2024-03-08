<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div id="modal-popup" class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            {{#if tmp._title}}
                <div class="modal-body">
                    <div class="modal-title">{{tmp._title}}</div>
                    {{#if tmp._subject}}
                        <div>{{tmp._subject}}</div>
                    {{else}}
                    {{/if}}
                </div>
            {{else}}
            {{/if}}
            <div class="modal-body">
                <div class="row">
                    <style>
                        .notification-image img {
                            max-width: 90%;
                            max-height: 90%;
                            width: 100%;
                            height: 100%;
                        }
                    </style>
                    <div class="notification-image" style="margin: 0 auto;">
                        <img src="{{tmp._img_src}}" style="display: block;">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger /*btn-link link-secondary me-auto*/" onclick="f_notificationsSetRead('{{tmp._id}}');">Do not show again</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
<!--</div>-->
