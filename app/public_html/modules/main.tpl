<style>
    canvas {
        position: fixed;
        top: 0;
        z-index: -1;
        width: 100%;
        height: 100%;
        user-select: none;
    }
</style>

<script type="text/javascript">
    var scene = new THREE.Scene();
    var camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);
    var renderer = new THREE.WebGLRenderer();

    renderer.setSize(window.innerWidth, window.innerHeight);
    document.body.appendChild(renderer.domElement);

    var spotLight = new THREE.SpotLight(0xffffff);
    spotLight.position.set(100,100,100);
    spotLight.castShadow = true; //If set to true light will cast dynamic shadows. Warning: This is expensive and requires tweaking to get shadows looking right.
    spotLight.shadowMapWidth = 1024;
    spotLight.shadowMapHeight = 1024;
    spotLight.shadowCameraNear = 500;
    spotLight.shadowCameraFar = 4000;
    spotLight.shadowCameraFov = 30;
    scene.add(spotLight);

    function Mat(){
    var material = new THREE.MeshPhongMaterial({
        color      : new THREE.Color("rgb(35,35,213)"),  //Diffuse color of the material
        emissive   : new THREE.Color("#bb9e73"),
        specular   : new THREE.Color("rgb(93,195,255)"), /*Specular color of the material, i.e., how shiny the material is and the color of its shine. 
                                                        Setting this the same color as the diffuse value (times some intensity) makes the material more metallic-looking; 
                                                        setting this to some gray makes the material look more plastic. Default is dark gray.*/
        shininess  : 1,                                  //How shiny the specular highlight is; a higher value gives a sharper highlight. Default is 30.
        shading    : THREE.FlatShading,                  //How the triangles of a curved surface are rendered: THREE.SmoothShading, THREE.FlatShading, THREE.NoShading
        wireframe  : 1,                                  //THREE.Math.randInt(0,1)
        transparent: 1,
        opacity    : 0.10                               //THREE.Math.randFloat(0,1) 
    });
    return material;
    }

    /* Create Geometry */
    var geometry = new THREE.SphereGeometry(50,20,20,0,Math.PI*2,0,Math.PI);
    //SphereGeometry(radius, widthSegments, heightSegments, phiStart, phiLength, thetaStart, thetaLength)

    /* Create Earth Sphere*/
    var earth = new THREE.Mesh(geometry, Mat());

    /*
    var numSphere = 30;
    var tabSphere = [];
    for(var i=0: i<numSphere; i++){
    tabShpere.push(new Sphere(i));
    scene.add(tabSphere[i].b);
    }
    */

    scene.add(earth);

    camera.position.z = 90;

    function render(){
    requestAnimationFrame(render);
    earth.rotation.x += 0.0005;
    earth.rotation.y += 0.00100;
    earth.position.x = 90;
    renderer.render(scene, camera);
    }
    render();
</script>

