<!--<div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">-->
    <div class="modal-dialog modal-md modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <div class="modal-title">Withdrawal confirmation</div>
                <div>Withdrawal request to USD wallet.</div>
            </div>
            <div class="modal-body">
                <div>
                    Withdrawal request:<br />
                    Amount: <b>{{tmp._amount_str}}</b><br />
                    Fee: <b>{{tmp._service_fee_str}}</b><br />
                    To be paid: <b>{{tmp._net_amount_str}}</b><br /><br />
                    Transaction: <b>{{tmp._transaction_code}}</b>
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
<!--</div>-->
