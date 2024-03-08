/*
 * WooUI 1.0
 * CSS definitions to create Metro (Windows Phone 8) UI Elements in HTML
 *
 * Copyright 2015, SniperGER
 * Janik Schmidt (SniperGER)
 *
 * Licensed under GNU GPLv2
*/

(function() {
    "use strict";
    window.WooUI = function(params) {
        var app = this;
        
        app.version = "1.0 (2B248d)";
        
        
        app.init = function() {
            /*app.initLinks.appmenu();
            app.initLinks.menu();
            app.initLinks.submenu();
            //app.initLinks.content();
            app.initLinks.tabs();
            View.renderElements();
            
            if (app.params.checkbox)
                app.initCheckboxes();
            
            if (app.params.radios)
                app.initRadios();
            
            if (app.params.theming) {
                app.initDesign.theme();
                app.initDesign.coloredPages();
            }
            
            if (app.params.switches)
                app.initSwitches();
                
            if (app.params.progress)
                app.initProgress();
            
            if (app.params.lists)
                app.initLists();
            
            if (app.params.theming)
                app.initThemeSelector();
            */
            if ('ontouchend' in window) {
                document.body.classList.add("touch");
            }
            
            /*if (document.body.classList.contains("colored") && app.params.theming) {
                document.body.setAttribute("data-bg", "dark");

                for (var i=0; i<document.querySelectorAll("div.list.theme").length; i++) {
                    document.querySelectorAll("div.list.theme")[i].classList.add("disabled");
                }
            }
            if (app.history.length < 1) {
                app.history.push(document.querySelector("div.page:last-child").getAttribute("data-page"));
            }*/
            
            
            window.addEventListener('load', function() {
                //app.animation.pageSlideIn(app.history[app.history.length-1]);
                //app.animation.menuSlideIn("index");
            }, false );
            window.onclick = function(event) {
                event.stopPropagation();
                
                /*
                if (app.listOpen) {
                    setTimeout(function() {
                        for (var i=0; i<document.querySelectorAll("div.list.open").length;i++) {
                            var parent = document.querySelectorAll("div.list.open");
                            
                            document.querySelectorAll("div.list.open")[i].children[1].removeAttribute("style");
                            document.querySelectorAll("div.list.open")[i].classList.remove("open");
                            
                                /** scrool auto => hidden **/
                /*                parent[i].children[1].children[0].style.overflowY = "hidden";
                                parent[i].children[1].children[0].style.maxHeight = "none";
                                
                                var indexInside = indexInParent(parent[i].children[1].querySelector("li.checked"));
                                parent[i].children[1].style.top = "-"+(indexInside*28)+"px";

                                parent[i].children[0].querySelector("option[selected]").removeAttribute("selected");
                                parent[i].children[0].children[indexInside].setAttribute("selected", "");
                        }
                        app.listOpen = false;
                    }, 10);
                }
                
                if (app.contextOpen) {
                    var a = event.target;
                    var els = [];
                    while (a) {
                        els.unshift(a);
                        a = a.parentNode;
                    }
                    if (els.indexOf(document.querySelector("div.popover")) == -1) {
                        setTimeout(function() {
                            document.querySelectorAll("div.popover")[0].classList.add("fade-out");
                            setTimeout(function() {
                                var el = document.querySelectorAll("div.popover")[0];
                                el.parentNode.removeChild(el);
                            }, 100);
                            app.contextOpen = false;
                        }, 10);
                    }
                }
                
                if (app.appMenuOpen) {
                    var a = event.target;
                    var els = [];
                    while (a) {
                        els.unshift(a);
                        a = a.parentNode;
                    }
                    if (els.indexOf(document.querySelector("div.menu-overlay")) > -1) {
                        if ((els.indexOf(document.querySelector("header .menu-overlay div.sub-left")) == -1) && 
                            (els.indexOf(document.querySelector("header .menu-overlay div.sub-right")) == -1)) {
                            for (var i=0; i<document.querySelectorAll("header div.left-menu-bar button.selected").length;i++) {
                                document.querySelectorAll("header div.left-menu-bar button.selected")[i].classList.remove("selected");
                            }
                            app.appMenuOpen = false;
                            
                            document.querySelector("header .menu-overlay").style.display = 'none';
                            document.querySelector("header .menu-overlay .sub-left").classList.remove("slide-in");
                        }
                    }
                }
                
                if (app.accountMenuOpen !== null) {
                    var a = event.target;
                    var els = [];
                    while (a) {
                        els.unshift(a);
                        a = a.parentNode;
                    }
                    
                    if (els.indexOf(document.querySelector("div.menu-overlay")) > -1) {
                        if (((els.indexOf(document.querySelector("header .menu-overlay div.sub-left")) == -1) && 
                            (els.indexOf(document.querySelector("header .menu-overlay div.sub-right")) == -1)) || 
                            els.indexOf(document.querySelector("header .menu-overlay div.sub.sub-right.slide-in div.subframe.active div.title div button.close_sub-button")) != -1) {
                                for (var i=0; i<document.querySelectorAll("header div.right-menu-bar button.selected").length;i++) {
                                    document.querySelectorAll("header div.right-menu-bar button.selected")[i].classList.remove("selected");
                                }
                                app.accountMenuOpen = null;
                                
                                document.querySelector("header .menu-overlay").style.display = 'none';
                                document.querySelector("header .menu-overlay .sub-right").classList.remove("slide-in");
                        }
                    }
                }
                
                if (app.appBarOpen) {
                    var a = event.target;
                    var els = [];
                    while (a) {
                        els.unshift(a);
                        a = a.parentNode;
                    }
                    if (els.indexOf(document.querySelector("div.pages")) > -1) {
                        if (document.querySelector("div.navigation-bar")) {
                            document.querySelector("div.navigation-bar").classList.toggle("minimal");
                        }
                        if (document.querySelector("div.application-bar")) {
                            document.querySelector("div.application-bar").classList.toggle("minimal");
                        }
                        app.appBarOpen = false;
                    }
                }*/
                
                //document.querySelector(".form-center"),
                if (event.target.className == "form-center") {
                    var body = document.querySelector("body");
                    var formCenter = document.querySelector(".form-center");
                    var panel = document.getElementById("panel");
                    
                    if (panel.style.display == "block") {
                        if (CFG__ENABLE_ANIMATION) {
                            Velocity(panel, "transition.slideRightOut", 300);
                            
                            setTimeout(function(){
                                    formCenter.style.display = "none";
                                },
                            160);
                        } else {
                            formCenter.style.display = "none";
                            panel.style.display = "none";
                        }
                        
                        setTimeout(function(){
                                body.classList.remove("formOpen");
                            },
                        500);
                    }
                }
            };
            /*
            if (document.querySelectorAll("div.application-bar").length == 1) {
                document.querySelector("div.application-bar div.icon-more").onclick = function() {
                    var el = this;
                    setTimeout(function() {
                        if (document.querySelectorAll("div.navigation-bar").length == 1) {
                            document.querySelector("div.navigation-bar").classList.remove("minimal");
                        }

                        el.parentNode.classList.remove("minimal");
                        app.appBarOpen = true;
                    }, 10);
                };
                document.querySelector("div.application-bar").onclick = function() {
                    if (!this.classList.contains("minimal")) {
                        app.appBarOpen = true;
                    }
                };
            }
            
            window.oncontextmenu = function(e) {
                if (app.params.barsOnContext) {
                    e.preventDefault();
                    if (document.querySelector("div.navigation-bar")) {
                        document.querySelector("div.navigation-bar").classList.toggle("minimal");
                    }
                    if (document.querySelector("div.application-bar")) {
                        document.querySelector("div.application-bar").classList.toggle("minimal");
                    }
                    app.appBarOpen = !app.appBarOpen;
                    return false;
                }
            };*/

            //var attachFastClick = Origami.fastclick;
            //attachFastClick(document.body);
            document.addEventListener('DOMContentLoaded', function() {
                FastClick.attach(document.body);
            }, false);
            
            
            // CLOSE FORM AND PRINT
            document.addEventListener('keydown', function(event) {
                event = event || window.event;
                var isEscape = false;
                
                // CLOSE FORM
                if ("key" in event) {
                    isEscape = (event.key == "Escape" || event.key == "Esc");
                } else {
                    isEscape = (event.keyCode == 27);
                }
                if (isEscape) {
                    //$("#modalForm").modal("hide");
                    //$("#modalFormLarge").modal("hide");
                    
                    dialogClose();
                    //formClose();
                }
                
                
                // PRINT
                if (event.keyCode === 80 && (event.ctrlKey || event.metaKey) && !event.altKey && (!event.shiftKey || window.chrome || window.opera)) {
                    event.preventDefault();
                    if (event.stopImmediatePropagation) {
                        event.stopImmediatePropagation();
                    } else {
                        event.stopPropagation();
                    }
                    
                    var elPrint = document.getElementById('printf');
                    if (elPrint != null) {
                        document.getElementById('printf').contentWindow.print();
                    }
                    return;
                }
            }, true);
        };
        
        app.notify = function(title,message,callback) {
            if (document.querySelectorAll("div.notification-center").length < 1) {
                var notificationCenter = document.createElement("div");
                notificationCenter.className = "notification-center";
                document.body.appendChild(notificationCenter);
            }
            for (var i=0; i<document.querySelectorAll("div.notification-wrapper").length;i++) {
                var el = document.querySelectorAll("div.notification-wrapper")[i];
                if (el) {
                    el.style.bottom = 20 + ((document.querySelectorAll("div.notification-wrapper").length-i)*100) + "px";
                }
            }

            var notificationWrapper = document.createElement("div");
            notificationWrapper.className = "notification-wrapper";

            var notification = document.createElement("div");
            notification.className = ((app.params.notificationTransitions))?"notification slide-in":"notification";
            notification.addEventListener(app.touchEventStart, function() {
                this.style.webkitTransform = "rotateY(-7deg)";
            });
            notification.addEventListener("mouseover", function() {
                clearTimeout(app.notificationTimeouts[this.id]);
                app.notificationTimeouts[this.id] = undefined;
                this.classList.remove("slide-in");
                this.classList.remove("fade-out");
            });
            notification.addEventListener("mouseup", function() {
                this.removeAttribute("style");
                var parent = this.parentNode;
                this.className = ((app.params.notificationTransitions))?"notification slide-out":"notification";

                setTimeout(function() {
                    parent.parentNode.removeChild(parent);
                    for (var i=0; i<document.querySelectorAll("div.notification-wrapper").length;i++) {
                        var el = document.querySelectorAll("div.notification-wrapper")[i];
                        if (el) {
                            el.style.bottom = 20 + ((document.querySelectorAll("div.notification-wrapper").length-(i+1))*100) + "px";
                        }
                    }
                    if (typeof callback === 'function') {
                        callback();
                    }
                }, ((app.params.notificationTransitions))?300:0);
            });
            
            var notificationClose = document.createElement("div");
            notificationClose.className = "close-box";
            notificationClose.addEventListener(app.touchEventStart, function() {
                var el = this;
                setTimeout(function() {
                    var bottom = el.parentNode.style.bottom;
                    el.parentNode.removeAttribute("style");
                    el.parentNode.style.bottom = bottom;
                }, 0);
            });
            notificationClose.addEventListener("mouseup", function() {
                var parent = this.parentNode.parentNode;
                this.parentNode.className = ((app.params.notificationTransitions))?"notification slide-out":"notification";

                setTimeout(function() {
                    for (var i=0; i<document.querySelectorAll("div.notification-wrapper").length;i++) {
                        var el = document.querySelectorAll("div.notification-wrapper")[i];
                        if (el) {
                            el.style.bottom = 20 + ((document.querySelectorAll("div.notification-wrapper").length-(i+1))*100) + "px";
                        }
                    }
                }, ((app.params.notificationTransitions))?300:0);
            });
            notification.appendChild(notificationClose);

            var notificationTitle = document.createElement("div");
            notificationTitle.className = "title";
            notificationTitle.innerHTML = ((typeof(title)!=="undefined"))?title:app.params.modalDefaultTitle;
            notification.appendChild(notificationTitle);

            var notificationContent = document.createElement("div");
            notificationContent.className = "content";
            var notificationContentText = document.createElement("p");
            notificationContentText.innerHTML = ((typeof(message)!=="undefined"))?message:"No content";
            notificationContent.appendChild(notificationContentText);
            notification.appendChild(notificationContent);
            notificationWrapper.appendChild(notification);

            document.getElementsByClassName("notification-center")[0].appendChild(notificationWrapper);
            
            setTimeout(function() {
                var el = document.querySelector("div.notification-center div.notification-wrapper:last-child div.content");
                var elNot = document.querySelector("div.notification-center div.notification-wrapper:last-child div.notification");
                var ellipsis = new Ellipsis(el);
                
                ellipsis.calc();
                ellipsis.set();
                
                elNot.id = app.notificationTimeouts.length;
                app.notificationTimeouts.push(setTimeout(function() {
                    elNot.classList.add("fade-out");
                    setTimeout(function() {
                        elNot.parentNode.parentNode.removeChild(elNot.parentNode);
                    }, 3000);
                }, 5000));
            }, 10);
        };
        
        app.alert = function(title, text, callback) {
            /*swal({
                title: title,
                text: text,
                //type: 'question',
                //showCancelButton: !0,
                //confirmButtonColor: 'red',
                confirmButtonText: 'OK',
                //cancelButtonText: 'Não'
            }).then((result) => {
                if (result.value) {
                    //
                }
            });*/
            
            alert(text);
            
            /**
            if (document.querySelectorAll("div.notification-center").length < 1) {
                var notificationCenter = document.createElement("div");
                notificationCenter.className = "notification-center";
                document.body.appendChild(notificationCenter);
            }

            var alertBG = document.createElement("div");
            alertBG.className = "notification-background fade-in";
            alertBG.addEventListener("mousewheel", function(e) {
                e.preventDefault();
                e.stopPropagation();
            });

            var alertBox = document.createElement("div");
            alertBox.className = "alert fade-in";
            alertBox.id = "alert";
            alertBox.addEventListener("mousewheel", function(e) {
                e.preventDefault();
                e.stopPropagation();
            });

            var alertTitle = document.createElement("div");
            alertTitle.className = "title";
            alertTitle.innerHTML = ((typeof(title)!=="undefined"))?title:"Untitled";
            alertBox.appendChild(alertTitle);

            var alertContent = document.createElement("div");
            alertContent.className = "content";
            alertContent.innerHTML = ((typeof(message)!=="undefined"))?message:"No content.";
            alertBox.appendChild(alertContent);

            var alertButtonContainer = document.createElement("div");
            alertButtonContainer.className = "button-container";
            var okButton = document.createElement("button");
            okButton.className = "colored";
            okButton.innerHTML = "ok";
            okButton.addEventListener("click", function() {
                document.querySelector("div.notification-background.fade-in").className = "notification-background fade-out";
                document.querySelector("div.alert.fade-in").className = "alert fade-out";

                setTimeout(function() {
                    var alertBGChild = document.querySelector("div.notification-background");
                    var alertChild = document.querySelector("div.alert");

                    alertBGChild.parentNode.removeChild(alertBGChild);
                    alertChild.parentNode.removeChild(alertChild);

                    if (typeof callback === 'function') {
                        callback();
                    }
                }, 200);
            });
            alertButtonContainer.appendChild(okButton);
            alertBox.appendChild(alertButtonContainer);

            document.getElementsByClassName("notification-center")[0].appendChild(alertBG);
            document.getElementsByClassName("notification-center")[0].appendChild(alertBox);

            document.getElementById("alert").style.marginTop = "-" + document.getElementById("alert").clientHeight/2;
            */
        };
        
        app.confirm = function(title,message,callback) {
            if (document.querySelectorAll("div.notification-center").length < 1) {
                var notificationCenter = document.createElement("div");
                notificationCenter.className = "notification-center";
                document.body.appendChild(notificationCenter);
            }

            var alertBG = document.createElement("div");
            alertBG.className = "notification-background fade-in";
            alertBG.addEventListener("mousewheel", function(e) {
                e.preventDefault();
                e.stopPropagation();
            });

            var alertBox = document.createElement("div");
            alertBox.className = "alert fade-in";
            alertBox.id = "alert";
            alertBox.addEventListener("mousewheel", function(e) {
                e.preventDefault();
                e.stopPropagation();
            });

            var alertTitle = document.createElement("div");
            alertTitle.className = "title";
            alertTitle.innerHTML = ((typeof(title)!=="undefined"))?title:"Untitled";
            alertBox.appendChild(alertTitle);

            var alertContent = document.createElement("div");
            alertContent.className = "content";
            alertContent.innerHTML = ((typeof(message)!=="undefined"))?message:"No content.";
            alertBox.appendChild(alertContent);

            var alertButtonContainer = document.createElement("div");
            alertButtonContainer.className = "button-container";
            var cancelButton = document.createElement("button");
            cancelButton.className = "";
            cancelButton.innerHTML = "cancel";
            cancelButton.addEventListener("click", function() {
                document.querySelector("div.notification-background.fade-in").className = "notification-background fade-out";
                document.querySelector("div.alert.fade-in").className = "alert fade-out";

                setTimeout(function() {
                    var alertBGChild = document.querySelector("div.notification-background");
                    var alertChild = document.querySelector("div.alert");

                    alertBGChild.parentNode.removeChild(alertBGChild);
                    alertChild.parentNode.removeChild(alertChild);
                }, 200);
            });
            alertButtonContainer.appendChild(cancelButton);
            var okButton = document.createElement("button");
            okButton.className = "colored inline";
            okButton.innerHTML = "ok";
            okButton.addEventListener("click", function() {
                document.querySelector("div.notification-background.fade-in").className = "notification-background fade-out";
                document.querySelector("div.alert.fade-in").className = "alert fade-out";

                setTimeout(function() {
                    var alertBGChild = document.querySelector("div.notification-background");
                    var alertChild = document.querySelector("div.alert");

                    alertBGChild.parentNode.removeChild(alertBGChild);
                    alertChild.parentNode.removeChild(alertChild);

                    if (typeof callback === 'function') {
                        callback();
                    }
                }, 200);
            });
            alertButtonContainer.appendChild(okButton);

            alertBox.appendChild(alertButtonContainer);

            document.getElementsByClassName("notification-center")[0].appendChild(alertBG);
            document.getElementsByClassName("notification-center")[0].appendChild(alertBox);

            document.getElementById("alert").style.marginTop = "-" + document.getElementById("alert").clientHeight/2;
        };
        
        /*
        app.form = function(title, content, button, callback) { alert(999999);
            if (document.querySelectorAll("div.form-center").length < 1) {
                var formCenter = document.createElement("div");
                formCenter.className = "form-center fade-in";
                document.body.appendChild(formCenter);
            }

            var formBox = document.createElement("div");
            formBox.className = "form right slide-in";
            
            var formContent = document.createElement("div");
            formContent.className = "od-formContent";
            formContent.innerHTML = ((typeof(content)!=="undefined"))?content:"No content.";
            formBox.appendChild(formContent);
            
            var formTopBar = document.createElement("div");
            formTopBar.className = "od-topBar";
            var formTopBarButtonContainer = document.createElement("div");
            formTopBarButtonContainer.id = "form-od-topBar-commandBar";
            formTopBarButtonContainer.className = "od-topBar-commandBar";
            
            var separatorL = document.createElement("div");
            separatorL.className = "separator left";
            formTopBarButtonContainer.appendChild(separatorL);
            
            if (button == "back") {
                var backButton = document.createElement("button");
                backButton.className = "left";
                backButton.innerHTML = '<div class="commandBar-itemWrapper">'+
                                         '   <i class="back"></i>'+
                                         '   <span class="label o365buttonLabel _fce_r">Voltar</span>'+
                                         '</div>';
                backButton.addEventListener("click", function() {
                    document.querySelector("div.form.right.slide-in").className = "form right slide-out";
                    document.querySelector("div.form-center.fade-in").className = "form-center fade-out";
                    
                    setTimeout(function() {
                        var formBGChild = document.querySelector("div.form-center");
                        var formChild = document.querySelector("div.form");

                        formBGChild.parentNode.removeChild(formBGChild);
                        formChild.parentNode.removeChild(formChild);
                    }, 200);
                });
                formTopBarButtonContainer.appendChild(backButton);
            }
            
            if (button == "save" || button == "saveCancel") {
                var okButton = document.createElement("button");
                okButton.className = "left";
                okButton.innerHTML = '<div class="commandBar-itemWrapper">'+
                                     '   <i class="accept"></i>'+
                                     '   <span class="label o365buttonLabel _fce_r">Salvar</span>'+
                                     '</div>';
                okButton.addEventListener("click", function() {
                    if (typeof callback === 'function') {
                        if (callback() === true) {
                            document.querySelector("div.form.right.slide-in").className = "form right slide-out";
                            document.querySelector("div.form-center.fade-in").className = "form-center fade-out";
                            
                            setTimeout(function() {
                                var formBGChild = document.querySelector("div.form-center");
                                var formChild = document.querySelector("div.form");

                                formBGChild.parentNode.removeChild(formBGChild);
                                formChild.parentNode.removeChild(formChild);
                            }, 200);
                        }
                    }
                });
                formTopBarButtonContainer.appendChild(okButton);
            }
            
            if (button == "printCancel") {
                var printButton = document.createElement("button");
                printButton.className = "left";
                printButton.innerHTML = '<div class="commandBar-itemWrapper">'+
                                         '   <i class="scan"></i>'+
                                         '   <span class="label o365buttonLabel _fce_r">Imprimir</span>'+
                                         '</div>';
                printButton.addEventListener("click", function() {
                    //window.frames["printf"].focus();
                    //window.frames["printf"].print();
                    document.getElementById('printf').contentWindow.print();
                });
                formTopBarButtonContainer.appendChild(printButton);
            }
            
            if (button == "saveCancel" || button == "printCancel" || button == "cancel") {
                var cancelButton = document.createElement("button");
                cancelButton.className = "left";
                cancelButton.innerHTML = '<div class="commandBar-itemWrapper">'+
                                         '   <i class="cancel"></i>'+
                                         '   <span class="label o365buttonLabel _fce_r">Cancelar</span>'+
                                         '</div>';
                cancelButton.addEventListener("click", function() {
                    document.querySelector("div.form.right.slide-in").className = "form right slide-out";
                    document.querySelector("div.form-center.fade-in").className = "form-center fade-out";
                    
                    setTimeout(function() {
                        var formBGChild = document.querySelector("div.form-center");
                        var formChild = document.querySelector("div.form");

                        formBGChild.parentNode.removeChild(formBGChild);
                        formChild.parentNode.removeChild(formChild);
                    }, 200);
                });
                formTopBarButtonContainer.appendChild(cancelButton);
            }
            
            
            
            var closeButton = document.createElement("button");
            closeButton.className = "right";
            closeButton.innerHTML = '<div class="commandBar-itemWrapper">'+
                                 '   <i class="cancel" style="top: 0px !important;"></i>'+
                                 '   <span class="label o365buttonLabel _fce_r"></span>'+
                                 '</div>';
            closeButton.addEventListener("click", function() {
                document.querySelector("div.form.right.slide-in").className = "form right slide-out";
                document.querySelector("div.form-center.fade-in").className = "form-center fade-out";
                
                setTimeout(function() {
                    var formBGChild = document.querySelector("div.form-center");
                    var formChild = document.querySelector("div.form");
                    
                    formBGChild.parentNode.removeChild(formBGChild);
                    formChild.parentNode.removeChild(formChild);
                }, 200);
            });
            formTopBarButtonContainer.appendChild(closeButton);
            
            var separatorR = document.createElement("div");
            separatorR.className = "separator right";
            formTopBarButtonContainer.appendChild(separatorR);
            
            
            formTopBar.appendChild(formTopBarButtonContainer);
            formBox.appendChild(formTopBar);

            document.getElementsByClassName("form-center")[0].appendChild(formBox);
            
            
            app.init();
        };
        */
        
        app.dialog = function(__dialog, maxWidth = "680px") {
            var t = document.querySelector('[data-template="'+__dialog+'"]');
            
            // add to document DOM
            var clone = document.importNode(t.content, true); // where true means deep copy
            //document.querySelector("main").appendChild(clone);
            
            //var main_content = document.querySelector("main");
            //main_content.innerHTML = "";
            //main_content.appendChild(clone);
            
            
            
            
            var body = document.querySelector("body");
            var formCenter = document.querySelector(".form-center");
            var form = document.getElementById("dialog");
            
            document.getElementById('dialog').innerHTML = '';
            document.getElementById('dialog').appendChild(clone);
            
            /** **/
            //console.log(Inputmask.format("1157381", { alias: "currencyUSD" }));
            Inputmask().mask(document.getElementById('dialog').querySelectorAll("input"));
            /** **/
            
            body.classList.add("formOpen");
            formCenter.style.top = "0";
            formCenter.style.backgroundColor = "rgba(0, 0, 0, 0.6)";
            form.style.maxWidth = maxWidth;
            
            if (CFG__ENABLE_ANIMATION) {
                formCenter.style.display = "grid";
                
                Velocity(form, "transition.slideUpIn", 300);
            } else {
                formCenter.style.display = "grid";
                form.style.display = "block";
            }
        }
        
        app.form = function(__form, maxWidth = "680px") {
            var t = document.querySelector('[data-template="'+__form+'"]');
            
            // add to document DOM
            var clone = document.importNode(t.content, true); // where true means deep copy
            //document.querySelector("main").appendChild(clone);
            
            //var main_content = document.querySelector("main");
            //main_content.innerHTML = "";
            //main_content.appendChild(clone);
            
            
            
            
            var body = document.querySelector("body");
            var formCenter = document.querySelector(".form-center");
            var form = document.getElementById("dialog");
            
            document.getElementById('dialog').innerHTML = '';
            document.getElementById('dialog').appendChild(clone);
            
            /** **/
            //console.log(Inputmask.format("1157381", { alias: "currencyUSD" }));
            Inputmask().mask(document.getElementById('dialog').querySelectorAll("input"));
            /** **/
            
            body.classList.add("formOpen");
            formCenter.style.top = "0";
            formCenter.style.backgroundColor = "rgba(0, 0, 0, 0.6)";
            form.style.maxWidth = maxWidth;
            
            if (CFG__ENABLE_ANIMATION) {
                formCenter.style.display = "grid";
                
                Velocity(form, "transition.slideUpIn", 300);
            } else {
                formCenter.style.display = "grid";
                form.style.display = "block";
            }
        }
        
        app.panel = function(template) {  //, callback) {
            var t = document.querySelector('[data-template="panel__' + template + '"]');
            
            // set
            //t.content.querySelector('img').src = 'demo.png';
            //t.content.querySelector('p').textContent= 'demo text';
            
            // add to document DOM
            var clone = document.importNode(t.content, true); // where true means deep copy
            //document.querySelector("main").appendChild(clone);
            
            //panelOpen(clone);
            
            
            var body = document.querySelector("body");
            var formCenter = document.querySelector(".form-center");
            var panel = document.getElementById("panel");
            
            document.getElementById('panel').innerHTML = '';
            document.getElementById('panel').appendChild(clone);
            
            /** **/
            //console.log(Inputmask.format("1157381", { alias: "currencyUSD" }));
            Inputmask().mask(document.getElementById('panel').querySelectorAll("input"));
            /** **/
            
            
            //body.classList.add("formOpen");
            formCenter.style.backgroundColor = "rgba(255, 255, 255, 0.6)";
            
            if (isMobile.any()) {
                formCenter.style.top = "0";
            } else {
                formCenter.style.top = "50px";
            }
            
            if (CFG__ENABLE_ANIMATION) {
                formCenter.style.display = "grid";
                
                Velocity(panel, "transition.slideRightIn", 300);
            } else {
                formCenter.style.display = "grid";
                panel.style.display = "block";
            }
        }
        
        
        app.init();
    };
})();


