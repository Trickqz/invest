<div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title">Invoice <b>#{{tmp.__seq}}</b></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
            <div class="card-body">
                <div class="row">
                  <div class="col-6">
                    <p class="h3">{{tmp.doc__shipping_withdrawal_local__account._name}}</p>
                    <address>
                      {{tmp.doc__shipping_withdrawal_local__account.address.0.street}}, nº {{tmp.doc__shipping_withdrawal_local__account.address.0.number}}<br>
                      {{tmp.doc__shipping_withdrawal_local__account.address.0.city}} / {{tmp.doc__shipping_withdrawal_local__account.address.0.state}}<br>
                      {{tmp.doc__shipping_withdrawal_local__account.address.0.postal_code}}<br>
                      {{tmp.doc__shipping_withdrawal_local__account._email}}<br>
                      {{tmp.doc__shipping_withdrawal_local__account.contact.mobile_phone}}
                    </address>
                  </div>
                  <div class="col-6 text-end">
                    <p class="h3">{{tmp.username}} | {{tmp.doc__account._name}}</p>
                    <address>
                      <!--Street Address<br>
                      State, City<br>
                      Region, Postal Code<br>-->
                      {{tmp.doc__account.contact.mobile_phone}}<br>
                      {{tmp.doc__account._email}}<br><br>
                      <!--Criado em {{tmp.created_at}}<br>
                      Pago em {{tmp.due_date}}<br>-->
                      Punctuation of {{{tmp.total__points}}} pts<br>
                      {{{tmp.statusTxt}}}
                    </address>
                  </div>
                  <div class="col-12 my-5">
                    <h1>Invoice #{{tmp.__seq}} | {{tmp.created_at}}</h1>
                  </div>
                </div>
                
                {{{tmp.el__table}}}
                
                <p class="text-muted text-center mt-5">{{{tmp.payment_msg}}}</p>
              </div>
        </div>
        <div class="modal-footer">
            {{{tmp.el__buttons}}}
            <a href="#" class="btn" data-bs-dismiss="modal">
                Close
            </a>
        </div>
    </div>
</div>

<script type="text/javascript">
    function invoicesProcessById(id) {
        $.ajax({
            type: 'PATCH',
            url: _V1API+'/invoices/payments/'+id+'/proccess',
            headers: {
                'Content-Type':'application/x-www-form-urlencoded',
                'Accept': 'application/json',
                'Authorization': _Virtual.Session.Authorization
            },
            crossDomain: true,
            contentType : 'application/json',
            data: {},
            success: function(data){
                if ((!data.error) && (data.result)) {
                    if (whatIsIt(data.result) == "Object") {
                        if (data.result.success == true) {
                            View.showNotification('Processing completed!');
                            Controller.getSessionAccount();
                            //$("#modalForm").modal("hide");
                            
                            dialogClose();
                            
                            invoicesGetListing();
                            invoicesGetMultilevelListing();
                            invoicesPaymentsUnprocessedGetListing();
                        } else {
                            View.showNotification('Processing cannot be performed.', 'danger');
                        }
                    } else {
                        View.showNotification('Your code may be invalid. Check it.', 'danger');
                    }
                } else {
                    View.showNotification(data.error.message, 'danger');
                }
            },
            error: function(xhr){
                View.showNotification('Unknown error. Try again later!', 'danger');
            },
            timeout: 60000
        });
    }
    
    
    function invoicesPrint(_id) {
        var _data = {
                _id: _id
            };
        
        var source = getBackofficeURL('templates/popup-invoices_print.html');
        var template = Handlebars.compile(source);
        var html = template(_data);
        dialogOpen(html, "95%");  //"900px");
    }
</script>
