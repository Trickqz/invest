<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
    <div class="modal-content">
        <div class="modal-body">
            <div class="modal-title">Withdrawal request</div>
            <div>
                The deadline for clearing and the <b>minimum amount</b> of the withdrawal is according to the company's rules.
                {{#contains "true" settings.cashout_service_enabled}}
                    <br />Minimum withdrawal: <b>{{formatmoney_br settings.cashout_minimum_value 'USD #.##0.00'}}</b>.
                {{else}}
                {{/contains}}
            </div>
        </div>
        <form id="formWalletWithdrawalNew" name="formWalletWithdrawalNew" method="post" onsubmit="return formWalletWithdrawalNewProcess();">
            <div class="modal-body">
                <div id="transfer_to_usd" class="row">
                    <div class="col-lg-12">
                        <div class="mb-3">
                            <label class="form-label">Your Wallet crypto</label>
                            <input class="form-control" name="coinbase_email" type="text" placeholder="Wallet crypto" value="{{system.userdata._coinbase_email}}" onkeyup="formWalletWithdrawalEnableAmount();" onblur="formWalletWithdrawalEnableAmount();">
                            <div id="coinbase_email--invalid-feedback" class="invalid-feedback"></div>
                            <!--<small class="form-hint"></small>-->
                        </div>
                    </div>
                </div>
                
                <div id="transfer_to_pix" class="row" style="display: none;">
                    <div class="col-lg-12">
                        <div class="mb-3">
                            <label class="form-label">Enter your PIX key to request the withdrawal</label>
                            <input class="form-control" name="key" type="text" placeholder="PIX KEY" value="" maxlength="160" onkeyup="formWalletWithdrawalEnableAmount();" onblur="formWalletWithdrawalEnableAmount();">
                            <div id="key--invalid-feedback" class="invalid-feedback"></div>
                            <small class="form-hint">
                                If you don't have PIX, you can use your bank account by clicking <a class="btn-link" href="javascript:;" onclick="formWalletWithdrawalMode('bank');">here</a>.
                            </small>
                        </div>
                    </div>
                </div>
                
                <div id="transfer_to_bank" class="row" style="display: none;">
                    <input name="bank_name" type="hidden" class="form-control" value="{{tmp.bank.bank_name}}" />
                    <div class="row">
                        <div class="mb-3">
                            <label class="form-label">Bank</label>
                            <select name="bank_number" class="form-select" onchange="setBankName();" style="max-width: 280px;">
                                {{#selected tmp.bank.bank_number}}
                                    <option value="001">BANCO DO BRASIL S.A (BB)</option>
                                    <option value="237">BRADESCO S.A</option>
                                    <option value="335">Banco Digio S.A</option>
                                    <option value="260">NU PAGAMENTOS S.A (NUBANK)</option>
                                    <option value="290">Pagseguro Internet S.A (PagBank)</option>
                                    <option value="380">PicPay Servicos S.A.</option>
                                    <option value="323">Mercado Pago - conta do Mercado Livre</option>
                                    <option value="237">NEXT BANK (UTILIZAR O MESMO CÓDIGO DO BRADESCO)</option>
                                    <option value="637">BANCO SOFISA S.A (SOFISA DIRETO)</option>
                                    <option value="077">BANCO INTER S.A</option>
                                    <option value="341">ITAÚ UNIBANCO S.A</option>
                                    <option value="104">CAIXA ECONÔMICA FEDERAL (CEF)</option>
                                    <option value="033">BANCO SANTANDER BRASIL S.A</option>
                                    <option value="212">BANCO ORIGINAL S.A</option>
                                    <option value="756">BANCOOB (BANCO COOPERATIVO DO BRASIL)</option>
                                    <option value="655">BANCO VOTORANTIM S.A</option>
                                    <option value="655">NEON PAGAMENTOS S.A (OS MESMOS DADOS DO BANCO VOTORANTIM)</option>
                                    <option value="041">BANRISUL – BANCO DO ESTADO DO RIO GRANDE DO SUL S.A</option>
                                    <option value="389">BANCO MERCANTIL DO BRASIL S.A</option>
                                    <option value="422">BANCO SAFRA S.A</option>
                                    <option value="070">BANCO DE BRASÍLIA (BRB)</option>
                                    <option value="136">UNICRED COOPERATIVA</option>
                                    <option value="741">BANCO RIBEIRÃO PRETO</option>
                                    <option value="739">BANCO CETELEM S.A</option>
                                    <option value="743">BANCO SEMEAR S.A</option>
                                    <option value="100">PLANNER CORRETORA DE VALORES S.A</option>
                                    <option value="096">BANCO B3 S.A</option>
                                    <option value="747">Banco RABOBANK INTERNACIONAL DO BRASIL S.A</option>
                                    <option value="748">SICREDI S.A</option>
                                    <option value="752">BNP PARIBAS BRASIL S.A</option>
                                    <option value="091">UNICRED CENTRAL RS</option>
                                    <option value="399">KIRTON BANK</option>
                                    <option value="108">PORTOCRED S.A</option>
                                    <option value="757">BANCO KEB HANA DO BRASIL S.A</option>
                                    <option value="102">XP INVESTIMENTOS S.A</option>
                                    <option value="348">BANCO XP S/A</option>
                                    <option value="340">SUPER PAGAMENTOS S/A (SUPERDITAL)</option>
                                    <option value="364">GERENCIANET PAGAMENTOS DO BRASIL</option>
                                    <option value="084">UNIPRIME NORTE DO PARANÁ</option>
                                    <option value="180">CM CAPITAL MARKETS CCTVM LTDA</option>
                                    <option value="066">BANCO MORGAN STANLEY S.A</option>
                                    <option value="015">UBS BRASIL CCTVM S.A</option>
                                    <option value="143">TREVISO CC S.A</option>
                                    <option value="062">HIPERCARD BM S.A</option>
                                    <option value="074">BCO. J.SAFRA S.A</option>
                                    <option value="099">UNIPRIME CENTRAL CCC LTDA</option>
                                    <option value="025">BANCO ALFA S.A.</option>
                                    <option value="075">BCO ABN AMRO S.A</option>
                                    <option value="040">BANCO CARGILL S.A</option>
                                    <option value="190">SERVICOOP</option>
                                    <option value="063">BANCO BRADESCARD</option>
                                    <option value="191">NOVA FUTURA CTVM LTDA</option>
                                    <option value="064">GOLDMAN SACHS DO BRASIL BM S.A</option>
                                    <option value="097">CCC NOROESTE BRASILEIRO LTDA</option>
                                    <option value="016">CCM DESP TRÂNS SC E RS</option>
                                    <option value="012">BANCO INBURSA</option>
                                    <option value="003">BANCO DA AMAZONIA S.A</option>
                                    <option value="060">CONFIDENCE CC S.A</option>
                                    <option value="037">BANCO DO ESTADO DO PARÁ S.A</option>
                                    <option value="159">CASA CREDITO S.A</option>
                                    <option value="172">ALBATROSS CCV S.A</option>
                                    <option value="085">COOP CENTRAL AILOS</option>
                                    <option value="114">CENTRAL COOPERATIVA DE CRÉDITO NO ESTADO DO ESPÍRITO SANTO</option>
                                    <option value="036">BANCO BBI S.A</option>
                                    <option value="394">BANCO BRADESCO FINANCIAMENTOS S.A</option>
                                    <option value="004">BANCO DO NORDESTE DO BRASIL S.A.</option>
                                    <option value="320">BANCO CCB BRASIL S.A</option>
                                    <option value="189">HS FINANCEIRA</option>
                                    <option value="105">LECCA CFI S.A</option>
                                    <option value="076">BANCO KDB BRASIL S.A.</option>
                                    <option value="082">BANCO TOPÁZIO S.A</option>
                                    <option value="286">CCR DE OURO</option>
                                    <option value="093">PÓLOCRED SCMEPP LTDA</option>
                                    <option value="273">CCR DE SÃO MIGUEL DO OESTE</option>
                                    <option value="157">ICAP DO BRASIL CTVM LTDA</option>
                                    <option value="183">SOCRED S.A</option>
                                    <option value="014">NATIXIS BRASIL S.A</option>
                                    <option value="130">CARUANA SCFI</option>
                                    <option value="127">CODEPE CVC S.A</option>
                                    <option value="079">BANCO ORIGINAL DO AGRONEGÓCIO S.A</option>
                                    <option value="081">BBN BANCO BRASILEIRO DE NEGOCIOS S.A</option>
                                    <option value="118">STANDARD CHARTERED BI S.A</option>
                                    <option value="133">CRESOL CONFEDERAÇÃO</option>
                                    <option value="121">BANCO AGIBANK S.A</option>
                                    <option value="083">BANCO DA CHINA BRASIL S.A</option>
                                    <option value="138">GET MONEY CC LTDA</option>
                                    <option value="024">BCO BANDEPE S.A</option>
                                    <option value="095">BANCO CONFIDENCE DE CÂMBIO S.A</option>
                                    <option value="094">BANCO FINAXIS</option>
                                    <option value="276">SENFF S.A</option>
                                    <option value="137">MULTIMONEY CC LTDA</option>
                                    <option value="092">BRK S.A</option>
                                    <option value="047">BANCO BCO DO ESTADO DE SERGIPE S.A</option>
                                    <option value="144">BEXS BANCO DE CAMBIO S.A.</option>
                                    <option value="126">BR PARTNERS BI</option>
                                    <option value="301">BPP INSTITUIÇÃO DE PAGAMENTOS S.A</option>
                                    <option value="173">BRL TRUST DTVM SA</option>
                                    <option value="119">BANCO WESTERN UNION</option>
                                    <option value="254">PARANA BANCO S.A</option>
                                    <option value="268">BARIGUI CH</option>
                                    <option value="107">BANCO BOCOM BBM S.A</option>
                                    <option value="412">BANCO CAPITAL S.A</option>
                                    <option value="124">BANCO WOORI BANK DO BRASIL S.A</option>
                                    <option value="149">FACTA S.A. CFI</option>
                                    <option value="197">STONE PAGAMENTOS S.A</option>
                                    <option value="142">BROKER BRASIL CC LTDA</option>
                                    <option value="389">BANCO MERCANTIL DO BRASIL S.A.</option>
                                    <option value="184">BANCO ITAÚ BBA S.A</option>
                                    <option value="634">BANCO TRIANGULO S.A (BANCO TRIÂNGULO)</option>
                                    <option value="545">SENSO CCVM S.A</option>
                                    <option value="132">ICBC DO BRASIL BM S.A</option>
                                    <option value="298">VIPS CC LTDA</option>
                                    <option value="129">UBS BRASIL BI S.A</option>
                                    <option value="128">MS BANK S.A BANCO DE CÂMBIO</option>
                                    <option value="194">PARMETAL DTVM LTDA</option>
                                    <option value="310">VORTX DTVM LTDA</option>
                                    <option value="163"> COMMERZBANK BRASIL S.A BANCO MÚLTIPLO</option>
                                    <option value="280">AVISTA S.A</option>
                                    <option value="146">GUITTA CC LTDA</option>
                                    <option value="279">CCR DE PRIMAVERA DO LESTE</option>
                                    <option value="182">DACASA FINANCEIRA S/A</option>
                                    <option value="278">GENIAL INVESTIMENTOS CVM S.A</option>
                                    <option value="271">IB CCTVM LTDA</option>
                                    <option value="021">BANCO BANESTES S.A</option>
                                    <option value="246">BANCO ABC BRASIL S.A</option>
                                    <option value="751">SCOTIABANK BRASIL</option>
                                    <option value="208">BANCO BTG PACTUAL S.A</option>
                                    <option value="746">BANCO MODAL S.A</option>
                                    <option value="241">BANCO CLASSICO S.A</option>
                                    <option value="612">BANCO GUANABARA S.A</option>
                                    <option value="604">BANCO INDUSTRIAL DO BRASIL S.A</option>
                                    <option value="505">BANCO CREDIT SUISSE (BRL) S.A</option>
                                    <option value="196">BANCO FAIR CC S.A</option>
                                    <option value="300">BANCO LA NACION ARGENTINA</option>
                                    <option value="477">CITIBANK N.A</option>
                                    <option value="266">BANCO CEDULA S.A</option>
                                    <option value="122">BANCO BRADESCO BERJ S.A</option>
                                    <option value="376">BANCO J.P. MORGAN S.A</option>
                                    <option value="473">BANCO CAIXA GERAL BRASIL S.A</option>
                                    <option value="745">BANCO CITIBANK S.A</option>
                                    <option value="120">BANCO RODOBENS S.A</option>
                                    <option value="265">BANCO FATOR S.A</option>
                                    <option value="007">BNDES (Banco Nacional do Desenvolvimento Social)</option>
                                    <option value="188">ATIVA S.A INVESTIMENTOS</option>
                                    <option value="134">BGC LIQUIDEZ DTVM LTDA</option>
                                    <option value="641">BANCO ALVORADA S.A</option>
                                    <option value="029">BANCO ITAÚ CONSIGNADO S.A</option>
                                    <option value="243">BANCO MÁXIMA S.A</option>
                                    <option value="078">HAITONG BI DO BRASIL S.A</option>
                                    <option value="111">BANCO OLIVEIRA TRUST DTVM S.A</option>
                                    <option value="017">BNY MELLON BANCO S.A</option>
                                    <option value="174">PERNAMBUCANAS FINANC S.A</option>
                                    <option value="495">LA PROVINCIA BUENOS AIRES BANCO</option>
                                    <option value="125">BRASIL PLURAL S.A BANCO</option>
                                    <option value="488">JPMORGAN CHASE BANK</option>
                                    <option value="065">BANCO ANDBANK S.A</option>
                                    <option value="492">ING BANK N.V</option>
                                    <option value="250">BANCO BCV</option>
                                    <option value="145">LEVYCAM CCV LTDA</option>
                                    <option value="494">BANCO REP ORIENTAL URUGUAY</option>
                                    <option value="253">BEXS CC S.A</option>
                                    <option value="269">HSBC BANCO DE INVESTIMENTO</option>
                                    <option value="213">BCO ARBI S.A</option>
                                    <option value="139">INTESA SANPAOLO BRASIL S.A</option>
                                    <option value="018">BANCO TRICURY S.A</option>
                                    <option value="630">BANCO INTERCAP S.A</option>
                                    <option value="224">BANCO FIBRA S.A</option>
                                    <option value="600">BANCO LUSO BRASILEIRO S.A</option>
                                    <option value="623">BANCO PAN</option>
                                    <option value="204">BANCO BRADESCO CARTOES S.A</option>
                                    <option value="479">BANCO ITAUBANK S.A</option>
                                    <option value="456">BANCO MUFG BRASIL S.A</option>
                                    <option value="464">BANCO SUMITOMO MITSUI BRASIL S.A</option>
                                    <option value="613">OMNI BANCO S.A</option>
                                    <option value="652">ITAÚ UNIBANCO HOLDING BM S.A</option>
                                    <option value="653">BANCO INDUSVAL S.A</option>
                                    <option value="069">BANCO CREFISA S.A</option>
                                    <option value="370">BANCO MIZUHO S.A</option>
                                    <option value="249">BANCO INVESTCRED UNIBANCO S.A</option>
                                    <option value="318">BANCO BMG S.A</option>
                                    <option value="626">BANCO FICSA S.A</option>
                                    <option value="270">SAGITUR CC LTDA</option>
                                    <option value="366">BANCO SOCIETE GENERALE BRASIL</option>
                                    <option value="113">MAGLIANO S.A</option>
                                    <option value="131">TULLETT PREBON BRASIL CVC LTDA</option>
                                    <option value="011">C.SUISSE HEDGING-GRIFFO CV S.A (Credit Suisse)</option>
                                    <option value="611">BANCO PAULISTA</option>
                                    <option value="755">BOFA MERRILL LYNCH BM S.A</option>
                                    <option value="089">CCR REG MOGIANA</option>
                                    <option value="643">BANCO PINE S.A</option>
                                    <option value="140">EASYNVEST - TÍTULO CV S.A</option>
                                    <option value="707">BANCO DAYCOVAL S.A</option>
                                    <option value="288">CAROL DTVM LTDA</option>
                                    <option value="101">RENASCENCA DTVM LTDA</option>
                                    <option value="487">DEUTSCHE BANK S.A BANCO ALEMÃO</option>
                                    <option value="233">BANCO CIFRA</option>
                                    <option value="177">GUIDE</option>
                                    <option value="633">BANCO RENDIMENTO S.A</option>
                                    <option value="218">BANCO BS2 S.A</option>
                                    <option value="292">BS2 DISTRIBUIDORA DE TÍTULOS E INVESTIMENTOS</option>
                                    <option value="169">BANCO OLÉ BONSUCESSO CONSIGNADO S.A</option>
                                    <option value="293">LASTRO RDV DTVM LTDA</option>
                                    <option value="285">FRENTE CC LTDA</option>
                                    <option value="080">B&amp;T CC LTDA</option>
                                    <option value="753">NOVO BANCO CONTINENTAL S.A BM</option>
                                    <option value="222">BANCO CRÉDIT AGRICOLE BR S.A</option>
                                    <option value="754">BANCO SISTEMA</option>
                                    <option value="098">CREDIALIANÇA CCR</option>
                                    <option value="610">BANCO VR S.A</option>
                                    <option value="712">BANCO OURINVEST S.A</option>
                                    <option value="010">CREDICOAMO</option>
                                    <option value="283">RB CAPITAL INVESTIMENTOS DTVM LTDA</option>
                                    <option value="217">BANCO JOHN DEERE S.A</option>
                                    <option value="117">ADVANCED CC LTDA</option>
                                    <option value="336">BANCO C6 S.A - C6 BANK</option>
                                    <option value="654">BANCO DIGIMAIS S.A</option>
                                {{/selected}}
                            </select>
                            <small class="form-hint">Selecione banco da sua conta.</small>
                            <div id="bank_number--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                    
                    <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 12px 5%;">
                    
                    <div class="row">
                        <div class="col-lg-8">
                            <div class="mb-3">
                                <label class="form-label">Tipo</label>
                                <select name="account_type" class="form-select">
                                    {{#selected tmp.bank.account_type}}
                                        <option value="--">- Selecione -</option>
                                        <option value="cc">Conta corrente</option>
                                        <option value="cp">Conta poupança</option>
                                    {{/selected}}
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-7">
                            <div class="mb-3">
                                <label class="form-label">Agency number</label>
                                <input name="agency_number" type="text" class="form-control" placeholder="Agency number" value="{{tmp.bank.agency_number}}" inputmode="number" />
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="mb-3">
                                <label class="form-label">Agency digit</label>
                                <input name="agency_digit" type="text" class="form-control" placeholder="Agency digit" value="{{tmp.bank.agency_digit}}" inputmode="number" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-7">
                            <div class="mb-3">
                                <label class="form-label">Account number</label>
                                <input name="account_number" type="text" class="form-control" placeholder="Account number" value="{{tmp.bank.account_number}}" inputmode="number" />
                            </div>
                        </div>
                        <div class="col-lg-5">
                            <div class="mb-3">
                                <label class="form-label">Account digit</label>
                                <input name="account_digit" type="text" class="form-control" placeholder="Account digit" value="{{tmp.bank.account_digit}}" inputmode="number" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-5">
                            <div class="mb-3">
                                <label class="form-label">Operation</label>
                                <input name="operation" type="text" class="form-control" placeholder="Operation" value="{{tmp.bank.operation}}" />
                            </div>
                        </div>
                    </div>
                </div>
                
                <hr style="border: 0;height: 1px;background: #dedcdc;width: 90%;position: relative;display: inline-block;margin: 6px 5%;display: none;">
                
                <div class="row" style="display: none;">
                    <div class="col-lg-12">
                        <div class="mb-3">
                            <label class="form-label">Holder</label>
                            <input class="form-control" name="name" type="text" placeholder="Holder" value="{{tmp.bank.holder.name}}" title="Account holder" maxlength="60" style="width: 100%;max-width: 320px;">
                            <div id="name--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="mb-3">
                            <label class="form-label">DOC</label>
                            <input class="form-control" name="doc" type="text" class="cpf" placeholder="DOC (CPF, CNPJ, other...)" value="{{tmp.bank.holder.cpf}}" title="Digite o CPF (xxx.xxx.xxx-xx), CNPJ (xx.xxx.xxx/xxxx-xx) ou outro documento do titular" maxlength="14" style="width: 100%;max-width: 320px;"><!--onkeypress="mask(this,_maskCpf_cnpj);" style="width: 100%;max-width: 320px;">-->
                            <div id="doc--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                </div>
                
                <div id="section-amount-div" class="row" style="display: none;margin-top: 16px;">
                    <div class="col-lg-12">
                        <div class="card card-sm">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col-auto">
                                        <span class="bg-green text-white avatar">
                                            <!-- Download SVG icon from http://tabler-icons.io/i/currency-dollar -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                <path d="M16.7 8a3 3 0 0 0 -2.7 -2h-4a3 3 0 0 0 0 6h4a3 3 0 0 1 0 6h-4a3 3 0 0 1 -2.7 -2"></path>
                                                <path d="M12 3v3m0 12v3"></path>
                                            </svg>
                                        </span>
                                    </div>
                                    <div class="col">
                                        <div class="font-weight-medium">
                                            {{tmp.available_str}}
                                        </div>
                                        <div class="text-muted">
                                            Withdrawal balance
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div id="section-amount" class="row" style="display: none;margin-top: 16px;margin-bottom: 16px;">
                    <div class="col-lg-12">
                        <div class="mb-3">
                            <label class="form-label">What amount do you want to withdraw?</label>
                            <input id="amount" name="amount" type="text" class="form-control" placeholder="Valor" autocomplete="off" inputmode="numeric" data-inputmask="'alias': 'currencyUSD'" onkeyup="formWalletWithdrawalCheckAvailableBalance();" required="" />
                            <div id="amount--invalid-feedback" class="invalid-feedback"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="error-msg"></div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            {{#if system.userdata._coinbase_email}}
                <button id="formWalletWithdrawalConfirmBtn" type="button" class="btn btn-danger" onclick="formWalletWithdrawalNewProcess();">Request withdrawal</button>
            {{else}}
                <button id="formWalletWithdrawalConfirmBtn" type="button" class="btn btn-danger" onclick="formWalletWithdrawalNewProcess();" disabled="">Request withdrawal</button>
            {{/if}}
            <button type="button" class="btn /*btn-link link-secondary me-auto*/" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    var availableValue = {{tmp._total}};
    var withdrawalMode = "usd";
    
    //$('#formWalletWithdrawalNew select[name="account_type"]').val('{{bank.account_type}}');
    
    function fGetCurrentDateDay() {
        var A = new Date();
        var R = A.getDate();
        
        return R;
    }
    
    
    function formWalletWithdrawalCheckAvailableBalance(){
        var elAmount = document.querySelector('#formWalletWithdrawalNew input[name="amount"]');
        
        {{#contains "true" settings.cashout_service_enabled}}
            //if (justNumber(elAmount.value) <= availableValue && justNumber(elAmount.value) >= _appData.settings.cashout_minimum_value && (document.querySelector('#formWalletWithdrawalNew input[name="key"]').value != "" || withdrawalMode == "bank")) {
            if ((parseFloat(justNumber(elAmount.value)/100.0)) <= parseFloat(availableValue) && parseFloat(justNumber(elAmount.value)/100.0) >= parseFloat(_appData.settings.cashout_minimum_value) && (document.querySelector('#formWalletWithdrawalNew input[name="coinbase_email"]').value != "" || withdrawalMode == "pix" || withdrawalMode == "bank")) {
                document.querySelector('#formWalletWithdrawalConfirmBtn').disabled = false;
            } else {
                document.querySelector('#formWalletWithdrawalConfirmBtn').disabled = true;
            }
        {{else}}
        {{/contains}}
    }
    
    /*function formWalletWithdrawalSetEnabled(el) {
        var currency = el.value;
        var number = Number(currency.replace(/[^\d]+/g,''));
        
        //if (fGetCurrentDateDay() != 5 || fGetCurrentDateDay() != 20) {
            if (number >= 5000 && document.querySelector('#formWalletWithdrawalNew input[name="key"]').value != "") {
                document.getElementById("formWalletWithdrawalConfirmBtn").disabled = false;
            } else {
                document.getElementById("formWalletWithdrawalConfirmBtn").disabled = true;
            }
        //}
    }*/
    
    function formWalletWithdrawalMode(mode){
        withdrawalMode = mode;
        
        if (mode == "usd") {
            document.getElementById('transfer_to_bank').style.display = "none";
            document.getElementById('transfer_to_usd').style.display = "block";
            document.getElementById('transfer_to_pix').style.display = "none";
        } else if (mode == "pix") {
            document.getElementById('transfer_to_bank').style.display = "none";
            document.getElementById('transfer_to_usd').style.display = "none";
            document.getElementById('transfer_to_pix').style.display = "block";
        } else {
            document.getElementById('transfer_to_bank').style.display = "block";
            document.getElementById('transfer_to_usd').style.display = "none";
            document.getElementById('transfer_to_pix').style.display = "none";
            formWalletWithdrawalEnableAmount();
        }
    }
    
    function setBankName() {
        var select = document.querySelector('#formWalletWithdrawalNew select[name="bank_number"]');
        document.querySelector('#formWalletWithdrawalNew input[name="bank_name"]').value = select.options[select.selectedIndex].text;
    }
    
    function formWalletWithdrawalNewProcess(){
        document.querySelectorAll('.invalid-feedback').forEach(elem => {
            var el = elem.parentElement.querySelector('.form-control');
            if (el != null) {
                el.classList.remove("is-invalid");
            }
        });
        
        var elCoinbase_email = document.querySelector('#formWalletWithdrawalNew input[name="coinbase_email"]');
        var elKey = document.querySelector('#formWalletWithdrawalNew input[name="key"]');
        var elDoc = document.querySelector('#formWalletWithdrawalNew input[name="doc"]');
        var elName = document.querySelector('#formWalletWithdrawalNew input[name="name"]');
        var elAmount = document.querySelector('#formWalletWithdrawalNew input[name="amount"]');
        
        
        if (withdrawalMode == "usd") {
            if (elCoinbase_email.value == "") {
                elCoinbase_email.classList.add("is-invalid");
                document.getElementById('coinbase_email--invalid-feedback').innerHTML = "A Wallet crypto must be provided for the withdrawal request";
                elCoinbase_email.focus();
                return;
            }
        }
        
        if (withdrawalMode == "pix") {
            if (elKey.value == "") {
                elKey.classList.add("is-invalid");
                document.getElementById('key--invalid-feedback').innerHTML = "A PIX key must be provided for the withdrawal request";
                elKey.focus();
                return;
            }
        }
        
        if (withdrawalMode != "usd") {
            if (elName.value == "") {
                elName.classList.add("is-invalid");
                document.getElementById('name--invalid-feedback').innerHTML = "The name of the holder must be informed for the withdrawal request";
                elName.focus();
                return;
            }
            
            if (elDoc.value == "") {
                elDoc.classList.add("is-invalid");
                document.getElementById('doc--invalid-feedback').innerHTML = "A document (CPF or CNPJ) must be provided for the withdrawal request";
                elDoc.focus();
                return;
            }
        }
        
        if (elAmount.value == "") {
            elAmount.classList.add("is-invalid");
            document.getElementById('amount--invalid-feedback').innerHTML = "An amount must be informed for the withdrawal request";
            elAmount.focus();
            return;
        }
        
        {{#contains "true" settings.cashout_service_enabled}}
            //if ((parseFloat(justNumber(elAmount.value)/100.0)) <= parseFloat(justNumber(availableValue))) {
            //if (elAmount.value < {{settings.cashout_minimum_value}}) {
            if ((parseFloat(justNumber(elAmount.value)/100.0)) < parseFloat('{{settings.cashout_minimum_value}}')) {
                elAmount.classList.add("is-invalid");
                document.getElementById('amount--invalid-feedback').innerHTML = "The minimum withdrawal amount is USD {{settings.cashout_minimum_value}}";
                elAmount.focus();
                return;
            }
        {{else}}
        {{/contains}}
        
        if (withdrawalMode == "usd") {
            Controller.walletWithdrawalUSD(elCoinbase_email.value, justNumber(elAmount.value));
        } else if (withdrawalMode == "pix") {
            elKey.value = "";
            
            Controller.walletWithdrawalPIX(elKey.value, elDoc.value, elName.value, justNumber(elAmount.value));
        } else if (withdrawalMode == "bank") {
            Controller.walletWithdrawalBANK('formWalletWithdrawalNew', justNumber(elAmount.value));
        }
    }
    
    function formWalletWithdrawalEnableAmount() {
        var wallet_sectionAmount_div = document.getElementById("section-amount-div");
        var wallet_sectionAmount = document.getElementById("section-amount");
        
        if (document.querySelector('#formWalletWithdrawalNew input[name="coinbase_email"]').value != "") {
            wallet_sectionAmount_div.style.display = "block";
            wallet_sectionAmount.style.display = "block";
        } else if (document.querySelector('#formWalletWithdrawalNew input[name="key"]').value != "") {
            wallet_sectionAmount_div.style.display = "block";
            wallet_sectionAmount.style.display = "block";
        } else if (document.querySelector('#formWalletWithdrawalNew select[name="account_type"]').value != "") {
            if (withdrawalMode == "bank") {
                wallet_sectionAmount_div.style.display = "block";
                wallet_sectionAmount.style.display = "block";
            }
        } else {
            wallet_sectionAmount_div.style.display = "none";
            wallet_sectionAmount.style.display = "none";
        }
    }
    
    setTimeout(function(){
        document.formWalletWithdrawalNew.coinbase_email.focus();
    }, 500);
</script>
