/*
 * https://gomakethings.com/converting-a-string-into-markup-with-vanilla-js
 * https://stackoverflow.com/questions/59587482/navigo-js-router-root-page-is-reloading
 * https://stackoverflow.com/questions/59665395/problem-with-navigo-router-it-wont-navigate-between-routes
 * https://stackoverflow.com/questions/19501371/get-an-object-from-array-which-contains-a-specific-value
 */

var router;
var el = function (sel) {
    return document.querySelector(sel);
};
/**var setContent = function (id, content, el_name) {
  //el('.js-content').innerHTML = content || el('#content-' + id).innerHTML;
  el(el_name).innerHTML = content || el('#content-' + id).innerHTML;
};**/


var support = (function () {
	if (!window.DOMParser) return false;
	var parser = new DOMParser();
	try {
		parser.parseFromString('x', 'text/html');
	} catch(err) {
		return false;
	}
	return true;
})();

/**
 * Convert a template string into HTML DOM nodes
 * @param  {String} str The template string
 * @return {Node}       The template HTML
 */
var stringToHTML = function (str, returnAsTemplate = true) {
    // If DOMParser is supported, use it
	if (support && !returnAsTemplate) {
		var parser = new DOMParser();
		var doc = parser.parseFromString(str, 'text/html');
		return doc.body;
	}
    
	// Otherwise, fallback to old-school method
	var dom = document.createElement('template');
	dom.innerHTML = str;
	return dom;
};


var didScroll = false,
    lastScrollTop = 0,
    delta = 5;

