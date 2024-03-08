// FUNC
var stringConstructor = "test".constructor;
var arrayConstructor = [].constructor;
var objectConstructor = {}.constructor;

function whatIsIt(object) {
    if (object === null) {
        return "null";
    }
    else if (object === undefined) {
        return "undefined";
    }
    else if (object.constructor === stringConstructor) {
        return "String";
    }
    else if (object.constructor === arrayConstructor) {
        return "Array";
    }
    else if (object.constructor === objectConstructor) {
        return "Object";
    }
    else {
        return "don't know";
    }
}


function checkPattern(event){
    var charCode = (window.event)?event.keyCode:event.which;
    
    if (event.shiftKey == false){
        if (charCode>=45 && charCode<=46 || charCode>=48 && charCode<=57 || charCode>=65 && charCode<=90 || charCode>=97 && charCode<=122 || charCode==173 || charCode==190)
            return true;
        else {
            if (charCode==8 || charCode==0 || charCode==9 || charCode==13)
                return true;
            else
                return false;
        }
    } else {
        if (event.shiftKey == true && charCode==9)
            return true;
        else
            return false;
    }
}

function RemoveAccents(element) {  //strAccents) {
    var strAccents = element.value;
        strAccents = strAccents.split('');
    var strAccentsOut = new Array();
    var strAccentsLen = strAccents.length;
    var accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var accentsOut = "AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz";
    
    for (var y = 0; y < strAccentsLen; y++) {
        if (accents.indexOf(strAccents[y]) != -1) {
            strAccentsOut[y] = accentsOut.substr(accents.indexOf(strAccents[y]), 1);
        } else
            strAccentsOut[y] = strAccents[y];
    }
    
    strAccentsOut = strAccentsOut.join('');
    element.value = strAccentsOut;
    //return strAccentsOut;
}

function queryObj() {
    var result = {}, keyValuePairs = location.search.slice(1).split("&");
    keyValuePairs.forEach(function(keyValuePair) {
        keyValuePair = keyValuePair.split('=');
        result[decodeURIComponent(keyValuePair[0])] = decodeURIComponent(keyValuePair[1]) || '';
    });
    return result;
}


formatDate = function date2str(x, y) {
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
}



/* ******************************************************
 *  WORK
 *  function doSomething(foo, bar) {
 *      if(empty(bar)) {
 *          bar = 'default value';
 *      }
 *  }
 * ****************************************************** */
function isEmpty(data) {
    if (typeof(data) == 'number' || typeof(data) == 'boolean') { 
        return false; 
    }
    
    if (typeof(data) == 'undefined' || data === null) {
        return true;
    }
  
    if (typeof(data.length) != 'undefined') {
        return data.length == 0;
    }
    
    var count = 0;
    for(var i in data) {
        if (data.hasOwnProperty(i)) {
            count ++;
        }
    }
    return count == 0;
};

function isObjEmpty(obj) {
    // null and undefined are "empty"
    if (obj == null) return true;
 
    // Assume if it has a length property with a non-zero value
    // that that property is correct.
    if (obj.length && obj.length > 0)    return false;
    if (obj.length === 0)  return true;
 
    // Otherwise, does it have any properties of its own?
    // Note that this doesn't handle
    // toString and toValue enumeration bugs in IE < 9
    for (var key in obj) {
        if (hasOwnProperty.call(obj, key)) return false;
    }
 
    return true;
};






/*
 * VARIOUS
 */
function stopRKey(evt) { 
    var evt = (evt) ? evt : ((event) ? event : null); 
    var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null); 
    if ((evt.keyCode == 13) && (node.type=="text"))  {return false;}
}

function setFocus(elem) {
    document.getElementById(elem).focus();
}

function getPageSize() {
    var de = document.documentElement;
    var w = window.innerWidth || self.innerWidth || (de&&de.clientWidth) || document.body.clientWidth;
    var h = window.innerHeight || self.innerHeight || (de&&de.clientHeight) || document.body.clientHeight;
    arrayPageSize = [w,h];
    return arrayPageSize;
}

function getPageHeight() {
    var de = document.documentElement;
    var h = window.innerHeight || self.innerHeight || (de&&de.clientHeight) || document.body.clientHeight;
    alert(h);
    return h;
}

