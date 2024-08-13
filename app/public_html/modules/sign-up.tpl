<style>
    html,
    body {
        overflow: hidden;
    }

    .inputpasswordusernameloginup2 {
        padding: 15px;
        width: 362px;
        height: 51px;
        outline: none;
        background-color: #181818;
        border: #FFFFFF05 1px solid;
        border-radius: 7px;
        margin-bottom: 10px;
        color: #fff;
        font-size: 14px;
    }

    .flex-direction {
        display: flex;
        flex-direction: column;
    }

    .text-stepunotwo {
     font-size: 12px;
     font-weight: 200;
    }

    .text-centeralign {
        display: none;
    }

    @media only screen and (max-width: 1030px) {
    .card-rightuplogin {
      display: none;
    }

    .text-centeralign {
        max-width: 300px;
        font-size: 40px !important;
        margin-bottom: 35px;
        display: block;
    }

    @media only screen and (max-width: 371px) {
      .inputpasswordusernameloginup {
        width: 300px;
      }
      .inputpasswordusernameloginup2 {
        width: 300px;
      }
      .buttonpasswordusernameloginup {
        width: 300px;
      }
      .buttonpasswordusernameloginupnext {
        width: 300px;
      }
       .buttonpasswordusernameloginupback {
        width: 300px;
      }
      .text-centeralign {
       max-width: 300px;
       font-size: 40px !important;
       margin-bottom: 30px;
       display: block;
      }
    }
</style>

<div class="divgerallingup">
    <div class="card-leftuplogin">
        <form id="frmLogin" name="frmLogin" class="card-md" autocomplete="off">
            <div class="card-body">
                <form id="frmRegister" name="frmRegister" class="card card-md">
                    <div class="card-body">

                        <!-- Step 1 -->
                        <div id="step1">
                          <h1 class="text-stepunotwo">STEP 1</h1>
                            <h1 class="text-centeralign">Enter your <font style="color: #26C57E;">personal</font> data</h1>
                            <div class="mb-3">
                                <span class="labelloginuptextcolor">Sponsor:</span>
                                <div id="dataIndicator" style="margin-top: 12px; margin-bottom: 28px; height: auto; max-width: 362px; max-height: 260px; background: #15593B; padding: 8px; font-size: 14px; border-radius: 4px;">
                                    Checking your referral...
                                </div>
                                <input name="sponsor" type="hidden" value="">
                            </div>

                            <section id="register" class="disabled">
                                <div class="mb-3" style="display: none;">
                                    <div class="labelloginuptextcolor">Type</div>
                                    <div>
                                        <label class="labelforloginup">
                                            <input name="person_type" class="inputpasswordusernameloginup" type="radio" value="natural_person" onchange="setPersonType('natural_person')" />
                                            <span class="labelloginuptextcolor">Natural person</span>
                                        </label>
                                        <label class="labelforloginup">
                                            <input name="person_type" class="inputpasswordusernameloginup" type="radio" value="legal_person" onchange="setPersonType('legal_person')" />
                                            <span class="labelloginuptextcolor">Legal person</span>
                                        </label>
                                        <label class="labelforloginup">
                                            <input name="person_type" class="inputpasswordusernameloginup" type="radio" value="foreign_person" onchange="setPersonType('foreign_person')" checked="" />
                                            <span class="labelloginuptextcolor">Foreign person</span>
                                        </label>
                                    </div>
                                </div>

                                <div class="flex-direction">
                                    <label class="labelloginuptextcolor">Name</label>
                                    <input name="name" type="text" class="inputpasswordusernameloginup" placeholder="Full name" required="" />
                                    <div id="name--invalid-feedback" class="invalid-feedback"></div>
                                </div>

                                <div class="flex-direction">
                                    <label class="labelloginuptextcolor">Birthdate</label>
                                    <input name="birthdate" type="text" class="inputpasswordusernameloginup" placeholder="00/00/0000" inputmode="numeric" data-inputmask="'alias': 'datetime', 'inputFormat': 'dd/mm/yyyy', 'outputFormat': 'ddmmyyyy'" autocomplete="off">
                                </div>

                                <div>
                                        <div class="labelloginuptextcolor">Sex</div>
                                        <select name="sex" class="inputpasswordusernameloginup2">
                                            <option value="">- Select -</option>
                                            <option value="masc">Male</option>
                                            <option value="fem">Female</option>
                                            <option value="other">Other</option>
                                        </select>
                                    </div>

                                <!-- Section for CNPJ -->
                                <section id="person_type_1" style="display: none;">
                                    <div>
                                        <label class="labelloginuptextcolor">CNPJ</label>
                                        <input name="cnpj" type="text" class="inputpasswordusernameloginup" placeholder="CNPJ" data-inputmask="'mask': '99.999.999/9999-99'" onblur="frmRegisterCheckCNPJ()" inputmode="numeric" autocomplete="off" />
                                        <div id="cnpj--invalid-feedback" class="invalid-feedback"></div>
                                    </div>
                                </section>

                                <!-- Section for CPF and other personal details -->
                                <section id="person_type_2" style="display: none;">
                                    <div>
                                        <label class="labelloginuptextcolor">CPF</label>
                                        <input name="cpf" type="text" class="inputpasswordusernameloginup" placeholder="CPF" data-inputmask="'mask': '999.999.999-99'" onblur="frmRegisterCheckCPF()" inputmode="numeric" autocomplete="off" />
                                        <div id="cpf--invalid-feedback" class="invalid-feedback"></div>
                                    </div>

                                </section>

                                <div>
                                    <label class="labelloginuptextcolor">Mobile phone</label>
                                    <input id="mobile_phone" name="mobile_phone" type="tel" class="inputpasswordusernameloginup" inputmode="numeric" autocomplete="off" onkeyup="setInputMask(this);" required />
                                    <div id="mobile_phone--invalid-feedback" class="invalid-feedback" style="display: none;"></div>
                                </div>

                                <button type="button" class="buttonpasswordusernameloginup" onclick="nextStep(2)">Next</button>
                            </section>
                        </div>

                        <!-- Step 2 -->
                        <div id="step2" style="display: none;">
                         <h1 class="text-stepunotwo">STEP 2</h1>
                          <h1 class="text-centeralign">Now enter data for <font style="color: #26C57E;">your access</font></h1>
                            <div class="flex-direction">
                                <label class="labelloginuptextcolor flex-direction">Email</label>
                                <input name="email" type="email" class="inputpasswordusernameloginup" placeholder="Email" onblur="frmRegisterCheckEmail(this.value);" required />
                                <div id="email--invalid-feedback" class="invalid-feedback"></div>
                            </div>

                            <style>
                                .iti {
                                    width: 100%;
                                }
                            </style>

                            <script>
                                const phoneInputField = document.querySelector("#mobile_phone");
                                const phoneInput = window.intlTelInput(phoneInputField, {
                                    preferredCountries: ["us", "br", "co", "in", "de"],
                                    utilsScript: "https://cdnjs.cloudflare.com/ajax/libs/intl-tel-input/17.0.8/js/utils.js",
                                });

                                function setInputMask(el) {
                                    var str = el.placeholder.replace(/0|1|2|3|4|5|6|7|8/g, "9");
                                    var im = new Inputmask(str);
                                    im.mask(el);
                                }
                            </script>

                            <div class="flex-direction">
                                <label class="labelloginuptextcolor">Username</label>
                                <input name="username" type="text" class="inputpasswordusernameloginup" placeholder="Username" minlength="6" maxlength="40" pattern="[a-zA-Z0-9._]+" autocomplete="off" onblur="frmRegisterCheckUsername(this.value);" onkeypress="return ApenasLetras(event,this);" required />
                                <div id="username--invalid-feedback" class="invalid-feedback"></div>
                            </div>

                            <div class="flex-direction">
                                <label class="labelloginuptextcolor">Password</label>
                                <input name="password" type="password" class="inputpasswordusernameloginup" placeholder="Password" minlength="6" maxlength="40" autocomplete="off" required />
                                <div id="password--invalid-feedback" class="invalid-feedback"></div>
                            </div>

                            <div class="mb-3 flex-direction">
                                <label class="labelloginuptextcolor">Confirm password</label>
                                <input name="password_confirm" type="password" class="inputpasswordusernameloginup" placeholder="Confirm password" minlength="6" maxlength="40" autocomplete="off" required />
                                <div id="password_confirm--invalid-feedback" class="invalid-feedback"></div>
                            </div>

                            <div class=" ">
                                <label class="form-check">
                                    <input id="basic_checkbox_1" type="checkbox" class="form-check-input" onchange="activeNewRegister(this);" />
                                    <span class="labelloginuptextcolor">I agree with <a href="" tabindex="-1" target="_blank">terms and policy</a>.</span>
                                </label>
                            </div>

                            <div class="form-footer flex-direction">
                                <div id="msg"></div>
                                <button id="newRegister" type="submit" class="buttonpasswordusernameloginupnext" disabled="">Create account</button>
                                <button type="button" class="buttonpasswordusernameloginupback" onclick="prevStep(1)">Back</button>
                            </div>
                        </div>
                    </div>
                </form>

                <style>
                    a.gflag {
                        margin: 4px;
                        display: none;
                    }
                </style>
            </div>
        </form>
    </div>
        <div class="card-rightuplogin">
        <h1 class="h1-textwelcomeloginup">Enter your <font style="color: #26C57E;">personal</font><br>data</h1>
        <img class="image-rightuplogin" src="/assets/img/grid.svg" alt="" srcset="">
        <svg class="svg-imagewelcomeloginup" width="1159" height="799" viewBox="0 0 1159 799" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path opacity="0.2" d="M-679.064 259.956C-782.649 371.698 -977.262 457.612 -1061.62 486.602V875.582H2093V96.56C1616.28 96.56 1610.39 765.956 1339.66 765.956C1068.93 765.956 1057.15 386.456 921.788 386.456C786.422 386.456 821.735 592.019 509.804 568.3C197.873 544.581 44.8505 310.029 -143.485 96.56C-330.807 -115.759 -547.24 117.738 -676.965 257.691L-679.064 259.956Z" fill="#26C57E"/>
            <path opacity="0.2" d="M-595.808 557.353C-694.653 471.796 -950.786 412.15 -1066.5 393.022V875.582H2093V768.636C1669.38 768.636 1357.55 366.937 1316.36 304.335C1275.18 241.733 1181.04 111.311 922.162 111.311C663.284 111.311 445.59 372.154 192.595 526.052C-60.3999 679.949 -178.072 674.733 -260.443 674.733C-342.813 674.733 -472.252 664.299 -595.808 557.353Z" fill="#009452"/>
            <ellipse cx="106.332" cy="383.367" rx="17.2727" ry="19.0561" fill="#26C57E"/>
            <ellipse cx="511.02" cy="573.117" rx="17.2727" ry="19.0561" fill="#26C57E"/>
            <ellipse cx="910.833" cy="388.638" rx="17.2727" ry="19.0561" fill="#26C57E"/>
        </svg>
    </div>
</div>


    <script>

        function nextStep(step) {
            document.getElementById('step1').style.display = 'none';
            document.getElementById('step2').style.display = 'block';
        }

        function prevStep(step) {
            document.getElementById('step2').style.display = 'none';
            document.getElementById('step1').style.display = 'block';
        }

        var qs = urlQueryObj();
        var frmRegister = document.getElementById('frmRegister');

        var url = window.location.href;
        var absoluto = url.split("/")[url.split("/").length - 1];

        var elDataIndicator = document.getElementById("dataIndicator");
        if (url == "{{settings.__app_url}}/create-account/" + absoluto && absoluto != "" && absoluto != "create-account") {
            checkSponsorAccount(absoluto);
        } else {
            elDataIndicator.innerHTML = "Your indicator was not informed.<br />Please contact us and request a link to register.";

            frmRegister.querySelector("input[name='binary_key']").value = 'right';
        }

        function checkSponsorAccount(username) {
            if ((username == "") || (username.length < 4)) {
                elDataIndicator.innerHTML = '<b>- Undefined indicator -</b>';
                return;
            }

            $.ajax({
                type: "POST",
                url: CFG__API_URL + CFG__API_VERSION + "/accounts/check-indicator",
                data: {
                    username: username
                },
                success: function (response) {
                    if (response.data != null) {
                        frmRegister.querySelector("input[name='sponsor']").value = response.data._username;

                        frmRegister.querySelector("input[name='binary_key']").value = response.data._binary_key;

                        var _info = '',
                            _social = '';

                        if (!!response.data._name) {
                            _info += '<b>' + response.data._name + '</b><br />';
                        }

                        if (!!response.data._username) {
                            _info += response.data._username + '<br />';
                        }

                        if (!!response.data._mobile_phone) {
                            _info += formatMobilePhone(response.data._mobile_phone, response.data._country_phone_mask) + '<br />'; ///_maskMobile_phone)+
                        }

                        if (!!response.data._email) {
                            _info += response.data._email + '<br />';
                        }


                        elDataIndicator.innerHTML =
                            '<div style="width: 100%;display: block;position: relative;height: 60px;">'
                            + '    <div style="width: 60px;display: block;position: absolute;height: 60px;">'
                            + '        <img src="../assets/img/picker_account.png" style="height: 40px;width: 40px;border-radius: 50%;display: block;margin: 0 auto;padding: 0;margin-top: 6px;">'
                            + '    </div>'
                            + '    <div style="width: calc(100% - 60px);display: block;position: absolute;height: 60px;left: 60px;padding: 4px;">'
                            + _info
                            + '    </div>'
                            + '</div>';

                        document.getElementById("register").classList.remove("disabled");
                        frmRegister.name.focus();
                    } else {
                        alert('Sponsor not found or not available.');

                        var fullName = document.getElementsByClassName('dataProfileFullName');
                        for (var i = 0; i < fullName.length; i++) {
                            fullName[i].innerHTML = '<b>- undefined -</b>';
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    var jsonResponse = JSON.parse(XMLHttpRequest.responseText);

                    console.log(error);

                    elDataIndicator.innerHTML = "It was not possible to search for your sponsor.<br />Please wait a while and try again.";
                }
            });
        }


        function setPersonType(personType) {
            switch (personType) {
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

            frmRegister.name.focus();
        }

        function activeNewRegister(el) {
            if (el.checked == true) {
                document.getElementById('newRegister').disabled = false;
            } else {
                document.getElementById('newRegister').disabled = true;
            }
        }


        var frm_accountCreate = document.getElementById('frmRegister');

        function frmRegisterCheckCPF() {
            var elCpf = frm_accountCreate.querySelector("input[name='cpf']");

            document.querySelectorAll('.is-invalid').forEach(elem => {
                elem.classList.remove("is-invalid");
            });

            if (elCpf.value.length > 0) {
                $.ajax({
                    type: "POST",
                    url: CFG__API_URL + CFG__API_VERSION + "/accounts/check-cpf-available",
                    data: {
                        cpf: elCpf.value
                    },
                    success: function (response) {
                        if (response.success == false) {
                            elCpf.classList.add("is-invalid");
                            document.getElementById("cpf--invalid-feedback").innerHTML = response.message;
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        var jsonResponse = JSON.parse(XMLHttpRequest.responseText);

                        console.log(error);

                        elCpf.classList.add("is-invalid");
                        document.getElementById("cpf--invalid-feedback").innerHTML = jsonResponse.message;
                    }
                });
            } else {
                elCpf.classList.add("is-invalid");
                document.getElementById("cpf--invalid-feedback").innerHTML = 'CPF must be informed!';
            }
        }

        function frmRegisterCheckCNPJ() {
            var elCnpj = frm_accountCreate.querySelector("input[name='cnpj']");

            document.querySelectorAll('.is-invalid').forEach(elem => {
                elem.classList.remove("is-invalid");
            });

            if (elCnpj.value.length > 0) {
                $.ajax({
                    type: "POST",
                    url: CFG__API_URL + CFG__API_VERSION + "/accounts/check-cnpj-available",
                    data: {
                        cnpj: elCnpj.value
                    },
                    success: function (response) {
                        if (response.success == false) {
                            elCnpj.classList.add("is-invalid");
                            document.getElementById("cnpj--invalid-feedback").innerHTML = response.message;
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        var jsonResponse = JSON.parse(XMLHttpRequest.responseText);

                        console.log(error);

                        elCnpj.classList.add("is-invalid");
                        document.getElementById("cnpj--invalid-feedback").innerHTML = jsonResponse.message;
                    }
                });
            } else {
                elCnpj.classList.add("is-invalid");
                document.getElementById("cnpj--invalid-feedback").innerHTML = 'CNPJ must be informed!';
            }
        }

        function frmRegisterCheckUsername() {
            var elUsername = document.querySelector("#frmRegister input[name='username']");

            elUsername.classList.remove("is-invalid");

            var usernameOK = validateUsername(elUsername.value);
            if (usernameOK == false) {
                elUsername.classList.add("is-invalid");
                document.getElementById("username--invalid-feedback").innerHTML = 'The username can only contain letter, number, dash (_) and period (.).!';

                elUsername.focus();
                return false;
            }

            if (elUsername.value.length >= 4) {
                $.ajax({
                    type: "POST",
                    url: CFG__API_URL + CFG__API_VERSION + "/accounts/check-username-available",
                    data: {
                        username: elUsername.value
                    },
                    success: function (response) {

                        document.querySelectorAll('.is-invalid').forEach(elem => {
                            elem.classList.remove("is-invalid");
                        });

                        if (response.is_available == true) {
                            return true;
                        } else {
                            elUsername.classList.add("is-invalid");
                            document.getElementById("username--invalid-feedback").innerHTML = 'The entered username is already in use. Use another username!';

                            elUsername.focus();
                            return false;
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        var jsonResponse = JSON.parse(XMLHttpRequest.responseText);

                        console.log(error);

                        elUsername.classList.add("is-invalid");
                        document.getElementById("username--invalid-feedback").innerHTML = 'Could not verify username, please try again!';
                        return false;
                    }
                });
            } else {
                elUsername.classList.add("is-invalid");
                document.getElementById("username--invalid-feedback").innerHTML = 'The username must contain at least 4 digits!';
            }
        }

        function frmRegisterCheckEmail() {
            var elEmail = document.querySelector("#frmRegister input[name='email']");

            elEmail.classList.remove("is-invalid");

            if (elEmail.value.length >= 1) {
                $.ajax({
                    type: "POST",
                    url: CFG__API_URL + CFG__API_VERSION + "/accounts/check-email-available",
                    data: {
                        email: elEmail.value
                    },
                    success: function (response) {

                        document.querySelectorAll('.is-invalid').forEach(elem => {
                            elem.classList.remove("is-invalid");
                        });

                        if (response.is_available == true) {
                            return true;
                        } else {
                            elEmail.classList.add("is-invalid");
                            document.getElementById("email--invalid-feedback").innerHTML = 'The email provided is already in use!';

                            elEmail.focus();
                            return false;
                        }

                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        var jsonResponse = JSON.parse(XMLHttpRequest.responseText);

                        console.log(error);

                        elEmail.classList.add("is-invalid");
                        document.getElementById("email--invalid-feedback").innerHTML = 'Could not verify email, please try again!';
                        return false;
                    }
                });
            } else {
                elEmail.classList.add("is-invalid");
                document.getElementById("email--invalid-feedback").innerHTML = 'Please provide a valid email!';
            }
        }

        function frmRegisterCheckPassword() {
            var elPassword = document.querySelector("#frmRegister input[name='password']");
            var elPassword_confirm = document.querySelector("#frmRegister input[name='password_confirm']");

            if ((elPassword.value != "") && (elPassword.value.length >= 6)) {
                if (elPassword.value != elPassword_confirm.value) {
                    elPassword_confirm.classList.add("is-invalid");
                    document.getElementById("password_confirm--invalid-feedback").innerHTML = 'Passwords do not match!';

                    elPassword_confirm.focus();
                    return false;
                } else {
                    return true;
                }
            } else {
                elPassword_confirm.classList.add("is-invalid");
                document.getElementById("password_confirm--invalid-feedback").innerHTML = 'The password must be longer than 6 digits.';

                elPassword.focus();
                return false;
            }
        }

        frmRegister.onsubmit = function (e) {
            e.preventDefault();

            document.querySelectorAll('.is-invalid').forEach(elem => {
                elem.classList.remove("is-invalid");
            });

            var elPerson_type = document.querySelector("#frmRegister input[name='person_type']");
            var personType = 'foreign_person';

            var elSponsor = document.querySelector("#frmRegister input[name='sponsor']");
            var elName = document.querySelector("#frmRegister input[name='name']");
            var elSex = document.querySelector("#frmRegister select[name='sex']");
            var elBirthdate = document.querySelector("#frmRegister input[name='birthdate']");
            var elCPF = document.querySelector("#frmRegister input[name='cpf']");
            var elCNPJ = document.querySelector("#frmRegister input[name='cnpj']");
            var elMobile_phone = document.querySelector("#frmRegister input[name='mobile_phone']");
            var elEmail = document.querySelector("#frmRegister input[name='email']");
            var elUsername = document.querySelector("#frmRegister input[name='username']");
            var elPassword = document.querySelector("#frmRegister input[name='password']");

            if (elName.value == "") {
                elName.classList.add("is-invalid");
                document.getElementById("password--invalid-feedback").innerHTML = 'The name is mandatory!';

                elName.focus();
                return;
            }
            if (elEmail.value == "") {
                elEmail.classList.add("is-invalid");
                document.getElementById("password--invalid-feedback").innerHTML = 'The email is mandatory!';

                elEmail.focus();
                return;
            }

            const phoneNumber = phoneInput.getNumber();
            var countryData = phoneInput.getSelectedCountryData();

            if (phoneNumber == "") {
                elMobile_phone.classList.add("is-invalid");
                document.getElementById("password--invalid-feedback").innerHTML = 'The phone is mandatory!';

                elMobile_phone.focus();
                return;
            }
            if (elUsername.value == "") {
                elUsername.classList.add("is-invalid");
                document.getElementById("password--invalid-feedback").innerHTML = 'The username is mandatory!';

                elUsername.focus();
                return;
            }

            if (personType == "natural_person") {
                if (elCPF.value == "") {
                    elCPF.classList.add("is-invalid");
                    document.getElementById("password--invalid-feedback").innerHTML = 'The CPF is mandatory!';

                    elCPF.focus();
                    return;
                }

            } else if (personType == "legal_person") {
                if (elCNPJ.value == "") {
                    elCNPJ.classList.add("is-invalid");
                    document.getElementById("password--invalid-feedback").innerHTML = 'The CNPJ is mandatory!';

                    elCNPJ.focus();
                    return;
                }

            } else if (personType == "foreign_person") {
            }

            if (!frmRegisterCheckPassword()) {
                return;
            }

            const phoneInputField = document.querySelector("#mobile_phone");
            var phone_mask = phoneInputField.placeholder;
            phone_mask = phone_mask.replace(/0/g, "9");
            phone_mask = phone_mask.replace(/1/g, "9");
            phone_mask = phone_mask.replace(/2/g, "9");
            phone_mask = phone_mask.replace(/3/g, "9");
            phone_mask = phone_mask.replace(/4/g, "9");
            phone_mask = phone_mask.replace(/5/g, "9");
            phone_mask = phone_mask.replace(/6/g, "9");
            phone_mask = phone_mask.replace(/7/g, "9");
            phone_mask = phone_mask.replace(/8/g, "9");

            document.getElementById("newRegister").disabled = true;

            $.ajax({
                type: "POST",
                url: CFG__API_URL + CFG__API_VERSION + "/accounts",
                data: {
                    type: personType,
                    name: elName.value,
                    sex: elSex.value,
                    birthdate: FormatStringDate(elBirthdate.value),
                    cpf: elCPF.value,
                    cnpj: elCNPJ.value,
                    mobile_phone: phoneNumber,
                    email: elEmail.value,
                    username: elUsername.value,
                    password: elPassword.value,
                    sponsor: elSponsor.value,
                    country_dial_code: countryData.dialCode,
                    country_phone_mask: phone_mask,
                    country_iso2: countryData.iso2,
                    country_name: countryData.name
                    //indicator: elStore_sponsor.value
                },
                success: function (response) {

                    document.querySelectorAll('.alert').forEach(elem => {
                        elem.remove();
                    });

                    if (response.data) {
                        $.ajax({
                            type: "POST",
                            url: CFG__API_URL + CFG__API_VERSION + "/auth",
                            data: {
                                username: elUsername.value,
                                password: elPassword.value
                            },
                            success: function (response_login) {


                                if (response_login.data.role == "user") {
                                    var decoded = jwt_decode(response.data.token);
                                    cookieSetJwt('__utmo', response_login.data.token, decoded.exp, CFG__COOKIE_DOMAIN);

                                    window.location.replace(_appData.settings.__app_url);
                                }

                                frm_accountCreate.querySelectorAll('button').forEach(elem => {
                                    elem.removeAttribute('disabled');
                                });

                                hideElementPreloader();
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);

                                console.log(error)

                                frm_accountCreate.querySelectorAll('button').forEach(elem => {
                                    elem.removeAttribute('disabled');
                                });

                                var newItem = document.createElement("div");
                                newItem.className = 'alert alert-danger alert-dismissible';

                                var newItem_button = document.createElement("button");
                                newItem_button.className = 'close';
                                newItem_button.setAttribute("data-dismiss", 'alert');
                                newItem_button.setAttribute("aria-label", 'Close');
                                newItem_button.setAttribute("onclick", 'this.parentElement.remove();');

                                var newItem_button_span = document.createElement("span");
                                newItem_button_span.ariaHidden = 'true';
                                newItem_button_span.innerHTML = '&times';

                                var newItem_content = document.createElement("div");
                                newItem_content.className = 'content';
                                newItem_content.innerHTML = error.message;

                                newItem_button.appendChild(newItem_button_span);
                                newItem.appendChild(newItem_button);
                                newItem.appendChild(newItem_content);

                                frm_accountCreate.insertAdjacentElement('beforeBegin', newItem);

                                hideElementPreloader();
                            }
                        });
                    } else {
                        frm_accountCreate.querySelector("#msg").insertAdjacentHTML('beforeBegin',
                            '<div class="alert alert-danger alert-dismissible" role="alert">'
                            + '    <div class="d-flex">'
                            + '        <div>'
                            + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '                <circle cx="12" cy="12" r="9"></circle>'
                            + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                            + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                            + '            </svg>'
                            + '        </div>'
                            + '        <div>'
                            + '            <h4 class="alert-title">Sorry...</h4>'
                            + '            <div class="text-muted">Error creating your login account.</div>'
                            + '        </div>'
                            + '    </div>'
                            + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                            + '</div>'
                        );

                        document.getElementById("newRegister").disabled = true;
                    }

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    var jsonResponse = JSON.parse(XMLHttpRequest.responseText);

                    console.log(error);

                    frm_accountCreate.querySelector("#msg").insertAdjacentHTML('beforeBegin',
                        '<div class="alert alert-danger alert-dismissible" role="alert">'
                        + '    <div class="d-flex">'
                        + '        <div>'
                        + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                        + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                        + '                <circle cx="12" cy="12" r="9"></circle>'
                        + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                        + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                        + '            </svg>'
                        + '        </div>'
                        + '        <div>'
                        + '            <h4 class="alert-title">Sorry...</h4>'
                        + '            <div class="text-muted">' + error.message + '</div>'
                        + '        </div>'
                        + '    </div>'
                        + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                        + '</div>'
                    );

                    document.getElementById("newRegister").disabled = true;

                    elUsername.focus();
                    return false;
                }
            });
        }

        function validaCpfCnpj(val) {
            if (val.length == 14) {
                var cpf = val.trim();

                cpf = cpf.replace(/\./g, '');
                cpf = cpf.replace('-', '');
                cpf = cpf.split('');

                var v1 = 0;
                var v2 = 0;
                var aux = false;

                for (var i = 1; cpf.length > i; i++) {
                    if (cpf[i - 1] != cpf[i]) {
                        aux = true;
                    }
                }

                if (aux == false) {
                    return false;
                }

                for (var i = 0, p = 10; (cpf.length - 2) > i; i++, p--) {
                    v1 += cpf[i] * p;
                }

                v1 = ((v1 * 10) % 11);

                if (v1 == 10) {
                    v1 = 0;
                }

                if (v1 != cpf[9]) {
                    return false;
                }

                for (var i = 0, p = 11; (cpf.length - 1) > i; i++, p--) {
                    v2 += cpf[i] * p;
                }

                v2 = ((v2 * 10) % 11);

                if (v2 == 10) {
                    v2 = 0;
                }

                if (v2 != cpf[10]) {
                    return false;
                } else {
                    return true;
                }
            } else if (val.length == 18) {
                var cnpj = val.trim();

                cnpj = cnpj.replace(/\./g, '');
                cnpj = cnpj.replace('-', '');
                cnpj = cnpj.replace('/', '');
                cnpj = cnpj.split('');

                var v1 = 0;
                var v2 = 0;
                var aux = false;

                for (var i = 1; cnpj.length > i; i++) {
                    if (cnpj[i - 1] != cnpj[i]) {
                        aux = true;
                    }
                }

                if (aux == false) {
                    return false;
                }

                for (var i = 0, p1 = 5, p2 = 13; (cnpj.length - 2) > i; i++, p1--, p2--) {
                    if (p1 >= 2) {
                        v1 += cnpj[i] * p1;
                    } else {
                        v1 += cnpj[i] * p2;
                    }
                }

                v1 = (v1 % 11);

                if (v1 < 2) {
                    v1 = 0;
                } else {
                    v1 = (11 - v1);
                }

                if (v1 != cnpj[12]) {
                    return false;
                }

                for (var i = 0, p1 = 6, p2 = 14; (cnpj.length - 1) > i; i++, p1--, p2--) {
                    if (p1 >= 2) {
                        v2 += cnpj[i] * p1;
                    } else {
                        v2 += cnpj[i] * p2;
                    }
                }

                v2 = (v2 % 11);

                if (v2 < 2) {
                    v2 = 0;
                } else {
                    v2 = (11 - v2);
                }

                if (v2 != cnpj[13]) {
                    return false;
                } else {
                    return true;
                }
            } else {
                return false;
            }
        }

        function ApenasLetras(e, t) {
            try {
                if (window.event) {
                    var charCode = window.event.keyCode;
                } else if (e) {
                    var charCode = e.which;
                } else {
                    return true;
                }
                if (
                    (charCode == 46) ||
                    (charCode == 95) ||
                    (charCode >= 48 && charCode <= 57) ||
                    (charCode > 64 && charCode < 91) ||
                    (charCode > 96 && charCode < 123)
                ) {
                    return true;
                } else {
                    return false;
                }
            } catch (err) {
                alert(err.Description);
            }
        }

        function validateUsername(str) {
            var nameRegex = /^[a-zA-Z0-9._]+$/;
            var validUsername = str.match(nameRegex);
            if (validUsername != null) {
                return true;
            }

            return false;
        }


        function showElementPreloader() {
            var elemDivHolder = document.createElement('div');
            elemDivHolder.className = 'holder';
            elemDivHolder.style.cssText = 'position: absolute; left: 0px; top: 0px; bottom: 0px; right: 0px; width: 100%; height: 100%; background-color: #ffffff; z-index: 9999; opacity: 0.9;';
            var elemDivPreloaderImg = document.createElement('img');
            elemDivPreloaderImg.className = 'preloader';
            elemDivPreloaderImg.style.cssText = 'display: block; width: 60px; height: 60px; margin: auto; position: absolute; top: 0; left: 0; bottom: 0; right: 0;';
            elemDivPreloaderImg.src = '../assets/img/loading.gif';

            elemDivHolder.appendChild(elemDivPreloaderImg);
            window.document.body.insertBefore(elemDivHolder, window.document.body.firstChild);
        }

        function hideElementPreloader() {
            setTimeout(function () {
                document.querySelectorAll('.holder').forEach(function (a) {
                    a.remove()
                });
            }, 250);
        }


        document.querySelectorAll("input[name='name']").focus();
    </script>