var setContent = function (__el, __template, __params = null, __data = null, __mode = 'app', __activeMenu = null){
    /* NEW */
/*    if (document.querySelectorAll("div.form-center").length < 1) {
        var formCenter = document.createElement("div");
        formCenter.className = "form-center";
        document.body.appendChild(formCenter);
    }
*/    
    
    if (__mode == 'app') {
        /*document.getElementById("app").classList.remove("mod-wrapper");
        document.getElementById("app").classList.add("mod-app");*/
        
        document.querySelector("body").classList.remove("border-top-wide");
        document.querySelector("body").classList.remove("border-primary");
        document.querySelector("body").classList.remove("d-flex");
        document.querySelector("body").classList.remove("flex-column");
    } else if (__mode == 'wrapper') {
        /*document.getElementById("app").classList.remove("mod-app");
        document.getElementById("app").classList.add("mod-wrapper");*/
        
        document.querySelector("body").classList.add("border-top-wide");
        document.querySelector("body").classList.add("border-primary");
        //document.querySelector("body").classList.add("d-flex");
        document.querySelector("body").classList.add("flex-column");
    }
    
    // #navbar-menu
    if (__activeMenu != null) {
        var el1 = document.querySelectorAll("#navbar-menu .navbar-nav .nav-item");
        if (typeof el1 !== 'undefined' && el1 !== null) {
            for (var i = 0; i < el1.length; i++) {
                if (el1[i].hasAttribute("noselect") == false) {
                    el1[i].classList.remove('active');
                    
                    if (el1[i].getAttribute("data-menu") == __activeMenu) {
                        el1[i].classList.add('active');
                    }
                }
            }
        }
    }
    
    
    ///var t = document.querySelector('[data-template="'+__template+'"]');
    
    xhrpub(__template, function(data) {
        var t0 = '';
        if (__mode == 'app' && __template != '/modules/main.tpl') {
            if (_appData.system.isadmin == false) {
    /**            if (_appData.settings.office.register.use_account_validation) {
                    if (_appData.system.userdata.validation.status == "waiting") {
                        t0 = '<div class="container-fluid bg-red data--validation-status--message" style="height: 33px;text-align: center;line-height: 33px;color: #fff;">Conta pendente de validação.</div>';
                    } else {
                        if (_appData.system.userdata.validation.status == "validating") {
                            t0 = '<div class="container-fluid bg-yellow data--validation-status--message" style="height: 33px;text-align: center;line-height: 33px;color: #fff;">Validação da conta em andamento.</div>';
                        } else {
                            if (_appData.system.userdata.validation.status == "invalidated") {
                                t0 = '<div class="container-fluid bg-red data--validation-status--message" style="height: 33px;text-align: center;line-height: 33px;color: #fff;">Conta não validada.</div>';
                            }/** else {
                                if (_appData.system.userdata.validation.status == "validated") {
                                    //Conta validada
                                }
                            }*/
    /**                    }
                    }
                }*/
            }
        }
        
        var t = stringToHTML(t0 + data);
        
        if (__data != null) {
            Handlebars.registerHelper('checked', function (selected, options) {
                return options.fn(this).replace(new RegExp(' value=\"' + selected + '\"'), '$& checked=""');
            });
            Handlebars.registerHelper('selected', function (selected, options) {
                return options.fn(this).replace(new RegExp(' value=\"' + selected + '\"'), '$& selected="selected"');
            });
            Handlebars.registerHelper('formatdate', function(datetime, format) {
                var x = new Date(datetime);
                var y = format;
                
                // original function
                //formatDate = function date2str(x, y) {
                    var z = {
                        M: x.getMonth() + 1,
                        d: x.getDate(),
                        h: x.getHours(),
                        m: x.getMinutes(),
                        s: x.getSeconds()
                    };
                    y = y.replace(/(M+|d+|h+|m+|s+)/g, function(v) {
                        return ((v.length > 1 ? "0" : "") + eval('z.' + v.slice(-1))).slice(-2)
                    });

                    return y.replace(/(y+)/g, function(v) {
                        return x.getFullYear().toString().slice(-v.length)
                    });
                //}
            });
            Handlebars.registerHelper('formatdoc', function(doc, type) {
                if (type == 'cpf') {
                    return Inputmask.format(doc, { mask: "999.999.999-99" });
                } else if (type == 'cnpj') {
                    return Inputmask.format(doc, { mask: "99.999.999/9999-99" });
                } else {
                    var val = doc;
                    var digit = '';
                    if (val != null) {
                        digit = val.replace(/\D/g, '');
                    }
                    
                    if (digit.length == 11) {
                        return Inputmask.format(doc, { mask: "999.999.999-99" });
                    } else if (digit.length == 14) {
                        return Inputmask.format(doc, { mask: "99.999.999/9999-99" });
                    } else {
                        return '';
                    }
                }
            });
            Handlebars.registerHelper('format', function(input, format) {
                //return jSuites.mask.run(input, format)
                //return Inputmask.format(input, { mask: format });
                return "";
            });
            Handlebars.registerHelper('formatmoney_br', function(input) {
                return fmtMoney(input);
            });
            Handlebars.registerHelper('formatpercentage', function(input) {
                return fmtPercentage(input);
            });
            Handlebars.registerHelper('isdefined', function (value) {
                return value !== undefined;
            });
            Handlebars.registerHelper('contains', function(needle, haystack, options) {
               needle = Handlebars.escapeExpression(needle);
               haystack = Handlebars.escapeExpression(haystack);
               return (haystack.indexOf(needle) > -1) ? options.fn(this) : options.inverse(this);
            });
            
            var template = Handlebars.compile(t.innerHTML);
            var new_template = document.createElement('template');
            new_template.innerHTML = template(__data);
            
            var clone = document.importNode(new_template.content, true); // where true means deep copy
        } else {
            // add to document DOM
            var clone = document.importNode(t.content, true); // where true means deep copy
        }
        
        
        //var body = document.querySelector("body");
    //    var formCenter = document.querySelector(".form-center");
    //    var formList = document.querySelectorAll(".dialog");
        //var form = document.getElementById("dialog");
        
    //    if (formList.length > 0) {
    //        formList[formList.length-1].classList.add("disabled");
    //    }
        
        
    //    var form = document.createElement("div");
        //form.id = "dialog";
    //    if (__template == "viewer__pdf") {
    //        form.className = "dialog full";
    //        __params["title"] = __params.title;
    //    } else {
    //        form.className = "dialog";
    //    }
    //    form.setAttribute('data-src', JSON.stringify(__params));
        

        //var formContent = document.createElement("div");
        //formContent.className = "od-formContent";
        //formContent.innerHTML = ((typeof(content)!=="undefined"))?content:"No content.";
        //formBox.appendChild(formContent);
    //    form.appendChild(clone);
        
        //runScripts(form);
        runScripts(clone);
        
        
        ///document.getElementById('dialog').innerHTML = '';
        ///document.getElementById('dialog').appendChild(clone);
    //    document.getElementsByClassName("form-center")[0].appendChild(form);
        
        //var elInner = document.querySelector(__el);
        
        
        var elINNER = document.querySelector(__el);
        if (elINNER != null) {
            elINNER.innerHTML = '';
            elINNER.appendChild(clone);
            
            ///Inputmask().mask(document.querySelectorAll("input"));
            Inputmask().mask(elINNER.querySelectorAll("input"));
        } // else {
            //setTimeout(function(){ setContent(__el, __template, __params, __data); }, 300);
        //}
        
    //    document.body.classList.add("open");  //"noscroll");
    //    formCenter.style.top = "0";
        //formCenter.style.backgroundColor = "rgba(0, 0, 0, 0.6)";
        
        /**
         * EVENTS
         */
    /*    var __forms = form.querySelectorAll("form");
        __forms.forEach(form => {
            form.addEventListener("keydown", function(e){
                e.target.classList.remove("error");
                e.target.parentElement.classList.remove("error");
                
                /*var sections = document.querySelectorAll('.visible');
                for (i = 0; i < sections.length; i++){
                    sections[i].classList.remove('visible');
                }*/
    /*        });
        });
        
        var inputs__form = document.querySelectorAll("input, select, textarea");
        inputs__form.forEach(input => {
            input.addEventListener(
                "invalid",
                event => {
                    input.classList.add("error");
                },
                false
            );
            input.addEventListener(
                "valid",
                event => {
                    input.classList.remove("error");
                },
                false
            );
            input.addEventListener(
                "blur",
                function() {
                    input.checkValidity();
                }
            );
        });
        
        
        if (CFG__ENABLE_ANIMATION) {
            formCenter.style.display = "flex";
            
            Velocity(form, "transition.slideUpIn", 300);
        } else {
            formCenter.style.display = "flex";
            form.style.display = "flex";
        }
    */
    
    
        var elContent_full = document.querySelector('.content-full');
        if (elContent_full != null) {
            elContent_full.addEventListener('scroll', onScroll);
        }
    });
    
    
    if (typeof toggleMainMenu === "function") {
        toggleMainMenu();
    }
    
    setTimeout(function(){
        // Se existe um tema salvo, seta esse tema, caso contrário, pega o tema do sistema do usuário
        if( userTheme ) {
            setTheme(userTheme);
        } else {
            //setTheme(isPreferredThemeDark.matches ? 'dark' : 'light');
            setTheme('dark');
        }
    }, 100);
}