function getPageWidth() {
    var de = document.documentElement;
    var w = window.innerWidth || self.innerWidth || (de&&de.clientWidth) || document.body.clientWidth;
    return w;
}

function sleep(milliseconds) {
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if ((new Date().getTime() - start) > milliseconds){
      break;
    }
  }
}

function datetimeToString(datetime, show_day, show_time){
    hoje = new Date(datetime);
    dia = hoje.getDate();
    dias = hoje.getDay();
    mes = hoje.getMonth()+1;
    ano = hoje.getFullYear();
    
    if (dia < 10)
        dia = "0" + dia;
    
    if (mes < 10)
        mes = "0" + mes;
    
    NomeDia = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    NomeMes = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    
    
    var hours = hoje.getHours();
    var minutes = hoje.getMinutes();
    var seconds = hoje.getSeconds();
    
    if (hours < 10)
        hours = "0" + hours;
    
    if (minutes < 10)
        minutes = "0" + minutes;
    
    if (seconds < 10)
        seconds = "0" + seconds;
    
    if (show_day) {
        if (show_time) {
            return NomeDia[dias] + ", " + dia + "/" + mes + "/" + ano + "&nbsp;" + hours + ":" + minutes + ":" + seconds;
        } else {
            return NomeDia[dias] + ", " + dia + "/" + mes + "/" + ano;
        }
    } else {
        if (show_time) {
            return dia + "/" + mes + "/" + ano + "&nbsp;" + hours + ":" + minutes + ":" + seconds;
        } else {
            return dia + "/" + mes + "/" + ano;
        }
    }
}



/* MONEY */
function fmtMoney(value) {
    /*var val1 = "0,00";
    if (value < 0) {
        val1 = String((value*-1));
    } else if (value > 0) {
        if (value >= 100) {
            val1 = String(value);
        } else {
            if (value > 10) {
                val1 = "0."+String(value);
            } else if (value > 1) {
                val1 = "00."+String(value);
            } else {
                val1 = String(value);
            }
        }
    }*/
    
    //return jSuites.mask.run(val1.replace(".", ","), 'USD #.##0,00');
    //return Inputmask.format(val1.replace(".", ","), { mask: "USD 9.999.999,99" });
    
    //return "USD " + Inputmask.format(val1.replace(".", ","), { mask: "999.999.999,99", placeholder: "", numericInput: true });
    ///return Inputmask.format(value/100.0, { alias: "currency", prefix: "USD " });
    
    //return Inputmask.format(value/100.0, { alias: "currency", prefix: "USD " });
    
    if (typeof(value) !== 'undefined' && value !== null) {
        var mystring = String(value);
        mystring = mystring.replace(".", ",");
        
        //return Inputmask.format(mystring/100.0, { alias: "currencyUSD" });
        return Inputmask.format(mystring, { alias: "currencyUSD" });
    } else {
        return "USD 0,00";
    }
}

function fmtMoneyBRL(value) {
    /*var val1 = "0,00";
    if (value < 0) {
        val1 = String((value*-1));
    } else if (value > 0) {
        if (value >= 100) {
            val1 = String(value);
        } else {
            if (value > 10) {
                val1 = "0."+String(value);
            } else if (value > 1) {
                val1 = "00."+String(value);
            } else {
                val1 = String(value);
            }
        }
    }*/
    
    //return jSuites.mask.run(val1.replace(".", ","), 'USD #.##0,00');
    //return Inputmask.format(val1.replace(".", ","), { mask: "USD 9.999.999,99" });
    
    //return "USD " + Inputmask.format(val1.replace(".", ","), { mask: "999.999.999,99", placeholder: "", numericInput: true });
    ///return Inputmask.format(value/100.0, { alias: "currency", prefix: "USD " });
    
    //return Inputmask.format(value/100.0, { alias: "currency", prefix: "USD " });
    
    if (typeof(value) !== 'undefined' && value !== null) {
        var mystring = String(value);
        mystring = mystring.replace(".", ",");
        
        //return Inputmask.format(mystring/100.0, { alias: "currencyUSD" });
        return Inputmask.format(mystring, { alias: "currencyBRL" });
    } else {
        return "RS 0,00";
    }
}

