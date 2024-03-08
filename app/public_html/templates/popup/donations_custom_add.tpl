<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
        <div class="modal-content">
            <form id="formDonationsCustomAdd" name="formDonationsCustomAdd">
                <div class="modal-body">
                    <div class="modal-title">Acquisition of licenses</div>
                    <div>You can choose the number of licenses to purchase, increasing your earning prospects.</div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="mb-3">
                                <label class="form-label">Licenses to be acquired</label>
                                <input name="contracts" type="number" class="form-control" min="1" max="500" value="1" required />
                                <div id="contracts--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="error-msg"></div>
                    </div>
                </div>
            </form>
            <div class="modal-footer">
                <button id="btn-upgrade" type="button" class="btn btn-danger" onclick="donations_custom_add__New();">Buy licenses</button>
                <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
<!--</div>-->

<script>
    var formDonationsCustomAdd = document.getElementById('formDonationsCustomAdd');
    formDonationsCustomAdd.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        donations_custom_add__New();
    }
    
    function donations_custom_add__New() {
        //document.querySelector('#formAccountProfileEdit input[name="birthdate"]').value = FormatStringDate(document.getElementById('birthdate').value);
        
        //Controller.accountsUpdate('formAccountProfileEdit');
        
        //var jsonData = JSON.parse(formToJSONString('formAccountProfileEdit'));
        var contractsValue = document.querySelector('#formDonationsCustomAdd input[name="contracts"]').value;
        
        if (contractsValue > maxValue) {
            App.alert('Error', 'You do not have enough balance to purchase the licenses.<br />You can select up to '+maxValue+' license(s).', null);
            return;
        }
        
        alertOpen({
                title: "Confirm",
                text: "Confirm the purchase of "+contractsValue+" license(s)?",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                $.ajax({
                    type: "POST",
                    url: CFG__API_URL + CFG__API_VERSION + "/donations",
                    data: {
                        contracts: contractsValue
                    },
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    success: function(response) {
                        if (response.success === true) {
                            //fgUpdateUserData();
                            if (router.current[0].url == "") {
                                if (typeof indexLoadData === "function") {
                                    indexLoadData();
                                }
                            } else {
                                if (typeof fc__donationsGetListing === "function") {
                                    fc__donationsGetListing();
                                }
                                if (typeof fc_walletGetListing === "function") {
                                    fc_walletGetListing("*");
                                }
                            }
                            dialogClose();
                        } else {
                            App.alert('Warning', response.message, null);
                        }
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                        
                        App.alert('Error', 'An unexpected error occurred while requesting information.', null);
                    }
                });
            }
        );
    }
    
    var maxValue = 0;
    $.ajax({
        type: 'GET',
        url: CFG__API_URL + CFG__API_VERSION + "/wallet/resume",
        data: {},
        beforeSend: function (xhr){ 
            xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
        },
        success: function(response) {
            if (response.success === true) {
                var _data = response.data;
                
                var elContracts = document.querySelector('#formDonationsCustomAdd input[name="contracts"]');
                maxValue = parseInt(_data._total)/_appData.settings.contracts_value_usd;
                elContracts.setAttribute("max", parseInt(maxValue));
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            console.log(jsonResponse);
        }
    });
    
    setTimeout(function(){
        document.querySelector('#formDonationsCustomAdd input[name="contracts"]').focus();
    }, 1000);
</script>
