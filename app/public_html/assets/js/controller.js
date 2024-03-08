var View = {
    /**
     * INVOICES
     */
    openFormInvoicesInfo: function(id){
        invoicesGetFullById({ _id: id }).then(function (response) {
            var _data = response.invoices__getById;
            
            var buttons = "",
                items_html = "",
                total__points = 0,
                original_amount = _data.amount;
            
            for (var i = 0; i < _data.purchase_details.items.length; i++) {
                var punctuation = 0;
                if (_data.purchase_details.items[i].punctuation.indication.qualification > 0) {
                    punctuation = _data.purchase_details.items[i].punctuation.indication.qualification;
                } else {
                    punctuation = _data.purchase_details.items[i].punctuation.matriz.qualification
                }
                
                ///items_html += "<div class='g12'><b>" + _data.purchase_details.items[i].quantity + " - " + _data.purchase_details.items[i].code + "</b> | " + _data.purchase_details.items[i].description + ",&nbsp; " + numberToRealHtml(_data.purchase_details.items[i].price_amount) + " - " + (punctuation / 100.0) + " pts</div>";
                
                items_html += 
                      '<tr>'
                    + '    <td class="text-center">' + (i+1) + '</td>'
                    + '    <td>'
                    + '        <p class="strong mb-1">' + _data.purchase_details.items[i].code + '</p>'
                    + '        <div class="text-muted">' + _data.purchase_details.items[i].description + '</div>'
                    + '    </td>'
                    + '    <td class="text-center">'
                    +          _data.purchase_details.items[i].quantity
                    + '    </td>'
                    + '    <td class="text-end">' + numberToRealHtml(_data.purchase_details.items[i].price_amount) + '</td>'
                    + '    <td class="text-end">' + (punctuation / 100.0) + '</td>'
                    + '</tr>';
                
                total__points += (punctuation / 100.0);
            }
            
            if (_data.status == 'waiting') {
                buttons = 
                      '<button type="button" class="btn btn-success" onclick="Controller.invoicesPay(\''+_data.code+'\');">'
                    + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-currency-dollar" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                    + '        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                    + '        <path d="M16.7 8a3 3 0 0 0 -2.7 -2h-4a3 3 0 0 0 0 6h4a3 3 0 0 1 0 6h-4a3 3 0 0 1 -2.7 -2"></path>'
                    + '        <path d="M12 3v3m0 12v3"></path>'
                    + '    </svg>'
                    + '    Pagar'
                    + '</button>';
            }
            
            buttons += 
                  '<button type="button" class="btn btn-primary" onclick="OpenFileReport(\''+CFG__API_REST_URL+'/export/invoices/'+_data._id+'/mirror.pdf\', \'Espelho do pedido #'+_data.code+'\');">'
                + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-text" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                + '       <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                + '       <path d="M14 3v4a1 1 0 0 0 1 1h4"></path>'
                + '       <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z"></path>'
                + '       <line x1="9" y1="9" x2="10" y2="9"></line>'
                + '       <line x1="9" y1="13" x2="15" y2="13"></line>'
                + '       <line x1="9" y1="17" x2="15" y2="17"></line>'
                + '    </svg>'
                + '    Espelho do pedido'
                + '</button>';
            
            if (_data.status == 'waiting' || _data.status == 'partially_paid') {
                buttons += 
                      '<button type="button" class="btn btn-danger" onclick="Controller.invoicesCancel(\''+_data._id+'\', \''+_data.code+'\');">'
                    + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-x" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                    + '        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                    + '        <line x1="18" y1="6" x2="6" y2="18"></line>'
                    + '        <line x1="6" y1="6" x2="18" y2="18"></line>'
                    + '    </svg>'
                    + '    Cancelar'
                    + '</button>';
            }
            
            //_data.doc__account.contact.mobile_phone = _maskMobile_phone(_data.doc__account.contact.mobile_phone);
            //_data.doc__account.doc.cpf = _maskCpf_cnpj(_data.doc__account.doc.cpf);
            //status: formatInvoicesStatus(_data.status),
            
            
            /** **/
            var tableHTML = `
                    <table class="table table-transparent table-responsive">
                      <thead>
                        <tr>
                          <th class="text-center" style="width: 1%"></th>
                          <th>Produto</th>
                          <th class="text-center" style="width: 1%">Qtd</th>
                          <th class="text-end" style="width: 1%">Preço</th>
                          <th class="text-end" style="width: 1%">Pontos</th>
                        </tr>
                      </thead>
                      <tbody>
                        ` + items_html + `
                      <tr>
                        <td colspan="4" class="strong text-end">Subtotal</td>
                        <td class="text-end">` + fmtMoney(_data.amount) + `</td>
                      </tr>
                      <tr>
                        <td colspan="4" class="strong text-end">Frete</td>
                        <td class="text-end">USD 0,00</td>
                      </tr>
                      <!--<tr>
                        <td colspan="4" class="strong text-end">Vat Rate</td>
                        <td class="text-end">20%</td>
                      </tr>
                      <tr>
                        <td colspan="4" class="strong text-end">Vat Due</td>
                        <td class="text-end">$5.000,00</td>
                      </tr>-->
                      <tr>
                        <td colspan="4" class="font-weight-bold text-uppercase text-end">Total</td>
                        <td class="font-weight-bold text-end">` + fmtMoney(_data.amount) + `</td>
                      </tr>
                    </tbody></table>
                `;
            /** **/
            
            _data["el__table"] = tableHTML;
            _data["el__buttons"] = buttons;
            _data["total__points"] = total__points;
            
            var doc = "";
            if (_data.doc__account.type == "natural_person") {
                doc = Inputmask.format(_data.doc__account.profile.docs.cpf, { mask: "999.999.999-99" });
            } else if (_data.doc__account.type == "legal_person") {
                doc = Inputmask.format(_data.doc__account.profile.docs.cnpj, { mask: "99.999.999/9999-99" });
            } else {
                doc = "Extrangeiro";
            }
            
            _data.doc__account.profile.docs.cpf = doc;
            //_data.doc__account.contact.mobile_phone = Inputmask.format(_data.doc__account.contact.mobile_phone, { mask: "(99) 99999-9999" });
            _data.doc__account.contact.mobile_phone = formatMobilePhone(_data.doc__account.contact.mobile_phone, _data.doc__account._country_phone_mask);
            //_data.doc__shipping_withdrawal_local__account.contact.mobile_phone = Inputmask.format(_data.doc__shipping_withdrawal_local__account.contact.mobile_phone, { mask: "(99) 99999-9999" });
            _data.doc__shipping_withdrawal_local__account.contact.mobile_phone = formatMobilePhone(_data.doc__shipping_withdrawal_local__account.contact.mobile_phone, _data.doc__shipping_withdrawal_local__account._country_phone_mask);
            _data.created_at = formatDate(new Date(_data.created_at), 'dd/MM/yyyy');
            _data.due_date = formatDate(new Date(_data.due_date), 'dd/MM/yyyy');
            _data.amount = fmtMoney(_data.amount);
            //_data.status = commerce__formatInvoicesStatus(_data.status);
            
            _data.statusTxt = commerce__formatInvoicesStatus(_data.status);
            
            _data.payment_msg = '';
            if (_data.status == "partially_paid" && _data.transaction.to_receive > 0) {
                _data.payment_msg = '<div style="display: block;margin: 8px 0;padding: 8px;background: #f4f6f9;">Este pedido foi pago <b>parcialmente</b> o valor de <b>' + fmtMoney(original_amount - _data.transaction.to_receive) + '</b>, você deve pagar ainda o valor restante de <b>' + fmtMoney(_data.transaction.to_receive) + '</b>.</div>';
            }
            
            dialogOpen('templates/popup/invoices_view.tpl', null, _data);
        });
    },
    
    
    /**
     * MY STORES
     */
    openFormMyStoreInvoicesInfo: function(id){
        invoicesGetFullById({ _id: id }).then(function (response) {
            var _data = response.invoices__getById;
            
            var buttons = "";
            var items_html = "";
            var original_amount = _data.amount;
            
            for (var i = 0; i < _data.purchase_details.items.length; i++) {
                var punctuation = 0;
                if (_data.purchase_details.items[i].punctuation.indication.qualification > 0) {
                    punctuation = _data.purchase_details.items[i].punctuation.indication.qualification;
                } else {
                    punctuation = _data.purchase_details.items[i].punctuation.matriz.qualification
                }
                
                ///items_html += "<div class='g12'><b>" + _data.purchase_details.items[i].quantity + " - " + _data.purchase_details.items[i].code + "</b> | " + _data.purchase_details.items[i].description + ",&nbsp; " + numberToRealHtml(_data.purchase_details.items[i].price_amount) + " - " + (punctuation / 100.0) + " pts</div>";
                items_html += 
                      '<tr>'
                    + '    <td class="text-center">' + (i+1) + '</td>'
                    + '    <td>'
                    + '        <p class="strong mb-1">' + _data.purchase_details.items[i].code + '</p>'
                    + '        <div class="text-muted">' + _data.purchase_details.items[i].description + '</div>'
                    + '    </td>'
                    + '    <td class="text-center">'
                    +          _data.purchase_details.items[i].quantity
                    + '    </td>'
                    + '    <td class="text-end">' + numberToRealHtml(_data.purchase_details.items[i].price_amount) + '</td>'
                    + '    <td class="text-end">' + (punctuation / 100.0) + '</td>'
                    + '</tr>';
            }
            
            if (_data.status == 'waiting' || _data.status == 'partially_paid') {
                buttons = '<button type="button" class="btn btn-primary" onclick="Controller.invoicesSetSettled(\''+_data._id+'\', \''+_data.code+'\');">'
                        + '    <i class="now-ui-icons business_money-coins"></i>'
                        + '    Marcar como recebido'
                        + '</button>';
            }
            
            var arrCategorization = _data.categorization;
            if (arrCategorization != undefined && arrCategorization.length > 0) {
                buttons += '<button type="button" class="btn" onclick="this.disabled=true; this.innerText=\'Aguarde…\'; Controller.invoicesDecategorizeById(\''+_data._id+'\'); this.innerText=\'Alterado!\';">Pedido "não impresso"</button>';
            } else {
                buttons += '<button type="button" class="btn" onclick="this.disabled=true; this.innerText=\'Aguarde…\'; Controller.invoicesCategorizeById(\''+_data._id+'\'); this.innerText=\'Alterado!\';">Marcar "impresso"</button>';
            }
            
            buttons += '<button type="button" class="btn btn-primary" onclick="OpenFileReport(\''+CFG__API_REST_URL+'/export/invoices/'+_data._id+'/mirror.pdf\', \'Espelho do pedido #'+_data.code+'\');">'
                    + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-file-text" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                    + '       <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                    + '       <path d="M14 3v4a1 1 0 0 0 1 1h4"></path>'
                    + '       <path d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z"></path>'
                    + '       <line x1="9" y1="9" x2="10" y2="9"></line>'
                    + '       <line x1="9" y1="13" x2="15" y2="13"></line>'
                    + '       <line x1="9" y1="17" x2="15" y2="17"></line>'
                    + '    </svg>'
                    + '    Espelho do pedido'
                    + '</button>'
                    + '<button type="button" class="btn btn-primary" onclick="OpenFileReport(\''+CFG__API_REST_URL+'/export/invoices/'+_data._id+'/blind_conference.pdf\', \'Espelho do pedido #'+_data.code+'\');">'
                    + '    <i class="now-ui-icons files_paper"></i>'
                    + '    Listagem de conferência'
                    + '</button>';
            
            if (_data.status == 'waiting' || _data.status == 'partially_paid') {
                buttons += '<button type="button" class="btn btn-danger" onclick="Controller.invoicesCancel(\''+_data._id+'\', \''+_data.code+'\');">'
                        + '    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-x" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                        + '        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                        + '        <line x1="18" y1="6" x2="6" y2="18"></line>'
                        + '        <line x1="6" y1="6" x2="18" y2="18"></line>'
                        + '    </svg>'
                        + '    Cancelar'
                        + '</button>';
            }
            
            //_data.doc__account.contact.mobile_phone = _maskMobile_phone(_data.doc__account.contact.mobile_phone);
            //_data.doc__account.doc.cpf = _maskCpf_cnpj(_data.doc__account.doc.cpf);
            //status: formatInvoicesStatus(_data.status),
            /** **/
            var tableHTML = `
                    <table class="table table-transparent table-responsive">
                      <thead>
                        <tr>
                          <th class="text-center" style="width: 1%"></th>
                          <th>Produto</th>
                          <th class="text-center" style="width: 1%">Qtd</th>
                          <th class="text-end" style="width: 1%">Preço</th>
                          <th class="text-end" style="width: 1%">Pontos</th>
                        </tr>
                      </thead>
                      <tbody>
                        ` + items_html + `
                      <tr>
                        <td colspan="4" class="strong text-end">Subtotal</td>
                        <td class="text-end">` + fmtMoney(_data.amount) + `</td>
                      </tr>
                      <tr>
                        <td colspan="4" class="strong text-end">Frete</td>
                        <td class="text-end">USD 0,00</td>
                      </tr>
                      <!--<tr>
                        <td colspan="4" class="strong text-end">Vat Rate</td>
                        <td class="text-end">20%</td>
                      </tr>
                      <tr>
                        <td colspan="4" class="strong text-end">Vat Due</td>
                        <td class="text-end">$5.000,00</td>
                      </tr>-->
                      <tr>
                        <td colspan="4" class="font-weight-bold text-uppercase text-end">Total</td>
                        <td class="font-weight-bold text-end">` + fmtMoney(_data.amount) + `</td>
                      </tr>
                    </tbody></table>
                `;
            /** **/
            
            _data["el__table"] = tableHTML;
            _data["el__buttons"] = buttons;
            
            var doc = "";
            if (_data.doc__account.type == "natural_person") {
                doc = Inputmask.format(_data.doc__account.profile.docs.cpf, { mask: "999.999.999-99" });
            } else if (_data.doc__account.type == "legal_person") {
                doc = Inputmask.format(_data.doc__account.profile.docs.cnpj, { mask: "99.999.999/9999-99" });
            } else {
                doc = "Extrangeiro";
            }
            
            _data.doc__account.profile.docs.cpf = doc;
            //_data.doc__account.contact.mobile_phone = Inputmask.format(_data.doc__account.contact.mobile_phone, { mask: "(99) 99999-9999" });
            _data.doc__account.contact.mobile_phone = formatMobilePhone(_data.doc__account.contact.mobile_phone, _data.doc__account._country_phone_mask);
            //_data.doc__shipping_withdrawal_local__account.contact.mobile_phone = Inputmask.format(_data.doc__shipping_withdrawal_local__account.contact.mobile_phone, { mask: "(99) 99999-9999" });
            _data.doc__shipping_withdrawal_local__account.contact.mobile_phone = formatMobilePhone(_data.doc__shipping_withdrawal_local__account.contact.mobile_phone, _data.doc__shipping_withdrawal_local__account._country_phone_mask);
            _data.created_at = formatDate(new Date(_data.created_at), 'dd/MM/yyyy');
            _data.due_date = formatDate(new Date(_data.due_date), 'dd/MM/yyyy');
            _data.amount = fmtMoney(_data.amount);
            _data.statusTxt = commerce__formatInvoicesStatus(_data.status);
            
            _data.payment_msg = '';
            if (_data.status == "partially_paid" && _data.transaction.to_receive > 0) {
                _data.payment_msg = '<div style="display: block;margin: 8px 0;padding: 8px;background: #f4f6f9;">Este pedido foi pago <b>parcialmente</b> o valor de <b>' + fmtMoney(original_amount - _data.transaction.to_receive) + '</b>, você deve receber o valor restante de <b>' + fmtMoney(_data.transaction.to_receive) + '</b>.</div>';
            }
            
            dialogOpen('templates/popup/invoices_view.tpl', null, _data);
        });
    },
    
    
    /**
     * UNILEVEL INVOICES
     */
    openFormUnilevelInvoicesInfo: function(id){
        unilevelInvoicesGetById({ _id: id }).then(function (response) {
            var _data = response.unilevel__invoicesGetById;
            
            var buttons = "",
                items_html = "",
                table = document.createElement('table'),
                total__points = 0;
            
            for (var i = 0; i < _data.purchase_details.items.length; i++) {
                var punctuation = 0;
                if (_data.purchase_details.items[i].punctuation.indication.qualification > 0) {
                    punctuation = _data.purchase_details.items[i].punctuation.indication.qualification;
                } else {
                    punctuation = _data.purchase_details.items[i].punctuation.matriz.qualification
                }
                
                ///items_html += "<div class='g12'><b>" + _data.purchase_details.items[i].quantity + " - " + _data.purchase_details.items[i].code + "</b> | " + _data.purchase_details.items[i].description + ",&nbsp; " + numberToRealHtml(_data.purchase_details.items[i].price_amount) + " - " + (punctuation / 100.0) + " pts</div>";
                items_html += 
                      '<tr>'
                    + '    <td class="text-center">' + (i+1) + '</td>'
                    + '    <td>'
                    + '        <p class="strong mb-1">' + _data.purchase_details.items[i].code + '</p>'
                    + '        <div class="text-muted">' + _data.purchase_details.items[i].description + '</div>'
                    + '    </td>'
                    + '    <td class="text-center">'
                    +          _data.purchase_details.items[i].quantity
                    + '    </td>'
                    + '    <td class="text-end">' + numberToRealHtml(_data.purchase_details.items[i].price_amount) + '</td>'
                    + '    <td class="text-end">' + (punctuation / 100.0) + '</td>'
                    + '</tr>';
                
                total__points += (punctuation / 100.0);
            }
            
            //_data.doc__account.contact.mobile_phone = _maskMobile_phone(_data.doc__account.contact.mobile_phone);
            //_data.doc__account.doc.cpf = _maskCpf_cnpj(_data.doc__account.doc.cpf);
            //status: formatInvoicesStatus(_data.status),
            
            /** **/
            var tableHTML = `
                    <table class="table table-transparent table-responsive">
                      <thead>
                        <tr>
                          <th class="text-center" style="width: 1%"></th>
                          <th>Produto</th>
                          <th class="text-center" style="width: 1%">Qtd</th>
                          <th class="text-end" style="width: 1%">Preço</th>
                          <th class="text-end" style="width: 1%">Pontos</th>
                        </tr>
                      </thead>
                      <tbody>
                        ` + items_html + `
                      <tr>
                        <td colspan="4" class="strong text-end">Subtotal</td>
                        <td class="text-end">` + fmtMoney(_data.amount) + `</td>
                      </tr>
                      <tr>
                        <td colspan="4" class="strong text-end">Frete</td>
                        <td class="text-end">USD 0,00</td>
                      </tr>
                      <!--<tr>
                        <td colspan="4" class="strong text-end">Vat Rate</td>
                        <td class="text-end">20%</td>
                      </tr>
                      <tr>
                        <td colspan="4" class="strong text-end">Vat Due</td>
                        <td class="text-end">$5.000,00</td>
                      </tr>-->
                      <tr>
                        <td colspan="4" class="font-weight-bold text-uppercase text-end">Total</td>
                        <td class="font-weight-bold text-end">` + fmtMoney(_data.amount) + `</td>
                      </tr>
                    </tbody></table>
                `;
            /** **/
            
            _data["el__table"] = tableHTML;  //items_html;
            _data["el__buttons"] = buttons;
            _data["total__points"] = total__points;
            
            var doc = "";
            if (_data.doc__account.type == "natural_person") {
                doc = Inputmask.format(_data.doc__account.profile.docs.cpf, { mask: "999.999.999-99" });
            } else if (_data.doc__account.type == "legal_person") {
                doc = Inputmask.format(_data.doc__account.profile.docs.cnpj, { mask: "99.999.999/9999-99" });
            } else {
                doc = "Extrangeiro";
            }
            
            _data.doc__account.profile.docs.cpf = doc;
            //_data.doc__account.contact.mobile_phone = Inputmask.format(_data.doc__account.contact.mobile_phone, { mask: "(99) 99999-9999" });
            _data.doc__account.contact.mobile_phone = formatMobilePhone(_data.doc__account.contact.mobile_phone, _data.doc__account._country_phone_mask);
            //_data.doc__shipping_withdrawal_local__account.contact.mobile_phone = Inputmask.format(_data.doc__shipping_withdrawal_local__account.contact.mobile_phone, { mask: "(99) 99999-9999" });
            _data.doc__shipping_withdrawal_local__account.contact.mobile_phone = formatMobilePhone(_data.doc__shipping_withdrawal_local__account.contact.mobile_phone, _data.doc__shipping_withdrawal_local__account._country_phone_mask);
            _data.created_at = formatDate(new Date(_data.created_at), 'dd/MM/yyyy');
            _data.due_date = formatDate(new Date(_data.due_date), 'dd/MM/yyyy');
            _data.amount = fmtMoney(_data.amount);
            //_data.status = commerce__formatInvoicesStatus(_data.status);
            
            _data.statusTxt = commerce__formatInvoicesStatus(_data.status);
            
            _data.payment_msg = '';
            if (_data.status == "partially_paid" && _data.transaction.to_receive > 0) {
                _data.payment_msg = '<div style="display: block;margin: 8px 0;padding: 8px;background: #f4f6f9;">Este pedido foi pago <b>parcialmente</b>.</div>';
            }
            
            dialogOpen('templates/popup/invoices_view.tpl', null, _data);
        });
    },
    
    
    /**
     * PASSWORD
     */
    passwordEditOpenForm: function(){
        dialogOpen('templates/popup/password.tpl', null, null);
    },
    
    
    /**
     * FEEDBACK
     */
    feedbackOpenForm: function(){
        dialogOpen('templates/popup/feedback.tpl', null, null);
    },
    
    
    /**
     * PROFILE
     */
    openFormCustomersProfile: function(){
        dialogOpen('templates/popup/customers_profile_view.tpl', null, null);
    },
    openFormCustomersProfilePersonalDataEdit: function(id){
        dialogClose();
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                var _data = response.data;
                
                var _cpf = "",
                    _cnpj = "";
                ///if (_data._type == "natural_person") {
                    if (_data._cpf != null) {
                        _cpf = Inputmask.format(_data._cpf, { mask: "999.999.999-99" });
                    }
                ///} else if (_data._type == "legal_person") {
                    if (_data._cnpj != null) {
                        _cnpj = Inputmask.format(_data._cnpj, { mask: "99.999.999/9999-99" });
                    }
                ///} else {
                ///    doc = "Extrangeiro";
                ///}
                
                _data._cpf = _cpf;
                _data._cnpj = _cnpj;
                //_data._mobile_phone = Inputmask.format(_data._mobile_phone, { mask: "(99) 99999-9999" });
                _data._mobile_phone = formatMobilePhone(_data._mobile_phone, _data._country_phone_mask);
                
                //dialogOpen('templates/popup/customers_profile_edit.tpl', null, _data);
                
                setTimeout(function(){
                    dialogOpen('templates/popup/customers_profile_edit.tpl', null, _data);
                }, 400);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    openFormCustomersProfileAddressEdit: function(id){
        dialogClose();
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                var _data = response.data;
                
                var _cpf = "",
                    _cnpj = "";
                ///if (_data._type == "natural_person") {
                    if (_data._cpf != null) {
                        _cpf = Inputmask.format(_data._cpf, { mask: "999.999.999-99" });
                    }
                ///} else if (_data._type == "legal_person") {
                    if (_data._cnpj != null) {
                        _cnpj = Inputmask.format(_data._cnpj, { mask: "99.999.999/9999-99" });
                    }
                ///} else {
                ///    doc = "Extrangeiro";
                ///}
                
                _data._cpf = _cpf;
                _data._cnpj = _cnpj;
                //_data._mobile_phone = Inputmask.format(_data._mobile_phone, { mask: "(99) 99999-9999" });
                _data._mobile_phone = formatMobilePhone(_data._mobile_phone, _data._country_phone_mask);
                
                //dialogOpen('templates/popup/customers_profile_edit.tpl', null, _data);
                
                setTimeout(function(){
                    dialogOpen('templates/popup/customers_profile_address_edit.tpl', null, _data);
                }, 400);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    openFormCustomersProfileBankEdit: function(id){
        dialogClose();
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                var _data = response.data;
                
                var _cpf = "",
                    _cnpj = "";
                ///if (_data._type == "natural_person") {
                    if (_data._cpf != null) {
                        _cpf = Inputmask.format(_data._cpf, { mask: "999.999.999-99" });
                    }
                ///} else if (_data._type == "legal_person") {
                    if (_data._cnpj != null) {
                        _cnpj = Inputmask.format(_data._cnpj, { mask: "99.999.999/9999-99" });
                    }
                ///} else {
                ///    doc = "Extrangeiro";
                ///}
                
                var doc = _data._bank_holder_doc;
                if (doc.length == 11) {
                    doc = Inputmask.format(doc, { mask: "999.999.999-99" });
                } else if (doc.length == 14) {
                    doc = Inputmask.format(doc, { mask: "99.999.999/9999-99" });
                } else {
                    doc = '';
                }
                
                _data._cpf = _cpf;
                _data._cnpj = _cnpj;
                _data._bank_holder_doc = doc;
                //_data._mobile_phone = Inputmask.format(_data._mobile_phone, { mask: "(99) 99999-9999" });
                _data._mobile_phone = formatMobilePhone(_data._mobile_phone, _data._country_phone_mask);
                
                //dialogOpen('templates/popup/customers_profile_edit.tpl', null, _data);
                
                setTimeout(function(){
                    dialogOpen('templates/popup/customers_profile_bank_edit.tpl', null, _data);
                }, 400);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    
    openFormCustomersProfileCryptoWalletEdit: function(id){
        dialogClose();
        
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                var _data = response.data;
                
                setTimeout(function(){
                    dialogOpen('templates/popup/customers_profile_crypto_wallet_edit.tpl', null, _data);
                }, 400);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    
    
    /**
     * PROFILE
     */
    openFormProfile: function(){
        dialogOpen('templates/popup/profile_view.tpl', null, null);
    },
    openFormProfilePersonalDataEdit: function(){
        dialogClose();
        
        setTimeout(function(){
            dialogOpen('templates/popup/profile_edit.tpl', null, null);
        }, 400);
    },
    openFormProfileAddressEdit: function(){
        dialogClose();
        
        setTimeout(function(){
            dialogOpen('templates/popup/profile_address_edit.tpl', null, null);
        }, 400);
    },
    openFormProfileBankEdit: function(){
        dialogClose();
        
        setTimeout(function(){
            dialogOpen('templates/popup/profile_bank_edit.tpl', null, null);
        }, 400);
    },
    openFormProfileCryptoWalletEdit: function(){
        dialogClose();
        
        setTimeout(function(){
            dialogOpen('templates/popup/profile_crypto_wallet_edit.tpl', null, null);
        }, 400);
    },
    openFormProfilePictureEdit: function(){
        dialogClose();
        
        setTimeout(function(){
            dialogOpen('templates/popup/profile_picture_edit.tpl', null, null);
        }, 400);
    },
    openFormProfileDocumentsEdit: function(){
        dialogClose();
        
        setTimeout(function(){
            dialogOpen('templates/popup/profile_documents_edit.tpl', null, null);
        }, 400);
    },
    
    
    /**
     * SETTINGS
     */
    settingsOpenForm: function(){
        dialogOpen('templates/popup/settings.tpl', null, null);
    },
    
    
    /**
     * PROFILE
     */
    openFormProfileDocuments: function(){
        openForm('templates/popup/documents.tpl', null, null);
    },
    
    
    /**
     * SHARE
     */
    openFormShare: function(){
        dialogOpen('templates/popup/share.tpl', null, null);
    },
    
    
    /**
     * PLAN
     */
    openFormPlanSelect: function(){
        dialogOpen('templates/popup/plan_select.tpl', null, null);
    },
    
    
    /**
     * NOTIFICATIONS
     */
    openFormNotifications: function(){
        dialogOpen('templates/popup/notifications.tpl', null, null);
    },
    
    
    /**
     * WALLET
     */
    openFormWalletTransfer: function(){
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
                    
                    //if (_data.available == 0) {
                    if (_data._total == 0) {
                        _data['available_str'] = "USD 0,00";
                    } else {
                        //_data['available_str'] = fmtMoney(_data.available);
                        _data['available_str'] = fmtMoney(_data._total);
                    }
                    
                    /*if (_data.blocked == 0) {
                        _data['blocked_str'] = "USD 0,00";
                    } else {
                        _data['blocked_str'] = fmtMoney(_data.blocked);
                    }*/
                    
                    if (_data._total == 0) {
                        _data['credit.total_str'] = "USD 0,00";
                    } else {
                        _data['credit.total_str'] = fmtMoney(_data._total);
                    }
                    
                    /*if (_data.total_month == 0) {
                        _data['credit.month_str'] = "USD 0,00";
                    } else {
                        _data['credit.month_str'] = fmtMoney(_data.total_month);
                    }
                    
                    if (_data.total_month == 0) {
                        _data['credit.month_str'] = "USD 0,00";
                    } else {
                        _data['credit.month_str'] = fmtMoney(_data.total_month);
                    }*/
                    
                    dialogOpen('templates/popup/wallet_transfer.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    
    openFormWalletWithdrawal: function(){
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
                    
                    //if (_data.available == 0) {
                    if (_data._total == 0) {
                        _data['available_str'] = "USD 0,00";
                    } else {
                        //_data['available_str'] = fmtMoney(_data.available);
                        _data['available_str'] = fmtMoney(_data._total);
                    }
                    
                    /*if (_data.blocked == 0) {
                        _data['blocked_str'] = "USD 0,00";
                    } else {
                        _data['blocked_str'] = fmtMoney(_data.blocked);
                    }*/
                    
                    if (_data._total == 0) {
                        _data['credit.total_str'] = "USD 0,00";
                    } else {
                        _data['credit.total_str'] = fmtMoney(_data._total);
                    }
                    
                    /*if (_data.total_month == 0) {
                        _data['credit.month_str'] = "USD 0,00";
                    } else {
                        _data['credit.month_str'] = fmtMoney(_data.total_month);
                    }
                    
                    if (_data.total_month == 0) {
                        _data['credit.month_str'] = "USD 0,00";
                    } else {
                        _data['credit.month_str'] = fmtMoney(_data.total_month);
                    }*/
                    
                    dialogOpen('templates/popup/wallet_withdrawal.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    
    openFormWalletMoneyAdd: function(){
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
                    
                    //if (_data.available == 0) {
                    if (_data._total == 0) {
                        _data['available_str'] = "USD 0,00";
                    } else {
                        //_data['available_str'] = fmtMoney(_data.available);
                        _data['available_str'] = fmtMoney(_data._total);
                    }
                    
                    /*if (_data.blocked == 0) {
                        _data['blocked_str'] = "USD 0,00";
                    } else {
                        _data['blocked_str'] = fmtMoney(_data.blocked);
                    }*/
                    
                    if (_data._total == 0) {
                        _data['credit.total_str'] = "USD 0,00";
                    } else {
                        _data['credit.total_str'] = fmtMoney(_data._total);
                    }
                    
                    /*if (_data.total_month == 0) {
                        _data['credit.month_str'] = "USD 0,00";
                    } else {
                        _data['credit.month_str'] = fmtMoney(_data.total_month);
                    }
                    
                    if (_data.total_month == 0) {
                        _data['credit.month_str'] = "USD 0,00";
                    } else {
                        _data['credit.month_str'] = fmtMoney(_data.total_month);
                    }*/
                    
                    dialogOpen('templates/popup/wallet_money_add.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    
    openFormCashout: function(id){
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/wallet/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    _data['_amount_str'] = fmtMoney(_data._amount * -1);
                    _data['_service_fee_str'] = fmtMoney(_data._service_fee);
                    _data['_net_amount_str'] = fmtMoney(_data._net_amount);
                    
                    var buttons = '';
                    if (_data._status == "pending") {
                        if (_appData.system.isadmin == true) {
                            buttons = '<button type="button" class="btn btn-primary" onclick="dialogClose();View.openFormCashoutConfirm(\'' + _data._id + '\');">Confirm</button>';
                        }
                        
                        buttons +=
                             '<button type="button" class="btn btn-danger" onclick="fc_cashoutCancel(\'' + _data._id + '\');">Cancel</button>'
                            + '<button type="button" class="btn btn-danger" onclick="fc_cashoutDelete(\'' + _data._id + '\');">Delete</button>';
                    }
                    
                    _data['el__buttons'] = buttons;
                    
                    dialogOpen('templates/popup/cashout_view.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
        
        /**
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                var _data = response.data;
                
                var _cpf = "",
                    _cnpj = "";
                ///if (_data._type == "natural_person") {
                    if (_data._cpf != null) {
                        _cpf = Inputmask.format(_data._cpf, { mask: "999.999.999-99" });
                    }
                ///} else if (_data._type == "legal_person") {
                    if (_data._cnpj != null) {
                        _cnpj = Inputmask.format(_data._cnpj, { mask: "99.999.999/9999-99" });
                    }
                ///} else {
                ///    doc = "Extrangeiro";
                ///}
                
                _data._cpf = _cpf;
                _data._cnpj = _cnpj;
                _data._mobile_phone = Inputmask.format(_data._mobile_phone, { mask: "(99) 99999-9999" });
                
                //dialogOpen('templates/popup/customers_profile_edit.tpl', null, _data);
                
                setTimeout(function(){
                    dialogOpen('templates/popup/customers_profile_edit.tpl', null, _data);
                }, 400);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
        */
    },
    
    openFormCashoutConfirm: function(id){
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/wallet/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    _data['_amount_str'] = fmtMoney(_data._amount * -1);
                    _data['_service_fee_str'] = fmtMoney(_data._service_fee);
                    _data['_net_amount_str'] = fmtMoney(_data._net_amount);
                    
                    dialogOpen('templates/popup/cashout_confirm.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    
    openFormWalletWithdrawalView: function(id){
        /**$.ajax({
            type: "GET",
            url: _V1API+"/session/wallet/"+id,
            headers: {
                'Content-Type':'application/x-www-form-urlencoded',
                'Accept': 'application/json',
                'Authorization': _Virtual.Session.Authorization
            },
            crossDomain: true,
            data: {},
            success: function(data){
                if ((!data.error) && (data.result)) {
                    var _dataObj = data.result;
                    
                    _dataObj.type = formatWalletType(_dataObj.type);
                    _dataObj.amount = numberToRealHtml(_dataObj.amount);
                    _dataObj.date = datetimeToString(_dataObj.date);
                    _dataObj.status = formatWalletStatus(_dataObj.status);
                    
                    if (_dataObj.withdrawal.bank.account_type == "cc") {
                        _dataObj.withdrawal.bank.account_type = "Conta Corrente";
                    } else if (_dataObj.withdrawal.bank.account_type == "cp") {
                        _dataObj.withdrawal.bank.account_type = "Conta Poupança";
                    } else {
                        _dataObj.withdrawal.bank.account_type = "Não Informado";
                    }
                    
                    _dataObj.withdrawal.bank.holder.cpf = _maskCpf_cnpj(_dataObj.withdrawal.bank.holder.cpf);
                    
                    
                    var source = getBackofficeURL('templates/popup-wallet_withdrawal_view.html');
                    var template = Handlebars.compile(source);
                    var html = template(_dataObj);
                    dialogOpen(html, "920px");
                } else {
                    switch (data.error.code) {
                        case -32602:
                            View.showNotification('Ocorreu um erro inesperado ao requisitar informações. Tente atualizar.', 'danger');
                        break;
                    }
                }
            },
            error: function(xhr){
                View.showNotification('Ocorreu um erro inesperado ao requisitar informações. Tente atualizar.', 'danger');
            },
            timeout: 60000
        });**/
    },
    
    
    /**
     * POINTS
     */
    openFormPointsAdd: function(){
        /**$.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/points/add",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    /*
                    if (_data._total == 0) {
                        _data['available_str'] = "USD 0,00";
                    } else {
                        //_data['available_str'] = fmtMoney(_data.available);
                        _data['available_str'] = fmtMoney(_data._total);
                    }
                    
                    if (_data._total == 0) {
                        _data['credit.total_str'] = "USD 0,00";
                    } else {
                        _data['credit.total_str'] = fmtMoney(_data._total);
                    }*/
                    
                    dialogOpen('templates/popup/points_add.tpl', null, null);
        /**
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });**/
    },
    
    
    
    /**
     * DONATIONS
     */
    openFormDonationsAdd: function(id){
        /*$.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/donations/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    /**_data['_amount_str'] = fmtMoney(_data._amount);
                    _data['_fee_str'] = fmtMoney(_data._fee);
                    _data['_income_str'] = fmtMoney(_data._income);
                    
                    _data['mode'] = mode;
                    */
       /*             
                    dialogOpen('templates/popup/donations_details.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });*/
        
        dialogOpen('templates/popup/donations_add.tpl', null, null);
    },
    openFormDonationsCustomAdd: function(id){
        /*$.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/donations/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    /**_data['_amount_str'] = fmtMoney(_data._amount);
                    _data['_fee_str'] = fmtMoney(_data._fee);
                    _data['_income_str'] = fmtMoney(_data._income);
                    
                    _data['mode'] = mode;
                    */
       /*             
                    dialogOpen('templates/popup/donations_details.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });*/
        
        dialogOpen('templates/popup/donations_custom_add.tpl', null, null);
    },
    openFormDonationsDetails: function(id){
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/donations/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    /**_data['_amount_str'] = fmtMoney(_data._amount);
                    _data['_fee_str'] = fmtMoney(_data._fee);
                    _data['_income_str'] = fmtMoney(_data._income);
                    
                    _data['mode'] = mode;
                    */
                    
                    dialogOpen('templates/popup/donations_details.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    
    /**
     * DONATIONS_MODEL / PACKAGES
     */
    openFormPackages: function(id, mode){
        if (mode == 'edition') {
            $.ajax({
                type: 'GET',
                url: CFG__API_URL + CFG__API_VERSION + "/donations_model/"+id,
                data: {},
                beforeSend: function (xhr){ 
                    xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                },
                success: function(response) {
                    if (response.success === true) {
                        var _data = response.data;
                        _data['_amount_str'] = fmtMoney(_data._amount);
                        _data['_fee_str'] = fmtMoney(_data._fee);
                        _data['_income_str'] = fmtMoney(_data._income);
                        
                        _data['mode'] = mode;
                        
                        dialogOpen('templates/popup/packages_edit.tpl', null, _data);
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                }
            });
        } else {
            var _data = {
                    mode: mode
                };
            
            dialogOpen('templates/popup/packages_edit.tpl', null, _data);
        }
    },
    
    
    
    /**
     * Income
     */
    openFormIncomeAdd: function(){
        /**
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
                    
                    dialogOpen('templates/popup/wallet_transfer.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
        */
        
        dialogOpen('templates/popup/income_add.tpl', null, null);
    },
    openFormIncomeSecurityPay: function(){
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/income/spoon/resume",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    
                    dialogOpen('templates/popup/income_security_pay.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    openFormIncomeGet: function(){
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/income/spoon",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    
                    dialogOpen('templates/popup/income_get.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    openFormIncomeGet2: function(){
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/income/spoon/requests",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    
                    dialogOpen('templates/popup/income_get2.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });
    },
    
    
    
    /**
     * NOTIFICATIONS
     */
    openFormNotificationsSend: function(){
        /*$.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/wallet/resume",
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    var _data = response.data;
                    
                    
                    
                    dialogOpen('templates/popup/notification_send.tpl.tpl', null, _data);
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            }
        });*/
        
        dialogOpen('templates/popup/notifications_send.tpl', null, null);
    },
    
    
    
    /**
     * USERS
     */
    openFormUsers: function(id, mode){
        if (mode == 'edition') {
            $.ajax({
                type: 'GET',
                url: CFG__API_URL + CFG__API_VERSION + "/users/"+id,
                data: {},
                beforeSend: function (xhr){ 
                    xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                },
                success: function(response) {
                    if (response.success === true) {
                        var _data = response.data;
                        /**_data['_amount_str'] = fmtMoney(_data._amount);
                        _data['_fee_str'] = fmtMoney(_data._fee);
                        _data['_income_str'] = fmtMoney(_data._income);*/
                        
                        _data['mode'] = mode;
                        
                        dialogOpen('templates/popup/users_edit.tpl', null, _data);
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    //var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                }
            });
        } else {
            var _data = {
                    mode: mode
                };
            
            dialogOpen('templates/popup/users_edit.tpl', null, _data);
        }
    },
    
    
    
    /**
     * PROFILE
     */
    openFormCustomer: function(id){
        $.ajax({
            type: 'GET',
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/"+id,
            data: {},
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                var _data = response.data;
                
                var _cpf = "",
                    _cnpj = "";
                ///if (_data._type == "natural_person") {
                    if (_data._cpf != null) {
                        _cpf = Inputmask.format(_data._cpf, { mask: "999.999.999-99" });
                    }
                ///} else if (_data._type == "legal_person") {
                    if (_data._cnpj != null) {
                        _cnpj = Inputmask.format(_data._cnpj, { mask: "99.999.999/9999-99" });
                    }
                ///} else {
                ///    doc = "Extrangeiro";
                ///}
                
                _data._cpf = _cpf;
                _data._cnpj = _cnpj;
                //_data._mobile_phone = Inputmask.format(_data._mobile_phone, { mask: "(99) 99999-9999" });
                _data._mobile_phone = formatMobilePhone(_data._mobile_phone, _data._country_phone_mask);
                
                dialogOpen('templates/popup/customer.tpl', null, _data);
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                page__wallet__loadClear();
            }
        });
    },
    
    
    /**
     * SETTINGS
     */
    openFormSettings: function(){
        dialogOpen('templates/popup/settings.tpl', null, null);
    },
    
    
    /**
     * REPORT
     */
    openFormReport_customers: function(){
        dialogOpen('templates/popup/report_customers.tpl', null, null);
    },
    openFormReport_balance: function(){
        dialogOpen('templates/popup/report_balance.tpl', null, null);
    },
    openFormReport_indicated: function(){
        dialogOpen('templates/popup/report_indicated.tpl', null, null);
    },
    openFormReport_quotas: function(){
        dialogOpen('templates/popup/report_quotas.tpl', null, null);
    },
    /**openFormReport_points: function(){
        dialogOpen('templates/popup/report_points.tpl', null, null);
    },
    openFormReport_pointsCareer: function(){
        dialogOpen('templates/popup/report_points_career.tpl', null, null);
    },*/
    
    
    
    /*
     * OTHERS
     */
    showElementPreloader: function(){
        var elemDivHolder = document.createElement('div');
        elemDivHolder.className = 'holder';
        elemDivHolder.style.cssText = 'position: absolute; left: 0px; top: 0px; bottom: 0px; right: 0px; width: 100%; height: 100%; background-color: #ffffff; z-index: 9999; opacity: 0.9;';
        var elemDivPreloaderImg = document.createElement('img');
        elemDivPreloaderImg.className = 'preloader';
        elemDivPreloaderImg.style.cssText = 'display: block; width: 60px; height: 60px; margin: auto; position: absolute; top: 0; left: 0; bottom: 0; right: 0;';
        elemDivPreloaderImg.src = '../assets/img/loading.gif';
        
        elemDivHolder.appendChild(elemDivPreloaderImg);
        window.document.body.insertBefore(elemDivHolder, window.document.body.firstChild);
    },
    
    hideElementPreloader: function(){
        setTimeout(function(){
            document.querySelectorAll('.holder').forEach(function(a){
                a.remove()
            });
        }, 250);
    },
    
    showNotification: function(message, type, icon, timer, from, align){
        // type :: primary, danger
        
        type = typeof type !== 'undefined' ? type : 'primary';
        icon = typeof icon !== 'undefined' ? icon : 'gd-bell';
        timer = typeof timer !== 'undefined' ? timer : 1500;
        from = typeof from !== 'undefined' ? from : 'top';
        align = typeof align !== 'undefined' ? align : 'right';
        
        $.notify({
            icon: icon,
            message: message
        },{
            type: type,
            timer: timer,
            placement: {
                from: from,
                align: align
            }
        });
	}
};

var Controller = {
    /**
     * ACCOUNTS
     */
    accountsUpdate: function(form){
        var jsonData = JSON.parse(formToJSONString(form));
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/session/account",
            data: jsonData,
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    fgUpdateUserData();
                    dialogClose();
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                App.alert('Erro', 'Ocorreu um erro inesperado ao requisitar informações.', null);
            }
        });
    },
    
    accountsAddressUpdate: function(form){
        var jsonData = JSON.parse(formToJSONString(form));
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/session/account/address",
            data: jsonData,
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    fgUpdateUserData();
                    dialogClose();
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                App.alert('Erro', 'Ocorreu um erro inesperado ao requisitar informações.', null);
            }
        });
    },
    
    bankAccountUpdate: function(form){
        var jsonData = JSON.parse(formToJSONString(form));
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/session/account/bank",
            data: jsonData,
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    fgUpdateUserData();
                    dialogClose();
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                App.alert('Erro', 'Ocorreu um erro inesperado ao requisitar informações.', null);
            }
        });
    },
    
    cryptoWalletAccountUpdate: function(form){
        var jsonData = JSON.parse(formToJSONString(form));
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/session/account/crypto-wallet",
            data: jsonData,
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    fgUpdateUserData();
                    dialogClose();
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                App.alert('Erro', 'Ocorreu um erro inesperado ao requisitar informações.', null);
            }
        });
    },
    
    
    
    /**
     * INVOICES
     */
    invoicesCancel: function(_id, code){
        alertOpen({
                title: "Confirmação",
                text: "Confirma o cancelamento do pedido #"+code+"?",
                type: "danger",
                confirmButtonText: "Sim",
                cancelButtonText: "Não"
            },
            function(){
                invoicesCancel({
                    _id: _id
                }).then(function (response) {
                    var _data = response.invoices__cancel;
                    
                    if (_data.canceled == true) {
                        if (typeof fc_invoicesGetAll === "function") {
                            fc_invoicesGetAll();
                        }
                        if (typeof fc_my_store__invoicesGetAll === "function") {
                            fc_my_store__invoicesGetAll();
                        }
                        
                        dialogClose();
                    } else {
                        App.alert('Atenção', "Não foi possível cancelar seu pedido.", null);
                    }
                }).catch(function (error) {
                    App.alert('Erro', error[0].message, null);
                });
            }
        );
    },
    invoicesSetSettled: function(_id, code){
        alertOpen({
                title: "Confirmação",
                text: "Confirma o recebimento do pedido #"+code+"?",
                type: "danger",
                confirmButtonText: "Sim",
                cancelButtonText: "Não"
            },
            function(){
                invoicesSetSettled({
                    _id: _id
                }).then(function (response) {
                    var _data = response.invoices__setSettled;
                    
                    if (_data.success == true) {
                        if (typeof fc_my_store__invoicesGetAll === "function") {
                            fc_my_store__invoicesGetAll();
                        }
                        
                        dialogClose();
                    } else {
                        App.alert('Atenção', "Não foi possível fazer o recebimento do pedido.", null);
                    }
                }).catch(function (error) {
                    App.alert('Erro', error[0].message, null);
                });
            }
        );
    },
    
    invoicesPay: function(code){
        window.open(_appData.settings.store.url + "/compras/" + code + "/pagar", "_blank");
        dialogClose();
    },
    
    
    invoicesDecategorizeById: function(_id){
        invoicesDecategorize({
            _id: _id
        }).then(function (response) {
            var _data = response.invoices__decategorize;
            
            if (_data.success == true) {
                //fc_invoicesGetAll();
                fc_my_storeGetAll();
                //dialogClose();
            } else {
                App.alert('Atenção', "Não foi possível categorizar o pedido.", null);
            }
        }).catch(function (error) {
            App.alert('Erro', error[0].message, null);
        });
    },
    
    invoicesCategorizeById: function(_id){
        invoicesCategorize({
            _id: _id
        }).then(function (response) {
            var _data = response.invoices__categorize;
            
            if (_data.success == true) {
                //fc_invoicesGetAll();
                fc_my_storeGetAll();
                //dialogClose();
            } else {
                App.alert('Atenção', "Não foi possível categorizar o pedido.", null);
            }
        }).catch(function (error) {
            App.alert('Erro', error[0].message, null);
        });
    },
    
    
    /**
     * SECURITY
     */
    passwordUpdate: function(form){
        var jsonData = JSON.parse(formToJSONString(form));
        
        var elPassword = document.querySelector('#formPasswordEdit input[name="password"]');
        var elNew_password = document.querySelector('#formPasswordEdit input[name="new_password"]');
        var elPassword_confirm = document.querySelector('#formPasswordEdit input[name="password_confirm"]');
        
        if ((elPassword.value == "") || (elPassword.value.length < 4)) {
            elPassword.focus();
            elPassword.classList.add("is-invalid");
            document.getElementById("password--invalid-feedback").innerHTML = "A senha deve ter no mínimo 4 caracteres";
            return;
        }
        
        if ((elNew_password.value == "") || (elNew_password.value.length < 4)) {
            elNew_password.focus();
            elNew_password.classList.add("is-invalid");
            document.getElementById("new_password--invalid-feedback").innerHTML = "A senha deve ter no mínimo 4 caracteres";
            return;
        }
        
        if (elNew_password.value != elPassword_confirm.value) {
            elPassword_confirm.focus();
            elPassword_confirm.classList.add("is-invalid");
            document.getElementById("password_confirm--invalid-feedback").innerHTML = "A senha de confirmação não confere";
            return;
        }
        
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/auth/password",
            data: jsonData,
            beforeSend: function (xhr){ 
                xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
            },
            success: function(response) {
                if (response.success === true) {
                    dialogClose();
                } else {
                    var message = "Não foi possível alterar a senha.";
                    
                    if (response.message != null) {
                        message = response.message;
                    }
                    
                    document.querySelector("#formPasswordEdit .error-msg").innerHTML =  
                          '<div class="alert alert-danger alert-dismissible" role="alert">'
                        + '    <div class="d-flex">'
                        + '        <div>'
                        //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                        + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                        + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                        + '                <circle cx="12" cy="12" r="9"></circle>'
                        + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                        + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                        + '            </svg>'
                        + '        </div>'
                        + '        <div>'
                        + '            <h4 class="alert-title">Desculpe...</h4>'
                        + '            <div class="text-muted">'+message+'</div>'
                        + '        </div>'
                        + '    </div>'
                        + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                        + '</div>';
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                
                document.querySelector("#formPasswordEdit .error-msg").innerHTML =  
                          '<div class="alert alert-danger alert-dismissible" role="alert">'
                        + '    <div class="d-flex">'
                        + '        <div>'
                        //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                        + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                        + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                        + '                <circle cx="12" cy="12" r="9"></circle>'
                        + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                        + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                        + '            </svg>'
                        + '        </div>'
                        + '        <div>'
                        + '            <h4 class="alert-title">Desculpe...</h4>'
                        + '            <div class="text-muted">' + jsonResponse.message + '</div>'
                        + '        </div>'
                        + '    </div>'
                        + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                        + '</div>';
            }
        });
    },
    
    
    
    /**
     * POINTS
     */
    pointsAdd: function(username, type, binary_side, value){
        alertOpen({
                title: "Confirm",
                text: "Insert points?",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                $.ajax({
                    type: "POST",
                    url: CFG__API_URL + CFG__API_VERSION + "/points",
                    data: {
                        username: username,
                        type: type,
                        binary_side: binary_side,
                        value: value
                    },
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    success: function(response){
                        if (response.success == true) {
                            if (typeof fc_pointsGetAll === "function") {
                                fc_pointsGetAll("*");
                            }
                            dialogClose();
                        } else {
                            if (response.message != "") {
                                document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                                      '<div class="alert alert-danger alert-dismissible" role="alert">'
                                    + '    <div class="d-flex">'
                                    + '        <div>'
                                    //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                                    + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                    + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                    + '                <circle cx="12" cy="12" r="9"></circle>'
                                    + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                                    + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                                    + '            </svg>'
                                    + '        </div>'
                                    + '        <div>'
                                    + '            <h4 class="alert-title">Sorry...</h4>'
                                    + '            <div class="text-muted">'+response.message+'</div>'
                                    + '        </div>'
                                    + '    </div>'
                                    + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                                    + '</div>';
                            } else {
                                document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                                      '<div class="alert alert-danger alert-dismissible" role="alert">'
                                    + '    <div class="d-flex">'
                                    + '        <div>'
                                    //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                                    + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                    + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                    + '                <circle cx="12" cy="12" r="9"></circle>'
                                    + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                                    + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                                    + '            </svg>'
                                    + '        </div>'
                                    + '        <div>'
                                    + '            <h4 class="alert-title">Sorry...</h4>'
                                    + '            <div class="text-muted">Points not add.</div>'
                                    + '        </div>'
                                    + '    </div>'
                                    + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                                    + '</div>';
                            }
                        }
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                        
                        document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                              '<div class="alert alert-danger alert-dismissible" role="alert">'
                            + '    <div class="d-flex">'
                            + '        <div>'
                            //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                            + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '                <circle cx="12" cy="12" r="9"></circle>'
                            + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                            + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                            + '            </svg>'
                            + '        </div>'
                            + '        <div>'
                            + '            <h4 class="alert-title">Sorry...</h4>'
                            + '            <div class="text-muted">' + jsonResponse.message + '</div>'
                            + '        </div>'
                            + '    </div>'
                            + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                            + '</div>';
                    }
                });
            }
        );
    },
    
    
    
    /**
     * WALLET
     */
    walletWithdrawalBANK: function(form, amount){
        var jsonData = JSON.parse(formToJSONString(form));
        jsonData.amount = justNumber(jsonData.amount);
        
        alertOpen({
                title: "Confirmação",
                text: "Confirma a solicitação de saque de "+fmtMoney(amount)+"?",
                type: "danger",
                confirmButtonText: "Sim",
                cancelButtonText: "Não"
            },
            function(){
                walletWithdrawalRequest(
                    jsonData
                ).then(function (response) {
                    var _data = response.wallet__withdrawalRequest;
                    
                    if (_data != null) {
                        //fc_walletGetListing();
                        dialogClose();
                    } else {
                        document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                              '<div class="alert alert-danger alert-dismissible" role="alert">'
                            + '    <div class="d-flex">'
                            + '        <div>'
                            //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                            + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '                <circle cx="12" cy="12" r="9"></circle>'
                            + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                            + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                            + '            </svg>'
                            + '        </div>'
                            + '        <div>'
                            + '            <h4 class="alert-title">Desculpe...</h4>'
                            + '            <div class="text-muted">Não foi possível realizar a solicitação de saque.</div>'
                            + '        </div>'
                            + '    </div>'
                            + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                            + '</div>';
                    }
                }).catch(function (error) {
                    document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                          '<div class="alert alert-danger alert-dismissible" role="alert">'
                        + '    <div class="d-flex">'
                        + '        <div>'
                        //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                        + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                        + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                        + '                <circle cx="12" cy="12" r="9"></circle>'
                        + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                        + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                        + '            </svg>'
                        + '        </div>'
                        + '        <div>'
                        + '            <h4 class="alert-title">Desculpe...</h4>'
                        + '            <div class="text-muted">' + error[0].message + '</div>'
                        + '        </div>'
                        + '    </div>'
                        + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                        + '</div>';
                });
            }
        );
    },
    
    walletAddUSD: function(amount){
        alertOpen({
                title: "Confirm",
                text: "Confirms the entry of balance of "+fmtMoney(amount/100.0)+"?",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                $.ajax({
                    type: "POST",
                    url: CFG__API_URL + CFG__API_VERSION + "/wallet/coinbase/add-usd",
                    data: {
                        amount: amount
                    },
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    success: function(response){
                        if (response.success == true) {
                            /**
                            //fc_walletGetListing();
                            if (typeof fc_walletGetListing === "function") {
                                fc_walletGetListing("*");
                            }
                            dialogClose();
                            */
                            
                            location.href = response.data.data.hosted_url;
                        } else {
                            if (response.message != "") {
                                document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                                      '<div class="alert alert-danger alert-dismissible" role="alert">'
                                    + '    <div class="d-flex">'
                                    + '        <div>'
                                    //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                                    + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                    + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                    + '                <circle cx="12" cy="12" r="9"></circle>'
                                    + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                                    + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                                    + '            </svg>'
                                    + '        </div>'
                                    + '        <div>'
                                    + '            <h4 class="alert-title">Desculpe...</h4>'
                                    + '            <div class="text-muted">'+response.message+'</div>'
                                    + '        </div>'
                                    + '    </div>'
                                    + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                                    + '</div>';
                            } else {
                                document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                                      '<div class="alert alert-danger alert-dismissible" role="alert">'
                                    + '    <div class="d-flex">'
                                    + '        <div>'
                                    //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                                    + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                    + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                    + '                <circle cx="12" cy="12" r="9"></circle>'
                                    + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                                    + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                                    + '            </svg>'
                                    + '        </div>'
                                    + '        <div>'
                                    + '            <h4 class="alert-title">Desculpe...</h4>'
                                    + '            <div class="text-muted">Não foi possível realizar a solicitação de saque.</div>'
                                    + '        </div>'
                                    + '    </div>'
                                    + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                                    + '</div>';
                            }
                        }
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                        
                        document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                              '<div class="alert alert-danger alert-dismissible" role="alert">'
                            + '    <div class="d-flex">'
                            + '        <div>'
                            //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                            + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '                <circle cx="12" cy="12" r="9"></circle>'
                            + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                            + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                            + '            </svg>'
                            + '        </div>'
                            + '        <div>'
                            + '            <h4 class="alert-title">Desculpe...</h4>'
                            + '            <div class="text-muted">' + jsonResponse.message + '</div>'
                            + '        </div>'
                            + '    </div>'
                            + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                            + '</div>';
                    }
                });
            }
        );
    },
    
    walletWithdrawalUSD: function(coinbase_email, amount){
        alertOpen({
                title: "Confirmação",
                text: "Confirma a solicitação de saque de "+fmtMoney(amount/100.0)+"?",
                type: "danger",
                confirmButtonText: "Sim",
                cancelButtonText: "Não"
            },
            function(){
                $.ajax({
                    type: "POST",
                    url: CFG__API_URL + CFG__API_VERSION + "/wallet/withdraw-request",
                    data: {
                        coinbase_email: coinbase_email,
                        amount: amount
                    },
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    success: function(response){
                        if (response.success == true) {
                            //fc_walletGetListing();
                            if (router.current[0].url == "") {
                                if (typeof indexLoadData === "function") {
                                    indexLoadData();
                                }
                            } else {
                                if (typeof fc_walletGetListing === "function") {
                                    fc_walletGetListing("*");
                                }
                            }
                            
                            dialogClose();
                        } else {
                            if (response.message != "") {
                                document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                                      '<div class="alert alert-danger alert-dismissible" role="alert">'
                                    + '    <div class="d-flex">'
                                    + '        <div>'
                                    //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                                    + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                    + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                    + '                <circle cx="12" cy="12" r="9"></circle>'
                                    + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                                    + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                                    + '            </svg>'
                                    + '        </div>'
                                    + '        <div>'
                                    + '            <h4 class="alert-title">Desculpe...</h4>'
                                    + '            <div class="text-muted">'+response.message+'</div>'
                                    + '        </div>'
                                    + '    </div>'
                                    + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                                    + '</div>';
                            } else {
                                document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                                      '<div class="alert alert-danger alert-dismissible" role="alert">'
                                    + '    <div class="d-flex">'
                                    + '        <div>'
                                    //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                                    + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                    + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                    + '                <circle cx="12" cy="12" r="9"></circle>'
                                    + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                                    + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                                    + '            </svg>'
                                    + '        </div>'
                                    + '        <div>'
                                    + '            <h4 class="alert-title">Desculpe...</h4>'
                                    + '            <div class="text-muted">Não foi possível realizar a solicitação de saque.</div>'
                                    + '        </div>'
                                    + '    </div>'
                                    + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                                    + '</div>';
                            }
                        }
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                        
                        document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                              '<div class="alert alert-danger alert-dismissible" role="alert">'
                            + '    <div class="d-flex">'
                            + '        <div>'
                            //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                            + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '                <circle cx="12" cy="12" r="9"></circle>'
                            + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                            + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                            + '            </svg>'
                            + '        </div>'
                            + '        <div>'
                            + '            <h4 class="alert-title">Desculpe...</h4>'
                            + '            <div class="text-muted">' + jsonResponse.message + '</div>'
                            + '        </div>'
                            + '    </div>'
                            + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                            + '</div>';
                    }
                });
            }
        );
    },
    
    walletWithdrawalPIX: function(key, doc, name, amount){
        alertOpen({
                title: "Confirmação",
                text: "Confirma a solicitação de saque de "+fmtMoney(amount)+"?",
                type: "danger",
                confirmButtonText: "Sim",
                cancelButtonText: "Não"
            },
            function(){
                walletWithdrawalRequest({
                    key: key,
                    doc: doc,
                    name: name,
                    amount: amount
                }).then(function (response) {
                    var _data = response.wallet__withdrawalRequest;
                    
                    if (_data != null) {
                        //fc_walletGetListing();
                        dialogClose();
                    } else {
                        document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                              '<div class="alert alert-danger alert-dismissible" role="alert">'
                            + '    <div class="d-flex">'
                            + '        <div>'
                            //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                            + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '                <circle cx="12" cy="12" r="9"></circle>'
                            + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                            + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                            + '            </svg>'
                            + '        </div>'
                            + '        <div>'
                            + '            <h4 class="alert-title">Desculpe...</h4>'
                            + '            <div class="text-muted">Não foi possível realizar a solicitação de saque.</div>'
                            + '        </div>'
                            + '    </div>'
                            + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                            + '</div>';
                    }
                }).catch(function (error) {
                    document.querySelector("#formWalletWithdrawalNew .error-msg").innerHTML =  
                          '<div class="alert alert-danger alert-dismissible" role="alert">'
                        + '    <div class="d-flex">'
                        + '        <div>'
                        //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                        + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                        + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                        + '                <circle cx="12" cy="12" r="9"></circle>'
                        + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                        + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                        + '            </svg>'
                        + '        </div>'
                        + '        <div>'
                        + '            <h4 class="alert-title">Desculpe...</h4>'
                        + '            <div class="text-muted">' + error[0].message + '</div>'
                        + '        </div>'
                        + '    </div>'
                        + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                        + '</div>';
                });
            }
        );
    },
    
    walletTransfer: function(to_username, name, amount){
        alertOpen({
                title: "Confirm",
                text: "Transfer "+fmtMoney(amount/100.0)+" to "+name+"?",
                type: "danger",
                confirmButtonText: "Yes",
                cancelButtonText: "No"
            },
            function(){
                $.ajax({
                    type: "POST",
                    url: CFG__API_URL + CFG__API_VERSION + "/wallet/transfer",
                    data: {
                        to_username: to_username,
                        name: name,
                        amount: amount
                    },
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    success: function(response){
                        if (response.success == true) {
                            //fc_walletGetListing();
                            if (typeof fc_walletGetListing === "function") {
                                fc_walletGetListing("*");
                            }
                            dialogClose();
                        } else {
                            if (response.message != "") {
                                document.querySelector("#formWalletTransferNew .error-msg").innerHTML =  
                                      '<div class="alert alert-danger alert-dismissible" role="alert">'
                                    + '    <div class="d-flex">'
                                    + '        <div>'
                                    //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                                    + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                    + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                    + '                <circle cx="12" cy="12" r="9"></circle>'
                                    + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                                    + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                                    + '            </svg>'
                                    + '        </div>'
                                    + '        <div>'
                                    + '            <h4 class="alert-title">Desculpe...</h4>'
                                    + '            <div class="text-muted">'+response.message+'</div>'
                                    + '        </div>'
                                    + '    </div>'
                                    + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                                    + '</div>';
                            } else {
                                document.querySelector("#formWalletTransferNew .error-msg").innerHTML =  
                                      '<div class="alert alert-danger alert-dismissible" role="alert">'
                                    + '    <div class="d-flex">'
                                    + '        <div>'
                                    //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                                    + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                    + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                                    + '                <circle cx="12" cy="12" r="9"></circle>'
                                    + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                                    + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                                    + '            </svg>'
                                    + '        </div>'
                                    + '        <div>'
                                    + '            <h4 class="alert-title">Sorry...</h4>'
                                    + '            <div class="text-muted">Failed to transfer.</div>'
                                    + '        </div>'
                                    + '    </div>'
                                    + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                                    + '</div>';
                            }
                        }
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                        
                        document.querySelector("#formWalletTransferNew .error-msg").innerHTML =  
                              '<div class="alert alert-danger alert-dismissible" role="alert">'
                            + '    <div class="d-flex">'
                            + '        <div>'
                            //+ '            <!-- Download SVG icon from http://tabler-icons.io/i/alert-circle -->'
                            + '            <svg xmlns="http://www.w3.org/2000/svg" class="icon alert-icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            + '                <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            + '                <circle cx="12" cy="12" r="9"></circle>'
                            + '                <line x1="12" y1="8" x2="12" y2="12"></line>'
                            + '                <line x1="12" y1="16" x2="12.01" y2="16"></line>'
                            + '            </svg>'
                            + '        </div>'
                            + '        <div>'
                            + '            <h4 class="alert-title">Desculpe...</h4>'
                            + '            <div class="text-muted">' + jsonResponse.message + '</div>'
                            + '        </div>'
                            + '    </div>'
                            + '    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                            + '</div>';
                    }
                });
            }
        );
    },
    
    
    /**
     * SPACES KEYS
     */
    /**spacesGenKey: function(path, permission){
        spacesGenKey({
            path: path,
            permission: permission
        }).then(function (response) {
            localStorage.setItem('tmp__spacesKey', response.spaces__genKey.key);
        }).catch(function (error) {
            localStorage.setItem('tmp__spacesKey', "");
        });
        
        return localStorage.getItem('tmp__spacesKey');
    },*/
    
    
    /**
     * SESSION
     */
    checkSession: function () {
        /**if (cookieGet('__utmo')) {
            setTimeout(Controller.checkSession, 3000);
        } else {
            if (localStorage.getItem('userData') == null) {
                Controller.logout();
            }
        }*/
        
        if (cookieGet('__utmo')) {
            setTimeout(Controller.checkSession, 1000);
        } else {
            Controller.logout();
        }
    },
    logout: function () {
        /**eraseCookie('__utmu', "."+DOMAIN_NAME);
        eraseCookie('__utmo', "."+DOMAIN_NAME);
        eraseCookie('__utmr', "."+DOMAIN_NAME);
        
        window.location.replace(SITE_URL);*/
        
        cookieErase('__utmo', CFG__COOKIE_DOMAIN);
        cookieErase('__utmo', CFG__COOKIE_ADMIN_DOMAIN);
        
        localStorage.clear();
        //location.href = '/login';
        router.navigate('/login');
    }
};

window.addEventListener("load", function(){ Controller.checkSession(); });
///Controller.getSessionAccount();


function introspect(path, permission, callback) {
    return spacesGenKey({
        path: path,
        permission: permission
    }).then(function (response) {
        var objects = {}
        objects = response;
        callback(objects)
    });
}


function f_notificationsGetAll(){
    $.ajax({
        type: "GET",
        url: CFG__API_URL + CFG__API_VERSION + "/accounts/notifications",
        data: {
            read: false,
            order: 'desc'
        },
        beforeSend: function (xhr){ 
            xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
        },
        success: function(response){
            var arr = response.data;
            
            var elApp__list_notifications = document.getElementById("app-list_notifications");
            var elSystemNotificationArea = document.getElementById("system--notification-area");
            
            if (elApp__list_notifications != null) {
                elApp__list_notifications.innerHTML = "";
                
                if (elSystemNotificationArea != null) {
                    elSystemNotificationArea.innerHTML = "";
                }
                
                var countUnread = 0;
                if (arr.length > 0) {
                    for (var i = 0; i < arr.length; i++) {
                        var currentObject = arr[i];
                        var _date = new Date(currentObject._created_at);
                        
                        //›› ` + formatDate(_date, 'dd/MM/yyyy h:m:s')
                        //f_notificationsSetRead(' + currentObject._id + ');
                        
                        var badgeBg = '';
                        switch(currentObject._type) {
                            case "success":
                                badgeBg = 'bg-green';
                            break;
                            case "danger":
                                badgeBg = 'bg-red';
                            break;
                            case "warning":
                                badgeBg = 'bg-yellow';
                            break;
                            case "info":
                                badgeBg = 'bg-blue';
                            break;
                        }
                        
                        var readAnimated = '',
                            btnSetRead = '';
                        if (currentObject._read == false) {
                            readAnimated = 'status-dot-animated';
                            btnSetRead = '<a href="javascript:;" onclick="f_notificationsSetRead(\''+currentObject._id+'\');" class="text-body d-block" style="margin-top: 8px;">Marcar como lido</a>';
                        }
                        
                        elApp__list_notifications.insertAdjacentHTML('beforeend', 
                              '<div class="list-group-item" id="notifications__' + currentObject._id + '">'
                            + '    <div class="row align-items-center">'
                            + '        <div class="col-auto"><span class="status-dot '+readAnimated+' '+badgeBg+' d-block"></span></div>'
                            + '        <div class="col text-truncate">'
                            //+ '            <a href="javascript:;" class="text-body d-block">' + currentObject._subject + '</a>'
                            + '            <span class="text-body d-block">' + currentObject._subject + '</span>'
                            + '            <div class="d-block text-muted text-truncate mt-n1">'
                            +                  currentObject._content
                            + '            </div>'
                            +              btnSetRead
                            + '        </div>'
                            //+ '        <div class="col-auto">'
                            //+ '            <a href="#" class="list-group-item-actions">'
                            //+ '                <svg xmlns="http://www.w3.org/2000/svg" class="icon text-muted" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                            //+ '                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>'
                            //+ '                    <path d="M12 17.75l-6.172 3.245l1.179 -6.873l-5 -4.867l6.9 -1l3.086 -6.253l3.086 6.253l6.9 1l-5 4.867l1.179 6.873z"></path>'
                            //+ '                </svg>'
                            //+ '            </a>'
                            //+ '        </div>'
                            + '    </div>'
                            + '</div>');
                        
                        if (currentObject._display_type == "enter") {
                            var alertType = '',
                                alertBtnType = '';
                            switch(currentObject._type) {
                                case "success":
                                    alertType = 'alert-success';
                                    alertBtnType = 'btn-success';
                                break;
                                case "danger":
                                    alertType = 'alert-danger';
                                    alertBtnType = 'btn-danger';
                                break;
                                case "warning":
                                    alertType = 'alert-warning';
                                    alertBtnType = 'btn-warning';
                                break;
                                case "info":
                                    alertType = 'alert-info';
                                    alertBtnType = 'btn-info';
                                break;
                            }
                            
                            if (elSystemNotificationArea != null) {
                                elSystemNotificationArea.innerHTML += 
                                      '<div class="container-xl data--validation-status--alert" id="system--notifications__' + currentObject._id + '">'
                                    + '    <div class="row row-cards flex-center">'
                                    + '        <div class="col-sm-10 col-lg-8">'
                                    + '            <div class="container-xl">'
                                    + '                <div class="alert ' + alertType + ' alert-dismissible" role="alert">'
                                    + '                    <h3 class="mb-1">' + currentObject._subject + '</h3>'
                                    + '                    <p>'
                                    +                          currentObject._content                        
                                    + '                    </p>'
                                    + '                    <div class="btn-list">'
                                    + '                        <a href="javascript:;" class="btn '+alertBtnType+'" onclick="f_notificationsSetRead(\''+currentObject._id+'\');">Marcar como lido</a>'
                                    + '                        <a class="btn" data-bs-dismiss="alert" aria-label="close">Fechar</a>'
                                    + '                    </div>'
                                    + '                    <a class="btn-close" data-bs-dismiss="alert" aria-label="close"></a>'
                                    + '                </div>'
                                    + '            </div>'
                                    + '        </div>'
                                    + '    </div>'
                                    + '</div>';
                            }
                        }
                        
                        if (currentObject._display_type == "enter_popup") {
                            if (document.getElementById("modal-popup") == null) {
                                dialogOpen('templates/popup/notification_popup.tpl', null, currentObject);
                            }
                        }
                    }
                    
                    document.getElementById("app-notifications--badge").classList.add("badge");
                    document.getElementById("app-notifications--badge").classList.add("bg-red");
                } else {
                    elApp__list_notifications.innerHTML = 
                          '<div class="list-group-item">'
                        + '    <div class="row align-items-center">'
                        + '        Nenhuma notificação'
                        + '    </div>'
                        + '</div>';
                    
                    document.getElementById("app-notifications--badge").classList.remove("badge");
                    document.getElementById("app-notifications--badge").classList.remove("bg-red");
                }
                
                var elNt = document.querySelectorAll(".data__notifications_n");
                if (elNt.length > 0) {
                    for (var i = 0; i < elNt.length; i++) {
                        if (arr.length > 0) {
                            elNt[i].innerHTML = arr.length;
                        } else {
                            elNt[i].innerHTML = "";
                        }
                    }
                }
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            
            console.log(jsonResponse);
        }
    });
}

function f_notificationsSetRead(_id) {
    $.ajax({
        type: "POST",
        url: CFG__API_URL + CFG__API_VERSION + "/accounts/notifications/"+_id+"/setRead",
        data: {},
        beforeSend: function (xhr){ 
            xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
        },
        success: function(response) {
            if (response.success === true) {
                var el = document.getElementById('notifications__' + _id);
                if (el != null) {
                    el.remove();
                }
                
                var el2 = document.getElementById('system--notifications__' + _id);
                if (el2 != null) {
                    el2.remove();
                }
                
                if (typeof fc_notificationsGetAll === "function") {
                    fc_notificationsGetAll();
                }
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            console.log(jsonResponse);
            //App.alert('Erro', 'Ocorreu um erro inesperado ao requisitar informações.', null);
        }
    });
}

function f_notificationsSetAllRead() {
    $.ajax({
        type: "POST",
        url: CFG__API_URL + CFG__API_VERSION + "/accounts/notifications/setAllRead",
        data: {},
        beforeSend: function (xhr){ 
            xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
        },
        success: function(response) {
            if (response.success === true) {
                var elApp__list_notifications = document.getElementById("app-list_notifications");
                elApp__list_notifications.innerHTML = "";
                
                var elNt = document.querySelectorAll(".data__notifications_n");
                if (elNt.length > 0) {
                    for (var i = 0; i < elNt.length; i++) {
                        elNt[i].innerHTML = "";
                    }
                }
                
                ///f_notificationsGetAll();
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
            console.log(jsonResponse);
            //App.alert('Erro', 'Ocorreu um erro inesperado ao requisitar informações.', null);
        }
    });
}


function userGetProfile(){
    /**$.ajax({
        type: "GET",
        url: API_REST_URL+"/accounts/profile",
        headers: {'Authorization': getCookie('jwt')},
        data: {},
        success: function(response){
            if (response.success === true) {
                var elDataName = document.querySelectorAll(".data-users___name");
                if (elDataName.length > 0) {
                    for (var i = 0; i < elDataName.length; i++) {
                        elDataName[i].innerHTML = response.data._name;
                    }
                }
            } else {
                //
            }
        },
        error: function(XMLHttpRequest, textStatus, errorThrown) {
            //
        }
    });*/
}


/*
function formToJSONString(form){
    var obj = {};
    var elements = document.getElementById(form).querySelectorAll( "input, select, textarea" );
    for( var i = 0; i < elements.length; ++i ) {
        var element = elements[i];
        var name = element.name;
        var value = element.value;
        
        if (element.type != "radio") {
            if( name ) {
                if (element.classList.contains("number")) {
                    obj[ name ] = parseInt(value.replace(/[^0-9]/g,''));
                } else if (element.classList.contains("money") || element.classList.contains("percent")) {
                    obj[ name ] = parseInt(value.replace(/[^0-9]/g,''));
                } else {
                    if (value === "true") {
                        obj[ name ] = true;
                    } else if (value === "false") {
                        obj[ name ] = false;
                    } else {
                        obj[ name ] = value;
                    }
                }
            }
        }
    }

    return JSON.stringify( obj );
}
*/
function formToJSONString(form){
    var obj = {};
    var elements = document.getElementById(form).querySelectorAll( "input, select, textarea" );
    for( var i = 0; i < elements.length; ++i ) {
        var element = elements[i];
        var name = element.name;
        var value = element.value;
        
        if (element.type != "radio") {
            if( name ) {
                if (element.classList.contains("number")) {
                    obj[ name ] = parseInt(value.replace(/[^0-9]/g,''));
                } else if (element.classList.contains("money") || element.classList.contains("percent")) {
                    obj[ name ] = parseInt(value.replace(/[^0-9]/g,''));
                } else {
                    if (value === "true") {
                        obj[ name ] = true;
                    } else if (value === "false") {
                        obj[ name ] = false;
                    } else {
                        obj[ name ] = value;
                    }
                }
            }
        } else if (element.type == "radio") {
            if ( name ) {
                if (element.checked) {
                    obj[ name ] = value;
                }
            }
        }
    }

    return JSON.stringify( obj );
}


var newActivationStatus = function(activeUntilDate) {
    var date_curr = new Date();
    date_curr.setMonth(date_curr.getMonth() + 1);
    date_curr.setDate(4);
    
    var date_active_until = new Date(activeUntilDate);
    var status, days;
    
    if (date_active_until > date_curr) {
        return true
    } else {
        return false
    }
}

var newActivationStatus2B = function(activeUntilDate) {
    var date_curr = new Date();
    date_curr.setHours(00, 00, 00);
    
    var date_end = new Date(activeUntilDate);
    date_end.setHours(23, 59, 59);
    var timeDiff = Math.abs(date_end.getTime() - date_curr.getTime());
    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
    
    console.log('1 :: '+(date_end > date_curr));
    console.log('2 :: '+(diffDays > 30));
    
    if (date_end < date_curr) {
        return [false, diffDays]
    } else if (date_end >= date_curr) {
        return [true, diffDays]
    }
}

//# sourceURL=app.js