function fmtPercentage(value) {
    if (typeof(value) !== 'undefined' && value !== null) {
        var mystring = String(value);
        mystring = mystring.replace(".", ",");
        
        //return Inputmask.format(mystring/100.0, { alias: "currencyUSD" });
        return Inputmask.format(mystring, { alias: "percentage" });
    } else {
        return "0,00 %";
    }
}


function getMoney( str )
{
    return parseInt( str.replace(/[\D]+/g,'') );
}

function formatReal( int )
{
    if (int == null) int = 0;
    
    var tmp = int+'';
    
    tmp = tmp.replace(/([0-9]{2})$/g, ",$1");
    
    if( tmp.length > 6 )
        tmp = tmp.replace(/([0-9]{3}),([0-9]{2}$)/g, ".$1,$2");
    
    return tmp;
}

function numberToReal(numero) {
    
    var numero = numero.toFixed(2).split('.');
    numero[0] = "USD " + numero[0].split(/(?=(?:...)*$)/).join('.');
    return numero.join(',');
    
}

function numberToRealHtml(number) {
    
    var numero = number/100;
    numero = numero.toFixed(2).split('.');
    numero[0] = "USD " + numero[0].split(/(?=(?:...)*$)/).join('.');
    
    if (number < 0) {
        return '<span style="color:red;">' + numero.join(',') + '</span>';
    } else {
        return numero.join(',');
    }
    
}

function numberToRealSupHtml(number) {
    
    var numero = number/100;
    numero = numero.toFixed(2).split('.');
    numero[0] = "<sup>USD</sup> " + numero[0].split(/(?=(?:...)*$)/).join('.');
    
    if (number < 0) {
        return '<span style="color:red;">' + numero.join(',') + '</span>';
    } else {
        return numero.join(',');
    }
    
}

function numberIntToReal(numero) {
    
    var numero = numero/100;
    numero = numero.toFixed(2).split('.');
    numero[0] = "USD " + numero[0].split(/(?=(?:...)*$)/).join('.');
    return numero.join(',');
    
}

function justNumber(str){
    str = str.toString();
    return str.replace(/\D/g, '');
}

// leftPad(1, 4); // 0001
function leftPad(value, totalWidth, paddingChar) {
  var length = totalWidth - value.toString().length + 1;
  return Array(length).join(paddingChar || '0') + value;
};


/* PHONE */
function formatMobilePhone(number, maskStr) {
    //phone.substr(0, 3) + '-' + phone.substr(3, 3) + '-' + phone.substr(6,4)
    //return '(' + number.substr(0, 2) + ') ' + number.substr(2, 5) + '-' + number.substr(7,4)
    
    if (number != "") {
        if (maskStr == "") {
            return Inputmask.format(number, { mask: "(99) 99999-9999" });
        }
        
        return Inputmask.format(number, { mask: maskStr })
    }
    
    return "";
}

/* Accounts */
function formatAccountStatus(status){
    switch(status){
        case 'active':
            return 'Conta habilitada';
        break;
        case 'suspended_by_admin':
            return 'Conta desabilitada';
        break;
        case 'automatically_suspended':
            return 'Conta suspendida';
        break;
    }
}

/* Invoices */
function formatInvoicesStatus(status){
    switch(status){
        case 1:
            return 'Pendente';
        break;
        case 2:
        case 4:
        case 5:
            return 'Pago <sup>(a baixar)</sup>';
        break;
        case 3:
            return 'Pago';
        break;
        case 7:
            return 'Cancelado';
        break;
    }
}

/* Wallet */
function formatWalletType(type){
    switch(type){
        case 1:
            return 'credit';
        break;
        case 2:
        case 3:
        case 4:
            return 'debit';
        break;
    }
}

function formatWalletTypeStr(type){
    switch(type){
        case 1:
            return 'Crédito em conta';
        break;
        case 2:
            return 'Débito em conta';
        break;
        case 3:
            return 'Saque por depósito';
        break;
        case 4:
            return 'Saque em dinheiro';
        break;
    }
}

