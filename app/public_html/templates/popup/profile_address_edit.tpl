<div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title">My address</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form class="form-default" id="formAccountProfileAddressEdit" name="formAccountProfileAddressEdit" method="post" action="" role="form">
            <div class="modal-body">
                <div class="row">
                    <div class="mb-3">
                        <label class="form-label">Postal Code</label>
                        <input name="postal_code" type="text" class="form-control" placeholder="Digite seu CEP" value="{{system.userdata._address_postal_code}}" style="max-width: 180px;" data-inputmask="'mask': '99.999-999'" onblur="loadPostalCode();" inputmode="numeric" autocomplete="off" />
                        <small class="form-hint">Enter your zip code so we can get the data.</small>
                        <div id="postal_code--invalid-feedback" class="invalid-feedback"></div>
                    </div>
                </div>
                
                <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 12px 5%;">
                
                <div class="row">
                    <div class="col-lg-4">
                        <div class="mb-3">
                            <label class="form-label">Estate</label>
                            <select id="formAccountProfileAddressEdit-state" name="state" class="form-select">
                                {{#selected system.userdata._address_state}}
                                    <option value="--">- Select -</option>
                                    <option value="AC">Acre</option>
                                    <option value="AL">Alagoas</option>
                                    <option value="AP">Amapá</option>
                                    <option value="AM">Amazonas</option>
                                    <option value="BA">Bahia</option>
                                    <option value="CE">Ceará</option>
                                    <option value="DF">Distrito Federal</option>
                                    <option value="ES">Espirito Santo</option>
                                    <option value="GO">Goiás</option>
                                    <option value="MA">Maranhão</option>
                                    <option value="MS">Mato Grosso do Sul</option>
                                    <option value="MT">Mato Grosso</option>
                                    <option value="MG">Minas Gerais</option>
                                    <option value="PA">Pará</option>
                                    <option value="PB">Paraíba</option>
                                    <option value="PR">Paraná</option>
                                    <option value="PE">Pernambuco</option>
                                    <option value="PI">Piauí</option>
                                    <option value="RJ">Rio de Janeiro</option>
                                    <option value="RN">Rio Grande do Norte</option>
                                    <option value="RS">Rio Grande do Sul</option>
                                    <option value="RO">Rondônia</option>
                                    <option value="RR">Roraima</option>
                                    <option value="SC">Santa Catarina</option>
                                    <option value="SP">São Paulo</option>
                                    <option value="SE">Sergipe</option>
                                    <option value="TO">Tocantins</option>
                                {{/selected}}
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="mb-3">
                            <label class="form-label">City</label>
                            <input name="city" type="text" class="form-control" placeholder="City" value="{{system.userdata._address_city}}" />
                        </div>
                        <!--<div class="mb-3">
                            <label class="form-label">Visibilidade</label>
                            <select name="visibility" class="form-select">
                                <option value="private" selected>Privado</option>
                                <option value="public">Público</option>
                                <option value="hidden">Oculto</option>
                            </select>
                        </div>-->
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8">
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <input name="street" type="text" class="form-control" placeholder="Address" value="{{system.userdata._address_street}}" />
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="mb-3">
                            <label class="form-label">Number</label>
                            <input name="number" type="text" class="form-control" placeholder="Number" value="{{system.userdata._address_number}}" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8">
                        <div class="mb-3">
                            <label class="form-label">District</label>
                            <input name="district" type="text" class="form-control" placeholder="District" value="{{system.userdata._address_district}}" />
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="mb-3">
                            <label class="form-label">Complement</label>
                            <input name="complement" type="text" class="form-control" placeholder="Complement" value="{{system.userdata._address_complement}}" />
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <a href="javascript:;" onclick="formAccountProfileAddressEdit__Save();" class="btn btn-primary ms-auto">
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

<script type="text/javascript">
    var formAccountProfileAddressEdit = document.getElementById('formAccountProfileAddressEdit');
    formAccountProfileAddressEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formAccountProfileAddressEdit__Save();
    }
    
    function formAccountProfileAddressEdit__Save() {
        Controller.accountsAddressUpdate('formAccountProfileAddressEdit');
    }
    
    function loadPostalCode() {
        var valor = document.querySelector('#formAccountProfileAddressEdit input[name="postal_code"]').value;
        document.querySelector('#formAccountProfileAddressEdit input[name="postal_code"]').classList.remove("is-invalid");
        
        var cep = valor.replace(/\D/g, '');
        if (cep != "") {
            var validacep = /^[0-9]{8}$/;
            
            //Valida o formato do CEP.
            if (validacep.test(cep)) {
                //Cria um elemento javascript.
                var script = document.createElement('script');
                
                //Sincroniza com o callback.
                script.src = 'https://viacep.com.br/ws/'+ cep + '/json/?callback=loadPostalCode_callback';
                
                //Insere script no documento e carrega o conteúdo.
                document.body.appendChild(script);
            } else {
                document.querySelector('#formAccountProfileAddressEdit input[name="postal_code"]').classList.add("is-invalid");
                document.getElementById("postal_code--invalid-feedback").innerHTML = "Invalid Postal Code";
            }
        } else {
            document.querySelector('#formAccountProfileAddressEdit input[name="postal_code"]').classList.add("is-invalid");
            document.getElementById("postal_code--invalid-feedback").innerHTML = "Invalid Postal Code";
        }
    };
    
    function loadPostalCode_callback(conteudo) {
        if (!("erro" in conteudo)) {
            //Atualiza os campos com os valores.
            document.querySelector('#formAccountProfileAddressEdit input[name="street"]').value=(conteudo.logradouro);
            document.querySelector('#formAccountProfileAddressEdit input[name="district"]').value=(conteudo.bairro);
            document.querySelector('#formAccountProfileAddressEdit input[name="city"]').value=(conteudo.localidade);
            //document.getElementById('uf').value=(conteudo.uf);
            selecionarTexto('formAccountProfileAddressEdit-state', (conteudo.uf));
            //document.getElementById('ibge').value=(conteudo.ibge);
        } //end if.
        else {
            document.querySelector('#formAccountProfileAddressEdit input[name="postal_code"]').classList.add("is-invalid");
            document.getElementById("postal_code--invalid-feedback").innerHTML = "Postal Code not found";
        }
    }
    
    function selecionarTexto(elementId, cod) {
        var elt = document.getElementById(elementId);
        var opt = elt.getElementsByTagName("option");
        
        for (var i = 0; i < opt.length; i++) {
            if(opt[i].value == cod) {
                elt.value = cod;
            }
        }
        
        return null;
    }
    
    setTimeout(function(){
        document.querySelector('#formAccountProfileAddressEdit input[name="postal_code"]').focus();
    }, 500);
</script>
