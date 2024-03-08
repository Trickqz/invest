<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-body" style="/*margin-bottom: 0;padding-bottom: 0;*/padding-bottom: 12px;">
            <div class="modal-title">Add points</div>
            <div>
                The deadline for compensation, the <b>minimum and maximum amount</b> to be added is according to the company's rules.
            </div>
        </div>
        
        <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;/*display: none;*/">
        
        <form id="formPointsAdd" name="formPointsAdd" method="post" onsubmit="return formPointsAddProcess();">
            <div class="modal-body" style="padding-top: 12px;">
                <div class="col-lg-12">
                    <div class="mb-3">
                        <label class="form-label">Username to add?</label>
                        <input id="username" name="username" type="text" class="form-control" placeholder="Username" required="" />
                        <div id="username--invalid-feedback" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-5">
                        <div class="mb-3">
                            <label class="form-label">Type</label>
                            <select name="type" class="form-select" onchange="enableBinarySide(this);">
                                <option value="unilevel">Unilevel</option>
                                <option value="binary" selected="">Binary</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="mb-3">
                            <label class="form-label">Side</label>
                            <select id="binary_side" name="binary_side" class="form-select">
                                <option value="left">Left</option>
                                <option value="right">Right</option>
                            </select>
                        </div>
                    </div>
                    
                    <script>
                        function enableBinarySide(el) {
                            if (el.value == 'binary') {
                                document.getElementById("binary_side").disabled = false;
                            } else {
                                document.getElementById("binary_side").disabled = true;
                            }
                        }
                    </script>
                </div>
                <div class="col-lg-12">
                    <div class="mb-3">
                        <label class="form-label">Value to add?</label>
                        <input id="value" name="value" type="text" class="form-control" placeholder="0.00" autocomplete="off" inputmode="numeric" data-inputmask="'alias': 'numeric2'" required="" />
                        <div id="value--invalid-feedback" class="invalid-feedback"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="error-msg"></div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <button type="button" class="btn btn-danger" onclick="formPointsAddProcess();">Add points</button>
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    function formPointsAddProcess(){
        document.querySelectorAll('.invalid-feedback').forEach(elem => {
            var el = elem.parentElement.querySelector('.form-control');
            if (el != null) {
                el.classList.remove("is-invalid");
            }
        });
        
        var elUsername = document.querySelector('#formPointsAdd input[name="username"]');
        var elType = document.querySelector('#formPointsAdd select[name="type"]');
        var elBinary_side = document.querySelector('#formPointsAdd select[name="binary_side"]');
        var elValue = document.querySelector('#formPointsAdd input[name="value"]');
        
        Controller.pointsAdd(elUsername.value, elType.value, elBinary_side.value, justNumber(elValue.value));
    }
    
    setTimeout(function(){
        document.formPointsAdd.amount.focus();
    }, 1000);
</script>