function formatWalletStatus(status){
    switch(status){
        case 1:
            return 'Aguardando';
        break;
        case 3:
        case 4:
            return 'Realizado';
        break;
        case 7:
            return 'Cancelado';
        break;
    }
}

/* Products */
function formatProductsCategory(category){
    switch (category) {
        case "adhesion":
            return "Adesão";
        break;
        case "activation":
            return "Ativação";
        break;
        case "sale":
            return "Venda";
        break;
    }
}

function formatProductsEnabled(enabled){
    switch(enabled){
        case true:
            return 'Habilitado';
        break;
        case false:
            return 'Desativado';
        break;
    }
}


/* ARRAY */
// array = [{key:value},{key:value}]
function objectFindByKey(array, key, value) {
    for (var i = 0; i < array.length; i++) {
        if (array[i][key] === value) {
            return array[i];
        }
    }
    return null;
}



function formatBytes(bytes,decimals) {
   if(bytes == 0) return '0 Bytes';
   var k = 1024,
       dm = decimals || 2,
       sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
       i = Math.floor(Math.log(bytes) / Math.log(k));
   return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}






function hasClass(el, className){
    return el.className && new RegExp("(^|\\s)" + className + "(\\s|$)").test(el.className);
}
/**function hasClass(element, className) {
    return (' ' + element.className + ' ').indexOf(' ' + className+ ' ') > -1;
}*/



function numberToReal(numero) {
    var numero = numero.toFixed(2).split('.');
    numero[0] = "USD " + numero[0].split(/(?=(?:...)*$)/).join('.');
    return numero.join(',');
}

function numberToRealHtml(number) {
    var numero = number/100;
    numero = numero.toFixed(2).split('.');
    numero[0] = "USD " + numero[0].split(/(?=(?:...)*$)/).join('.');
    
    if (number < 0) {
        return '<span style="color:red;">' + numero.join(',') + '</span>';
    } else {
        return numero.join(',');
    }
}

function numberToRealSupHtml(number) {
    var numero = number/100;
    numero = numero.toFixed(2).split('.');
    numero[0] = "<sup>USD</sup> " + numero[0].split(/(?=(?:...)*$)/).join('.');
    
    if (number < 0) {
        return '<span style="color:red;">' + numero.join(',') + '</span>';
    } else {
        return numero.join(',');
    }
}




function GetFilename(url)
{
   if (url)
   {
      var m = url.toString().match(/.*\/(.+?)\./);
      if (m && m.length > 1)
      {
         return m[1];
      }
   }
   return "";
}

function isVisible(el){
    var style = window.getComputedStyle(el);
    return  style.width !== "0" &&
    style.height !== "0" &&
    style.opacity !== "0" &&
    style.display!=='none' &&
    style.visibility!== 'hidden';
}



formatDate = function date2str(x, y) {
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
}




// UTILS
var stringConstructor = "test".constructor;
var arrayConstructor = [].constructor;
var objectConstructor = {}.constructor;

function whatIsIt(object) {
    if (object === null) {
        return "null";
    }
    else if (object === undefined) {
        return "undefined";
    }
    else if (object.constructor === stringConstructor) {
        return "String";
    }
    else if (object.constructor === arrayConstructor) {
        return "Array";
    }
    else if (object.constructor === objectConstructor) {
        return "Object";
    }
    else {
        return "don't know";
    }
}


function checkPattern(event){
    var charCode = (window.event)?event.keyCode:event.which;
    
    if (event.shiftKey == false){
        if (charCode>=45 && charCode<=46 || charCode>=48 && charCode<=57 || charCode>=65 && charCode<=90 || charCode>=97 && charCode<=122 || charCode==173 || charCode==190)
            return true;
        else {
            if (charCode==8 || charCode==0 || charCode==9 || charCode==13)
                return true;
            else
                return false;
        }
    } else {
        if (event.shiftKey == true && charCode==9)
            return true;
        else
            return false;
    }
}

