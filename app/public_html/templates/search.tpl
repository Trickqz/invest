<div class="container-xl">
    <!-- Page title -->
    <div class="page-header d-print-none">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="page-title">
                    Search people
                </h2>
                <!--<div class="text-muted mt-1">1-18 of 413 people</div>-->
            </div>
            <!-- Page title actions -->
            <!--<div class="col-auto ms-auto d-print-none">
                <div class="d-flex">
                    <input type="search" class="form-control d-inline-block w-9 me-3" placeholder="Search user…" />
                    <a href="#" class="btn btn-primary">
                        <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
            <!--            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                            <line x1="12" y1="5" x2="12" y2="19" />
                            <line x1="5" y1="12" x2="19" y2="12" />
                        </svg>
                        New user
                    </a>
                </div>
            </div>-->
        </div>
    </div>
</div>
<div class="page-body">
    <!-- -->
</div>

<script>
    var elSearch = document.getElementById("search_q");
    
    function fc_searchGetAll() {
        if (elSearch.value != "") {
            var search_q = { q: elSearch.value };
            
            document.querySelector(".page-body").innerHTML = 
                  '<div class="empty">'
                + '    <p class="empty-title"><div class="spinner-grow" role="status"></div></p>'
                + '</div>';
            
            
            $.ajax({
                type: "GET",
                url: CFG__API_URL + CFG__API_VERSION + "/search",
                data: search_q,
                success: function(response){
                    var arr = response.data;
                    var itemsHTML = '';
                    
                    if (arr.length > 0) {
                        for (var i = 0; i < arr.length; i++){
                            var picture__src = '../assets/img/picker_account.png';
                            
                            if (arr[i]._picture_src != null) {
                                picture__src = CFG__API_URL+'/d/uploads/accounts/'+arr[i]._id+'/profile/picture/'+arr[i]._picture_src;
                            }
                            
                            itemsHTML += 
                                  '<div class="col-md-6 col-lg-3">'
                                + '    <div class="card">'
                                + '        <div class="card-body p-4 text-center">'
                                + '            <span class="avatar avatar-xl mb-3 avatar-rounded" style="background-image: url(\''+picture__src+'\');"></span>'
                                + '            <h3 class="m-0 mb-1"><a href="#">' + arr[i]._name + '</a></h3>'
                                + '            <div class="text-muted">' + formatMobilePhone(arr[i]._mobile_phone, arr[i]._country_phone_mask) + '</div>'
                                + '            <div class="mt-3">'
                                + '                <span class="badge bg-green-lt">' + arr[i]._username + '</span>'
                                + '            </div>'
                                + '        </div>'
                                + '        <div class="d-flex">'
                                + '            <a href="mailto:' + arr[i]._email + '" class="card-btn">'
                                + '                <!-- Download SVG icon from http://tabler-icons.io/i/mail -->'
                                + '                <svg xmlns="http://www.w3.org/2000/svg" class="icon me-2 text-muted" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />'
                                + '                    <rect x="3" y="5" width="18" height="14" rx="2" />'
                                + '                    <polyline points="3 7 12 13 21 7" />'
                                + '                </svg>'
                                + '                Email'
                                + '            </a>'
                                + '            <a href="tel:' + arr[i]._mobile_phone + '" class="card-btn">'
                                + '                <!-- Download SVG icon from http://tabler-icons.io/i/phone -->'
                                + '                <svg xmlns="http://www.w3.org/2000/svg" class="icon me-2 text-muted" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">'
                                + '                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />'
                                + '                    <path d="M5 4h4l2 5l-2.5 1.5a11 11 0 0 0 5 5l1.5 -2.5l5 2v4a2 2 0 0 1 -2 2a16 16 0 0 1 -15 -15a2 2 0 0 1 2 -2" />'
                                + '                </svg>'
                                + '                Tel'
                                + '            </a>'
                                + '        </div>'
                                + '    </div>'
                                + '</div>';
                        }
                        
                        document.querySelector(".page-body").innerHTML = 
                              ' <div class="container-xl">'
                            + '     <div class="row row-cards">'
                            +           itemsHTML
                            + '     </div>'
                            + ' </div>';
                    } else {
                        page__search__loadClear();
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    var jsonResponse = JSON.parse(XMLHttpRequest.responseText);
                    
                    console.log(error);
                    page__search__loadClear();
                }
            });
        }
    }
    
    function page__search__loadClear() {
        document.querySelector(".page-body").innerHTML = 
              '<div class="container-xl d-flex flex-column justify-content-center">'
            + '    <div class="empty">'
            + '        <div class="empty-img"><img src="https://cdn.brauntech.com.br/ajax/libs/tabler/1.0.0-beta9/demo/static/illustrations/undraw_printing_invoices_5r4r.svg" height="128" alt="" /></div>'
            + '        <p class="empty-title">No results found</p>'
            + '        <p class="empty-subtitle text-muted">'
            + '            Try changing your search or filter to find what you\'re looking for.'
            + '        </p>'
            + '    </div>'
            + '</div>';
    }
    
    fc_searchGetAll();
</script>