<div class="wrapper">
    <canvas></canvas>
    <div class="sticky-top">
        <header class="navbar navbar-expand-md navbar-light sticky-top d-print-none">
            <div class="container-xl">
                <button id="navbar-menu--opt" class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-menu">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <h1 class="navbar-brand navbar-brand-autodark d-none-navbar-horizontal pe-0 pe-md-3" style="padding-top: 0;padding-bottom: 0;">
                    <a href="javascript:router.navigate('/');">
                        <img src="/assets/img/logo-wide.png" srcset="/assets/img/logo-wide.png" width="auto" height="32" alt="Tabler" class="navbar-brand-image" style="height: 22px;" />
                    </a>
                </h1>
                
                <script>
                    /**
                    // CLOSE MENU
                    id="#navbar-menu--opt"
                    aria-expanded="true"
                    class="navbar-toggler" >> class="navbar-toggler collapsed"
                    
                    id="navbar-menu"
                    class="navbar-collapse collapse" >> class="navbar-collapse collapsing" >> class="navbar-collapse collapse show"
                    
                    toggle()
                    show()
                    hide()
                    
                    // element toggle log
                    {
                        "_element": {},
                        "_isTransitioning": false,
                        "_config": {
                            "toggle": false,
                            "parent": null
                        },
                        "_triggerArray": [
                            {}
                        ],
                        "_selector": "#navbar-menu"
                    }**/
                    
                    function toggleMainMenu() {
                        if (isMobile.any()) {
                            document.getElementById('navbar-menu--opt').click();
                        }
                    }
                </script>
                
                <div class="navbar-nav flex-row order-md-last">
                    <div class="nav-item d-none d-md-flex me-3">
                        <div class="btn-list">
                            {{#if system.isadmin}}
                                <div class="my-2 my-md-0 flex-grow-1 flex-md-grow-0 /*order-first order-md-last*/">
                                    <!--<form action="">-->
                                        <div class="input-icon">
                                            <span class="input-icon-addon">
                                                <!-- Download SVG icon from http://tabler-icons.io/i/search -->
                                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                    <circle cx="10" cy="10" r="7" />
                                                    <line x1="21" y1="21" x2="15" y2="15" />
                                                </svg>
                                            </span>
                                            <input id="search_q" name="search_q" type="text" class="form-control" placeholder="Search people..." aria-label="Localizar pessoa..." onkeyup="searchIn(this);" />
                                        </div>
                                    <!--</form>-->
                                    
                                    <script>
                                        function searchIn(el) {
                                            var keyPressed = event.keyCode || event.which;
                                            
                                            //if ENTER is pressed
                                            if (keyPressed==13 && el.value.length >= 1){
                                                //setPage(el);
                                                router.navigate('/search');
                                                if (typeof fc_searchGetAll === 'function') {
                                                    fc_searchGetAll();
                                                }
                                                keyPressed=null;
                                            }
                                        }
                                    </script>
                                </div>
                                
                                <a href="javascript:;" onclick="View.openFormNotificationsSend();" class="btn btn-outline-white" rel="noreferrer">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-brand-telegram" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                       <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                       <path d="M15 10l-4 4l6 6l4 -16l-18 7l4 2l2 6l3 -4"></path>
                                    </svg>
                                    Send notification
                                </a>
                            {{else}}
                                {{#contains "true" settings.donations_service_enabled}}
                                    <a href="javascript:;" onclick="View.openFormDonationsAdd();" class="btn btn-outline-white" rel="noreferrer">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                            <circle cx="6" cy="19" r="2" />
                                            <circle cx="17" cy="19" r="2" />
                                            <path d="M17 17h-11v-14h-2" />
                                            <path d="M6 5l6.005 .429m7.138 6.573l-.143 .998h-13" />
                                            <path d="M15 6h6m-3 -3v6" />
                                        </svg>
                                        Buy
                                    </a>
                                {{else}}
                                {{/contains}}
                                <a href="javascript:;" onclick="View.openFormShare();" class="btn btn-outline-white">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon text-pink" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                        <path d="M19.5 13.572l-7.5 7.428l-7.5 -7.428m0 0a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572" />
                                    </svg>
                                    Share
                                </a>
                            {{/if}}
                            
                            <style>
                                .custom-css1 .ts-control .item {
                                    max-width: 80px;
                                    margin-right: 22px;
                                    overflow: hidden;
                                }
                                .custom-css1 .ts-wrapper.form-select {
                                    max-width: 120px;
                                    max-height: 38px;
                                }
                                .custom-css1 .ts-wrapper.form-select .ts-control, .ts-wrapper.form-select.single.input-active .ts-control {
                                    max-height: 38px;
                                }
                                .custom-css1 .has-items .ts-control>input {
                                    display: none !important;
                                }
                                
                                .flag {
                                    display: none;
                                }
                            </style>
                            <div class="custom-css1 /*mb-3*/">
                                <!--<label class="form-label">Select with flags</label>
                                <select type="text" class="form-select" id="select-countries" value="">
                                    <option value="pl" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-pl&quot;&gt;&lt;/span&gt;">Poland</option>
                                    <option value="de" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-de&quot;&gt;&lt;/span&gt;">Germany</option>
                                    <option value="cz" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-cz&quot;&gt;&lt;/span&gt;">Czech Republic</option>
                                    <option value="br" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-br&quot;&gt;&lt;/span&gt;">Brazil</option>
                                </select>-->
                                
                                <select type="text" class="form-select" id="select-countries" value="" onchange="doGTranslate(this);">
                                    <option value="">Language</option>
                                    <option value="en|af" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-af&quot;&gt;&lt;/span&gt;">Afrikaans</option>
                                    <!--<option value="en|sq" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-sq&quot;&gt;&lt;/span&gt;">Albanian</option>-->
                                    <option value="en|ar" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-ar&quot;&gt;&lt;/span&gt;">Arabic</option>
                                    <option value="en|hy" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-am&quot;&gt;&lt;/span&gt;">Armenian</option>
                                    <option value="en|az" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-az&quot;&gt;&lt;/span&gt;">Azerbaijani</option>
                                    <!--<option value="en|eu" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-eu&quot;&gt;&lt;/span&gt;">Basque</option>-->
                                    <option value="en|be" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-be&quot;&gt;&lt;/span&gt;">Belarusian</option>
                                    <option value="en|bg" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-bg&quot;&gt;&lt;/span&gt;">Bulgarian</option>
                                    <!--<option value="en|ca" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-ca&quot;&gt;&lt;/span&gt;">Catalan</option>-->
                                    <option value="en|zh-CN" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-cn&quot;&gt;&lt;/span&gt;">Chinese (Simplified)</option>
                                    <option value="en|zh-TW" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-cn&quot;&gt;&lt;/span&gt;">Chinese (Traditional)</option>
                                    <option value="en|hr" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-hr&quot;&gt;&lt;/span&gt;">Croatian</option>
                                    <option value="en|cs" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-cz&quot;&gt;&lt;/span&gt;">Czech</option>
                                    <option value="en|da" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-dk&quot;&gt;&lt;/span&gt;">Danish</option>
                                    <option value="en|nl" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-nl&quot;&gt;&lt;/span&gt;">Dutch</option>
                                    <option value="en|en" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-us&quot;&gt;&lt;/span&gt;">English</option>
                                    <option value="en|et" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-et&quot;&gt;&lt;/span&gt;">Estonian</option>
                                    <option value="en|tl" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-tl&quot;&gt;&lt;/span&gt;">Filipino</option>
                                    <option value="en|fi" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-fi&quot;&gt;&lt;/span&gt;">Finnish</option>
                                    <option value="en|fr" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-fr&quot;&gt;&lt;/span&gt;">French</option>
                                    <!--<option value="en|gl" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-gl&quot;&gt;&lt;/span&gt;">Galician</option>-->
                                    <option value="en|ka" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-ge&quot;&gt;&lt;/span&gt;">Georgian</option>
                                    <option value="en|de" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-de&quot;&gt;&lt;/span&gt;">German</option>
                                    <option value="en|el" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-gr&quot;&gt;&lt;/span&gt;">Greek</option>
                                    <option value="en|ht" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-ht&quot;&gt;&lt;/span&gt;">Haitian Creole</option>
                                    <!--<option value="en|iw" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-il&quot;&gt;&lt;/span&gt;">Hebrew</option>-->
                                    <option value="en|hi" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-in&quot;&gt;&lt;/span&gt;">Hindi</option>
                                    <option value="en|hu" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-hu&quot;&gt;&lt;/span&gt;">Hungarian</option>
                                    <!--<option value="en|is" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-is&quot;&gt;&lt;/span&gt;">Icelandic</option>-->
                                    <option value="en|id" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-id&quot;&gt;&lt;/span&gt;">Indonesian</option>
                                    <!--<option value="en|ga" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-ga&quot;&gt;&lt;/span&gt;">Irish</option>-->
                                    <option value="en|it" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-it&quot;&gt;&lt;/span&gt;">Italian</option>
                                    <option value="en|ja" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-jp&quot;&gt;&lt;/span&gt;">Japanese</option>
                                    <option value="en|ko" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-kr&quot;&gt;&lt;/span&gt;">Korean</option>
                                    <option value="en|lv" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-lv&quot;&gt;&lt;/span&gt;">Latvian</option>
                                    <option value="en|lt" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-lt&quot;&gt;&lt;/span&gt;">Lithuanian</option>
                                    <option value="en|mk" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-mk&quot;&gt;&lt;/span&gt;">Macedonian</option>
                                    <!--<option value="en|ms" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-ms&quot;&gt;&lt;/span&gt;">Malay</option>
                                    <option value="en|mt" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-mt&quot;&gt;&lt;/span&gt;">Maltese</option>-->
                                    <option value="en|no" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-no&quot;&gt;&lt;/span&gt;">Norwegian</option>
                                    <option value="en|fa" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-ir&quot;&gt;&lt;/span&gt;">Persian</option>
                                    <option value="en|pl" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-pl&quot;&gt;&lt;/span&gt;">Polish</option>
                                    <option value="en|pt" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-pt&quot;&gt;&lt;/span&gt;">Portuguese</option>
                                    <option value="en|ro" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-ro&quot;&gt;&lt;/span&gt;">Romanian</option>
                                    <option value="en|ru" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-ru&quot;&gt;&lt;/span&gt;">Russian</option>
                                    <option value="en|sr" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-sr&quot;&gt;&lt;/span&gt;">Serbian</option>
                                    <option value="en|sk" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-sk&quot;&gt;&lt;/span&gt;">Slovak</option>
                                    <option value="en|sl" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-sl&quot;&gt;&lt;/span&gt;">Slovenian</option>
                                    <option value="en|es" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-es&quot;&gt;&lt;/span&gt;">Spanish</option>
                                    <option value="en|sw" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-za&quot;&gt;&lt;/span&gt;">Swahili</option>
                                    <option value="en|sv" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-sv&quot;&gt;&lt;/span&gt;">Swedish</option>
                                    <option value="en|th" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-th&quot;&gt;&lt;/span&gt;">Thai</option>
                                    <option value="en|tr" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-tr&quot;&gt;&lt;/span&gt;">Turkish</option>
                                    <option value="en|uk" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-uk&quot;&gt;&lt;/span&gt;">Ukrainian</option>
                                    <option value="en|ur" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-ur&quot;&gt;&lt;/span&gt;">Urdu</option>
                                    <option value="en|vi" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-vi&quot;&gt;&lt;/span&gt;">Vietnamese</option>
                                    <option value="en|cy" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-cy&quot;&gt;&lt;/span&gt;">Welsh</option>
                                    <option value="en|yi" data-custom-properties="&lt;span class=&quot;flag flag-xs flag-country-yi&quot;&gt;&lt;/span&gt;">Yiddish</option>
                                </select>
                            </div>
                            <script>
                                // @formatter:off
                                //document.addEventListener("DOMContentLoaded", function () {
                                (function () {
                                    var el;
                                    window.TomSelect && (new TomSelect(el = document.getElementById('select-countries'), {
                                        copyClassesToDropdown: false,
                                        dropdownClass: 'dropdown-menu',
                                        optionClass:'dropdown-item',
                                        controlInput: '<input>',
                                        render:{
                                            item: function(data,escape) {
                                                if( data.customProperties ){
                                                    return '<div><span class="dropdown-item-indicator">' + data.customProperties + '</span>' + escape(data.text) + '</div>';
                                                }
                                                return '<div>' + escape(data.text) + '</div>';
                                            },
                                            option: function(data,escape){
                                                if( data.customProperties ){
                                                    return '<div><span class="dropdown-item-indicator">' + data.customProperties + '</span>' + escape(data.text) + '</div>';
                                                }
                                                return '<div>' + escape(data.text) + '</div>';
                                            },
                                        },
                                    }));
                                })();
                                //});
                                // @formatter:on
                            </script>
                        </div>
                    </div>
                    
                    <div style="height: 44px;padding: 12px;margin: 6px;text-align: center;display: none;">
                        <!-- GTranslate: https://gtranslate.io/ -->
                        <a href="#" onclick="doGTranslate('en|en');return false;" title="English" class="gflag nturl" style="background-position:-0px -0px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="English" /></a><a href="#" onclick="doGTranslate('en|fr');return false;" title="French" class="gflag nturl" style="background-position:-200px -100px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="French" /></a><a href="#" onclick="doGTranslate('en|de');return false;" title="German" class="gflag nturl" style="background-position:-300px -100px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="German" /></a><a href="#" onclick="doGTranslate('en|it');return false;" title="Italian" class="gflag nturl" style="background-position:-600px -100px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="Italian" /></a><a href="#" onclick="doGTranslate('en|pt');return false;" title="Portuguese" class="gflag nturl" style="background-position:-300px -200px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="Portuguese" /></a><a href="#" onclick="doGTranslate('en|ru');return false;" title="Russian" class="gflag nturl" style="background-position:-500px -200px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="Russian" /></a><a href="#" onclick="doGTranslate('en|es');return false;" title="Spanish" class="gflag nturl" style="background-position:-600px -200px;"><img src="//gtranslate.net/flags/blank.png" height="16" width="16" alt="Spanish" /></a>

                        <style type="text/css">
                        <!--
                        a.gflag {vertical-align:middle;font-size:16px;padding:1px 0;background-repeat:no-repeat;background-image:url(//gtranslate.net/flags/16.png);}
                        a.gflag img {border:0;}
                        a.gflag:hover {background-image:url(//gtranslate.net/flags/16a.png);}
                        #goog-gt-tt {display:none !important;}
                        .goog-te-banner-frame {display:none !important;}
                        .goog-te-menu-value:hover {text-decoration:none !important;}
                        body {top:0 !important;}
                        #google_translate_element2 {display:none!important;}
                        -->
                        </style>

                        <br />
                        <select onchange="doGTranslate(this);">
                            <option value="">Select Language</option>
                            <option value="en|zh-CN">Chinese (Simplified)</option>
                            <option value="en|zh-TW">Chinese (Traditional)</option>
               googleTranslateElementInit2             <option value="en|en">English</option>
                            <option value="en|fr">French</option>
                            <option value="en|de">German</option>
                            <option value="en|pt">Portuguese</option>
                            <option value="en|es">Spanish</option>
                        </select>
                        <div id="google_translate_element2"></div>
                        <script type="text/javascript">
                        function googleTranslateElementInit2() {new google.translate.TranslateElement({pageLanguage: 'en',autoDisplay: false}, 'google_translate_element2');}
                        </script><script type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit2"></script>


                        <script type="text/javascript">
                        /* <![CDATA[ */
                        eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('6 7(a,b){n{4(2.9){3 c=2.9("o");c.p(b,f,f);a.q(c)}g{3 c=2.r();a.s(\'t\'+b,c)}}u(e){}}6 h(a){4(a.8)a=a.8;4(a==\'\')v;3 b=a.w(\'|\')[1];3 c;3 d=2.x(\'y\');z(3 i=0;i<d.5;i++)4(d[i].A==\'B-C-D\')c=d[i];4(2.j(\'k\')==E||2.j(\'k\').l.5==0||c.5==0||c.l.5==0){F(6(){h(a)},G)}g{c.8=b;7(c,\'m\');7(c,\'m\')}}',43,43,'||document|var|if|length|function|GTranslateFireEvent|value|createEvent||||||true|else|doGTranslate||getElementById|google_translate_element2|innerHTML|change|try|HTMLEvents|initEvent|dispatchEvent|createEventObject|fireEvent|on|catch|return|split|getElementsByTagName|select|for|className|goog|te|combo|null|setTimeout|500'.split('|'),0,{}))
                        /* ]]> */
                        </script>
                    </div>
                    
                    <a href="javascript:;" onclick="setTheme('dark');" class="set_themeBtn-hidden nav-link px-0 hide-theme-dark" title="" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-original-title="Enable dark mode">
                        <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M12 3c.132 0 .263 0 .393 0a7.5 7.5 0 0 0 7.92 12.446a9 9 0 1 1 -8.313 -12.454z"></path></svg>
                    </a>
                    <a href="javascript:;" onclick="setTheme('light');" class="set_themeBtn-hidden nav-link px-0 hide-theme-light" title="" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-original-title="Enable light mode">
                        <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><circle cx="12" cy="12" r="4"></circle><path d="M3 12h1m8 -9v1m8 8h1m-9 8v1m-6.4 -15.4l.7 .7m12.1 -.7l-.7 .7m0 11.4l.7 .7m-12.1 -.7l-.7 .7"></path></svg>
                    </a>
                    
                    <style>
                        @media (max-width: 768px) {
                            .set_themeBtn-hidden {
                                display: none!important;
                            }
                        }
                        @media (min-width: 767px) {
                            .set_themeLink-hidden {
                                display: none!important;
                            }
                        }
                    </style>
                    
                    <div class="nav-item dropdown d-none d-md-flex me-3">
                        <a href="#" class="nav-link px-0" data-bs-toggle="dropdown" tabindex="-1" aria-label="Show notifications" title="Show notifications">
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                <path d="M10 5a2 2 0 0 1 4 0a7 7 0 0 1 4 6v3a4 4 0 0 0 2 3h-16a4 4 0 0 0 2 -3v-3a7 7 0 0 1 4 -6" />
                                <path d="M9 17v1a3 3 0 0 0 6 0v-1" />
                            </svg>
                            <span id="app-notifications--badge" class="/*badge bg-red*/"></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-end dropdown-menu-card" style="min-width: 280px;">
                            <div class="card">
                                <div class="card-header">
                                    <h3 class="card-title">Notifications</h3>
                                </div>
                                <div id="app-list_notifications" class="list-group list-group-flush list-group-hoverable">
                                  <!--
                                  <div class="list-group-item">
                                    <div class="row align-items-center">
                                      <div class="col-auto"><span class="status-dot status-dot-animated bg-red d-block"></span></div>
                                      <div class="col text-truncate">
                                        <a href="#" class="text-body d-block">Exemplo 1</a>
                                        <div class="d-block text-muted text-truncate mt-n1">
                                          Change deprecated html tags to text decoration classes (#29604)
                                        </div>
                                      </div>
                                      <div class="col-auto">
                                        <a href="#" class="list-group-item-actions">
                                          <svg xmlns="http://www.w3.org/2000/svg" class="icon text-muted" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M12 17.75l-6.172 3.245l1.179 -6.873l-5 -4.867l6.9 -1l3.086 -6.253l3.086 6.253l6.9 1l-5 4.867l1.179 6.873z"></path></svg>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="list-group-item">
                                    <div class="row align-items-center">
                                      <div class="col-auto"><span class="status-dot d-block"></span></div>
                                      <div class="col text-truncate">
                                        <a href="#" class="text-body d-block">Exemplo 2</a>
                                        <div class="d-block text-muted text-truncate mt-n1">
                                          justify-content:between ⇒ justify-content:space-between (#29734)
                                        </div>
                                      </div>
                                      <div class="col-auto">
                                        <a href="#" class="list-group-item-actions show">
                                          <svg xmlns="http://www.w3.org/2000/svg" class="icon text-yellow" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M12 17.75l-6.172 3.245l1.179 -6.873l-5 -4.867l6.9 -1l3.086 -6.253l3.086 6.253l6.9 1l-5 4.867l1.179 6.873z"></path></svg>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="list-group-item">
                                    <div class="row align-items-center">
                                      <div class="col-auto"><span class="status-dot status-dot-animated bg-green d-block"></span></div>
                                      <div class="col text-truncate">
                                        <a href="#" class="text-body d-block">Exemplo 3</a>
                                        <div class="d-block text-muted text-truncate mt-n1">
                                          Regenerate package-lock.json (#29730)
                                        </div>
                                      </div>
                                      <div class="col-auto">
                                        <a href="#" class="list-group-item-actions">
                                          <svg xmlns="http://www.w3.org/2000/svg" class="icon text-muted" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M12 17.75l-6.172 3.245l1.179 -6.873l-5 -4.867l6.9 -1l3.086 -6.253l3.086 6.253l6.9 1l-5 4.867l1.179 6.873z"></path></svg>
                                        </a>
                                      </div>
                                    </div>
                                  </div>
                                  -->
                                </div>
                                <div class="card-footer">
                                    <a href="javascript:;" onclick="router.navigate('/notifications');" style="">Show all</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    {{#if system.isadmin}}
                    {{else}}
                        <!--<div class="nav-item d-none d-md-flex me-3">
                            <span class="avatar avatar-sm avatar-rounded data--graduation" style="background-image: url('{{CFG__API_URL}}/{{settings.__spaces_bucket}}/uploads/commerce_files/userapp/images/pins/1.png');"></span>
                        </div>-->
                    {{/if}}
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link d-flex lh-1 text-reset p-0" data-bs-toggle="dropdown" aria-label="Open user menu" title="User menu">
                            <span class="avatar avatar-sm avatar-rounded data--profile-picture-src" style="background-image: url('{{CFG__API_URL}}/d/uploads/accounts/{{system.userdata._id}}/profile/picture/{{system.userdata._picture_src}}'), url('../assets/img/picker_account.png');">
                                <!--<span class="badge bg-danger" style="top: 82%;"></span>-->
                            </span>
                            <div class="d-none d-xl-block ps-2">
                                <div class="data--name" style="max-width: 130px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">{{system.userdata._name}}</div>
                                <div class="mt-1 small text-muted data--email" style="max-width: 130px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;display: none;">{{system.userdata._email}}</div>
                                <div class="mt-1 small text-muted" style="max-width: 130px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;/*display: none;*/">{{system.userdata._username}}</div>
                                <div class="mt-1 small text-muted data--graduation" style="max-width: 130px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;display: none;"></div>
                            </div>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                            <a href="javascript:;" onclick="View.openFormProfile();" class="dropdown-item">Profile & account</a>
                            <div class="dropdown-divider set_themeLink-hidden"></div>
                            <a id="btn--set-theme" href="javascript:;" onclick="setTheme('dark');" class="dropdown-item set_themeLink-hidden">Dark theme</a>
                            
                            {{#if system.isadmin}}
                                {{#contains "administrator" system.userdata._role}}
                                    <div class="dropdown-divider"></div>
                                    <a href="javascript:;" onclick="router.navigate('users');" class="dropdown-item">Users</a>
                                    <a href="javascript:;" onclick="router.navigate('logs');" class="dropdown-item">Logs</a>
                                    <a href="javascript:;" onclick="View.settingsOpenForm();" class="dropdown-item">Settings</a>
                                {{else}}
                                {{/contains}}
                            {{else}}
                            {{/if}}
                            
                            <!--<a href="javascript:;" onclick="View.feedbackOpenForm();" class="dropdown-item">Feedback</a>-->
                            <div class="dropdown-divider"></div>
                            <!--<a href="javascript:;" onclick="View.settingsOpenForm();" class="dropdown-item">Configurações</a>-->
                            <a href="javascript:;" onclick="View.passwordEditOpenForm();" class="dropdown-item">Change password</a>
                            <a href="javascript:;" onclick="Controller.logout();" class="dropdown-item">Exit</a>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="navbar-expand-md">
            <div class="collapse navbar-collapse" id="navbar-menu">
                <div class="navbar navbar-light">
                    <div class="container-xl">
                        <ul class="navbar-nav">
                            <li class="nav-item" data-menu="/">
                                <a class="nav-link" href="javascript:router.navigate('/');">
                                    <span class="nav-link-icon d-md-none d-lg-inline-block">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                            <polyline points="5 12 3 12 12 3 21 12 19 12" />
                                            <path d="M5 12v7a2 2 0 0 0 2 2h10a2 2 0 0 0 2 -2v-7" />
                                            <path d="M9 21v-6a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v6" />
                                        </svg>
                                    </span>
                                    <span class="nav-link-title">
                                        Home
                                    </span>
                                </a>
                            </li>
                            
                            {{#if system.isadmin}}
                                <li class="nav-item" data-menu="/members">
                                    <a class="nav-link" href="javascript:router.navigate('/members');">
                                        <span class="nav-link-icon d-md-none d-lg-inline-block">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-user-check" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                               <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                               <circle cx="9" cy="7" r="4"></circle>
                                               <path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2"></path>
                                               <path d="M16 11l2 2l4 -4"></path>
                                            </svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Members
                                        </span>
                                    </a>
                                </li>
                            {{else}}
                            {{/if}}
                            
                            <li class="nav-item" data-menu="/network">
                                <a class="nav-link" href="javascript:router.navigate('/network');">
                                    <span class="nav-link-icon d-md-none d-lg-inline-block">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-users" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                           <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                           <circle cx="9" cy="7" r="4"></circle>
                                           <path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2"></path>
                                           <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                           <path d="M21 21v-2a4 4 0 0 0 -3 -3.85"></path>
                                        </svg>
                                    </span>
                                    <span class="nav-link-title">
                                        Network
                                    </span>
                                </a>
                            </li>
                            
                            {{#if system.isadmin}}
                                <li class="nav-item" data-menu="/financial">
                                    <a class="nav-link" href="javascript:router.navigate('/financial');">
                                        <span class="nav-link-icon d-md-none d-lg-inline-block">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                <path d="M9 5h-2a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h10a2 2 0 0 0 2 -2v-12a2 2 0 0 0 -2 -2h-2" />
                                                <rect x="9" y="3" width="6" height="4" rx="2" />
                                                <path d="M14 11h-2.5a1.5 1.5 0 0 0 0 3h1a1.5 1.5 0 0 1 0 3h-2.5" />
                                                <path d="M12 17v1m0 -8v1" />
                                            </svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Financial
                                        </span>
                                    </a>
                                </li>
                            {{else}}
                                <li class="nav-item" data-menu="/wallet">
                                    <a class="nav-link" href="javascript:router.navigate('/wallet');">
                                        <span class="nav-link-icon d-md-none d-lg-inline-block">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-cash" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                               <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                               <rect x="7" y="9" width="14" height="10" rx="2"></rect>
                                               <circle cx="14" cy="14" r="2"></circle>
                                               <path d="M17 9v-2a2 2 0 0 0 -2 -2h-10a2 2 0 0 0 -2 2v6a2 2 0 0 0 2 2h2"></path>
                                            </svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Wallet
                                        </span>
                                    </a>
                                </li>
                            {{/if}}
                            
                            <li class="nav-item" data-menu="/withdrawal">
                                <a class="nav-link" href="javascript:router.navigate('/withdrawal');">
                                    <span class="nav-link-icon d-md-none d-lg-inline-block">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-cash" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                           <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                           <rect x="7" y="9" width="14" height="10" rx="2"></rect>
                                           <circle cx="14" cy="14" r="2"></circle>
                                           <path d="M17 9v-2a2 2 0 0 0 -2 -2h-10a2 2 0 0 0 -2 2v6a2 2 0 0 0 2 2h2"></path>
                                        </svg>
                                    </span>
                                    <span class="nav-link-title">
                                        Withdraw
                                    </span>
                                </a>
                            </li>
                            
                            {{#if system.isadmin}}
                                <li class="nav-item" data-menu="/licenses">
                                    <a class="nav-link" href="javascript:router.navigate('/licenses');">
                                        <span class="nav-link-icon d-md-none d-lg-inline-block">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                <rect x="4" y="4" width="6" height="5" rx="2" />
                                                <rect x="4" y="13" width="6" height="7" rx="2" />
                                                <rect x="14" y="4" width="6" height="7" rx="2" />
                                                <rect x="14" y="15" width="6" height="5" rx="2" />
                                            </svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Licenses
                                        </span>
                                    </a>
                                </li>
                                <li class="nav-item dropdown" data-menu="/other" style="/*opacity: 0.7;pointer-events: none;*/">
                                    <a class="nav-link dropdown-toggle" href="#navbar-layout" data-bs-toggle="dropdown" role="button" aria-expanded="false">
                                        <span class="nav-link-icon d-md-none d-lg-inline-block">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-box" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                               <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                               <polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3"></polyline>
                                               <line x1="12" y1="12" x2="20" y2="7.5"></line>
                                               <line x1="12" y1="12" x2="12" y2="21"></line>
                                               <line x1="12" y1="12" x2="4" y2="7.5"></line>
                                            </svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Other
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">
                                                {{#contains "administrator" system.userdata._role}}
                                                    <a class="dropdown-item" href="javascript:router.navigate('/packs');">
                                                        Packs
                                                    </a>
                                                    <a class="dropdown-item" href="javascript:router.navigate('/bonus');">
                                                        Bonus
                                                    </a>
                                                {{else}}
                                                {{/contains}}
                                                <a class="dropdown-item" href="javascript:router.navigate('/bonus-extract');">
                                                    Bonification [Extract]
                                                </a>
                                                <a class="dropdown-item" href="javascript:router.navigate('/income-extract');">
                                                    Income [Extract]
                                                </a>
                                                <a class="dropdown-item" href="javascript:router.navigate('/points');">
                                                    Points
                                                </a>
                                                {{#contains "administrator" system.userdata._role}}
                                                    <a class="dropdown-item" href="javascript:router.navigate('/quotas');">
                                                        Quotas
                                                    </a>
                                                {{else}}
                                                {{/contains}}
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            {{else}}
                                <li class="nav-item" data-menu="/my-licenses">
                                    <a class="nav-link" href="javascript:router.navigate('/my-licenses');">
                                        <span class="nav-link-icon d-md-none d-lg-inline-block">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-box" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                               <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                               <polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3"></polyline>
                                               <line x1="12" y1="12" x2="20" y2="7.5"></line>
                                               <line x1="12" y1="12" x2="12" y2="21"></line>
                                               <line x1="12" y1="12" x2="4" y2="7.5"></line>
                                            </svg>
                                        </span>
                                        <span class="nav-link-title">
                                            My licenses
                                        </span>
                                    </a>
                                </li>
                            {{/if}}
                            
                            
                            {{#contains "administrator" system.userdata._role}}
                                <li class="nav-item dropdown" data-menu="/report" style="/*opacity: 0.7;pointer-events: none;*/">
                                    <a class="nav-link dropdown-toggle" href="#navbar-layout" data-bs-toggle="dropdown" role="button" aria-expanded="false">
                                        <span class="nav-link-icon d-md-none d-lg-inline-block">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                <path d="M8 5h-2a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h5.697" />
                                                <path d="M18 14v4h4" />
                                                <path d="M18 11v-4a2 2 0 0 0 -2 -2h-2" />
                                                <rect x="8" y="3" width="6" height="4" rx="2" />
                                                <circle cx="18" cy="18" r="4" />
                                                <path d="M8 11h4" />
                                                <path d="M8 15h3" />
                                            </svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Report
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">
                                                {{#if system.isadmin}}
                                                    <a class="dropdown-item" href="javascript:;" onclick="View.openFormReport_customers();">
                                                        Members
                                                    </a>
                                                {{else}}
                                                {{/if}}
                                                
                                                <a class="dropdown-item" href="javascript:;" onclick="View.openFormReport_quotas();">
                                                    Licenses
                                                </a>
                                                <a class="dropdown-item" href="javascript:;" onclick="View.openFormReport_balance();">
                                                    Financial
                                                </a>
                                                <a class="dropdown-item" href="javascript:;" onclick="View.openFormReport_indicated();">
                                                    Recommendations
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            {{else}}
                                <li class="nav-item dropdown" data-menu="/other" style="/*opacity: 0.7;pointer-events: none;*/">
                                    <a class="nav-link dropdown-toggle" href="#navbar-layout" data-bs-toggle="dropdown" role="button" aria-expanded="false">
                                        <span class="nav-link-icon d-md-none d-lg-inline-block">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-chart-infographic" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                               <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                               <circle cx="7" cy="7" r="4"></circle>
                                               <path d="M7 3v4h4"></path>
                                               <line x1="9" y1="17" x2="9" y2="21"></line>
                                               <line x1="17" y1="14" x2="17" y2="21"></line>
                                               <line x1="13" y1="13" x2="13" y2="21"></line>
                                               <line x1="21" y1="12" x2="21" y2="21"></line>
                                            </svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Extract
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">
                                                <a class="dropdown-item" href="javascript:router.navigate('/bonus-extract');">
                                                    Bonification [Extract]
                                                </a>
                                                <a class="dropdown-item" href="javascript:router.navigate('/income-extract');">
                                                    Income [Extract]
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            {{/contains}}
                            
                            {{#contains "user" system.userdata._role}}
                                <li class="nav-item dropdown" data-menu="/report" style="/*opacity: 0.7;pointer-events: none;*/">
                                    <a class="nav-link dropdown-toggle" href="#navbar-layout" data-bs-toggle="dropdown" role="button" aria-expanded="false">
                                        <span class="nav-link-icon d-md-none d-lg-inline-block">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                <path d="M8 5h-2a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h5.697" />
                                                <path d="M18 14v4h4" />
                                                <path d="M18 11v-4a2 2 0 0 0 -2 -2h-2" />
                                                <rect x="8" y="3" width="6" height="4" rx="2" />
                                                <circle cx="18" cy="18" r="4" />
                                                <path d="M8 11h4" />
                                                <path d="M8 15h3" />
                                            </svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Report
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">
                                                {{#if system.isadmin}}
                                                    <a class="dropdown-item" href="javascript:;" onclick="View.openFormReport_customers();">
                                                        Members
                                                    </a>
                                                {{else}}
                                                {{/if}}
                                                
                                                <a class="dropdown-item" href="javascript:;" onclick="View.openFormReport_quotas();">
                                                    Licenses
                                                </a>
                                                <a class="dropdown-item" href="javascript:;" onclick="View.openFormReport_balance();">
                                                    Financial
                                                </a>
                                                <a class="dropdown-item" href="javascript:;" onclick="View.openFormReport_indicated();">
                                                    Recommendations
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                            {{else}}
                            {{/contains}}
                            
                            <hr style="padding: 0;margin: 10px 22px;">
                            
                            {{#if system.isadmin}}
                            {{else}}
                                {{#contains "true" settings.donations_service_enabled}}
                                    <li class="nav-item d-sm-none" data-menu="#">
                                        <a class="nav-link" href="javascript:;" onclick="View.openFormDonationsAdd();">
                                            <span class="nav-link-icon d-md-none d-lg-inline-block">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                    <circle cx="6" cy="19" r="2" />
                                                    <circle cx="17" cy="19" r="2" />
                                                    <path d="M17 17h-11v-14h-2" />
                                                    <path d="M6 5l6.005 .429m7.138 6.573l-.143 .998h-13" />
                                                    <path d="M15 6h6m-3 -3v6" />
                                                </svg>
                                            </span>
                                            <span class="nav-link-title">
                                                Buy
                                            </span>
                                        </a>
                                    </li>
                                {{else}}
                                {{/contains}}
                                <li class="nav-item d-sm-none" data-menu="#">
                                    <a class="nav-link" href="javascript:;" onclick="View.openFormShare();">
                                        <span class="nav-link-icon d-md-none d-lg-inline-block">
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon text-pink" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                                <path d="M19.5 13.572l-7.5 7.428l-7.5 -7.428m0 0a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572" />
                                            </svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Share
                                        </span>
                                    </a>
                                </li>
                            {{/if}}
                        </ul>
                        <!--<div class="my-2 my-md-0 flex-grow-1 flex-md-grow-0 order-first order-md-last">
                            <!--<form action="">-->
                        <!--        <div class="input-icon">
                                    <span class="input-icon-addon">
                                        <!-- Download SVG icon from http://tabler-icons.io/i/search -->
                        <!--                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                                            <circle cx="10" cy="10" r="7" />
                                            <line x1="21" y1="21" x2="15" y2="15" />
                                        </svg>
                                    </span>
                                    <input id="search_q" name="search_q" type="text" class="form-control" placeholder="Localizar..." aria-label="Localizar..." onkeyup="searchIn(this);" />
                                </div>
                            <!--</form>-->
                            
                        <!--    <script>
                                function searchIn(el) {
                                    var keyPressed = event.keyCode || event.which;
                                    
                                    //if ENTER is pressed
                                    if (keyPressed==13 && el.value.length >= 1){
                                        //setPage(el);
                                        router.navigate('/localizar');
                                        if (typeof fc_searchGetAll === 'function') {
                                            fc_searchGetAll();
                                        }
                                        keyPressed=null;
                                    }
                                }
                            </script>
                        </div>-->
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- TradingView Widget BEGIN -->
    <style>
        .tradingview-widget-container {
            height: 46px !important;
        }
    </style>
    {{#if system.isadmin}}
    {{else}}
        <div class="tradingview-widget-container" style="width: 100%; height: 46px !important;">
            <div class="tradingview-widget-container__widget"></div>
            <div class="tradingview-widget-copyright" style="display: none;">
                <a href="https://www.tradingview.com" rel="noopener" target="_blank"><span class="blue-text">Ticker Tape</span></a> by TradingView
            </div>
            
            <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-ticker-tape.js" async>
                {
                    "symbols": [
                        {
                            "description": "",
                            "proName": "COINBASE:BTCUSD"
                        },
                        {
                            "description": "",
                            "proName": "COINBASE:ETHUSD"
                        },
                        {
                            "description": "",
                            "proName": "BITFINEX:IOTUSD"
                        }
                    ],
                    "colorTheme": "dark",
                    "isTransparent": false,
                    "displayMode": "adaptive",
                    "locale": "en"
                }
            </script>
        </div>
        <!-- TradingView Widget END -->
    {{/if}}
    
    <div class="page-wrapper">
        <!-- -->
    </div>
</div>
<div class="modal modal-blur fade" id="modal-report" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">New report</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input type="text" class="form-control" name="example-text-input" placeholder="Your report name" />
                </div>
                <label class="form-label">Report type</label>
                <div class="form-selectgroup-boxes row mb-3">
                    <div class="col-lg-6">
                        <label class="form-selectgroup-item">
                            <input type="radio" name="report-type" value="1" class="form-selectgroup-input" checked />
                            <span class="form-selectgroup-label d-flex align-items-center p-3">
                                <span class="me-3">
                                    <span class="form-selectgroup-check"></span>
                                </span>
                                <span class="form-selectgroup-label-content">
                                    <span class="form-selectgroup-title strong mb-1">Simple</span>
                                    <span class="d-block text-muted">Provide only basic data needed for the report</span>
                                </span>
                            </span>
                        </label>
                    </div>
                    <div class="col-lg-6">
                        <label class="form-selectgroup-item">
                            <input type="radio" name="report-type" value="1" class="form-selectgroup-input" />
                            <span class="form-selectgroup-label d-flex align-items-center p-3">
                                <span class="me-3">
                                    <span class="form-selectgroup-check"></span>
                                </span>
                                <span class="form-selectgroup-label-content">
                                    <span class="form-selectgroup-title strong mb-1">Advanced</span>
                                    <span class="d-block text-muted">Insert charts and additional advanced analyses to be inserted in the report</span>
                                </span>
                            </span>
                        </label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8">
                        <div class="mb-3">
                            <label class="form-label">Report url</label>
                            <div class="input-group input-group-flat">
                                <span class="input-group-text">
                                    https://tabler.io/reports/
                                </span>
                                <input type="text" class="form-control ps-0" value="report-01" autocomplete="off" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="mb-3">
                            <label class="form-label">Visibility</label>
                            <select class="form-select">
                                <option value="1" selected>Private</option>
                                <option value="2">Public</option>
                                <option value="3">Hidden</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label class="form-label">Client name</label>
                            <input type="text" class="form-control" />
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label class="form-label">Reporting period</label>
                            <input type="date" class="form-control" />
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div>
                            <label class="form-label">Additional information</label>
                            <textarea class="form-control" rows="3"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-link link-secondary" data-bs-dismiss="modal">
                    Cancel
                </a>
                <a href="#" class="btn btn-primary ms-auto" data-bs-dismiss="modal">
                    <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <line x1="12" y1="5" x2="12" y2="19" />
                        <line x1="5" y1="12" x2="19" y2="12" />
                    </svg>
                    Create new report
                </a>
            </div>
        </div>
    </div>

</div>

<!-- Libs JS -->
<script src="https://cdn.brauntech.com.br/ajax/libs/tabler/1.0.0-beta9/dist/libs/apexcharts/dist/apexcharts.min.js"></script>


<!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">-->
<style>
    .support {
        position:fixed;
        width:50px;
        height:50px;
        bottom:16px;
        right:20px;
        background-color:#2d3ba5;
        color:#FFF;
        border-radius:50px;
        text-align:center;
        font-size:30px;
        box-shadow: 0px 0px 1px #888;
        z-index:1000;
        transition: transform .2s; /* Animation */
    }
    .support:hover {
        color: #fff !important;
        transform: scale(1.1); /* (150% zoom - Note: if the zoom is too large, it will go outside of the viewport) */
    }
    /*.support:focus {
        color: #fff !important;
    }
    .support i {
        margin-top:11px;
    }*/
    .support svg {
        fill: transparent;
        height: 34px;
        width: 34px;
        margin: 8px;
    }
</style>

<!--
<a class="support" href="https://support.invest.localm" target="_blank">
    <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-lifebuoy" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
       <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
       <circle cx="12" cy="12" r="4"></circle>
       <circle cx="12" cy="12" r="9"></circle>
       <line x1="15" y1="15" x2="18.35" y2="18.35"></line>
       <line x1="9" y1="15" x2="5.65" y2="18.35"></line>
       <line x1="5.65" y1="5.65" x2="9" y2="9"></line>
       <line x1="18.35" y1="5.65" x2="15" y2="9"></line>
    </svg>
</a>
-->