function RemoveAccents(element) {  //strAccents) {
    var strAccents = element.value;
        strAccents = strAccents.split('');
    var strAccentsOut = new Array();
    var strAccentsLen = strAccents.length;
    var accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var accentsOut = "AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz";
    
    for (var y = 0; y < strAccentsLen; y++) {
        if (accents.indexOf(strAccents[y]) != -1) {
            strAccentsOut[y] = accentsOut.substr(accents.indexOf(strAccents[y]), 1);
        } else
            strAccentsOut[y] = strAccents[y];
    }
    
    strAccentsOut = strAccentsOut.join('');
    element.value = strAccentsOut;
    //return strAccentsOut;
}

function queryObj() {
    var result = {}, keyValuePairs = location.search.slice(1).split("&");
    keyValuePairs.forEach(function(keyValuePair) {
        keyValuePair = keyValuePair.split('=');
        result[decodeURIComponent(keyValuePair[0])] = decodeURIComponent(keyValuePair[1]) || '';
    });
    return result;
}


formatDate = function date2str(x, y) {
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
}



/* ******************************************************
 *  WORK
 *  function doSomething(foo, bar) {
 *      if(empty(bar)) {
 *          bar = 'default value';
 *      }
 *  }
 * ****************************************************** */
function isEmpty(data) {
    if (typeof(data) == 'number' || typeof(data) == 'boolean') { 
        return false; 
    }
    
    if (typeof(data) == 'undefined' || data === null) {
        return true;
    }
  
    if (typeof(data.length) != 'undefined') {
        return data.length == 0;
    }
    
    var count = 0;
    for(var i in data) {
        if (data.hasOwnProperty(i)) {
            count ++;
        }
    }
    return count == 0;
};

function isObjEmpty(obj) {
    // null and undefined are "empty"
    if (obj == null) return true;
 
    // Assume if it has a length property with a non-zero value
    // that that property is correct.
    if (obj.length && obj.length > 0)    return false;
    if (obj.length === 0)  return true;
 
    // Otherwise, does it have any properties of its own?
    // Note that this doesn't handle
    // toString and toValue enumeration bugs in IE < 9
    for (var key in obj) {
        if (hasOwnProperty.call(obj, key)) return false;
    }
 
    return true;
};






/*
 * VARIOUS
 */
function stopRKey(evt) { 
    var evt = (evt) ? evt : ((event) ? event : null); 
    var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null); 
    if ((evt.keyCode == 13) && (node.type=="text"))  {return false;}
}

function setFocus(elem) {
    document.getElementById(elem).focus();
}

function getPageSize() {
    var de = document.documentElement;
    var w = window.innerWidth || self.innerWidth || (de&&de.clientWidth) || document.body.clientWidth;
    var h = window.innerHeight || self.innerHeight || (de&&de.clientHeight) || document.body.clientHeight;
    arrayPageSize = [w,h];
    return arrayPageSize;
}

function getPageHeight() {
    var de = document.documentElement;
    var h = window.innerHeight || self.innerHeight || (de&&de.clientHeight) || document.body.clientHeight;
    alert(h);
    return h;
}

function getPageWidth() {
    var de = document.documentElement;
    var w = window.innerWidth || self.innerWidth || (de&&de.clientWidth) || document.body.clientWidth;
    return w;
}

function sleep(milliseconds) {
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if ((new Date().getTime() - start) > milliseconds){
      break;
    }
  }
}

function datetimeToString(datetime, show_day, show_time){
    hoje = new Date(datetime);
    dia = hoje.getDate();
    dias = hoje.getDay();
    mes = hoje.getMonth()+1;
    ano = hoje.getFullYear();
    
    if (dia < 10)
        dia = "0" + dia;
    
    if (mes < 10)
        mes = "0" + mes;
    
    NomeDia = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    NomeMes = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    
    
    var hours = hoje.getHours();
    var minutes = hoje.getMinutes();
    var seconds = hoje.getSeconds();
    
    if (hours < 10)
        hours = "0" + hours;
    
    if (minutes < 10)
        minutes = "0" + minutes;
    
    if (seconds < 10)
        seconds = "0" + seconds;
    
    if (show_day) {
        if (show_time) {
            return NomeDia[dias] + ", " + dia + "/" + mes + "/" + ano + "&nbsp;" + hours + ":" + minutes + ":" + seconds;
        } else {
            return NomeDia[dias] + ", " + dia + "/" + mes + "/" + ano;
        }
    } else {
        if (show_time) {
            return dia + "/" + mes + "/" + ano + "&nbsp;" + hours + ":" + minutes + ":" + seconds;
        } else {
            return dia + "/" + mes + "/" + ano;
        }
    }
}