function onScroll(e) {
    var sticky = document.querySelector('#content-sort');
    var origOffsetY = sticky.offsetTop;
    
    var elContent_full = document.querySelector('.content-full');
    //window.scrollY >= origOffsetY ? sticky.classList.add('fixed') : sticky.classList.remove('fixed');
    elContent_full.scrollTop >= origOffsetY ? sticky.classList.add('fixed') : sticky.classList.remove('fixed');
}


var appLoaded = false;
var routing = function (mode) {
    router = new Navigo("/", mode === 'hash');
    const render = async (__el, __template, __params = null, __data = null, __activeMenu = null, __loggedarea = true) => {
        if (typeof hideFade === 'function') {
            hideFade();
        }
        
        if (appLoaded == false) {
            if (__loggedarea == true && __data.system.userlogged == false) {
                router.navigate('/login');
            } else {
                //if (__loggedarea == true && __data.system.userlogged == false) {
                    setTimeout(function(){
                        setContent('body', '/modules/main.tpl', __params, __data, 'app', __activeMenu);
                        appLoaded = true;
                        
                        setTimeout(function(){ setContent(__el, __template, __params, __data, 'app', __activeMenu); }, 400);
                    }, 400);
                /*} else {
                    router.navigate('/login');
                }*/
            }
        } else {
            //content.innerHTML = await view.render();
            //await view.after_render();
            
            if (__loggedarea == true && __data.system.userlogged == false) {
                router.navigate('/login');
            } else {
                setContent(__el, __template, __params, __data, 'app', __activeMenu);
            }
        }
    };
    
    router
        .on('create-account/:sponsor', (match) => {
            _appData.router = match;
            setContent('body', '/modules/sign-up.tpl', null, _appData, 'wrapper');
        })
        
        .on('login', (match) => {
            _appData.router = match;
            
            //if (_appData.system.userdata != null) {
            //    router.navigate('/conta-bloqueada');
            //    location.reload();
            //} else {
                setContent('body', '/modules/sign-in.tpl', null, _appData, 'wrapper');
            //}
        })
        .on('password/reset', (match) => {
            _appData.router = match;
            //setContent('body', '/modules/password/request-reset.tpl', null, _appData, 'wrapper');
            setContent('body', '/modules/password/forgot-password.tpl', null, _appData, 'wrapper');
        })
        .on('password/confirm-code', (match) => {
            _appData.router = match;
            setContent('body', '/modules/password/confirm-code.tpl', null, _appData, 'wrapper');
        })
        .on('password/reset-password', (match) => {
            _appData.router = match;
            setContent('body', '/modules/password/reset-password.tpl', null, _appData, 'wrapper');
        })
        
        .on('first-access', (match) => {
            _appData.router = match;
            
            if (_appData.system.userdata != null) {
                if (_appData.system.userdata.network.status == "receiving") {
                    //location.href = "/primeiro-acesso";
                    router.navigate('/');
                } else if (_appData.system.userdata.network.status == "awaiting_invoice") {
                    location.href = _appData.settings.store.url;
                } else if (_appData.system.userdata.network.status == "awaiting_payment") {
                    location.href = _appData.settings.store.url + "/compras";
                }
            }
            
            setContent('body', '/modules/first-access.tpl', null, _appData, 'wrapper');
        })
        
        
        
        .on('members', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/customers.tpl', null, _appData, '/members');
        })
        .on('network', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/network.tpl', null, _appData, '/network');
        })
        
        .on('financial', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/financial.tpl', null, _appData, '/financial');
        })
        .on('wallet', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/financial.tpl', null, _appData, '/wallet');
        })
        .on('withdrawal', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/cashout.tpl', null, _appData, '/withdrawal');
        })
        
        .on('licenses', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/quotas.tpl', null, _appData, '/licenses');
        })
        .on('my-licenses', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/quotas.tpl', null, _appData, '/my-licenses');
        })
        .on('my-points', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/points.tpl', null, _appData, '/my-points');
        })
        .on('request', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/income-requests.tpl', null, _appData, '/request');
        })
        
        .on('packs', (match) => {
            _appData.router = match;
            
            if (_appData.system.userdata._role == "financial" || _appData.system.userdata._role == "support") {
                setContent('body', '/modules/no-access.tpl', null, _appData, 'wrapper');
                return;
            }
            
            render('.wrapper .page-wrapper', '/templates/packages.tpl', null, _appData, '/other');
        })
        .on('quotas', (match) => {
            _appData.router = match;
            
            if (_appData.system.userdata._role == "financial" || _appData.system.userdata._role == "support") {
                setContent('body', '/modules/no-access.tpl', null, _appData, 'wrapper');
                return;
            }
            
            render('.wrapper .page-wrapper', '/templates/income.tpl', null, _appData, '/other');
        })
        .on('bonus', (match) => {
            _appData.router = match;
            
            if (_appData.system.userdata._role == "financial" || _appData.system.userdata._role == "support") {
                setContent('body', '/modules/no-access.tpl', null, _appData, 'wrapper');
                return;
            }
            
            render('.wrapper .page-wrapper', '/templates/bonus.tpl', null, _appData, '/other');
        })
        .on('bonus-extract', (match) => {
            _appData.router = match;
            
            /*if (_appData.system.userdata._role == "financial" || _appData.system.userdata._role == "support") {
                setContent('body', '/modules/no-access.tpl', null, _appData, 'wrapper');
                return;
            }*/
            
            render('.wrapper .page-wrapper', '/templates/bonus-extract.tpl', null, _appData, '/other');
        })
        .on('income-extract', (match) => {
            _appData.router = match;
            
            /*if (_appData.system.userdata._role == "financial" || _appData.system.userdata._role == "support") {
                setContent('body', '/modules/no-access.tpl', null, _appData, 'wrapper');
                return;
            }*/
            
            render('.wrapper .page-wrapper', '/templates/income-extract.tpl', null, _appData, '/other');
        })
        .on('points', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/points.tpl', null, _appData, '/other');
        })
        
        /** relatorios **/
        
        .on('upload', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/uploads.tpl', null, _appData, '/upload');
        })
        
        .on('notifications', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/notifications.tpl', null, _appData, '');
        })
        
        .on('logs', (match) => {
            _appData.router = match;
            if (_appData.system.userdata._role != "administrator") {
                setContent('body', '/modules/no-access.tpl', null, _appData, 'wrapper');
                return;
            }
            
            render('.wrapper .page-wrapper', '/templates/logs.tpl', null, _appData, '');
        })
        
        .on('users', (match) => {
            _appData.router = match;
            if (_appData.system.userdata._role != "administrator") {
                setContent('body', '/modules/no-access.tpl', null, _appData, 'wrapper');
                return;
            }
            
            render('.wrapper .page-wrapper', '/templates/users.tpl', null, _appData, '');
        })
        
        
        .on('search', (match) => {
            _appData.router = match;
            render('.wrapper .page-wrapper', '/templates/search.tpl', null, _appData);
        })
        
        
        // set the default route
        .on((match) => {
            _appData.router = match;
            
            /*setContent('main', '/templates/index.tpl', null, _appData);*/
            
            render('.wrapper .page-wrapper', '/templates/index.tpl', null, _appData, '/');
            
            /**if (_appData.system.firstPurchase == true) {
                setTimeout(function(){
                    View.openFormPlanSelect();
                }, 400);
            }*/
            
            /**if (_appData.system.userdata != null) {
                if (_appData.system.userdata.network.status == "waiting_for_plan" || _appData.system.userdata.network.status == "") {
                    //View.openFormPlanSelect();
                    //router.navigate('/primeiro-acesso');
                    location.href = "/primeiro-acesso";
                } else if (_appData.system.userdata.network.status == "awaiting_invoice") {
                    //location.href = _appData.settings.store.url;
                    //View.openFormPlanSelect();
                    //router.navigate('/selecionar-plano');
                    if (_appData.system.userdata.extra__data.plan.registration.enable_access == false) {
                        location.href = _appData.settings.store.url;
                    }
                } else if (_appData.system.userdata.network.status == "awaiting_payment") {
                    if (_appData.system.userdata.extra__data.plan.registration.enable_access == false) {
                        location.href = _appData.settings.store.url + "/compras";
                    }
                }
            }*/
        })
        
        .resolve();
};