function dialogClose() {
    /**var body = document.querySelector("body");
    var formCenter = document.querySelector(".form-center");
    var form = document.getElementById("dialog");
    
    if (CFG__ENABLE_ANIMATION) {
        Velocity(form, "transition.slideDownOut", 300);
        
        setTimeout(function(){
                formCenter.style.display = "none";
            },
        160);
    } else {
        formCenter.style.display = "none";
        form.style.display = "none";
    }
    
    setTimeout(function(){
            body.classList.remove("formOpen");
        },
    500);*/
    
    
    ///var body = document.querySelector("body");
    ///var formCenter = document.querySelector(".form-center");
    var formList = document.querySelectorAll(".modal");
    if (formList.length > 0) {
        //if (!formList[formList.length-1].querySelector(".modal-dialog .btn-close")) {
        if (!formList[formList.length-1].querySelector(".modal-dialog")) {
            return;
        }
        
        $(formList[formList.length-1]).modal('hide');
        setTimeout(function(){ formList[formList.length-1].remove(); }, 100);
        
        /**if (CFG__ENABLE_ANIMATION) {
            Velocity(formList[formList.length-1], "transition.slideDownOut", 300);
            /**Velocity(formList[formList.length-1], {top: "45%"}, 100);**/
            
       /**     setTimeout(function(){ formList[formList.length-1].parentNode.removeChild(formList[formList.length-1]); }, 100);
            
            if (formList.length == 1) {
                setTimeout(function(){
                        //formCenter.style.display = "none";
                        formCenter.parentNode.removeChild(formCenter);
                    },
                180);
            }
        } else {*/
            //formCenter.style.display = "none";
            ///formList[formList.length-1].style.display = "none";
            ///setTimeout(function(){ formList[formList.length-1].parentNode.removeChild(formList[formList.length-1]); }, 100);
            
            ///if (formList.length == 1) {
            ///    formCenter.parentNode.removeChild(formCenter);
            ///}
        ///}
        
        ///if ((formList.length-1) > 0) {
        ///    formList[formList.length-2].classList.remove("disabled");
        ///}
        
        ///if (formList.length == 1) {
        ///    setTimeout(function(){ body.classList.remove("open"); }, 400);
            /**setTimeout(function(){ body.classList.remove("open"); }, 200);**/
        ///}
    }
}