/* MONEY */
function getMoney( str )
{
    return parseInt( str.replace(/[\D]+/g,'') );
}

function formatReal( int )
{
    if (int == null) int = 0;
    
    var tmp = int+'';
    
    tmp = tmp.replace(/([0-9]{2})$/g, ",$1");
    
    if( tmp.length > 6 )
        tmp = tmp.replace(/([0-9]{3}),([0-9]{2}$)/g, ".$1,$2");
    
    return tmp;
}


/* ARRAY */
// array = [{key:value},{key:value}]
function objectFindByKey(array, key, value) {
    for (var i = 0; i < array.length; i++) {
        if (array[i][key] === value) {
            return array[i];
        }
    }
    return null;
}







/**
 * FILE
 */
//loadJS("../assets/js/libs/gallery/gallery.js");
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


/**
 * MONEY
 */
function floatToReal(value) {
    
    var value = value.toFixed(2).split('.');
    value[0] = "USD " + value[0].split(/(?=(?:...)*$)/).join('.');
    return value.join(',');
    
}


/**
 * STRING
 */
function replaceAll(find, replace, str) {
    
    while ( str.indexOf(find) > -1) {
        str = str.replace(find, replace);
    }
    return str;
    
}


/**
 * PRINT
 */
function printDiv(divName) {
     
     var printContents = document.getElementById(divName).innerHTML;
     var originalContents = document.body.innerHTML;
     
     document.body.innerHTML = printContents;
     
     window.print();
     
     document.body.innerHTML = originalContents;
     
}


/**
 * Make a X-Domain request to url and callback.
 *
 * @param url {String}
 * @param method {String} HTTP verb ('GET', 'POST', 'DELETE', etc.)
 * @param data {String} request body
 * @param callback {Function} to callback on completion
 * @param errback {Function} to callback on error
 */
function xdrpub(method, endpoint, data, callback, errback) {
    
    var req,
        ///url = 'https://api.imob.brauntech.com.br/services/v1/rest/'+XReqSourceData+endpoint;
        url = endpoint;
    
    if (XMLHttpRequest) {
        
        req = new XMLHttpRequest();

        if('withCredentials' in req) {
            req.open(method, url, true);
            req.onerror = errback;
            req.onreadystatechange = function() {
                if (req.readyState === 4) {
                    if (req.status >= 200 && req.status < 400) {
                        callback(req.responseText);
                    } else {
                        errback(new Error('Response returned with non-OK status'));
                    }
                }
            };
            
            req.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            req.setRequestHeader('Accept', 'application/json');
            req.send(data);
        }
        
    } else if(XDomainRequest) {
        
        req = new XDomainRequest();
        req.open(method, url);
        req.onerror = errback;
        req.onload = function() {
            callback(req.responseText);
        };
        
        req.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        req.setRequestHeader('Accept', 'application/json');
        req.send(data);
        
    } else {
        errback(new Error('CORS not supported'));
    }
    
}

function xhrpub(url, callback) {
    
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4) {
            callback(xhr.response);
        }
    };
    
    xhr.open('GET',url+"?"+(new Date()).getTime(), true);
    xhr.send(null);
    
}