var switchModes = function () {
  /** var trigger = el('.js-mode-trigger'); **/
  var mode = 'history-api';
  var isLocalStorageSupported = !!window.localStorage;
  var rerenderTrigger = function (mode) {
    //trigger.querySelector('input').checked = mode === 'hash';
  };

  if (isLocalStorageSupported) {
    mode = localStorage.getItem('navigo') || mode;
  }
  rerenderTrigger(mode);

  /**
    trigger.addEventListener('click', function () {
    mode = mode === 'history-api' ? 'hash' : 'history-api';
    isLocalStorageSupported && localStorage.setItem('navigo', mode);
    window.location.href = (router.root || '').replace('#', '');
    setTimeout(function () {
      window.location.reload(true);
    }, 200);
  });
  **/

  return mode;
};

var init = function () {
  routing(switchModes());
  
  /**document.querySelector('#toDownload').addEventListener('click', function (e) {
    e.preventDefault();
    router.navigate('/download');
  });*/
};







/**
 * TO EXECUTE SCRIPT
 */

/* helpers
 */

// runs an array of async functions in sequential order
function seq (arr, callback, index) {
    if (arr.length == 0) return null;  // mod by iury
    
  // first call, without an index
  if (typeof index === 'undefined') {
    index = 0
  }

  arr[index](function () {
    index++
    if (index === arr.length) {
      callback()
    } else {
      seq(arr, callback, index)
    }
  })
}