function formClose() {
    var body = document.querySelector("body");
    var formCenter = document.querySelector(".form-center");
    var form = document.getElementById("dialog");
    
    if (CFG__ENABLE_ANIMATION) {
        Velocity(form, "transition.slideDownOut", 300);
        /**Velocity(form, {top: "45%"}, 100);**/
        
        setTimeout(function(){
                formCenter.style.display = "none";
            },
        160);
    } else {
        formCenter.style.display = "none";
        form.style.display = "none";
    }
    
    setTimeout(function(){
            body.classList.remove("formOpen");
        },
    500);
    /**setTimeout(function(){
            body.classList.remove("formOpen");
        },
    200);**/
}

function setPage(el){
    var __page = el.getAttribute('data-link');
    var t = document.querySelector('[data-template="page__'+__page+'"]');
    
    var __page_name = el.getAttribute('data-name');
    if (__page_name != "") {
        var title = document.querySelector('.mob-logo .title');
        //var img = document.querySelector('.mob-logo .hide480px');
        if (title != null) {
            title.innerHTML = __page_name;
        }/* else {
            
        }*/
    }
    
    // set
    //t.content.querySelector('img').src = 'demo.png';
    //t.content.querySelector('p').textContent= 'demo text';
    
    
    if (t == null) {
        t = document.querySelector('[data-template="page__404"]');
    }
    
    if (__page != "") {
        var wooui__sidebar                 = document.getElementById("navSidebar");
        var wooui__dark                    = document.querySelector("#navFade");
        var wooui__fadeOut                 = "transition.fadeOut";
        
        if (wooui__hasClass(wooui__sidebar, "open")) {
            Velocity(wooui__sidebar, "reverse");
            Velocity(wooui__dark, wooui__fadeOut, 300);
            document.body.classList.remove("noscroll");
            wooui__sidebar.classList.remove("open");
        }
    }
    
    // add to document DOM
    var clone = document.importNode(t.content, true); // where true means deep copy
    //document.querySelector("main").appendChild(clone);
    
    var main_content = document.querySelector("main");
    main_content.innerHTML = "";
    /**
    main_content.innerHTML = `
            <div class="alert danger">
               <span class="title">ATENÇÃO, VOCÊ ESTÁ INATIVO!</span>
               <span class="message">Faça seu consumo mensal mínimo para se ativar!</span>
               <button type="button" class="btn btn-default btnAlertAtv" onclick="location.href='https://loja.wondercosmetics.com.br'">                            <i class="now-ui-icons ui-1_check"></i>&nbsp;&nbsp;FAZER CONSUMO MENSAL                        </button>                    
            </div>`;
     */
    main_content.appendChild(clone);
    
    /** **/
    //console.log(Inputmask.format("1157381", { alias: "currencyUSD" }));
    Inputmask().mask(main_content.querySelectorAll("input"));
    /** **/
}