function xhrpubDown(url) {
    var xhr = new XMLHttpRequest();
    //xhr.open('GET',url+"?"+(new Date()).getTime(), true);
    xhr.open('GET', url, true);
    xhr.responseType = 'arraybuffer';
    
    xhr.setRequestHeader("X-Api-Key", CFG__API_KEY);
    xhr.setRequestHeader("Authorization", cookieGet('__utmo'));
    
    xhr.onload = function () {
        if (this.status === 200) {
            var filename = "";
            var disposition = xhr.getResponseHeader('Content-Disposition');
            if (disposition && disposition.indexOf('attachment') !== -1) {
                var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                var matches = filenameRegex.exec(disposition);
                if (matches != null && matches[1]) filename = matches[1].replace(/['"]/g, '');
            }
            
            var type = xhr.getResponseHeader('Content-Type');

            var blob = new Blob([this.response], { type: type });
            if (typeof window.navigator.msSaveBlob !== 'undefined') {
                // IE workaround for "HTML7007: One or more blob URLs were revoked by closing the blob for which they were created. These URLs will no longer resolve as the data backing the URL has been freed."
                window.navigator.msSaveBlob(blob, filename);
            } else {
                var URL = window.URL || window.webkitURL;
                var downloadUrl = URL.createObjectURL(blob);

                if (filename) {
                    // use HTML5 a[download] attribute to specify filename
                    var a = document.createElement("a");
                    // safari doesn't support this yet
                    if (typeof a.download === 'undefined') {
                        //window.location = downloadUrl;
                        window.open(downloadUrl);
                    } else {
                        a.href = downloadUrl;
                        a.download = filename;
                        document.body.appendChild(a);
                        a.click();
                    }
                } else {
                    //window.location = downloadUrl;
                    window.open(downloadUrl);
                }

                setTimeout(function () { URL.revokeObjectURL(downloadUrl); }, 100); // cleanup
            }
            
            
                /*
                var saveData = (function () {
                    var a = document.createElement("a");
                    document.body.appendChild(a);
                    a.style = "display: none";
                    return function (data, fileName) {
                        var json = JSON.stringify(data),
                            blob = new Blob([json], {type: "octet/stream"}),
                            url = window.URL.createObjectURL(blob);
                        a.href = url;
                        a.download = fileName;
                        a.click();
                        window.URL.revokeObjectURL(url);
                    };
                }());

                var data = { x: 42, s: "hello, world", d: new Date() },
                    fileName = "my-download.json";

                saveData(data, fileName);
                */
        }
    };
    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    
    xhr.send(null);
}


/*
 * Core
 */
function openInNewTab(url) {
    var opn = window.open(url, '_blank');
    opn.focus();
}

function sendMail(){
    
    var link = "mailto:me@example.com"
             + "?cc=myCCaddress@example.com"
             + "&subject=" + escape(document.title)
             + "&body=Eu pensei que você poderia estar interessado em " + document.title
             + ". Você pode vê-lo em, " + location.href
    ;

    window.location.href = link;
    
}

function checkEmail(val) {
    
    if (!val.match(/\S+@\S+\.\S+/)) { // Jaymon's / Squirtle's solution
        // Do something
        return false;
    }
    
    if ( val.indexOf(' ')!=-1 || val.indexOf('..')!=-1) {
        // Do something
        return false;
    }
    
    return true;
    
}

function printContent(el){
    
    var restorepage = document.body.innerHTML;
    var printcontent = document.getElementById(el).innerHTML;
    
    document.body.innerHTML = printcontent;
    window.print();
    document.body.innerHTML = restorepage;
    
}







/**
 * NEW
 */
function OpenFile(file, contentType) {
    var fileUrl = CFG__API_URL+'/'+_appData.settings.__spaces_bucket+file;
    
    if (contentType.includes("image")) {
        App.form('viewer_image', null, '95%', { file: fileUrl });
    } else if (contentType.includes("pdf")) {
            App.form('viewer_pdf', null, '95%', { file: fileUrl });
        } else if (contentType.includes("text")) {
            App.form('viewer_code', null, '95%', { file: fileUrl });
        }
}

function OpenFileReport(url) {
    App.form('viewer_pdf', null, '95%', { file: url });
}






/**
function shareTwitter(url, text) {
    open('http://twitter.com/share?url=' + url + '&text=' + text, 'tshare', 'height=400,width=550,resizable=1,toolbar=0,menubar=0,status=0,location=0');  
}

function shareFacebook(url, text, image) {
    open('http://facebook.com/sharer.php?s=100&p[url]=' + url + '&p[images][0]=' + image + '&p[title]=' + text, 'fbshare', 'height=380,width=660,resizable=0,toolbar=0,menubar=0,status=0,location=0,scrollbars=0');
}

function shareGooglePlus(url) {
    open('https://plus.google.com/share?url=' + url, 'gshare', 'height=270,width=630,resizable=0,toolbar=0,menubar=0,status=0,location=0,scrollbars=0');
}
*/