// trigger DOMContentLoaded
function scriptsDone () {
  var DOMContentLoadedEvent = document.createEvent('Event')
  DOMContentLoadedEvent.initEvent('DOMContentLoaded', true, true)
  document.dispatchEvent(DOMContentLoadedEvent)
}

/* script runner
 */

function insertScript ($script, callback) {
  var s = document.createElement('script')
  s.type = 'text/javascript'
  if ($script.src) {
    s.onload = callback
    s.onerror = callback
    s.src = $script.src
  } else {
    s.textContent = $script.innerText
  }

  // re-insert the script tag so it executes.
  ///document.head.appendChild(s)
  $script.parentNode.appendChild(s)

  // clean-up
  $script.parentNode.removeChild($script)

  // run the callback immediately for inline scripts
  if (!$script.src) {
    callback()
  }
}

// https://html.spec.whatwg.org/multipage/scripting.html
var runScriptTypes = [
  'application/javascript',
  'application/ecmascript',
  'application/x-ecmascript',
  'application/x-javascript',
  'text/ecmascript',
  'text/javascript',
  'text/javascript1.0',
  'text/javascript1.1',
  'text/javascript1.2',
  'text/javascript1.3',
  'text/javascript1.4',
  'text/javascript1.5',
  'text/jscript',
  'text/livescript',
  'text/x-ecmascript',
  'text/x-javascript'
]

