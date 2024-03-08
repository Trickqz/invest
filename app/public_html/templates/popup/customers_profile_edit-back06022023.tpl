<div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title">Personal data of <b>{{tmp._name}}</b></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form class="form-default" id="formAccountProfileEdit" name="formAccountProfileEdit" method="post" action="" role="form">
            <input name="country_dial_code" type="hidden" value="{{system.userdata._country_dial_code}}" />
            <input name="country_phone_mask" type="hidden" value="{{system.userdata._country_phone_mask}}" />
            <input name="country_iso2" type="hidden" value="{{system.userdata._country_iso2}}" />
            <input name="country_name" type="hidden" value="{{system.userdata._country_name}}" />
            <input name="mobile_phone" type="hidden" value="{{system.userdata._mobile_phone}}" />
            
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input name="name" type="text" class="form-control" placeholder="Full name" value="{{tmp._name}}" />
                        </div>
                    </div>
                </div>
                
                
                <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;">
                
                <div class="mb-3">
                    <div class="form-label">Type</div>
                    <div>
                        <label class="form-check form-check-inline">
                            {{#contains "natural_person" tmp._type}}
                                <input name="type" class="form-check-input" type="radio" value="natural_person" onchange="setPersonType('natural_person')" checked="" />
                            {{else}}
                                <input name="type" class="form-check-input" type="radio" value="natural_person" onchange="setPersonType('natural_person')" />
                            {{/contains}}
                            <span class="form-check-label">natural person</span>
                        </label>
                        <label class="form-check form-check-inline">
                            {{#contains "legal_person" tmp._type}}
                            <input name="type" class="form-check-input" type="radio" value="legal_person" onchange="setPersonType('legal_person')" checked="" />
                            {{else}}
                            <input name="type" class="form-check-input" type="radio" value="legal_person" onchange="setPersonType('legal_person')" />
                            {{/contains}}
                            <span class="form-check-label">Legal person</span>
                        </label>
                        <label class="form-check form-check-inline">
                            {{#contains "foreign_person" system.userdata._type}}
                            <input name="type" class="form-check-input" type="radio" value="foreign_person" onchange="setPersonType('foreign_person')" checked="" disabled="" />
                            {{else}}
                            <input name="type" class="form-check-input" type="radio" value="foreign_person" onchange="setPersonType('foreign_person')" disabled="" />
                            {{/contains}}
                            <span class="form-check-label">Foreign person</span>
                        </label>
                    </div>
                </div>
                
                <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;">
                
                
                <!-- -->
                {{#contains "legal_person" tmp._type}}
                <section id="person_type_1">
                {{else}}
                <section id="person_type_1" style="display: none;">
                {{/contains}}
                    <div class="row">
                        <div class="col-md-4 col-lg-4">
                            <div class="mb-3">
                                <label class="form-label">CNPJ</label>
                                <input name="cnpj" type="text" class="form-control" placeholder="CNPJ" data-inputmask="'mask': '99.999.999/9999-99'" inputmode="numeric" value="{{formatdoc tmp._cnpj 'cnpj'}}" autocomplete="off" />
                                <div id="cnpj--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>
                </section>
                
                {{#contains "natural_person" tmp._type}}
                <section id="person_type_2">
                {{else}}
                <section id="person_type_2" style="display: none;">
                {{/contains}}
                    <div class="row">
                        <div class="col-md-4 col-lg-4">
                            <div class="mb-3">
                                <label class="form-label">CPF</label>
                                <input name="cpf" type="text" class="form-control" placeholder="CPF" data-inputmask="'mask': '999.999.999-99'" inputmode="numeric" value="{{formatdoc tmp._cpf 'cpf'}}" autocomplete="off" />
                                <div id="cpf--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>
                        <!--<div class="col-md-4 col-lg-4">
                            <div class="mb-3">
                                <label class="form-label">RG</label>
                                <input name="rg" type="text" class="form-control" placeholder="Seu RG" value="{{tmp._rg}}" autocomplete="off" />
                                <div id="rg--invalid-feedback" class="invalid-feedback"></div>
                            </div>
                        </div>-->
                    </div>
                    <div class="row">
                        <div class="col-md-4 col-lg-4">
                            <div class="mb-3">
                                <label class="form-label">Birthdate</label>
                                <input id="birthdate" type="text" class="form-control" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" value="{{formatdate tmp._birthdate 'dd/MM/yyyy'}}" autocomplete="off">
                                <input name="birthdate" type="hidden" class="form-control" value="{{formatdate tmp._birthdate 'dd/MM/yyyy'}}">
                            </div>
                        </div>
                        
                        <div class="col-md-4 col-lg-4">
                            <div class="mb-3">
                                <div class="form-label">Sex</div>
                                <select name="sex" class="form-select">
                                    {{#selected tmp._sex}}
                                        <option value="">- Select -</option>
                                        <option value="masc">Masc</option>
                                        <option value="fem">Fem</option>
                                        <option value="other">Other</option>
                                    {{/selected}}
                                </select>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- -->
                
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input name="email" type="email" class="form-control" placeholder="Email" value="{{tmp._email}}" required />
                            <div id="email--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                    
                    <style>
                        .iti {
                            width: 100%;
                        }
                    </style>
                    <div class="col-md-4 col-lg-4">
                        <div class="mb-3">
                            <label class="form-label">Mobile Phone</label>
                            <!--<input name="mobile_phone" type="text" class="form-control" placeholder="Digite seu celular" data-inputmask="'mask': '(99) 99999-9999'" inputmode="numeric" autocomplete="off" value="{{system.userdatap._mobile_phone}}" required />
                            <div id="mobile_phone--invalid-feedback" class="invalid-feedback"></div>-->
                            <input id="mobile_phone2" name="mobile_phone2" type="tel" class="form-control" inputmode="numeric" autocomplete="off" onkeyup="setInputMask(this);" value="{{tmp._mobile_phone}}" required />
                            <div id="mobile_phone2--invalid-feedback" class="invalid-feedback" style="display: none;"></div>
                        </div>
                    </div>
                    
                    <script>
                        if (typeof phoneInputField2 == "object") {
                            phoneInputField2 = document.querySelector("#mobile_phone2");
                            phoneInput = window.intlTelInput(phoneInputField2, {
                                initialCountry: "{{tmp._country_iso2}}",
                                preferredCountries: ["br", "us", "co", "in", "de"],
                                utilsScript:
                                    "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
                            });
                        } else {
                            var phoneInputField2 = document.querySelector("#mobile_phone2");
                            var phoneInput = window.intlTelInput(phoneInputField2, {
                                initialCountry: "{{tmp._country_iso2}}",
                                preferredCountries: ["br", "us", "co", "in", "de"],
                                utilsScript:
                                    "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
                            });
                        }
                        
                        /** **/
                        function setInputMask(el) {
                            var str = el.placeholder;
                            str = str.replace(/0/g, "9");
                            str = str.replace(/1/g, "9");
                            str = str.replace(/2/g, "9");
                            str = str.replace(/3/g, "9");
                            str = str.replace(/4/g, "9");
                            str = str.replace(/5/g, "9");
                            str = str.replace(/6/g, "9");
                            str = str.replace(/7/g, "9");
                            str = str.replace(/8/g, "9");
                            
                            var im = new Inputmask(str);
                            im.mask(el);
                        }
                     </script>
                </div>
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                        <div class="mb-3">
                            <label class="form-label">Wallet crypto</label>
                            <input name="coinbase_email" type="email" class="form-control" placeholder="Wallet crypto" value="{{system.userdata._coinbase_email}}" />
                            <div id="coinbase_email--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div>
                            <label class="form-label">About me</label>
                            <textarea name="about_me" class="form-control" rows="6" placeholder="About me">{{tmp._about_me}}</textarea>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <a href="javascript:;" onclick="formAccountProfileEdit__Save();" class="btn btn-primary ms-auto">
                <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-check" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                   <path d="M5 12l5 5l10 -10"></path>
                </svg>
                Save
            </a>
            <a href="#" class="btn" data-bs-dismiss="modal">
                Close
            </a>
        </div>
    </div>
</div>

<script>
    var formAccountProfileEdit = document.getElementById('formAccountProfileEdit');
    formAccountProfileEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formAccountProfileEdit__Save();
    }
    
    function formAccountProfileEdit__Save() {
        document.querySelector('#formAccountProfileEdit input[name="birthdate"]').value = FormatStringDate(document.getElementById('birthdate').value);
        
        //Controller.accountsUpdate('formAccountProfileEdit');
        
        const phoneNumber = phoneInput.getNumber();
        var countryData = phoneInput.getSelectedCountryData();
        
        /** **/
        //const phoneInputField = document.querySelector("#mobile_phone");
        var phone_mask = phoneInputField2.placeholder;
        phone_mask = phone_mask.replace(/0/g, "9");
        phone_mask = phone_mask.replace(/1/g, "9");
        phone_mask = phone_mask.replace(/2/g, "9");
        phone_mask = phone_mask.replace(/3/g, "9");
        phone_mask = phone_mask.replace(/4/g, "9");
        phone_mask = phone_mask.replace(/5/g, "9");
        phone_mask = phone_mask.replace(/6/g, "9");
        phone_mask = phone_mask.replace(/7/g, "9");
        phone_mask = phone_mask.replace(/8/g, "9");
        /** **/
        
        document.querySelector('#formAccountProfileEdit input[name="mobile_phone"]').value = phoneNumber;
        document.querySelector('#formAccountProfileEdit input[name="country_dial_code"]').value = countryData.dialCode;
        document.querySelector('#formAccountProfileEdit input[name="country_phone_mask"]').value = phone_mask;
        document.querySelector('#formAccountProfileEdit input[name="country_iso2"]').value = countryData.iso2;
        document.querySelector('#formAccountProfileEdit input[name="country_name"]').value = countryData.name;
        
        
        var jsonData = JSON.parse(formToJSONString('formAccountProfileEdit'));
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/{{tmp._id}}",
            data: jsonData,
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    //fgUpdateUserData();
                    fc__customersGetAll();
                    dialogClose();
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                App.alert('Error', 'An unexpected error occurred while requesting information.', null);
            }
        });
    }
    
    /*function formAccountProfileAlter(){
        //validate fields
        var fail = false;
        $('#formAccountProfileEdit').find("select, textarea, input").each(function(){
            if (!$(this).prop("required")) {
                //
            } else {
                if (!$(this).val()) {
                    fail = true;
                    name = $(this).attr('name');
                }

            }
        });

        //submit if fail never got set to true
        if (!fail) {
            //process form here.
            Controller.saveAccountProfile('formAccountProfileEdit');
        } else {
            View.showNotification('Por favor, preencha os campos obrigatórios.', 'danger');
        }
    }*/
    
    function setPersonType(personType) {
        switch(personType){
            case 'natural_person':
                document.getElementById('person_type_1').style.display = 'none';
                document.getElementById('person_type_2').style.display = 'block';
            break;
            case 'legal_person':
                document.getElementById('person_type_1').style.display = 'block';
                document.getElementById('person_type_2').style.display = 'none';
            break;
            case 'foreign_person':
                document.getElementById('person_type_1').style.display = 'none';
                document.getElementById('person_type_2').style.display = 'none';
            break;
        }
        
        formAccountProfileEdit.name.focus();
    }
    
    setTimeout(function(){
        document.querySelector('#formAccountProfileEdit input[name="name"]').focus();
    }, 500);
</script>
