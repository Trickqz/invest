/**
 * Make a X-Domain request to url and callback.
 *
 * @param url {String}
 * @param method {String} HTTP verb ('GET', 'POST', 'DELETE', etc.)
 * @param data {String} request body
 * @param callback {Function} to callback on completion
 * @param errback {Function} to callback on error
 */
function xdr(method, url, data, callback, errback) {
    if (XMLHttpRequest) {
        var req = new XMLHttpRequest();
        
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
            
            //req.overrideMimeType("application/octet-stream; charset=x-user-defined;");
            //req.overrideMimeType("application/x-www-form-urlencoded");
            req.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            req.setRequestHeader('Accept', 'application/json');
            /*if (XReqSourceData == true) {
                req.setRequestHeader('X-Req-Source-Data', cookieGet('XReqSourceData'));
            }*/
            req.setRequestHeader('Authorization', cookieGet('__utmo'));
            if (method == "PUT" || method == "DELETE") {
                /**var accessKeyId = null;
                (async () => {
                    accessKeyId = await Controller.spacesGenKey(CFG__API_REST_SPACES_FILEPATH, 6);
                    
                    req.setRequestHeader('Access-Key-Id', accessKeyId);
                    req.send(data);
                })().finally(() => {
                    //accessKeyId = null;
                });*/
                
                /**$.ajax({
                    type: 'POST',
                    url: CFG__API_URL + "/upload/gen-key",
                    beforeSend: function (xhr){ 
                        xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                    },
                    data: {
                        path: CFG__API_REST_SPACES_FILEPATH,
                        permission: 6
                    },
                    success: function(response) {
                        if (response.success === true) {
                            req.setRequestHeader('Access-Key-Id', response.data.key);**/
                            req.send(data);
                /**        } else {
                            App.alert('Atenção', response.message, null);
                        }
                    }
                });*/
            } else {
                req.send(data);
            }
        }
    } else if(XDomainRequest) {
        var req = new XDomainRequest();
        req.open(method, url);
        req.onerror = errback;
        req.onload = function() {
            callback(req.responseText);
        };
        
        //req.overrideMimeType("application/octet-stream; charset=x-user-defined;");
        //req.overrideMimeType("application/x-www-form-urlencoded");
        req.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        req.setRequestHeader('Accept', 'application/json');
        /*if (XReqSourceData == true) {
            req.setRequestHeader('X-Req-Source-Data', '59f30ad2fa70c761e6b644fc');
        }*/
        req.setRequestHeader('Authorization', cookieGet('__utmo'));
        if (method == "PUT" || method == "DELETE") {
            /**var accessKeyId = null;
            (async () => {
                accessKeyId = await Controller.spacesGenKey(CFG__API_REST_SPACES_FILEPATH, 6);
                
                req.setRequestHeader('Access-Key-Id', accessKeyId);
                req.send(data);
            })().finally(() => {
                //accessKeyId = null;
            });*/
            
            /**$.ajax({
                type: 'POST',
                url: CFG__API_URL + "/upload/gen-key",
                beforeSend: function (xhr){ 
                    xhr.setRequestHeader('Authorization', cookieGet('__utmo'));
                },
                data: {
                    path: CFG__API_REST_SPACES_FILEPATH,
                    permission: 6
                },
                success: function(response) {
                    if (response.success === true) {
                        req.setRequestHeader('Access-Key-Id', response.data.key);**/
                        req.send(data);
            /**        } else {
                        App.alert('Atenção', response.message, null);
                    }
                }
            });**/
        } else {
            req.send(data);
        }
    } else {
        errback(new Error('CORS not supported'));
    }
}

function xdr_file(method, url, data, callback, errback) {
    var req;
    
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
            
            //req.overrideMimeType("application/octet-stream; charset=x-user-defined;");
            //req.overrideMimeType("application/x-www-form-urlencoded");
            //req.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            req.setRequestHeader('Accept', 'application/json');
            /*if (XReqSourceData == true) {
                req.setRequestHeader('X-Req-Source-Data', '59f30ad2fa70c761e6b644fc');
            }*/
            req.setRequestHeader('Authorization', cookieGet('__utmo'));
            req.send(data);
        }
    } else if(XDomainRequest) {
        req = new XDomainRequest();
        req.open(method, url);
        req.onerror = errback;
        req.onload = function() {
            callback(req.responseText);
        };
        
        //req.overrideMimeType("application/octet-stream; charset=x-user-defined;");
        //req.overrideMimeType("application/x-www-form-urlencoded");
        //req.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        req.setRequestHeader('Accept', 'application/json');
        /*if (XReqSourceData == true) {
            req.setRequestHeader('X-Req-Source-Data', _Virtual.Session.XReqSourceData);
        }*/
        req.setRequestHeader('Authorization', cookieGet('__utmo'));
        req.send(data);
    } else {
        errback(new Error('CORS not supported'));
    }
}



/**
 * BYTE
 */
function formatBytes(bytes,decimals) {
   if(bytes == 0) return '0 Bytes';
   var k = 1024,
       dm = decimals || 2,
       sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
       i = Math.floor(Math.log(bytes) / Math.log(k));
   return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}


/**
 * FILE
 */
function dataURLtoFile(dataurl, filename) {
    var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
        bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
    while(n--){
        u8arr[n] = bstr.charCodeAt(n);
    }
    return new File([u8arr], filename, {type:mime});
}
/*
    //Usage example:
    var file = dataURLtoFile('data:text/plain;base64,aGVsbG8gd29ybGQ=', 'hello.txt');
    console.log(file);
*/

//return a promise that resolves with a File instance
function urltoFile(url, filename, mimeType){
    return (fetch(url)
        .then(function(res){return res.arrayBuffer();})
        .then(function(buf){return new File([buf], filename, {type:mimeType});})
    );
}

/*
    //Usage example:
    urltoFile('data:text/plain;base64,aGVsbG8gd29ybGQ=', 'hello.txt', 'text/plain')
    .then(function(file){
        console.log(file);
    })
*/
