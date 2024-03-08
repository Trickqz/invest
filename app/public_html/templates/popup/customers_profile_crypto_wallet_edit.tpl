<div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title">Crypto wallet</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form class="form-default" id="formAccountCustomersCryptoWalletEdit" name="formAccountCustomersCryptoWalletEdit" method="post" action="" role="form">
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-10">
                        <div class="mb-3">
                            <label class="form-label">Wallet</label>
                            <input name="crypto_wallet" type="text" class="form-control" placeholder="Wallet" value="{{tmp._crypto_wallet}}" />
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <a href="javascript:;" onclick="formAccountCustomersCryptoWalletEdit__Save();" class="btn btn-primary ms-auto">
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
    var formAccountCustomersCryptoWalletEdit = document.getElementById('formAccountCustomersCryptoWalletEdit');
    formAccountCustomersCryptoWalletEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formAccountCustomersCryptoWalletEdit__Save();
    }
    
    function formAccountCustomersCryptoWalletEdit__Save() {
        //Controller.bankAccountUpdate('formAccountCustomersBankEdit');
        
        var jsonData = JSON.parse(formToJSONString('formAccountCustomersCryptoWalletEdit'));
        
        $.ajax({
            type: "POST",
            url: CFG__API_URL + CFG__API_VERSION + "/accounts/{{tmp._id}}/crypto-wallet",
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
    
    setTimeout(function(){
        document.querySelector('#formAccountCustomersCryptoWalletEdit select[name="crypto_wallet"]').focus();
    }, 500);
</script>