function wooui__hasClass(element, className) {
    return (' ' + element.className + ' ').indexOf(' ' + className+ ' ') > -1;
}



function indexInParent(node) {
	var children = node.parentNode.childNodes;
	var num = 0;
	for (var i=0; i<children.length; i++) {
		 if (children[i]==node) return num;
		 if (children[i].nodeType==1) num++;
	}
	return -1;
}

var cumulativeOffset = function(element) {
    var top = 0, left = 0;
    do {
        top += element.offsetTop  || 0;
        left += element.offsetLeft || 0;
        element = element.offsetParent;
    } while(element);

    return {
        top: top,
        left: left
    };
};

// For really old browser's or incompatible ones
function getOffsetSum(elem) {
    var top = 0,
        left = 0,
        bottom = 0,
        right = 0;

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
    };
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
    };
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
}


(function(DOMParser) {
	"use strict";

	var
		proto = DOMParser.prototype
	, nativeParse = proto.parseFromString
	;

	// Firefox/Opera/IE throw errors on unsupported types
	try {
		// WebKit returns null on unsupported types
		if ((new DOMParser()).parseFromString("", "text/html")) {
			// text/html parsing is natively supported
			return;
		}
	} catch (ex) {}

	proto.parseFromString = function(markup, type) {
		if (/^\s*text\/html\s*(?:;|$)/i.test(type)) {
			var
				 doc = document.implementation.createHTMLDocument("")
			;
			 		if (markup.toLowerCase().indexOf('<!doctype') > -1) {
					doc.documentElement.innerHTML = markup;
					}
					else {
					doc.body.innerHTML = markup;
					}
			return doc;
		} else {
			return nativeParse.apply(this, arguments);
		}
	};
}(DOMParser));

DOMTokenList.prototype.removemany = function(input) {
	var classValues = input.split(' ');
	var classValuesCount = classValues.length;

	for (var i = 0; i < classValuesCount; i++) {
		if (this.contains(classValues[i])) {
			this.remove(classValues[i]);
		}
	}
}