function runScripts ($container) {
  // get scripts tags from a node
  var $scripts = $container.querySelectorAll('script')
  var runList = []
  var typeAttr

  [].forEach.call($scripts, function ($script) {
    typeAttr = $script.getAttribute('type')

    // only run script tags without the type attribute
    // or with a javascript mime attribute value
    if (!typeAttr || runScriptTypes.indexOf(typeAttr) !== -1) {
      runList.push(function (callback) {
        insertScript($script, callback)
      })
    }
  })

  // insert the script tags sequentially
  // to preserve execution order
  seq(runList, scriptsDone)
}



/**
 * FILE
 */
//loadJS("lib/gallery/gallery.js");
function loadJS(file) {
    
    // DOM: Create the script element
    var jsElm = document.createElement("script");
    // set the type attribute
    jsElm.type = "application/javascript";
    // make the script element load file
    jsElm.src = file;
    // finally insert the element to the body element in order to load the script
    document.body.appendChild(jsElm);
    
}

//loadJSCSSFile("myscript.js", "js");
function loadJSCSSFile(filename, filetype) {
    
    if (filetype == "js") { //if filename is a external JavaScript file
        var fileref = document.createElement('script')
        fileref.setAttribute("type", "text/javascript")
        fileref.setAttribute("src", filename)
    } else if (filetype == "css") { //if filename is an external CSS file
        var fileref = document.createElement("link")
        fileref.setAttribute("rel", "stylesheet")
        fileref.setAttribute("type", "text/css")
        fileref.setAttribute("href", filename)
    }
    
    if (typeof fileref != "undefined")
        document.getElementsByTagName("head")[0].appendChild(fileref)
    
}



