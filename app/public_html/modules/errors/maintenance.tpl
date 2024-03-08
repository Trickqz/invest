
        <div class="page page-center">
            <div class="container-tight py-4">
                <div class="empty">
                    <div class="empty-img"><img src="https://cdn.brauntech.com.br/ajax/libs/tabler/1.0.0-beta5/demo/static/illustrations/undraw_quitting_time_dm8t.svg" height="128" alt="" /></div>
                    <p class="empty-title">Temporariamente fora do ar para manutenção</p>
                    <p id="offlineInfo" class="empty-subtitle text-muted">
                        Estamos passando por atualizações e o acesso está indisponível no momento.
                    </p>
                    <p id="offlineContainer"></p>
                    <div class="empty-action">
                        <a href="./." class="btn btn-primary">
                            <!-- Download SVG icon from http://tabler-icons.io/i/arrow-left -->
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <line x1="5" y1="12" x2="19" y2="12" />
                                <line x1="5" y1="12" x2="11" y2="18" />
                                <line x1="5" y1="12" x2="11" y2="6" />
                            </svg>
                            Voltar para home
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <script type="text/javascript">
            if (cookieGet('__utmo')) {
                document.getElementById("offlineContainer").innerHTML += '<span id="offlineInfoReconnect" style="color: #4e4e4e;"></span>';
                
                /** **/
                function startTimer(duration, display) {
                    var timer = duration, minutes, seconds;
                    setInterval(function () {
                        minutes = parseInt(timer / 60, 10);
                        seconds = parseInt(timer % 60, 10);

                        //minutes = minutes < 10 ? "0" + minutes : minutes;
                        //seconds = seconds < 10 ? "0" + seconds : seconds;
                        
                        // display.textContent = "Tentando reconectar em " + minutes + ":" + seconds;
                        display.textContent = "Tentando reconectar em " + seconds + " segundos...";

                        if (--timer < 0) {
                            //timer = duration;
                            location.reload();
                        }
                    }, 1000);
                }
                
                window.onload = function () {
                    //var fiveMinutes = 60 * 1,
                    var fivenineSeconds = 59,
                        display = document.querySelector('#offlineInfoReconnect');
                    startTimer(fivenineSeconds, display);
                };
                /** **/
                
                
                const centrifuge = new Centrifuge("wss://api.centrifugo.brauntech.com.br/centrifugo/connection/websocket");
                centrifuge.setToken(cookieGet('__utmo'));
                
                centrifuge.on('connect', function(ctx) {
                    console.log("connected", ctx);
                });
                
                centrifuge.on('disconnect', function(ctx) {
                    console.log("disconnected", ctx);
                });
                
                centrifuge.subscribe("com.commerce["+CFG__API_KEY+"]", function(ctx) {
                    //document.title = ctx.data.value;
                    
                    if (ctx.data.value == "app.update") {
                        document.title = "Reconectando...";
                        titlenotifier.add();
                        
                        setTimeout(function(){ location.reload(); }, 3000);
                    }
                });
                
                centrifuge.connect();
            }
        </script>