;(function () {
	'use strict';

	/**
	 * @preserve FastClick: polyfill to remove click delays on browsers with touch UIs.
	 *
	 * @codingstandard ftlabs-jsv2
	 * @copyright The Financial Times Limited [All Rights Reserved]
	 * @license MIT License (see LICENSE.txt)
	 */

	/*jslint browser:true, node:true*/
	/*global define, Event, Node*/


	/**
	 * Instantiate fast-clicking listeners on the specified layer.
	 *
	 * @constructor
	 * @param {Element} layer The layer to listen on
	 * @param {Object} [options={}] The options to override the defaults
	 */
	function FastClick(layer, options) {
		var oldOnClick;

		options = options || {};

		/**
		 * Whether a click is currently being tracked.
		 *
		 * @type boolean
		 */
		this.trackingClick = false;


		/**
		 * Timestamp for when click tracking started.
		 *
		 * @type number
		 */
		this.trackingClickStart = 0;


		/**
		 * The element being tracked for a click.
		 *
		 * @type EventTarget
		 */
		this.targetElement = null;


		/**
		 * X-coordinate of touch start event.
		 *
		 * @type number
		 */
		this.touchStartX = 0;


		/**
		 * Y-coordinate of touch start event.
		 *
		 * @type number
		 */
		this.touchStartY = 0;


		/**
		 * ID of the last touch, retrieved from Touch.identifier.
		 *
		 * @type number
		 */
		this.lastTouchIdentifier = 0;


		/**
		 * Touchmove boundary, beyond which a click will be cancelled.
		 *
		 * @type number
		 */
		this.touchBoundary = options.touchBoundary || 10;


		/**
		 * The FastClick layer.
		 *
		 * @type Element
		 */
		this.layer = layer;

		/**
		 * The minimum time between tap(touchstart and touchend) events
		 *
		 * @type number
		 */
		this.tapDelay = options.tapDelay || 200;

		/**
		 * The maximum time for a tap
		 *
		 * @type number
		 */
		this.tapTimeout = options.tapTimeout || 700;

		if (FastClick.notNeeded(layer)) {
			return;
		}

		// Some old versions of Android don't have Function.prototype.bind
		function bind(method, context) {
			return function() { return method.apply(context, arguments); };
		}


		var methods = ['onMouse', 'onClick', 'onTouchStart', 'onTouchMove', 'onTouchEnd', 'onTouchCancel'];
		var context = this;
		for (var i = 0, l = methods.length; i < l; i++) {
			context[methods[i]] = bind(context[methods[i]], context);
		}

		// Set up event handlers as required
		if (deviceIsAndroid) {
			layer.addEventListener('mouseover', this.onMouse, true);
			layer.addEventListener('mousedown', this.onMouse, true);
			layer.addEventListener('mouseup', this.onMouse, true);
		}

		layer.addEventListener('click', this.onClick, true);
		layer.addEventListener('touchstart', this.onTouchStart, false);
		layer.addEventListener('touchmove', this.onTouchMove, false);
		layer.addEventListener('touchend', this.onTouchEnd, false);
		layer.addEventListener('touchcancel', this.onTouchCancel, false);

		// Hack is required for browsers that don't support Event#stopImmediatePropagation (e.g. Android 2)
		// which is how FastClick normally stops click events bubbling to callbacks registered on the FastClick
		// layer when they are cancelled.
		if (!Event.prototype.stopImmediatePropagation) {
			layer.removeEventListener = function(type, callback, capture) {
				var rmv = Node.prototype.removeEventListener;
				if (type === 'click') {
					rmv.call(layer, type, callback.hijacked || callback, capture);
				} else {
					rmv.call(layer, type, callback, capture);
				}
			};

			layer.addEventListener = function(type, callback, capture) {
				var adv = Node.prototype.addEventListener;
				if (type === 'click') {
					adv.call(layer, type, callback.hijacked || (callback.hijacked = function(event) {
						if (!event.propagationStopped) {
							callback(event);
						}
					}), capture);
				} else {
					adv.call(layer, type, callback, capture);
				}
			};
		}

		// If a handler is already declared in the element's onclick attribute, it will be fired before
		// FastClick's onClick handler. Fix this by pulling out the user-defined handler function and
		// adding it as listener.
		if (typeof layer.onclick === 'function') {

			// Android browser on at least 3.2 requires a new reference to the function in layer.onclick
			// - the old one won't work if passed to addEventListener directly.
			oldOnClick = layer.onclick;
			layer.addEventListener('click', function(event) {
				oldOnClick(event);
			}, false);
			layer.onclick = null;
		}
	}

	/**
	* Windows Phone 8.1 fakes user agent string to look like Android and iPhone.
	*
	* @type boolean
	*/
	var deviceIsWindowsPhone = navigator.userAgent.indexOf("Windows Phone") >= 0;

	/**
	 * Android requires exceptions.
	 *
	 * @type boolean
	 */
	var deviceIsAndroid = navigator.userAgent.indexOf('Android') > 0 && !deviceIsWindowsPhone;


	/**
	 * iOS requires exceptions.
	 *
	 * @type boolean
	 */
	var deviceIsIOS = /iP(ad|hone|od)/.test(navigator.userAgent) && !deviceIsWindowsPhone;


	/**
	 * iOS 4 requires an exception for select elements.
	 *
	 * @type boolean
	 */
	var deviceIsIOS4 = deviceIsIOS && (/OS 4_\d(_\d)?/).test(navigator.userAgent);


	/**
	 * iOS 6.0-7.* requires the target element to be manually derived
	 *
	 * @type boolean
	 */
	var deviceIsIOSWithBadTarget = deviceIsIOS && (/OS [6-7]_\d/).test(navigator.userAgent);

	/**
	 * BlackBerry requires exceptions.
	 *
	 * @type boolean
	 */
	var deviceIsBlackBerry10 = navigator.userAgent.indexOf('BB10') > 0;

	/**
	 * Determine whether a given element requires a native click.
	 *
	 * @param {EventTarget|Element} target Target DOM element
	 * @returns {boolean} Returns true if the element needs a native click
	 */
	FastClick.prototype.needsClick = function(target) {
		switch (target.nodeName.toLowerCase()) {

		// Don't send a synthetic click to disabled inputs (issue #62)
		case 'button':
		case 'select':
		case 'textarea':
			if (target.disabled) {
				return true;
			}

			break;
		case 'input':

			// File inputs need real clicks on iOS 6 due to a browser bug (issue #68)
			if ((deviceIsIOS && target.type === 'file') || target.disabled) {
				return true;
			}

			break;
		case 'label':
		case 'iframe': // iOS8 homescreen apps can prevent events bubbling into frames
		case 'video':
			return true;
		}

		return (/\bneedsclick\b/).test(target.className);
	};


	/**
	 * Determine whether a given element requires a call to focus to simulate click into element.
	 *
	 * @param {EventTarget|Element} target Target DOM element
	 * @returns {boolean} Returns true if the element requires a call to focus to simulate native click.
	 */
	FastClick.prototype.needsFocus = function(target) {
		switch (target.nodeName.toLowerCase()) {
		case 'textarea':
			return true;
		case 'select':
			return !deviceIsAndroid;
		case 'input':
			switch (target.type) {
			case 'button':
			case 'checkbox':
			case 'file':
			case 'image':
			case 'radio':
			case 'submit':
				return false;
			}

			// No point in attempting to focus disabled inputs
			return !target.disabled && !target.readOnly;
		default:
			return (/\bneedsfocus\b/).test(target.className);
		}
	};


	/**
	 * Send a click event to the specified element.
	 *
	 * @param {EventTarget|Element} targetElement
	 * @param {Event} event
	 */
	FastClick.prototype.sendClick = function(targetElement, event) {
		var clickEvent, touch;

		// On some Android devices activeElement needs to be blurred otherwise the synthetic click will have no effect (#24)
		if (document.activeElement && document.activeElement !== targetElement) {
			document.activeElement.blur();
		}

		touch = event.changedTouches[0];

		// Synthesise a click event, with an extra attribute so it can be tracked
		clickEvent = document.createEvent('MouseEvents');
		clickEvent.initMouseEvent(this.determineEventType(targetElement), true, true, window, 1, touch.screenX, touch.screenY, touch.clientX, touch.clientY, false, false, false, false, 0, null);
		clickEvent.forwardedTouchEvent = true;
		targetElement.dispatchEvent(clickEvent);
	};

	FastClick.prototype.determineEventType = function(targetElement) {

		//Issue #159: Android Chrome Select Box does not open with a synthetic click event
		if (deviceIsAndroid && targetElement.tagName.toLowerCase() === 'select') {
			return 'mousedown';
		}

		return 'click';
	};


	/**
	 * @param {EventTarget|Element} targetElement
	 */
	FastClick.prototype.focus = function(targetElement) {
		var length;

		// Issue #160: on iOS 7, some input elements (e.g. date datetime month) throw a vague TypeError on setSelectionRange. These elements don't have an integer value for the selectionStart and selectionEnd properties, but unfortunately that can't be used for detection because accessing the properties also throws a TypeError. Just check the type instead. Filed as Apple bug #15122724.
		if (deviceIsIOS && targetElement.setSelectionRange && targetElement.type.indexOf('date') !== 0 && targetElement.type !== 'time' && targetElement.type !== 'month') {
			length = targetElement.value.length;
			targetElement.setSelectionRange(length, length);
		} else {
			targetElement.focus();
		}
	};


	/**
	 * Check whether the given target element is a child of a scrollable layer and if so, set a flag on it.
	 *
	 * @param {EventTarget|Element} targetElement
	 */
	FastClick.prototype.updateScrollParent = function(targetElement) {
		var scrollParent, parentElement;

		scrollParent = targetElement.fastClickScrollParent;

		// Attempt to discover whether the target element is contained within a scrollable layer. Re-check if the
		// target element was moved to another parent.
		if (!scrollParent || !scrollParent.contains(targetElement)) {
			parentElement = targetElement;
			do {
				if (parentElement.scrollHeight > parentElement.offsetHeight) {
					scrollParent = parentElement;
					targetElement.fastClickScrollParent = parentElement;
					break;
				}

				parentElement = parentElement.parentElement;
			} while (parentElement);
		}

		// Always update the scroll top tracker if possible.
		if (scrollParent) {
			scrollParent.fastClickLastScrollTop = scrollParent.scrollTop;
		}
	};


	/**
	 * @param {EventTarget} targetElement
	 * @returns {Element|EventTarget}
	 */
	FastClick.prototype.getTargetElementFromEventTarget = function(eventTarget) {

		// On some older browsers (notably Safari on iOS 4.1 - see issue #56) the event target may be a text node.
		if (eventTarget.nodeType === Node.TEXT_NODE) {
			return eventTarget.parentNode;
		}

		return eventTarget;
	};


	/**
	 * On touch start, record the position and scroll offset.
	 *
	 * @param {Event} event
	 * @returns {boolean}
	 */
	FastClick.prototype.onTouchStart = function(event) {
		var targetElement, touch, selection;

		// Ignore multiple touches, otherwise pinch-to-zoom is prevented if both fingers are on the FastClick element (issue #111).
		if (event.targetTouches.length > 1) {
			return true;
		}

		targetElement = this.getTargetElementFromEventTarget(event.target);
		touch = event.targetTouches[0];

		if (deviceIsIOS) {

			// Only trusted events will deselect text on iOS (issue #49)
			selection = window.getSelection();
			if (selection.rangeCount && !selection.isCollapsed) {
				return true;
			}

			if (!deviceIsIOS4) {

				// Weird things happen on iOS when an alert or confirm dialog is opened from a click event callback (issue #23):
				// when the user next taps anywhere else on the page, new touchstart and touchend events are dispatched
				// with the same identifier as the touch event that previously triggered the click that triggered the alert.
				// Sadly, there is an issue on iOS 4 that causes some normal touch events to have the same identifier as an
				// immediately preceeding touch event (issue #52), so this fix is unavailable on that platform.
				// Issue 120: touch.identifier is 0 when Chrome dev tools 'Emulate touch events' is set with an iOS device UA string,
				// which causes all touch events to be ignored. As this block only applies to iOS, and iOS identifiers are always long,
				// random integers, it's safe to to continue if the identifier is 0 here.
				if (touch.identifier && touch.identifier === this.lastTouchIdentifier) {
					event.preventDefault();
					return false;
				}

				this.lastTouchIdentifier = touch.identifier;

				// If the target element is a child of a scrollable layer (using -webkit-overflow-scrolling: touch) and:
				// 1) the user does a fling scroll on the scrollable layer
				// 2) the user stops the fling scroll with another tap
				// then the event.target of the last 'touchend' event will be the element that was under the user's finger
				// when the fling scroll was started, causing FastClick to send a click event to that layer - unless a check
				// is made to ensure that a parent layer was not scrolled before sending a synthetic click (issue #42).
				this.updateScrollParent(targetElement);
			}
		}

		this.trackingClick = true;
		this.trackingClickStart = event.timeStamp;
		this.targetElement = targetElement;

		this.touchStartX = touch.pageX;
		this.touchStartY = touch.pageY;

		// Prevent phantom clicks on fast double-tap (issue #36)
		if ((event.timeStamp - this.lastClickTime) < this.tapDelay) {
			event.preventDefault();
		}

		return true;
	};


	/**
	 * Based on a touchmove event object, check whether the touch has moved past a boundary since it started.
	 *
	 * @param {Event} event
	 * @returns {boolean}
	 */
	FastClick.prototype.touchHasMoved = function(event) {
		var touch = event.changedTouches[0], boundary = this.touchBoundary;

		if (Math.abs(touch.pageX - this.touchStartX) > boundary || Math.abs(touch.pageY - this.touchStartY) > boundary) {
			return true;
		}

		return false;
	};


	/**
	 * Update the last position.
	 *
	 * @param {Event} event
	 * @returns {boolean}
	 */
	FastClick.prototype.onTouchMove = function(event) {
		if (!this.trackingClick) {
			return true;
		}

		// If the touch has moved, cancel the click tracking
		if (this.targetElement !== this.getTargetElementFromEventTarget(event.target) || this.touchHasMoved(event)) {
			this.trackingClick = false;
			this.targetElement = null;
		}

		return true;
	};


	/**
	 * Attempt to find the labelled control for the given label element.
	 *
	 * @param {EventTarget|HTMLLabelElement} labelElement
	 * @returns {Element|null}
	 */
	FastClick.prototype.findControl = function(labelElement) {

		// Fast path for newer browsers supporting the HTML5 control attribute
		if (labelElement.control !== undefined) {
			return labelElement.control;
		}

		// All browsers under test that support touch events also support the HTML5 htmlFor attribute
		if (labelElement.htmlFor) {
			return document.getElementById(labelElement.htmlFor);
		}

		// If no for attribute exists, attempt to retrieve the first labellable descendant element
		// the list of which is defined here: http://www.w3.org/TR/html5/forms.html#category-label
		return labelElement.querySelector('button, input:not([type=hidden]), keygen, meter, output, progress, select, textarea');
	};


	/**
	 * On touch end, determine whether to send a click event at once.
	 *
	 * @param {Event} event
	 * @returns {boolean}
	 */
	FastClick.prototype.onTouchEnd = function(event) {
		var forElement, trackingClickStart, targetTagName, scrollParent, touch, targetElement = this.targetElement;

		if (!this.trackingClick) {
			return true;
		}

		// Prevent phantom clicks on fast double-tap (issue #36)
		if ((event.timeStamp - this.lastClickTime) < this.tapDelay) {
			this.cancelNextClick = true;
			return true;
		}

		if ((event.timeStamp - this.trackingClickStart) > this.tapTimeout) {
			return true;
		}

		// Reset to prevent wrong click cancel on input (issue #156).
		this.cancelNextClick = false;

		this.lastClickTime = event.timeStamp;

		trackingClickStart = this.trackingClickStart;
		this.trackingClick = false;
		this.trackingClickStart = 0;

		// On some iOS devices, the targetElement supplied with the event is invalid if the layer
		// is performing a transition or scroll, and has to be re-detected manually. Note that
		// for this to function correctly, it must be called *after* the event target is checked!
		// See issue #57; also filed as rdar://13048589 .
		if (deviceIsIOSWithBadTarget) {
			touch = event.changedTouches[0];

			// In certain cases arguments of elementFromPoint can be negative, so prevent setting targetElement to null
			targetElement = document.elementFromPoint(touch.pageX - window.pageXOffset, touch.pageY - window.pageYOffset) || targetElement;
			targetElement.fastClickScrollParent = this.targetElement.fastClickScrollParent;
		}

		targetTagName = targetElement.tagName.toLowerCase();
		if (targetTagName === 'label') {
			forElement = this.findControl(targetElement);
			if (forElement) {
				this.focus(targetElement);
				if (deviceIsAndroid) {
					return false;
				}

				targetElement = forElement;
			}
		} else if (this.needsFocus(targetElement)) {

			// Case 1: If the touch started a while ago (best guess is 100ms based on tests for issue #36) then focus will be triggered anyway. Return early and unset the target element reference so that the subsequent click will be allowed through.
			// Case 2: Without this exception for input elements tapped when the document is contained in an iframe, then any inputted text won't be visible even though the value attribute is updated as the user types (issue #37).
			if ((event.timeStamp - trackingClickStart) > 100 || (deviceIsIOS && window.top !== window && targetTagName === 'input')) {
				this.targetElement = null;
				return false;
			}

			this.focus(targetElement);
			this.sendClick(targetElement, event);

			// Select elements need the event to go through on iOS 4, otherwise the selector menu won't open.
			// Also this breaks opening selects when VoiceOver is active on iOS6, iOS7 (and possibly others)
			if (!deviceIsIOS || targetTagName !== 'select') {
				this.targetElement = null;
				event.preventDefault();
			}

			return false;
		}

		if (deviceIsIOS && !deviceIsIOS4) {

			// Don't send a synthetic click event if the target element is contained within a parent layer that was scrolled
			// and this tap is being used to stop the scrolling (usually initiated by a fling - issue #42).
			scrollParent = targetElement.fastClickScrollParent;
			if (scrollParent && scrollParent.fastClickLastScrollTop !== scrollParent.scrollTop) {
				return true;
			}
		}

		// Prevent the actual click from going though - unless the target node is marked as requiring
		// real clicks or if it is in the whitelist in which case only non-programmatic clicks are permitted.
		if (!this.needsClick(targetElement)) {
			event.preventDefault();
			this.sendClick(targetElement, event);
		}

		return false;
	};


	/**
	 * On touch cancel, stop tracking the click.
	 *
	 * @returns {void}
	 */
	FastClick.prototype.onTouchCancel = function() {
		this.trackingClick = false;
		this.targetElement = null;
	};


	/**
	 * Determine mouse events which should be permitted.
	 *
	 * @param {Event} event
	 * @returns {boolean}
	 */
	FastClick.prototype.onMouse = function(event) {

		// If a target element was never set (because a touch event was never fired) allow the event
		if (!this.targetElement) {
			return true;
		}

		if (event.forwardedTouchEvent) {
			return true;
		}

		// Programmatically generated events targeting a specific element should be permitted
		if (!event.cancelable) {
			return true;
		}

		// Derive and check the target element to see whether the mouse event needs to be permitted;
		// unless explicitly enabled, prevent non-touch click events from triggering actions,
		// to prevent ghost/doubleclicks.
		if (!this.needsClick(this.targetElement) || this.cancelNextClick) {

			// Prevent any user-added listeners declared on FastClick element from being fired.
			if (event.stopImmediatePropagation) {
				event.stopImmediatePropagation();
			} else {

				// Part of the hack for browsers that don't support Event#stopImmediatePropagation (e.g. Android 2)
				event.propagationStopped = true;
			}

			// Cancel the event
			event.stopPropagation();
			event.preventDefault();

			return false;
		}

		// If the mouse event is permitted, return true for the action to go through.
		return true;
	};


	/**
	 * On actual clicks, determine whether this is a touch-generated click, a click action occurring
	 * naturally after a delay after a touch (which needs to be cancelled to avoid duplication), or
	 * an actual click which should be permitted.
	 *
	 * @param {Event} event
	 * @returns {boolean}
	 */
	FastClick.prototype.onClick = function(event) {
		var permitted;

		// It's possible for another FastClick-like library delivered with third-party code to fire a click event before FastClick does (issue #44). In that case, set the click-tracking flag back to false and return early. This will cause onTouchEnd to return early.
		if (this.trackingClick) {
			this.targetElement = null;
			this.trackingClick = false;
			return true;
		}

		// Very odd behaviour on iOS (issue #18): if a submit element is present inside a form and the user hits enter in the iOS simulator or clicks the Go button on the pop-up OS keyboard the a kind of 'fake' click event will be triggered with the submit-type input element as the target.
		if (event.target.type === 'submit' && event.detail === 0) {
			return true;
		}

		permitted = this.onMouse(event);

		// Only unset targetElement if the click is not permitted. This will ensure that the check for !targetElement in onMouse fails and the browser's click doesn't go through.
		if (!permitted) {
			this.targetElement = null;
		}

		// If clicks are permitted, return true for the action to go through.
		return permitted;
	};


	/**
	 * Remove all FastClick's event listeners.
	 *
	 * @returns {void}
	 */
	FastClick.prototype.destroy = function() {
		var layer = this.layer;

		if (deviceIsAndroid) {
			layer.removeEventListener('mouseover', this.onMouse, true);
			layer.removeEventListener('mousedown', this.onMouse, true);
			layer.removeEventListener('mouseup', this.onMouse, true);
		}

		layer.removeEventListener('click', this.onClick, true);
		layer.removeEventListener('touchstart', this.onTouchStart, false);
		layer.removeEventListener('touchmove', this.onTouchMove, false);
		layer.removeEventListener('touchend', this.onTouchEnd, false);
		layer.removeEventListener('touchcancel', this.onTouchCancel, false);
	};


	/**
	 * Check whether FastClick is needed.
	 *
	 * @param {Element} layer The layer to listen on
	 */
	FastClick.notNeeded = function(layer) {
		var metaViewport;
		var chromeVersion;
		var blackberryVersion;
		var firefoxVersion;

		// Devices that don't support touch don't need FastClick
		if (typeof window.ontouchstart === 'undefined') {
			return true;
		}

		// Chrome version - zero for other browsers
		chromeVersion = +(/Chrome\/([0-9]+)/.exec(navigator.userAgent) || [,0])[1];

		if (chromeVersion) {

			if (deviceIsAndroid) {
				metaViewport = document.querySelector('meta[name=viewport]');

				if (metaViewport) {
					// Chrome on Android with user-scalable="no" doesn't need FastClick (issue #89)
					if (metaViewport.content.indexOf('user-scalable=no') !== -1) {
						return true;
					}
					// Chrome 32 and above with width=device-width or less don't need FastClick
					if (chromeVersion > 31 && document.documentElement.scrollWidth <= window.outerWidth) {
						return true;
					}
				}

			// Chrome desktop doesn't need FastClick (issue #15)
			} else {
				return true;
			}
		}

		if (deviceIsBlackBerry10) {
			blackberryVersion = navigator.userAgent.match(/Version\/([0-9]*)\.([0-9]*)/);

			// BlackBerry 10.3+ does not require Fastclick library.
			// https://github.com/ftlabs/fastclick/issues/251
			if (blackberryVersion[1] >= 10 && blackberryVersion[2] >= 3) {
				metaViewport = document.querySelector('meta[name=viewport]');

				if (metaViewport) {
					// user-scalable=no eliminates click delay.
					if (metaViewport.content.indexOf('user-scalable=no') !== -1) {
						return true;
					}
					// width=device-width (or less than device-width) eliminates click delay.
					if (document.documentElement.scrollWidth <= window.outerWidth) {
						return true;
					}
				}
			}
		}

		// IE10 with -ms-touch-action: none or manipulation, which disables double-tap-to-zoom (issue #97)
		if (layer.style.msTouchAction === 'none' || layer.style.touchAction === 'manipulation') {
			return true;
		}

		// Firefox version - zero for other browsers
		firefoxVersion = +(/Firefox\/([0-9]+)/.exec(navigator.userAgent) || [,0])[1];

		if (firefoxVersion >= 27) {
			// Firefox 27+ does not have tap delay if the content is not zoomable - https://bugzilla.mozilla.org/show_bug.cgi?id=922896

			metaViewport = document.querySelector('meta[name=viewport]');
			if (metaViewport && (metaViewport.content.indexOf('user-scalable=no') !== -1 || document.documentElement.scrollWidth <= window.outerWidth)) {
				return true;
			}
		}

		// IE11: prefixed -ms-touch-action is no longer supported and it's recomended to use non-prefixed version
		// http://msdn.microsoft.com/en-us/library/windows/apps/Hh767313.aspx
		if (layer.style.touchAction === 'none' || layer.style.touchAction === 'manipulation') {
			return true;
		}

		return false;
	};


	/**
	 * Factory method for creating a FastClick object
	 *
	 * @param {Element} layer The layer to listen on
	 * @param {Object} [options={}] The options to override the defaults
	 */
	FastClick.attach = function(layer, options) {
		return new FastClick(layer, options);
	};


	if (typeof define === 'function' && typeof define.amd === 'object' && define.amd) {

		// AMD. Register as an anonymous module.
		define(function() {
			return FastClick;
		});
	} else if (typeof module !== 'undefined' && module.exports) {
		module.exports = FastClick.attach;
		module.exports.FastClick = FastClick;
	} else {
		window.FastClick = FastClick;
	}
}());