/*function getOffset( el ) {
    var _x = 0;
    var _y = 0;
    while( el && !isNaN( el.offsetLeft ) && !isNaN( el.offsetTop ) ) {
        _x += el.offsetLeft - el.scrollLeft;
        _y += el.offsetTop - el.scrollTop;
        el = el.offsetParent;
    }
    return { top: _y, left: _x };
}

function getOffset(el) {
  const rect = el.getBoundingClientRect();
  return {
    left: rect.left + window.scrollX,
    top: rect.top + window.scrollY
  };
}

var getAbsPosition = function(el){
    var el2 = el;
    var curtop = 0;
    var curleft = 0;
    if (document.getElementById || document.all) {
        do  {
            curleft += el.offsetLeft-el.scrollLeft;
            curtop += el.offsetTop-el.scrollTop;
            el = el.offsetParent;
            el2 = el2.parentNode;
            while (el2 != el) {
                curleft -= el2.scrollLeft;
                curtop -= el2.scrollTop;
                el2 = el2.parentNode;
            }
        } while (el.offsetParent);

    } else if (document.layers) {
        curtop += el.y;
        curleft += el.x;
    }
    return [curtop, curleft];
};*/

/**
// For really old browser's or incompatible ones
function getOffsetSum(elem) {
    var top = 0,
        left = 0,
        bottom = 0,
        right = 0

     var width = elem.offsetWidth;
     var height = elem.offsetHeight;

    while (elem) {
        top += elem.offsetTop;
        left += elem.offsetLeft;
        elem = elem.offsetParent;
    }

     right = left + width;
     bottom = top + height;

    return {
        top: top,
        left: left,
        bottom: bottom,
        right: right,
    }
}

function getOffsetRect(elem) {
    var box = elem.getBoundingClientRect();

    var body = document.body;
    var docElem = document.documentElement;

    var scrollTop = window.pageYOffset || docElem.scrollTop || body.scrollTop;
    var scrollLeft = window.pageXOffset || docElem.scrollLeft || body.scrollLeft;

    var clientTop = docElem.clientTop;
    var clientLeft = docElem.clientLeft;


    var top = box.top + scrollTop - clientTop;
    var left = box.left + scrollLeft - clientLeft;
    var bottom = top + (box.bottom - box.top);
    var right = left + (box.right - box.left);

    return {
        top: Math.round(top),
        left: Math.round(left),
        bottom: Math.round(bottom),
        right: Math.round(right),
    }
}

function getOffset(elem) {
    if (elem) {
        if (elem.getBoundingClientRect) {
            return getOffsetRect(elem);
        } else { // old browser
            return getOffsetSum(elem);
        }
    } else
        return null;
}**/

// ==============================================
/**window.addEventListener('scroll', function (evt) {
    var Positionsss =  GetTopLeft ();  
    if (EnableConsoleLOGS) { console.log(Positionsss); }
});*/
function GetOffset (object, offset) {
    if (!object) return;
    offset.x += object.offsetLeft;       offset.y += object.offsetTop;
    GetOffset (object.offsetParent, offset);
}
function GetScrolled (object, scrolled) {
    if (!object) return;
    scrolled.x += object.scrollLeft;    scrolled.y += object.scrollTop;
    if (object.tagName.toLowerCase () != "html") {          GetScrolled (object.parentNode, scrolled);        }
}

function GetTopLeft (el) {
    var offset = {x : 0, y : 0};        GetOffset (el, offset);
    var scrolled = {x : 0, y : 0};      GetScrolled (el.parentNode, scrolled);
    var posX = offset.x - scrolled.x;   var posY = offset.y - scrolled.y;
    return {lefttt: posX , toppp: posY };
}
// ==============================================


// ==============================================
function generateRandomInteger(min, max) {
  return Math.floor(min + Math.random()*(max + 1 - min))
}
// ==============================================
///window.onload = init;



