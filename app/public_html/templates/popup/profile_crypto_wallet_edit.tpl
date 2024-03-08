<div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title">My crypto wallet</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <form class="form-default" id="formAccountProfileCryptoWalletEdit" name="formAccountProfileCryptoWalletEdit" method="post" action="" role="form">
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-10">
                        <div class="mb-3">
                            <label class="form-label">Wallet</label>
                            <input name="crypto_wallet" type="text" class="form-control" placeholder="Wallet" value="{{system.userdata._crypto_wallet}}" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-10">
                        <div class="mb-3">
                            <label class="form-label">Network</label>
                            <select name="crypto_wallet_network" id="crypto_wallet_network">
                                {{#if system.userdata._crypto_wallet_network}}
                                <option value="{{system.userdata._crypto_wallet_network}}" selected>{{system.userdata._crypto_wallet_network}}</option>
                                {{/if}}
                                <option value="USDT - ERC20">USDT - ERC20</option>
                                <option value="USDT - TRC20">USDT - TRC20</option>
                                <option value="BITCOIN">BITCOIN</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="modal-footer">
            <a href="javascript:;" onclick="formAccountProfileCryptoWalletEdit__Save();" class="btn btn-primary ms-auto">
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
    var formAccountProfileCryptoWalletEdit = document.getElementById('formAccountProfileCryptoWalletEdit');
    formAccountProfileCryptoWalletEdit.onsubmit = function(e){
        e.preventDefault();
        
        document.querySelectorAll('.alert').forEach(elem => {
            elem.remove();
        });
        
        formAccountProfileCryptoWalletEdit__Save();
    }
    
    function formAccountProfileCryptoWalletEdit__Save() {
        Controller.cryptoWalletAccountUpdate('formAccountProfileCryptoWalletEdit');
    }
    
    setTimeout(function(){
        document.querySelector('#formAccountProfileCryptoWalletEdit select[name="crypto_wallet"]').focus();
    }, 500);
</script>
