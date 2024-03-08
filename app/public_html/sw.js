var cacheName = '1.9.18.104';
const assets = [
    "/index.html",
    
    //"/assets/css/reset.min.css",
    //"/assets/css/grid.css",
    //"/assets/css/style.css",
    //"/assets/css/table.css",
    
    /*"/assets/img/bottom-c7.svg",
    "/assets/img/default-user.png",
    "/assets/img/qrcode.png",
    "/assets/img/logo.png",
    "/assets/img/logo.svg",
    "/assets/img/top-b2.svg",
    */
    
    "/assets/js/app.js",
    "/assets/js/commerce.js",
    "/assets/js/controller.js",
    //"/assets/js/core.js",
    //"/assets/js/smask.js",
    "/assets/js/wooui.js",
    //"/assets/js/xdr.js",
    
    /*
    "/splashscreens/ipadpro1_splash.png",
    "/splashscreens/ipadpro2_splash.png",
    "/splashscreens/ipadpro3_splash.png",
    "/splashscreens/ipad_splash.png",
    "/splashscreens/iphone5_splash.png",
    "/splashscreens/iphone6_splash.png",
    "/splashscreens/iphoneplus_splash.png",
    "/splashscreens/iphonexr_splash.png",
    "/splashscreens/iphonexsmax_splash.png",
    "/splashscreens/iphonex_splash.png",
    
    "/templates/index.tpl",
    "/templates/profile.tpl"*/
    
    //"/modules/login.tpl",
    //"/modules/main.tpl",
    //"/modules/register.tpl",
    
    //"/modules/error/503.tpl",
    //"/modules/error/521.tpl",
    
    //"/modules/password/request-reset.tpl",
    //"/password/reset.tpl",
    //"/password/reset-password.tpl"
    
    "/config.ini.js"
];

self.addEventListener('install', installEvent => {
    installEvent.waitUntil(
        caches.open(cacheName)
            .then(cache => cache.addAll(
                assets
            ))
    );
});

self.addEventListener('message', function (messageEvent) {
    if (messageEvent.data.action === 'skipWaiting') {
        self.skipWaiting();
    }
});

self.addEventListener('fetch', function (fetchEvent) {
    fetchEvent.respondWith(
        caches.match(fetchEvent.request)
            .then(function (response) {
                if (response) {
                    return response;
                }
                return fetch(fetchEvent.request);
            })
    );
});

self.addEventListener('activate', async (eventActivate) => {
    const existingCaches = await caches.keys();
    const invalidCaches = existingCaches.filter(c => c !== cacheName);
    await Promise.all(invalidCaches.map(ic => caches.delete(ic)));
    
    // do whatever else you need to...
});