/*<!-- Theme Control -->
<script type="text/javascript">*/
    const html = document.querySelector('html');
    /**const metaTheme = document.querySelector('meta[name=theme-color]');**/
    const isPreferredThemeDark = window.matchMedia('(prefers-color-scheme: dark)');
    const userTheme = localStorage.getItem('userTheme');
    /**
    const themes = {
        light: {
            background: '#f3f5fa',
            background_alt: '#ffffff',  //'rgba(218, 214, 214, 0.3)',
            background_alt_hover: '#f9fafd',
            text: '#25262a'
        },
        dark: {
            background: '#25262a',
            background_alt: '#37383c',  //'rgba(218, 214, 214, 0.1)',
            background_alt_hover: '#4c4d52',
            text: '#ffffff'
        }
    };
    **/
    
    // Change colors
    function changeColors(theme) {
        /**
        const themeColors = themes[theme];
        
        Object.keys(themeColors).map(function(key) {
            html.style.setProperty(`--${key}`, themeColors[key]);
        });
        
        metaTheme.setAttribute('content', themeColors['background']);
        **/
        
        
        
        //https://api.spaces.brauntech.com.br/{{settings.spaces.bucket}}/uploads/commerce_files/userapp/images/logo/logo.png
        /**const logo = document.querySelectorAll('.logo img');
        if (logo != null) {
            logo.forEach(
                p => {
                    var imgName = 'logo';
                    if (theme == 'dark') {
                        imgName = 'logo-white';
                    }
                    
                    p.src = 'https://api.spaces.brauntech.com.br/'+_appData.settings.spaces.bucket+'/uploads/commerce_files/userapp/images/logo/'+imgName+'.png';
                    p.srcset = 'https://api.spaces.brauntech.com.br/'+_appData.settings.spaces.bucket+'/uploads/commerce_files/userapp/images/logo/'+imgName+'.svg';
                }
            );
        }**/
        
        setTimeout(function(){
            const nLogo = document.querySelectorAll('.n-logo');
            if (nLogo != null) {
                nLogo.forEach(
                    p => {
                        var imgName = 'logo';
                        if (theme == 'dark') {
                            imgName = 'logo-white';
                        }
                        
                        p.src = '/assets/img/'+imgName+'.png';
                        p.srcset = '/assets/img/'+imgName+'.svg';
                    }
                );
            }
        }, 400);
        
        var elSetTheme = document.getElementById("btn--set-theme");
        if (elSetTheme != null) {
            if (theme == 'dark') {
                document.querySelector("body").classList.add("theme-dark");
                elSetTheme.innerHTML = 'Disable dark mode';
                elSetTheme.setAttribute( "onClick", "setTheme('light');");
            } else if (theme == 'light') {
                document.querySelector("body").classList.remove("theme-dark");
                elSetTheme.innerHTML = 'Enable dark mode';
                elSetTheme.setAttribute( "onClick", "setTheme('dark');");
            }
        } else {
            if (theme == 'dark') {
                document.querySelector("body").classList.add("theme-dark");
            } else if (theme == 'light') {
                document.querySelector("body").classList.remove("theme-dark");
            }
        }
    }
    
    // Set Theme
    function setTheme(theme) {
        changeColors(theme);
        window.__userTheme = theme;
        localStorage.setItem('userTheme', theme);
    }
    
    // Change event when user change theme in the OS
    isPreferredThemeDark.addListener(function(event) {
        setTheme(event.matches ? 'dark' : 'light');
        themeToggle.checked = event.matches;
    });
    
    // Se existe um tema salvo, seta esse tema, caso contrário, pega o tema do sistema do usuário
    /**if( userTheme ) {
        setTheme(userTheme);
    } else {
        setTheme(isPreferredThemeDark.matches ? 'dark' : 'light');
    }**/
/*</script>
<!-- END: /Theme Control -->*/


function FormatStringDate(data) {
    var dia  = data.split("/")[0];
    var mes  = data.split("/")[1];
    var ano  = data.split("/")[2];
    
    return ano + '-' + ("0"+mes).slice(-2) + '-' + ("0"+dia).slice(-2);
    // Utilizo o .slice(-2) para garantir o formato com 2 digitos.
}