;(function(){

  'use strict';

  /**
   * Aliases
   */

  var indexOf = Array.prototype.indexOf;
  var getStyle = window.getComputedStyle;

  /**
   * CSS Classes
   */

  var overflowingChildClass = 'ellipsis-overflowing-child';
  var containerClass = 'ellipsis-set';

  /**
   * Vendor Info
   */

  var vendor = getVendorData();

  /**
   * Initialize a new Ellipsis
   * instance with the given element.
   *
   * Options:
   *
   *  - `container` A parent container element
   *  - `reRender` Forces a redraw after ellipsis applied
   *
   * @constructor
   * @param {Element} el
   * @param {Object} options
   * @api public
   */
  function Ellipsis(el, options) {
    if (!el) return;
    this.el = el;
    this.container = options && options.container;
    this.reRender = options && options.reRender;
  }

  /**
   * Measures the element and
   * finds the overflowing child.
   *
   * @return {Ellipsis}
   * @api public
   */
  Ellipsis.prototype.calc = function() {
    if (!this.el) return this;
    var style = getStyle(this.el);
    var size = getSize(this.el);

    this.columnHeight = size[1];
    this.columnCount = getColumnCount(style);
    this.columnGap = getColumnGap(style);
    this.columnWidth = size[0] / this.columnCount;
    this.lineHeight = getLineHeight(this.el, style);
    this.deltaHeight = size[1] % this.lineHeight;
    this.linesPerColumn = Math.floor(this.columnHeight / this.lineHeight);
    this.totalLines = this.linesPerColumn * this.columnCount;

    // COMPLEX:
    // We set the height on the container
    // explicitly to work around problem
    // with columned containers not fitting
    // all lines when the height is exactly
    // divisible by the line height.
    if (!this.deltaHeight && this.columnCount > 1) {
      this.el.style.height = this.columnHeight + 'px';
    }

    this.child = this.getOverflowingChild();

    return this;
  };

  /**
   * Clamps the overflowing child using
   * the information acquired from #calc().
   *
   * @return {Ellipsis}
   * @api public
   */
  Ellipsis.prototype.set = function() {
    if (!this.el || !this.child) return this;

    this.clampChild();
    siblingsAfter(this.child.el, { display: 'none' });
    this.markContainer();

    return this;
  };

  /**
   * Unclamps the overflowing child.
   *
   * @return {Ellipsis}
   * @api public
   */

  Ellipsis.prototype.unset = function() {
    if (!this.el || !this.child) return this;

    this.el.style.height = '';
    this.unclampChild(this.child);
    siblingsAfter(this.child.el, { display: '' });
    this.unmarkContainer();
    this.child = null;

    return this;
  };

  /**
   * Clears any references
   *
   * @return {Ellipsis}
   * @api public
   */

  Ellipsis.prototype.destroy = function() {

    // It's super important that we clear references
    // to any DOM nodes here so that we don't end up
    // with any 'detached nodes' lingering in memory
    this.el = this.child = this.container = null;

    return this;
  };

  /**
   * Returns the overflowing child with some
   * extra data required for clamping.
   *
   * @param  {Ellipsis} instance
   * @return {Object}
   * @api private
   */
  Ellipsis.prototype.getOverflowingChild = function() {
    var self = this;
    var child = {};
    var lineCounter = 0;

    // Loop over each child element
    each(this.el.children, function(el) {
      var lineCount, overflow, underflow;
      var startColumnIndex = Math.floor(lineCounter / self.linesPerColumn) || 0;

      // Get the line count of the
      // child and increment the counter
      lineCounter += lineCount = self.getLineCount(el);

      // If this is the overflowing child
      if (lineCounter >= self.totalLines) {
        overflow = lineCounter - self.totalLines;
        underflow = lineCount - overflow;

        child.el = el;
        child.clampedLines = underflow;
        child.clampedHeight = child.clampedLines * self.lineHeight;
        child.visibleColumnSpan = self.columnCount - startColumnIndex;
        child.gutterSpan = child.visibleColumnSpan - 1;
        child.applyTopMargin = self.shouldApplyTopMargin(child);

        // COMPLEX:
        // In order to get the overflowing
        // child height correct we have to
        // add the delta for each gutter the
        // overflowing child crosses. This is
        // just how webkit columns work.
        if (vendor.webkit && child.clampedLines > 1) {
          child.clampedHeight += child.gutterSpan * self.deltaHeight;
        }

        return child;
      }
    });

    return child;
  };

  /**
   * Returns the number
   * of lines an element has.
   *
   * If the element is larger than
   * the column width we make the
   * assumption that this is FireFox
   * and the element is broken across
   * a column boundary. In this case
   * we have to get the height using
   * `getClientRects()`.
   *
   * @param  {Element} el
   * @return {Number}
   * @api private
   */

  Ellipsis.prototype.getLineCount = function(el) {
    return (el.offsetWidth > this.columnWidth) ? getLinesFromRects(el, this.lineHeight) : lineCount(el.clientHeight, this.lineHeight);
  };

  /**
   * If a container has been
   * declared we mark it with
   * a class for styling purposes.
   *
   * @api private
   */
  Ellipsis.prototype.markContainer = function() {
    if (!this.container) return;
    this.container.classList.add(containerClass);
    if (this.reRender) reRender(this.container);
  };

  /**
   * Removes the class
   * from the container.
   *
   * @api private
   */
  Ellipsis.prototype.unmarkContainer = function() {
    if (!this.container) return;
    this.container.classList.remove(containerClass);
    if (this.reRender) reRender(this.container);
  };

  /**
   * Determines whether top margin should be
   * applied to the overflowing child.
   *
   * This is to counteract an annoying
   * column-count/-webkit-box bug, whereby the
   * flexbox element falls into the delta are under
   * the previous sibling. Top margin keeps it
   * in the correct column.
   *
   * @param  {Element} el
   * @param  {Ellipsis} instance
   * @return {Boolean}
   * @api private
   */
  Ellipsis.prototype.shouldApplyTopMargin = function(child) {
    var el = child.el;

    // Dont't if it's not webkit
    if (!vendor.webkit) return;

    // Don't if it's a single column layout
    if (this.columnCount === 1) return;

    // Don't if the delta height is minimal
    if (this.deltaHeight <= 3) return;

    // Don't if it's the first child
    if (!el.previousElementSibling) return;

    // FINAL TEST: If the element is at the top or bottom of its
    // parent container then we require top margin.
    return (el.offsetTop === 0 || el.offsetTop === this.columnHeight);
  };

  /**
   * Clamps the child element to the set
   * height and lines.
   *
   * @param  {Object} child
   * @api private
   */
  Ellipsis.prototype.clampChild = function() {
    var child = this.child;
    if (!child || !child.el) return;

    // Clamp the height
    child.el.style.height = child.clampedHeight + 'px';

    // Use webkit line clamp
    // for webkit browsers.
    if (vendor.webkit) {
      child.el.style.webkitLineClamp = child.clampedLines;
      child.el.style.display = '-webkit-box';
      child.el.style.webkitBoxOrient = 'vertical';
    }

    if (this.shouldHideOverflow()) child.el.style.overflow = 'hidden';

    // Apply a top margin to fix webkit
    // column-count mixed with flexbox bug,
    // if we have decided it is neccessary.
    if (child.applyTopMargin) child.el.style.marginTop = '2em';

    // Add the overflowing
    // child class as a style hook
    child.el.classList.add(overflowingChildClass);

    // Non webkit browsers get a helper
    // element that is styled as an alternative
    // to the webkit-line-clamp ellipsis.
    // Must be position relative so that we can
    // position the helper element.
    if (!vendor.webkit) {
      child.el.style.position = 'relative';
      child.helper = child.el.appendChild(this.helperElement());
    }
  };

  /**
   * Removes all clamping styles from
   * the overflowing child.
   *
   * @param  {Object} child
   * @api private
   */
  Ellipsis.prototype.unclampChild = function(child) {
    if (!child || !child.el) return;
    child.el.style.display = '';
    child.el.style.height = '';
    child.el.style.webkitLineClamp = '';
    child.el.style.webkitBoxOrient = '';
    child.el.style.marginTop = '';
    child.el.style.overflow = '';
    child.el.classList.remove(overflowingChildClass);

    if (child.helper) {
      child.helper.parentNode.removeChild(child.helper);
    }
  };

  /**
   * Creates the helper element
   * for non-webkit browsers.
   *
   * @return {Element}
   * @api private
   */
  Ellipsis.prototype.helperElement = function() {
    var el = document.createElement('span');
    var columns = this.child.visibleColumnSpan - 1;
    var rightOffset, marginRight;

    el.className = 'ellipsis-helper';
    el.style.display = 'block';
    el.style.height = this.lineHeight + 'px';
    el.style.width = '5em';
    el.style.position = 'absolute';
    el.style.bottom = 0;
    el.style.right = 0;

    // HACK: This is a work around to deal with
    // the wierdness of positioning elements
    // inside an element that is broken across
    // more than one column.
    if (vendor.moz && columns) {
      rightOffset = -(columns * 100);
      marginRight = -(columns * this.columnGap);
      el.style.right = rightOffset + '%';
      el.style.marginRight = marginRight + 'px';
      el.style.marginBottom = this.deltaHeight + 'px';
    }

    return el;
  };

  /**
   * Determines whether overflow
   * should be hidden on clamped
   * child.
   *
   * NOTE:
   * Overflow hidden is only required
   * for single column containers as
   * multi-column containers overflow
   * to the right, so are not visible.
   * `overflow: hidden;` also messes
   * with column layout in Firefox.
   *
   * @return {Boolean}
   * @api private
   */
  Ellipsis.prototype.shouldHideOverflow = function() {
    var hasColumns = this.columnCount > 1;

    // If there is not enough room to show
    // even one line; hide all overflow.
    if (this.columnHeight < this.lineHeight) return true;

    // Hide all single column overflow
    return !hasColumns;
  };

  /**
   * Re-render with no setTimeout, boom!
   *
   * NOTE:
   * We have to assign the return value
   * to something global so that Closure
   * Compiler doesn't strip it out.
   *
   * @param  {Element} el
   * @api private
   */
  function reRender(el) {
    el.style.display = 'none';
    Ellipsis.r = el.offsetTop;
    el.style.display = '';
  }

  /**
   * Sets the display property on
   * all siblingsafter the given element.
   *
   * Options:
   *   - `display` the css display type to use
   *
   * @param  {Node} el
   * @param  {Options} options
   * @api private
   */

  function siblingsAfter(el, options) {
    if (!el) return;
    var display = options && options.display;
    var siblings = el.parentNode.children;
    var index = indexOf.call(siblings, el);

    for (var i = index + 1, l = siblings.length; i < l; i++) {
      siblings[i].style.display = display;
    }
  }

  /**
   * Returns total line
   * count from a rect list.
   *
   * @param  {Element} el
   * @param  {Number} lineHeight
   * @return {Number}
   * @api private
   */

  function getLinesFromRects(el, lineHeight) {
    var rects = el.getClientRects();
    var lines = 0;

    each(rects, function(rect) {
      lines += lineCount(rect.height, lineHeight);
    });

    return lines;
  }

  /**
   * Calculates a line count
   * from the passed height.
   *
   * @param  {Number} height
   * @param  {Number} lineHeight
   * @return {Number}
   * @api private
   */

  function lineCount(height, lineHeight) {
    return Math.floor(height / lineHeight);
  }

  /**
   * Returns infomation about
   * the current vendor.
   *
   * @return {Object}
   * @api private
   */

   function getVendorData() {
     var el = document.createElement('test');
     var result = {};
     var vendors = {
       'Webkit': ['WebkitColumnCount', 'WebkitColumnGap'],
       'Moz': ['MozColumnCount', 'MozColumnGap'],
       'ms': ['msColumnCount', 'msColumnGap'],
       '': ['columnCount', 'columnGap']
     };

     for (var vendor in vendors) {
       if (vendors[vendor][0] in el.style) {
         result.columnCount = vendors[vendor][0];
         result.columnGap = vendors[vendor][1];
         result[vendor.toLowerCase()] = true;
       }
     }

     return result;
   }

   /**
    * Gets the column count of an
    * element using the vendor prefix.
    *
    * @param  {CSSStyleDeclaration} style  [description]
    * @return {Number}
    * @api private
    */

   function getColumnCount(style) {
     return parseInt(style[vendor.columnCount], 10) || 1;
   }

   /**
    * Returns the gap between columns
    *
    * @param  {CSSStyleDeclaration} style
    * @return {Number}
    * @api private
    */

   function getColumnGap(style) {
     return parseInt(style[vendor.columnGap], 10) || 0;
   }

  /**
   * Gets the line height
   * from the style declaration.
   *
   * @param  {CSSStyleDeclaration} style
   * @return {Number|null}
   * @api private
   */

  function getLineHeight(el, style) {
    var lineHeightStr = style.lineHeight;

    if (lineHeightStr) {
      if (lineHeightStr.indexOf('px') < 0) {
        throw Error('The ellipsis container ' + elementName(el) + ' must have line-height set using px unit, found: ' + lineHeightStr);
      }

      var lineHeight = parseInt(lineHeightStr, 10);
      if (lineHeight) {
        return lineHeight;
      }
    }
    throw Error('The ellipsis container ' + elementName(el) + ' must have line-height set on it, found: ' + lineHeightStr);
  }

  /**
   * Returns the width and
   * height of the given element.
   *
   * @param  {Element} el
   * @return {Array}
   * @api private
   */

  function getSize(el) {
    return [el.offsetWidth, el.offsetHeight];
  }

  /**
   * Little iterator
   *
   * @param  {Array}   list
   * @param  {Function} fn
   * @api private
   */

  function each(list, fn) {
    for (var i = 0, l = list.length; i < l; i++) if (fn(list[i])) break;
  }

  function elementName(el) {
    var name = el.tagName;
    if (el.id) name += '#' + el.id;
    if (el.className) name += (' ' + el.className).replace(/\s+/g,'.');
    return name;
  }

  /**
   * Expose `Ellipsis`
   */

  if (typeof exports === 'object') {
    module.exports = function(el, options) {
      return new Ellipsis(el, options);
    };
    module.exports.Ellipsis = Ellipsis;
  } else if (typeof define === 'function' && define.amd) {
    define(function() { return Ellipsis; });
  } else {
    window.Ellipsis = Ellipsis;
  }

})();





var isMobile = {
    Android: function() {
        return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
        return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
        return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
        return navigator.userAgent.match(/IEMobile/i) || navigator.userAgent.match(/WPDesktop/i);
    },
    any: function() {
        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
};
