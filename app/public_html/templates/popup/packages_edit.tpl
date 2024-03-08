<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                {{#contains "edition" tmp.mode}}
                    <div class="modal-title">Edit pack</div>
                {{else}}
                    <div class="modal-title">New pack</div>
                {{/contains}}
                
                <!--<div></div>-->
            </div>
            <div class="modal-body">
                <form id="formPackagesEdit" name="formPackagesEdit">
                    <input name="id" type="hidden" value="{{tmp._id}}">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Name</label>
                                <input name="name" type="text" class="form-control" placeholder="Name" value="{{tmp._name}}" required />
                                <div id="name--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <input name="description" type="text" class="form-control" placeholder="Description"  value="{{tmp._description}}" />
                                <div id="description--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Licenses</label>
                                <input name="contracts" type="number" class="form-control" placeholder="Licenses"  value="{{tmp._contracts}}" required />
                                <div id="contracts--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Amount</label>
                                <input name="amount" type="text" class="form-control" placeholder="USD 0,00" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" value="{{formatmoney_br tmp._amount}}" required />
                                <div id="amount--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Fee</label>
                                <input name="fee" type="text" class="form-control" placeholder="USD 0,00" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" value="{{formatmoney_br tmp._fee}}" />
                                <div id="fee--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Income</label>
                                <input name="income" type="text" class="form-control" placeholder="USD 0,00" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'"  value="{{formatmoney_br tmp._income}}" required />
                                <div id="income--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="error-msg"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="formPackagesEdit__Save();">Save</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    var formPackagesEdit = document.getElementById('formPackagesEdit');
    formPackagesEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formPackagesEdit__Save();
    }
    
    function formPackagesEdit__Save() {
        //Controller.formPackagesEditUpdate('formPackagesEdit');
        
        var jsonData = JSON.parse(formToJSONString('formPackagesEdit'));
        
        {{#contains "edition" tmp.mode}}
            $.ajax({
                type: 'POST',
                url: CFG__API_URL + CFG__API_VERSION + "/donations_model/{{tmp._id}}",
                beforeSend: function (xhr){ 
                    xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                },
                data: jsonData,
                success: function(response) {
                    if (response.success === true) {
                        dialogClose();
                        fc_donations_modelGetAll("*");
                    } else {
                        App.alert('Warning', response.message, null);
                    }
                }
            });
        {{else}}
            $.ajax({
                type: 'POST',
                url: CFG__API_URL + CFG__API_VERSION + "/donations_model",
                beforeSend: function (xhr){ 
                    xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                },
                data: jsonData,
                success: function(response) {
                    if (response.success === true) {
                        dialogClose();
                        fc_donations_modelGetAll("*");
                    } else {
                        App.alert('Warning', response.message, null);
                    }
                }
            });
        {{/contains}}
        
        return false;
    }
    
    setTimeout(function(){
        document.querySelector('#formPackagesEdit input[name="name"]').focus();
    }, 1000);
</script>
