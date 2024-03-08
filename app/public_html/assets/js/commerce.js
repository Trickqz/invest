/*
 *  GraphQL
 */
var graph = graphql(CFG__API_GRAPHQL_URL, {
    //method: "POST",
    //debug: true,
    //alwaysAutodeclare: true,
    headers: {
        //"Accept" : "application/json",
        //"Content-Type" : "application/json",
        "X-Api-Key": getCfgApiKey(cookieGet('__utmo')),  // CFG__API_KEY,
        "Authorization": cookieGet('__utmo'),
    }
    /*fragments: {
        // fragments, you don't need to say `fragment name`.
        auth: "on User { token }",
        error: "on Error { messages }"
    }*/
});

function getCfgApiKey(token) {
    if (typeof CFG__API_KEY != 'undefined') {
        return CFG__API_KEY;
    } else if (token == null) {
        return '';
    }
    
    
    ///var token = cookieGet('__utmo');  //"eyJ0eXAiO.../// jwt token";
    var decoded = jwt_decode(token);

    ///console.log(decoded);
    
    //CFG__API_KEY = decoded.droplet;
    
    return decoded.droplet;
}

var auth = graph(`mutation ($username: String!, $password: String!) {
    auth__login(username: $username, password: $password) {
        username
        role
        classification
        affiliation
        authorization {
            expires
            token
        }
    }
}`);

var authToken = graph(`mutation ($username: String!) {
    accounts__authToken(username: $username) {
        username
        role
        classification
        affiliation
        authorization {
            expires
            token
        }
    }
}`);

var passwordForgot = graph(`mutation ($username: String!) {
    accounts__passwordForgot(username: $username) {
        success
    }
}`);

var passwordReset = graph(`mutation ($username: String!, $code: String!, $password: String!) {
    accounts__passwordReset(username: $username, code: $code, password: $password) {
        success
    }
}`);


var accountsPasswordEdit = graph(`mutation ($username: String, $password: String!, $new_password: String!) {
    accounts__passwordEdit(username: $username, password: $password, new_password: $new_password) {
        success
    }
}`);

var passwordCheckCode = graph(`mutation ($username: String!, $code: String!) {
    accounts__passwordCheckCode(username: $username, code: $code) {
        is_valid
    }
}`);

var checkSignature = graph(`mutation ($code: String!) {
    accounts__checkSignature(code: $code) {
        is_valid
    }
}`);


var checkAvailableCpf = graph(`mutation ($cpf: String!) {
    accounts__checkAvailableCpf(cpf: $cpf) {
        is_available
    }
}`);

var checkAvailableCnpj = graph(`mutation ($cnpj: String!) {
    accounts__checkAvailableCnpj(cnpj: $cnpj) {
        is_available
    }
}`);

var checkAvailableUsername = graph(`mutation ($username: String!) {
    accounts__checkAvailableSigninNames(username: $username) {
        is_available
    }
}`);


var accountsSearch = graph(`query ($q: String, $status: String) {
    accounts__search(q: $q, status: $status) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
            role
        }
        validation {
            status
        }
        classification
        affiliation
        discount
    }
}`);

var accountsSearchSponsor = graph(`query ($username: String!) {
    accounts__getSponsorByUsername(username: $username) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            picture {
                src
            }
        }
        contact {
            email
            mobile_phone
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);

var storeRegisterCustomer = graph(`mutation ($type: String!, $full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $email: String!, $mobile_phone: String!, $username: String!, $password: String!, $indicator: String) {
    store__registerCustomer(type: $type, full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, email: $email, mobile_phone: $mobile_phone, username: $username, password: $password, indicator: $indicator) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
          about_me
          birthdate
          full_name
          sex
          picture {
            src
          }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var accountsRegister = graph(`mutation ($type: String!, $sponsor: String!, $full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $email: String!, $mobile_phone: String!, $username: String!, $password: String!, $indicator: String) {
    accounts__register(type: $type, sponsor: $sponsor, full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, email: $email, mobile_phone: $mobile_phone, username: $username, password: $password, indicator: $indicator) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
          about_me
          birthdate
          full_name
          sex
          picture {
            src
          }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var accountsUpdate = graph(`mutation ($full_name: String!, $sex: String, $birthdate: String, $rg: String, $email: String!, $phone: String, $mobile_phone: String!, $about_me: String, $maps_embed_url: String) {
    accounts__update(full_name: $full_name, sex: $sex, birthdate: $birthdate, rg: $rg, email: $email, phone: $phone, mobile_phone: $mobile_phone, about_me: $about_me, maps_embed_url: $maps_embed_url) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
          about_me
          birthdate
          full_name
          sex
            picture {
                src
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var accountsAddressUpdate = graph(`mutation ( $number: String, $complement: String, $city: String, $address__seq: Int, $postal_code: String, $state: String, $street: String, $district: String) {
    accounts__address_update(number: $number, complement: $complement, city: $city, address__seq: $address__seq, postal_code: $postal_code, state: $state, street: $street, district: $district) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
          about_me
          birthdate
          full_name
          sex
            picture {
                src
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var accountsBankAccountUpdate = graph(`mutation ($bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String, $holder__name: String, $holder__doc: String) {
    accounts__bank_account_update(bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, holder__name: $holder__name, holder__doc: $holder__doc) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
          about_me
          birthdate
          full_name
          sex
            picture {
                src
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var accountsSetProfilePicture = graph(`mutation ($src: String!) {
    accounts__setProfilePicture(src: $src) {
        success
    }
}`);

var accountsSetValidationStatus = graph(`mutation ($username: String, $status: String!) {
    accounts__setValidationStatus(username: $username, status: $status) {
        success
    }
}`);

var accountsGetAll__singleList = graph(`query ($q: String, $status: String, $limit: Int, $after: String, $before: String) {
    accounts__search(q: $q, status: $status, limit: $limit, after: $after, before: $before) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
            role
        }
        validation {
            status
        }
        classification
        affiliation
        discount
    }
}`);

var customersGetAll__singleList = graph(`query ($q: String, $status: String, $limit: Int, $after: String, $before: String) {
    customers__getAll(q: $q, status: $status, limit: $limit, after: $after, before: $before) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        network {
            active_until
            sponsor
            graduation {
                graduation__seq
                graduation__name
                graduation__award
                date
                status
            }
            status
            plan {
                registration__seq
                upgrade__seq
                current__seq
            }
        }
        access {
            username
            role
        }
        validation {
            status
        }
        classification
        affiliation
        discount
        extra__data {
            plan {
                name
                mode
                enable_access
            }
        }
    }
}`);


var accountsGetSalePoint = graph(`query ($username: String!) {
    accounts__getSalePoint(username: $username) {
        __v
        _id
        affiliation
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        profile {
            full_name
            picture {
                src
            }
        }
        contact {
            mobile_phone
            phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);

var accountsGetAllSalePoint = graph(`query ($state: String, $status: String) {
    accounts__getAllSalePoint(state: $state, status: $status) {
        __v
        _id
        affiliation
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        profile {
            full_name
            picture {
                src
            }
        }
        contact {
            mobile_phone
            phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);


var my_store__customersGetAll__singleList = graph(`query ($q: String, $status: String, $limit: Int, $after: String, $before: String) {
    my_store__customers_getAll(q: $q, status: $status, limit: $limit, after: $after, before: $before) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
            role
        }
        validation {
            status
        }
        classification
        affiliation
        discount
    }
}`);

var my_store__customersGetByUsername = graph(`query ($username: String!) {
    my_store__customers_getByUsername(username: $username) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            birthdate
            sex
            docs {
                cpf
                rg
                cnpj
            }
            about_me
            picture {
                src
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        network {
            active_until
            sponsor
            status
            plan {
                registration__seq
                upgrade__seq
                current__seq
            }
        }
        access {
            username
            role
        }
        validation {
            status
        }
        classification
        affiliation
        discount
    }
}`);

var my_store__productsGetAll = graph(`query ($type: String, $code: String, $barcode: String, $qrcode: String, $name: String, $category__id: String, $subcategory__id: String, $featured: Boolean, $enabled: Boolean, $limit: Int, $after: String, $before: String) {
    my_store__products__getAll(type: $type, code: $code, barcode: $barcode, qrcode: $qrcode, name: $name, category__id: $category__id, subcategory__id: $subcategory__id, featured: $featured, enabled: $enabled, limit: $limit, after: $after, before: $before) {
        __v
        _id
        category__id
        subcategory__id
        code
        barcode
        qrcode
        created_at
        currency
        digital_sales_commission
        digital_sales_punctuation
        description
        enabled
        name
        ncm
        cest
        cost_price
        original_price
        forward_price
        person_expiration {
            value
            time
        }
        features {
            weight
        }
        images {
            order
            category
            src
        }
        kit {
            items {
                code
                name
                quantity
            }
        }
        punctuation {
          binary {
            points
            qualification
          }
          indication {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        price
        specifications
        tags
        video
        type
        title_discount
        subsidize
        unity__id
        updated_at
        featured_text
        featured
        uses_kit
        sell_negative
        extra__data {
            stock {
                count
            }
        }
    }
}`);

/*
var storeGetProductsTopSelling = graph(`query ($local_account_id: String, $limit: Int) {
    store__getProductsTopSelling(local_account_id: $local_account_id, limit: $limit) {
        __v
        _id
        category__id
        subcategory__id
        code
        barcode
        qrcode
        created_at
        currency
        digital_sales_commission
        digital_sales_punctuation
        description
        enabled
        name
        ncm
        cost_price
        original_price
        forward_price
        person_expiration {
            value
            time
        }
        features {
            weight
        }
        images {
            order
            category
            src
        }
        kit {
            items {
                code
                name
                quantity
            }
        }
        punctuation {
          binary {
            points
            qualification
          }
          indication {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        price
        specifications
        tags
        video
        type
        title_discount
        subsidize
        unity__id
        updated_at
        featured_text
        featured
        uses_kit
        sell_negative
        extra__data {
            stock {
                count
            }
        }
    }
}`);
*/

var my_store__productsGetAll__singleList = graph(`query ($type: String, $code: String, $barcode: String, $qrcode: String, $name: String, $category__id: String, $subcategory__id: String, $featured: Boolean, $enabled: Boolean, $limit: Int, $after: String, $before: String) {
    my_store__products: my_store__products__getAll(type: $type, code: $code, barcode: $barcode, qrcode: $qrcode, name: $name, category__id: $category__id, subcategory__id: $subcategory__id, featured: $featured, enabled: $enabled, limit: $limit, after: $after, before: $before) {
        __v
        _id
        category__id
        subcategory__id
        code
        barcode
        qrcode
        created_at
        enabled
        name
        ncm
        cest
        cost_price
        original_price
        forward_price
        price
        tags
        video
        type
        title_discount
        subsidize
        unity__id
        updated_at
        featured
        uses_kit
        sell_negative
        images {
            order
            category
            src
        }
        kit {
            items {
                code
                name
                quantity
            }
        }
        extra__data {
            stock {
                count
            }
        }
    },
    products_categories: products_category__getAll {
        _id
        name
        enabled
    },
    products_subcategories: products_subcategory__getAll {
        _id
        name
        enabled
    }
}`);

var my_store__productsGetById = graph(`query ($_id: String!) {
    my_store__products__getById(_id: $_id) {
        __v
        _id
        category__id
        subcategory__id
        code
        barcode
        qrcode
        created_at
        currency
        digital_sales_commission
        digital_sales_punctuation
        description
        enabled
        name
        ncm
        cest
        cost_price
        original_price
        forward_price
        person_expiration {
            value
            time
        }
        features {
            weight
            dimensions {
                height
                width
                length
            }
        }
        images {
            order
            category
            src
        }
        kit {
            items {
                code
                name
                quantity
            }
        }
        punctuation {
          binary {
            points
            qualification
          }
          indication {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        price
        specifications
        tags
        video
        type
        title_discount
        subsidize
        unity__id
        updated_at
        featured_text
        featured
        uses_kit
        sell_negative
        extra__data {
            stock {
                count
            }
        }
    }
}`);

var accountsGetAll = graph(`query ($username: String, $profile__full_name: String) {
    accounts__getAll(username: $username, profile__full_name: $profile__full_name) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            email
            full_name
            picture {
                src
            }
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
            role
        }
        validation {
            status
        }
        classification
        affiliation
        discount
    }
}`);

var accountsGetByUsername = graph(`query ($username: String!) {
    accounts__getByUsername (username: $username) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            picture {
                src
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
        affiliation
        discount
    }
}`);

var accountsGetProfile = graph(`query {
    accounts__getProfile {
        __v
        _id
        created_at
        indicator
        last_access
        status
        uid
        type
        updated_at
        profile {
            about_me
            birthdate
            full_name
            sex
            picture {
                src
            }
        }
        contact {
            email
            mobile_phone
            phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        network {
            sponsor
            active_until
            graduation {
                graduation__seq
                graduation__name
                graduation__award
                date
                status
            }
            status
            plan {
                registration__seq
                upgrade__seq
                current__seq
            }
        }
        access {
            username
        }
        validation {
            status
        }
        affiliation
        discount
        extra__data {
            plan {
                name
                mode
                enable_access
                registration {
                    name
                    mode
                    enable_access
                    __seq
                }
                current {
                    name
                    mode
                    enable_access
                    __seq
                }
                upgrade {
                    name
                    mode
                    enable_access
                    __seq
                }
            }
        }
    }
}`);

var accountsDelete = graph(`mutation ($_id: String!) {
    accounts__delete(_id: $_id) {
        deleted
    }
}`);


/**
 * CUSTOMERS
 */
var customersGetBalance = graph(`query {
    customers__getBalance {
        count {
            active
            inactive
        }
    }
}`);

var customersGetById = graph(`query ($_id: String!) {
    customers__getById (_id: $_id) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            about_me
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
            email
            phone
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        bank {
            bank_number
            bank_name
            agency_number
            agency_digit
            account_number
            account_digit
            operation
            account_type
            holder {
                name
                doc
            }
        }
        network {
            sponsor
            active_until
            graduation {
                graduation__seq
                graduation__name
                graduation__award
                date
                status
            }
            status
            plan {
                registration__seq
                upgrade__seq
                current__seq
            }
        }
        access {
            username
        }
        validation {
            status
        }
        affiliation
        classification
        discount
        sell_negative
        block_sale
        extra__data {
            plan {
                name
                mode
            }
        }
    }
}`);

var customersCreate = graph(`mutation ($sponsor: String, $username: String, $full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $rg: String, $email: String!, $phone: String, $mobile_phone: String!, $number: String, $complement: String, $city: String, $postal_code: String, $state: String, $street: String, $district: String, $ bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String, $holder__name: String, $holder__doc: String, $about_me: String, $type: String!) {
    customers__create(sponsor: $sponsor, username: $username, full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, rg: $rg, email: $email, phone: $phone, mobile_phone: $mobile_phone, number: $number, complement: $complement, city: $city, postal_code: $postal_code, state: $state, street: $street, district: $district,  bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, holder__name: $holder__name, holder__doc: $holder__doc, about_me: $about_me, type: $type) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
            about_me
            birthdate
            full_name
            sex
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var customersUpdate = graph(`mutation ($username: String!, $full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $rg: String, $email: String!, $phone: String, $mobile_phone: String!, $number: String, $complement: String, $city: String, $address__seq: Int, $postal_code: String, $state: String, $street: String, $district: String, $ bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String, $holder__name: String, $holder__doc: String, $about_me: String, $maps_embed_url: String, $type: String!) {
    customers__update(username: $username, full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, rg: $rg, email: $email, phone: $phone, mobile_phone: $mobile_phone, number: $number, complement: $complement, city: $city, address__seq: $address__seq, postal_code: $postal_code, state: $state, street: $street, district: $district,  bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, holder__name: $holder__name, holder__doc: $holder__doc, about_me: $about_me, maps_embed_url: $maps_embed_url, type: $type) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
            about_me
            birthdate
            full_name
            sex
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var customersDelete = graph(`mutation ($username: String!) {
    customers__delete(username: $username) {
        deleted
    }
}`);



/**
 * Franchise
 */
var franchiseUpdate = graph(`mutation ($username: String!, $full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $rg: String, $email: String!, $phone: String, $mobile_phone: String!, $number: String, $complement: String, $city: String, $address__seq: Int, $postal_code: String, $state: String, $street: String, $district: String, $ bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String!, $holder__name: String, $holder__doc: String, $about_me: String, $maps_embed_url: String, $sell_negative: Boolean, $block_sale: Boolean, $type: String!) {
    franchise__update(username: $username, full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, rg: $rg, email: $email, phone: $phone, mobile_phone: $mobile_phone, number: $number, complement: $complement, city: $city, address__seq: $address__seq, postal_code: $postal_code, state: $state, street: $street, district: $district,  bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, holder__name: $holder__name, holder__doc: $holder__doc, about_me: $about_me, maps_embed_url: $maps_embed_url, sell_negative: $sell_negative, block_sale: $block_sale, type: $type) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
            about_me
            birthdate
            full_name
            sex
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var franchiseCreate = graph(`mutation ($username: String!, $full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $rg: String, $email: String!, $phone: String, $mobile_phone: String!, $number: String, $complement: String, $city: String, $postal_code: String, $state: String, $street: String, $district: String, $ bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String!, $holder__name: String, $holder__doc: String, $about_me: String, $maps_embed_url: String, $sell_negative: Boolean, $block_sale: Boolean, $type: String!) {
    franchise__create(username: $username, full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, rg: $rg, email: $email, phone: $phone, mobile_phone: $mobile_phone, number: $number, complement: $complement, city: $city, postal_code: $postal_code, state: $state, street: $street, district: $district,  bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, holder__name: $holder__name, holder__doc: $holder__doc, about_me: $about_me, maps_embed_url: $maps_embed_url, sell_negative: $sell_negative, block_sale: $block_sale, type: $type) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
            about_me
            birthdate
            full_name
            sex
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);


/**
 * Distribution center
 */
var distribution_centerCreate = graph(`mutation ($username: String!, $full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $rg: String, $email: String!, $phone: String, $mobile_phone: String!, $number: String, $complement: String, $city: String, $postal_code: String, $state: String, $street: String, $district: String, $ bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String!, $holder__name: String, $holder__doc: String, $about_me: String, $maps_embed_url: String, $sell_negative: Boolean, $block_sale: Boolean, $type: String!) {
    distribution_center__create(username: $username, full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, rg: $rg, email: $email, phone: $phone, mobile_phone: $mobile_phone, number: $number, complement: $complement, city: $city, postal_code: $postal_code, state: $state, street: $street, district: $district,  bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, holder__name: $holder__name, holder__doc: $holder__doc, about_me: $about_me, maps_embed_url: $maps_embed_url, sell_negative: $sell_negative, block_sale: $block_sale, type: $type) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
            about_me
            birthdate
            full_name
            sex
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var distribution_centerUpdate = graph(`mutation ($username: String!, $full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $rg: String, $email: String!, $phone: String, $mobile_phone: String!, $number: String, $complement: String, $city: String, $address__seq: Int, $postal_code: String, $state: String, $street: String, $district: String, $ bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String!, $holder__name: String, $holder__doc: String, $about_me: String, $maps_embed_url: String, $sell_negative: Boolean, $block_sale: Boolean, $type: String!) {
    distribution_center__update(username: $username, full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, rg: $rg, email: $email, phone: $phone, mobile_phone: $mobile_phone, number: $number, complement: $complement, city: $city, address__seq: $address__seq, postal_code: $postal_code, state: $state, street: $street, district: $district,  bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, holder__name: $holder__name, holder__doc: $holder__doc, about_me: $about_me, maps_embed_url: $maps_embed_url, sell_negative: $sell_negative, block_sale: $block_sale, type: $type) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
            about_me
            birthdate
            full_name
            sex
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);


/**
 * Selling point
 */
var selling_pointCreate = graph(`mutation ($username: String!, $full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $rg: String, $email: String!, $phone: String, $mobile_phone: String!, $number: String, $complement: String, $city: String, $postal_code: String, $state: String, $street: String, $district: String, $ bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String!, $holder__name: String, $holder__doc: String, $about_me: String, $maps_embed_url: String, $sell_negative: Boolean, $block_sale: Boolean, $type: String!) {
    selling_point__create(username: $username, full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, rg: $rg, email: $email, phone: $phone, mobile_phone: $mobile_phone, number: $number, complement: $complement, city: $city, postal_code: $postal_code, state: $state, street: $street, district: $district,  bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, holder__name: $holder__name, holder__doc: $holder__doc, about_me: $about_me, maps_embed_url: $maps_embed_url, sell_negative: $sell_negative, block_sale: $block_sale, type: $type) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
            about_me
            birthdate
            full_name
            sex
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var selling_pointUpdate = graph(`mutation ($username: String!, $full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $rg: String, $email: String!, $phone: String, $mobile_phone: String!, $number: String, $complement: String, $city: String, $address__seq: Int, $postal_code: String, $state: String, $street: String, $district: String, $ bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String!, $holder__name: String, $holder__doc: String, $about_me: String, $maps_embed_url: String, $sell_negative: Boolean, $block_sale: Boolean, $type: String!) {
    selling_point__update(username: $username, full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, rg: $rg, email: $email, phone: $phone, mobile_phone: $mobile_phone, number: $number, complement: $complement, city: $city, address__seq: $address__seq, postal_code: $postal_code, state: $state, street: $street, district: $district,  bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, holder__name: $holder__name, holder__doc: $holder__doc, about_me: $about_me, maps_embed_url: $maps_embed_url, sell_negative: $sell_negative, block_sale: $block_sale, type: $type) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
            about_me
            birthdate
            full_name
            sex
            docs {
                cpf
                rg
                cnpj
            }
            picture {
                src
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);



/**
 * Notifications
 */
var notificationsGetAll = graph(`query ($readed: Boolean) {
    notifications__getAll(readed: $readed) {
        __v
        _id
        content
        created_at
        deleted
        read_in
        readed
        subject
        type
        updated_at
        username
    }
}`);

var notificationsGetById = graph(`query ($_id: String!) {
    notifications__getById(_id: $_id) {
        __v
        _id
        content
        created_at
        deleted
        read_in
        readed
        subject
        type
        updated_at
        username
    }
}`);

var notificationsSetReaded = graph(`mutation ($_id: String!) {
    notifications__setReaded(_id: $_id) {
        success
    }
}`);

var notificationsSetAllReaded = graph(`mutation {
    notifications__setAllReaded {
        success
    }
}`);

function notificationsFormatReaded(readed){
    switch(readed){
        case true:
            return '<span class="badge badge-dot"><i class="bg-success"></i> Lido</span>';
        break;
        default:
            return '<span class="badge badge-dot"><i class="bg-danger"></i> Não lido</span>';
    }
}



/**
 * Unilevel
 */
// store_local, validation.status
var unilevelGetResume = graph(`query ($username: String) {
    unilevel__getResume(username: $username) {
        __v
        _id
        created_at
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            sex
        }
        contact {
            email
            mobile_phone
        }
        address {
            city
            state
        }
        network {
            active_until
            gain_level
            level
            master
            participative
            sponsor
            store_sponsor
            type
            graduation {
                graduation__seq
                date
            }
            status
            plan {
                registration__seq
                upgrade__seq
            }
        }
        access {
            username
            role
        }
        classification
        extra__data {
            count {
                direct
                indirect
                month {
                    direct
                    indirect
                }
            }
            plan {
                name
            }
            graduation {
                graduation__seq
                name
            }
            downline_grid {
                count {
                    active
                    inactive
                    total
                }
                grid {
                    level
                    count {
                        active
                        inactive
                        total
                    }
                }
            }
            prevision {
                vp
                ve
                vme
                vt
                gain {
                    gross
                    estimated
                    date
                }
                graduation {
                    graduation__seq
                    name
                    next {
                        __seq
                        name
                        ve
                        vme
                        perc_gain
                        points_required
                    }
                }
                date
            }
        }
    }
}`);

var unilevelGetDownline = graph(`query ($username: String!) {
    unilevel__getDownline(username: $username) {
        __v
        _id
        created_at
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            sex
        }
        contact {
            email
            mobile_phone
        }
        address {
            city
            state
        }
        access {
            username
            role
        }
        network {
            active_until
        }
        classification
        extra__data {
            count {
                direct
                indirect
                month {
                    direct
                    indirect
                }
            }
            plan {
                name
            }
            graduation {
                graduation__seq
                name
            }
            prevision {
                vp
                ve
                vme
                vt
                gain {
                    gross
                    estimated
                    date
                }
                graduation {
                    graduation__seq
                    name
                    next {
                        __seq
                        name
                        ve
                        vme
                        perc_gain
                        points_required
                    }
                }
                date
            }
        }
    }
}`);

var unilevelGetDownlineGrid = graph(`query ($username: String!) {
    unilevel__getDownlineGrid(username: $username) {
        count {
            active
            inactive
            total
        }
        grid {
            level
            count {
                active
                inactive
                total
            }
        }
    }
}`);

var unilevelGetIndications = graph(`query ($username: String, $date_of: String, $date_until: String, $type: String, $limit: Int, $after: String, $before: String, $order: String) {
    unilevel__getIndications(username: $username, date_of: $date_of, date_until: $date_until, type: $type, limit: $limit, after: $after, before: $before, order: $order) {
        __v
        _id
        created_at
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            sex
            picture {
                src
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            city
            state
        }
        access {
            username
            role
        }
        classification
    }
}`);



/**
 * VME
 */
var pointsGetVme = graph(`query ($username: String, $year: Int, $month: Int) {
    points__getVme (username: $username, year: $year, month: $month) {
        __v
        _id
        username
        graduation {
            __seq
            name
        }
        points {
            vp
            ve
            vme
            vt
        }
        gain {
            gross
            estimated
            date
        }
        year
        month
        created_at
        updated_at
        doc__people {
            access {
                username
            }
            profile {
                full_name
            }
            contact {
                email
                mobile_phone
            }
        }
    }
}`);



/**
 * Logs
 */
var logsGetAll = graph(`query ($date_of: String!, $date_until: String!) {
    logs__getAll(date_of: $date_of, date_until: $date_until) {
        __v
        _id
        created_at
        ip
        method
        source
        source_data
        time
        response {
            length
            milliseconds
        }
    }
}`);

var logsGetById = graph(`query ($_id: String!) {
    logs__getById(_id: $_id) {
        __v
        _id
        created_at
        ip
        method
        source
        source_data
        time
        response {
            length
            milliseconds
        }
    }
}`);

var logsStats = graph(`query {
    logs__stats {
        size
        count
    }
}`);

var logsClear = graph(`mutation {
    logs__clear {
        success
    }
}`);




/**
 * GRADUATIONS
 */
var commissioning_graduationsGetAll = graph(`query ($limit: Int, $after: String, $before: String) {
    commissioning_graduations__getAll(limit: $limit, after: $after, before: $before) {
        _id
        __v
        __seq
        name
        description
        pontuation {
            ve
            vme
            perc_gain
        }
        created_at
        updated_at
        enabled
    }
}`);

var commissioning_graduationsGetById = graph(`query ($_id: String!) {
    commissioning_graduations__getById(_id: $_id) {
        _id
        __v
        __seq
        name
        description
        pontuation {
            ve
            vme
            perc_gain
        }
        created_at
        updated_at
        enabled
    }
}`);

var commissioning_graduationsCreate = graph(`mutation ($name: String!, $description: String!, $pontuation__ve: Int!, $pontuation__vme: Int!, $pontuation__perc_gain: Int!) {
    commissioning_graduations__create(name: $name, description: $description, pontuation__ve: $pontuation__ve, pontuation__vme: $pontuation__vme, pontuation__perc_gain: $pontuation__perc_gain) {
        _id
        __v
        __seq
        name
        description
        pontuation {
            ve
            vme
            perc_gain
        }
        created_at
        updated_at
        enabled
    }
}`);

var commissioning_graduationsUpdate = graph(`mutation ($_id: String!, $name: String!, $description: String!, $pontuation__ve: Int!, $pontuation__vme: Int!, $pontuation__perc_gain: Int!, $enabled: Boolean!) {
    commissioning_graduations__update(_id: $_id, name: $name, description: $description, pontuation__ve: $pontuation__ve, pontuation__vme: $pontuation__vme, pontuation__perc_gain: $pontuation__perc_gain, enabled: $enabled) {
        _id
        __v
        __seq
        name
        description
        pontuation {
            ve
            vme
            perc_gain
        }
        created_at
        updated_at
        enabled
    }
}`);

var commissioning_graduationsDelete = graph(`mutation ($_id: String!) {
    commissioning_graduations__delete(_id: $_id) {
        deleted
    }
}`);



/**
 * COMMISSIONING BONUS
 */
var commissioning_bonusGetAll = graph(`query ($limit: Int, $after: String, $before: String) {
    commissioning_bonus__getAll(limit: $limit, after: $after, before: $before) {
        _id
        __v
        __seq
        type
        level
        name
        paying_plan
        receiving_plan
        qualification
        sponsor_plan
        calculation_based
        calculation_percentage
        calculation_fixed_value
        paid_in
        gain_ceiling
        direct
        indirect
        pay_sponsor
        created_at
        updated_at
        enabled
    }
}`);

var commissioning_bonusGetById = graph(`query ($_id: String!) {
    commissioning_bonus__getById(_id: $_id) {
        _id
        __v
        __seq
        type
        level
        name
        paying_plan
        receiving_plan
        qualification
        sponsor_plan
        calculation_based
        calculation_percentage
        calculation_fixed_value
        paid_in
        gain_ceiling
        direct
        indirect
        pay_sponsor
        created_at
        updated_at
        enabled
    }
}`);

var commissioning_bonusCreate = graph(`mutation ($type: Int!, $level: Int, $name: String!, $paying_plan: String, $receiving_plan: String, $qualification: String, $sponsor_plan: String, $calculation_based: String!, $calculation_percentage: Int, $calculation_fixed_value: Int, $paid_in: String!, $gain_ceiling: Int, $direct: Int, $indirect: Int, $pay_sponsor: Boolean!) {
    commissioning_bonus__create(type: $type, level: $level, name: $name, paying_plan: $paying_plan, receiving_plan: $receiving_plan, qualification: $qualification, sponsor_plan: $sponsor_plan, calculation_based: $calculation_based, calculation_percentage: $calculation_percentage, calculation_fixed_value: $calculation_fixed_value, paid_in: $paid_in, gain_ceiling: $gain_ceiling, direct: $direct, indirect: $indirect, pay_sponsor: $pay_sponsor) {
        _id
        __v
        __seq
        type
        level
        name
        paying_plan
        receiving_plan
        qualification
        sponsor_plan
        calculation_based
        calculation_percentage
        calculation_fixed_value
        paid_in
        gain_ceiling
        direct
        indirect
        pay_sponsor
        created_at
        updated_at
        enabled
    }
}`);

var commissioning_bonusUpdate = graph(`mutation ($_id: String!, $type: Int!, $level: Int, $name: String!, $paying_plan: String, $receiving_plan: String, $qualification: String, $sponsor_plan: String, $calculation_based: String!, $calculation_percentage: Int, $calculation_fixed_value: Int, $paid_in: String!, $gain_ceiling: Int, $direct: Int, $indirect: Int, $pay_sponsor: Boolean!, $enabled: Boolean!) {
    commissioning_bonus__update(_id: $_id, type: $type, level: $level, name: $name, paying_plan: $paying_plan, receiving_plan: $receiving_plan, qualification: $qualification, sponsor_plan: $sponsor_plan, calculation_based: $calculation_based, calculation_percentage: $calculation_percentage, calculation_fixed_value: $calculation_fixed_value, paid_in: $paid_in, gain_ceiling: $gain_ceiling, direct: $direct, indirect: $indirect, pay_sponsor: $pay_sponsor, enabled: $enabled) {
        _id
        __v
        __seq
        type
        level
        name
        paying_plan
        receiving_plan
        qualification
        sponsor_plan
        calculation_based
        calculation_percentage
        calculation_fixed_value
        paid_in
        gain_ceiling
        direct
        indirect
        pay_sponsor
        created_at
        updated_at
        enabled
    }
}`);

var commissioning_bonusDelete = graph(`mutation ($_id: String!) {
    commissioning_bonus__delete(_id: $_id) {
        deleted
    }
}`);



/**
 * PLANS
 */
var commissioning_plansGetAll = graph(`query ($enabled: Boolean, $limit: Int, $after: String, $before: String) {
    commissioning_plans__getAll(enabled: $enabled, limit: $limit, after: $after, before: $before) {
        _id
        __v
        __seq
        name
        description
        amount
        voucher_amount
        voucher_mode
        bonus_register_mode
        currency
        store {
          desc_perc
        }
        unilevel {
          gain {
            level
            values {
              bonus {
                register
                adhesion
                activation
                purchase
              }
            }
            percentage {
              adhesion
              monthly_plan
              purchase
            }
          }
        }
        punctuation {
          indication {
            points
            qualification
          }
          binary {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        upgrade_of
        gain_ceiling
        register_product__code
        payment_mode
        upgrade_mode
        mode
        enable_access
        created_at
        updated_at
        just_upgrade
        enabled
    }
}`);

var commissioning_plansGetById = graph(`query ($_id: String!) {
    commissioning_plans__getById(_id: $_id) {
        _id
        __v
        __seq
        name
        description
        amount
        voucher_amount
        voucher_mode
        bonus_register_mode
        currency
        store {
          desc_perc
        }
        unilevel {
          gain {
            level
            values {
              bonus {
                register
                adhesion
                activation
                purchase
              }
            }
            percentage {
              adhesion
              monthly_plan
              purchase
            }
          }
        }
        punctuation {
          indication {
            points
            qualification
          }
          binary {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        upgrade_of
        gain_ceiling
        register_product__code
        payment_mode
        upgrade_mode
        mode
        enable_access
        created_at
        updated_at
        just_upgrade
        enabled
    }
}`);

var commissioning_plansGetBySeq = graph(`query ($__seq: Int!) {
    commissioning_plans__getBySeq(__seq: $__seq) {
        _id
        __v
        __seq
        name
        description
        amount
        voucher_amount
        voucher_mode
        bonus_register_mode
        currency
        store {
          desc_perc
        }
        unilevel {
          gain {
            level
            values {
              bonus {
                register
                adhesion
                activation
                purchase
              }
            }
            percentage {
              adhesion
              monthly_plan
              purchase
            }
          }
        }
        punctuation {
          indication {
            points
            qualification
          }
          binary {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        upgrade_of
        gain_ceiling
        register_product__code
        payment_mode
        upgrade_mode
        mode
        enable_access
        created_at
        updated_at
        just_upgrade
        enabled
    }
}`);

var commissioning_plansCreate = graph(`mutation ($name: String!, $description: String!, $amount: Int!, $store__desc_perc: Int!, $unilevel__gain__values__bonus__register: Int!, $voucher_amount: Int!, $voucher_mode: String!, $bonus_register_mode: String!, $punctuation__indication__points: Int!, $punctuation__matriz__qualification: Int!, $punctuation__matriz__points: Int!, $gain_ceiling: Int, $register_product__code: String) {
    commissioning_plans__create(name: $name, description: $description, amount: $amount, store__desc_perc: $store__desc_perc, unilevel__gain__values__bonus__register: $unilevel__gain__values__bonus__register, voucher_amount: $voucher_amount, voucher_mode: $voucher_mode, bonus_register_mode: $bonus_register_mode, punctuation__indication__points: $punctuation__indication__points, punctuation__matriz__qualification: $punctuation__matriz__qualification, punctuation__matriz__points: $punctuation__matriz__points, gain_ceiling: $gain_ceiling, register_product__code: $register_product__code) {
        _id
        __v
        __seq
        name
        description
        amount
        voucher_amount
        voucher_mode
        bonus_register_mode
        currency
        store {
          desc_perc
        }
        unilevel {
          gain {
            level
            values {
              bonus {
                register
                adhesion
                activation
                purchase
              }
            }
            percentage {
              adhesion
              monthly_plan
              purchase
            }
          }
        }
        punctuation {
          indication {
            points
            qualification
          }
          binary {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        upgrade_of
        gain_ceiling
        register_product__code
        mode
        enable_access
        created_at
        updated_at
        just_upgrade
        enabled
    }
}`);

var commissioning_plansUpdate = graph(`mutation ($_id: String!, $name: String!, $description: String!, $amount: Int!, $store__desc_perc: Int!, $unilevel__gain__values__bonus__register: Int!, $voucher_amount: Int!, $voucher_mode: String!, $bonus_register_mode: String!, $punctuation__indication__points: Int!, $punctuation__matriz__qualification: Int!, $punctuation__matriz__points: Int!, $gain_ceiling: Int, $register_product__code: String, $payment_mode: String!, $upgrade_mode: String!, $upgrade_of: String, $mode: String!, $enable_access: Boolean!, $just_upgrade: Boolean!, $enabled: Boolean!) {
    commissioning_plans__update(_id: $_id, name: $name, description: $description, amount: $amount, store__desc_perc: $store__desc_perc, unilevel__gain__values__bonus__register: $unilevel__gain__values__bonus__register, voucher_amount: $voucher_amount, voucher_mode: $voucher_mode, bonus_register_mode: $bonus_register_mode, punctuation__indication__points: $punctuation__indication__points, punctuation__matriz__qualification: $punctuation__matriz__qualification, punctuation__matriz__points: $punctuation__matriz__points, gain_ceiling: $gain_ceiling, register_product__code: $register_product__code, payment_mode: $payment_mode, upgrade_mode: $upgrade_mode, upgrade_of: $upgrade_of, mode: $mode, enable_access: $enable_access, just_upgrade: $just_upgrade, enabled: $enabled) {
        _id
        __v
        __seq
        name
        description
        amount
        voucher_amount
        voucher_mode
        bonus_register_mode
        currency
        store {
          desc_perc
        }
        unilevel {
          gain {
            level
            values {
              bonus {
                register
                adhesion
                activation
                purchase
              }
            }
            percentage {
              adhesion
              monthly_plan
              purchase
            }
          }
        }
        punctuation {
          indication {
            points
            qualification
          }
          binary {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        upgrade_of
        gain_ceiling
        register_product__code
        payment_mode
        upgrade_mode
        mode
        enable_access
        created_at
        updated_at
        just_upgrade
        enabled
    }
}`);

var commissioning_plansDelete = graph(`mutation ($_id: String!) {
    commissioning_plans__delete(_id: $_id) {
        deleted
    }
}`);



/**
 * PRODUCTS
 */
var productsGetBalance = graph(`query {
    products__getBalance {
        count {
            active
            inactive
        }
    }
}`);

var productsGetAll = graph(`query ($type: String, $code: String, $barcode: String, $qrcode: String, $name: String, $classification: String, $category__id: String, $subcategory__id: String, $featured: Boolean, $local_account_id: String, $enabled: Boolean, $limit: Int, $after: String, $before: String) {
    products__getAll(type: $type, code: $code, barcode: $barcode, qrcode: $qrcode, name: $name, classification: $classification, category__id: $category__id, subcategory__id: $subcategory__id, featured: $featured, enabled: $enabled, local_account_id: $local_account_id, limit: $limit, after: $after, before: $before) {
        __v
        _id
        classification
        category__id
        subcategory__id
        code
        barcode
        qrcode
        created_at
        currency
        digital_sales_commission
        digital_sales_punctuation
        description
        enabled
        name
        ncm
        cest
        cost_price
        original_price
        forward_price
        person_expiration {
            value
            time
        }
        features {
            weight
        }
        images {
            order
            category
            src
        }
        kit {
            items {
                code
                name
                quantity
            }
        }
        punctuation {
          binary {
            points
            qualification
          }
          indication {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        price
        specifications
        tags
        video
        type
        title_discount
        subsidize
        unity__id
        updated_at
        featured_text
        featured
        uses_kit
        sell_negative
        extra__data {
            stock {
                count
            }
        }
    }
}`);

var productsGetAll_forSelect = graph(`query ($type: String, $code: String, $barcode: String, $qrcode: String, $name: String, $classification: String, $category__id: String, $subcategory__id: String, $featured: Boolean, $local_account_id: String, $enabled: Boolean, $limit: Int, $after: String, $before: String) {
    products__getAll(type: $type, code: $code, barcode: $barcode, qrcode: $qrcode, name: $name, classification: $classification, category__id: $category__id, subcategory__id: $subcategory__id, featured: $featured, enabled: $enabled, local_account_id: $local_account_id, limit: $limit, after: $after, before: $before) {
        __v
        _id
        code
        name
    }
}`);

var productsGetAll__singleList = graph(`query ($type: String, $code: String, $barcode: String, $qrcode: String, $name: String, $classification: String, $category__id: String, $subcategory__id: String, $featured: Boolean, $local_account_id: String, $enabled: Boolean, $limit: Int, $after: String, $before: String) {
    products: products__getAll(type: $type, code: $code, barcode: $barcode, qrcode: $qrcode, name: $name, classification: $classification, category__id: $category__id, subcategory__id: $subcategory__id, featured: $featured, enabled: $enabled, local_account_id: $local_account_id, limit: $limit, after: $after, before: $before) {
        __v
        _id
        classification
        category__id
        subcategory__id
        code
        barcode
        qrcode
        created_at
        enabled
        name
        ncm
        cest
        cost_price
        original_price
        forward_price
        price
        tags
        video
        type
        title_discount
        subsidize
        unity__id
        updated_at
        featured
        uses_kit
        sell_negative
        images {
            order
            category
            src
        }
        kit {
            items {
                code
                name
                quantity
            }
        }
        extra__data {
            stock {
                count
            }
        }
    },
    products_categories: products_category__getAll {
        _id
        name
        enabled
    },
    products_subcategories: products_subcategory__getAll {
        _id
        name
        enabled
    }
}`);

var products_kitGetById = graph(`query ($_id: String!) {
    products__getById(_id: $_id) {
        __v
        _id
        classification
        category__id
        subcategory__id
        code
        barcode
        qrcode
        created_at
        enabled
        name
        ncm
        cest
        cost_price
        original_price
        forward_price
        price
        tags
        video
        type
        title_discount
        subsidize
        unity__id
        updated_at
        featured
        uses_kit
        sell_negative
        images {
            order
            category
            src
        }
        kit {
            items {
                code
                name
                quantity
            }
        }
    }
}`);

var productsGetById = graph(`query ($_id: String!, $local_account_id: String) {
    products__getById(_id: $_id, local_account_id: $local_account_id) {
        __v
        _id
        classification
        category__id
        subcategory__id
        code
        barcode
        qrcode
        created_at
        currency
        digital_sales_commission
        digital_sales_punctuation
        description
        enabled
        name
        ncm
        cest
        cost_price
        original_price
        forward_price
        person_expiration {
            value
            time
        }
        features {
            weight
            dimensions {
                height
                width
                length
            }
        }
        images {
            order
            category
            src
        }
        kit {
            items {
                code
                name
                quantity
            }
        }
        punctuation {
          binary {
            points
            qualification
          }
          indication {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        price
        specifications
        tags
        video
        type
        title_discount
        subsidize
        unity__id
        updated_at
        featured_text
        featured
        uses_kit
        sell_negative
        extra__data {
            stock {
                count
            }
        }
    }
}`);

var productsCreate = graph(`mutation ($type: String!, $code: String!, $barcode: String, $qrcode: String, $ncm: String, $cest: String, $name: String!, $unity__id: String!, $classification: String!, $category__id: String!, $subcategory__id: String, $cost_price: Int, $original_price: Int, $price: Int!, $forward_price: Int, $punctuation__matriz__points: Int, $punctuation__matriz__qualification: Int, $person_expiration__value: Int, $person_expiration__time: String, $features__dimensions__height: Int!, $features__dimensions__width: Int!, $features__dimensions__length: Int!, $features__weight: Int!, $digital_sales_commission: Int, $digital_sales_punctuation: Int, $description: String, $featured_text: String, $specifications: String, $tags: String, $video: String, $title_discount: Boolean, $subsidize: Boolean, $featured: Boolean, $sell_negative: Boolean) {
    products__create(type: $type, code: $code, barcode: $barcode, qrcode: $qrcode, ncm: $ncm, cest: $cest, name: $name, unity__id: $unity__id, classification: $classification, category__id: $category__id, subcategory__id: $subcategory__id, cost_price: $cost_price, original_price: $original_price, price: $price, forward_price: $forward_price, punctuation__matriz__points: $punctuation__matriz__points, punctuation__matriz__qualification: $punctuation__matriz__qualification, person_expiration__value: $person_expiration__value, person_expiration__time: $person_expiration__time, features__dimensions__height: $features__dimensions__height, features__dimensions__width: $features__dimensions__width, features__dimensions__length: $features__dimensions__length, features__weight: $features__weight, digital_sales_commission: $digital_sales_commission, digital_sales_punctuation: $digital_sales_punctuation, description: $description, featured_text: $featured_text, specifications: $specifications, tags: $tags, video: $video, title_discount: $title_discount, subsidize: $subsidize, featured: $featured, sell_negative: $sell_negative) {
        __v
        _id
        classification
        category__id
        subcategory__id
        code
        barcode
        qrcode
        created_at
        currency
        digital_sales_commission
        digital_sales_punctuation
        description
        enabled
        name
        ncm
        cest
        cost_price
        original_price
        forward_price
        person_expiration {
            value
            time
        }
        features {
            weight
        }
        images {
            order
            category
            src
        }
        kit {
            items {
                code
                name
                quantity
            }
        }
        punctuation {
          binary {
            points
            qualification
          }
          indication {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        price
        specifications
        tags
        video
        type
        title_discount
        subsidize
        unity__id
        updated_at
        featured_text
        featured
        uses_kit
        sell_negative
    }
}`);

var productsUpdate = graph(`mutation ($_id: String!, $type: String!, $barcode: String, $qrcode: String, $ncm: String, $cest: String, $name: String!, $unity__id: String!, $classification: String!, $category__id: String!, $subcategory__id: String, $cost_price: Int, $original_price: Int, $price: Int!, $forward_price: Int, $punctuation__matriz__points: Int, $punctuation__matriz__qualification: Int, $person_expiration__value: Int, $person_expiration__time: String, $features__dimensions__height: Int!, $features__dimensions__width: Int!, $features__dimensions__length: Int!, $features__weight: Int!, $digital_sales_commission: Int, $digital_sales_punctuation: Int, $description: String, $featured_text: String, $specifications: String, $tags: String, $video: String, $enabled: Boolean, $title_discount: Boolean, $subsidize: Boolean, $featured: Boolean, $uses_kit: Boolean, $sell_negative: Boolean) {
    products__update(_id: $_id, ncm: $ncm, cest: $cest, type: $type, barcode: $barcode, qrcode: $qrcode, name: $name, unity__id: $unity__id, classification: $classification, category__id: $category__id, subcategory__id: $subcategory__id, cost_price: $cost_price, original_price: $original_price, price: $price, forward_price: $forward_price, punctuation__matriz__points: $punctuation__matriz__points, punctuation__matriz__qualification: $punctuation__matriz__qualification, person_expiration__value: $person_expiration__value, person_expiration__time: $person_expiration__time, features__dimensions__height: $features__dimensions__height, features__dimensions__width: $features__dimensions__width, features__dimensions__length: $features__dimensions__length, features__weight: $features__weight, digital_sales_commission: $digital_sales_commission, digital_sales_punctuation: $digital_sales_punctuation, description: $description, featured_text: $featured_text, specifications: $specifications, tags: $tags, video: $video, enabled: $enabled, title_discount: $title_discount, subsidize: $subsidize, featured: $featured, uses_kit: $uses_kit, sell_negative: $sell_negative) {
        __v
        _id
        classification
        category__id
        subcategory__id
        code
        barcode
        qrcode
        created_at
        currency
        digital_sales_commission
        digital_sales_punctuation
        description
        enabled
        name
        ncm
        cest
        cost_price
        original_price
        forward_price
        person_expiration {
            value
            time
        }
        features {
            weight
        }
        images {
            order
            category
            src
        }
        kit {
            items {
                code
                name
                quantity
            }
        }
        punctuation {
          binary {
            points
            qualification
          }
          indication {
            points
            qualification
          }
          matriz {
            points
            qualification
          }
        }
        price
        specifications
        tags
        video
        type
        title_discount
        subsidize
        unity__id
        updated_at
        featured_text
        featured
        uses_kit
        sell_negative
    }
}`);


/**
 * PRODUCTS STOCK
 */
var products_stockGetAll = graph(`query ($local_account_id: String, $product__code: String!, $limit: Int, $after: String, $before: String, $order: String) {
    products_stock__getAll(local_account_id: $local_account_id, product__code: $product__code, limit: $limit, after: $after, before: $before, order: $order) {
        _id
        __v
        type
        local_account_id
        invoices__id
        inventary__id
        product__code
        quantity
        created_at
        updated_at
        position
    }
}`);

var products_stockGetById = graph(`query ($_id: String!) {
    products_stock__getById(_id: $_id) {
        _id
        __v
        type
        local_account_id
        invoices__id
        inventary__id
        product__code
        quantity
        created_at
        updated_at
        position
    }
}`);

var productsStockMove = graph(`mutation ($code: String!, $local_account_id: String!, $type: String!, $quantity: Int!) {
    products_stock__move(code: $code, local_account_id: $local_account_id, type: $type, quantity: $quantity) {
        success
    }
}`);



/**
 * PRODUCTS CATEGORY
 */
var productsCategoryGetAll = graph(`query ($limit: Int, $after: String, $before: String) {
    products_category__getAll(limit: $limit, after: $after, before: $before) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsCategoryGetById = graph(`query ($_id: String!) {
    products_category__getById(_id: $_id) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsCategoryCreate = graph(`mutation ($name: String!) {
    products_category__create(name: $name) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsCategoryUpdate = graph(`mutation ($_id: String!, $name: String!) {
    products_category__update(_id: $_id, name: $name) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsCategoryDelete = graph(`mutation ($_id: String!) {
    products_category__delete(_id: $_id) {
        deleted
    }
}`);



/**
 * PRODUCTS KIT
 */
var productsKitItemsAdd = graph(`mutation ($_id: String!, $item_code: String!, $item_quantity: Int!) {
    products__kit__items__add(_id: $_id, item_code: $item_code, item_quantity: $item_quantity) {
        success
    }
}`);

var productsKitItemsUpdate = graph(`mutation ($_id: String!, $item_code: String!, $item_quantity: Int!) {
    products__kit__items__update(_id: $_id, item_code: $item_code, item_quantity: $item_quantity) {
        success
    }
}`);

var productsKitItemsDelete = graph(`mutation ($_id: String!, $item_code: String!) {
    products__kit__items__delete(_id: $_id, item_code: $item_code) {
        deleted
    }
}`);



/**
 * PRODUCTS GRID
 */
var productsGridGetAll = graph(`query ($product__id: String!, $limit: Int, $after: String, $before: String) {
    products_grid__getAll(product__id: $product__id, limit: $limit, after: $after, before: $before) {
        __v
        _id
        product__id
        color__id
        code
        barcode
        qrcode
        created_at
        updated_at
        enabled
    }
}`);

var productsGridGetById = graph(`query ($_id: String!) {
    products_grid__getById(_id: $_id) {
        __v
        _id
        product__id
        color__id
        code
        barcode
        qrcode
        created_at
        updated_at
        enabled
    }
}`);

var productsGridCreate = graph(`mutation ($product__id: String!, $color__id: String, $code: String, $barcode: String, $qrcode: String) {
    products_grid__create(product__id: $product__id, color__id: $color__id, code: $code, barcode: $barcode, qrcode: $qrcode) {
        __v
        _id
        product__id
        color__id
        code
        barcode
        qrcode
        created_at
        updated_at
        enabled
    }
}`);

var productsGridUpdate = graph(`mutation ($_id: String!, $color__id: String, $code: String, $barcode: String, $qrcode: String) {
    products_grid__update(_id: $_id, color__id: $color__id, code: $code, barcode: $barcode, qrcode: $qrcode) {
        __v
        _id
        product__id
        color__id
        code
        barcode
        qrcode
        created_at
        updated_at
        enabled
    }
}`);

var productsGridDelete = graph(`mutation ($_id: String!) {
    products_grid__delete(_id: $_id) {
        deleted
    }
}`);



/**
 * PRODUCTS SUBCATEGORY
 */
var productsSubcategoryGetAll = graph(`query ($category__id: String!, $limit: Int, $after: String, $before: String) {
    products_subcategory__getAll(category__id: $category__id, limit: $limit, after: $after, before: $before) {
        __v
        _id
        category__id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsSubcategoryGetById = graph(`query ($_id: String!) {
    products_subcategory__getById(_id: $_id) {
        __v
        _id
        category__id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsSubcategoryCreate = graph(`mutation ($category__id: String!, $name: String!) {
    products_subcategory__create(category__id: $category__id, name: $name) {
        __v
        _id
        category__id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsSubcategoryUpdate = graph(`mutation ($_id: String!, $name: String!) {
    products_subcategory__update(_id: $_id, name: $name) {
        __v
        _id
        category__id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsSubcategoryDelete = graph(`mutation ($_id: String!) {
    products_subcategory__delete(_id: $_id) {
        deleted
    }
}`);



/**
 * BATCH
 */
var productsBatchGetAll = graph(`query ($limit: Int, $after: String, $before: String) {
    products_batch__getAll(limit: $limit, after: $after, before: $before) {
        __v
        __seq
        _id
        name
        description
        expiration_date
        created_at
        updated_at
        enabled
    }
}`);

var productsBatchGetById = graph(`query ($_id: String!) {
    products_batch__getById(_id: $_id) {
        __v
        __seq
        _id
        name
        description
        expiration_date
        created_at
        updated_at
        enabled
    }
}`);

var productsBatchCreate = graph(`mutation ($name: String!, $description: String, $expiration_date: String!) {
    products_batch__create(name: $name, description: $description, expiration_date: $expiration_date) {
        __v
        __seq
        _id
        name
        description
        expiration_date
        created_at
        updated_at
        enabled
    }
}`);

var productsBatchUpdate = graph(`mutation ($_id: String!, $name: String!, $description: String, $expiration_date: String!) {
    products_batch__update(_id: $_id, name: $name, description: $description, expiration_date: $expiration_date) {
        __v
        __seq
        _id
        name
        description
        expiration_date
        created_at
        updated_at
        enabled
    }
}`);

var productsBatchDelete = graph(`mutation ($_id: String!) {
    products_batch__delete(_id: $_id) {
        deleted
    }
}`);



/**
 * COLOR
 */
var productsColorGetAll = graph(`query ($limit: Int, $after: String, $before: String) {
    products_color__getAll(limit: $limit, after: $after, before: $before) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsColorGetById = graph(`query ($_id: String!) {
    products_color__getById(_id: $_id) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsColorCreate = graph(`mutation ($name: String!) {
    products_color__create(name: $name) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsColorUpdate = graph(`mutation ($_id: String!, $name: String!) {
    products_color__update(_id: $_id, name: $name) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsColorDelete = graph(`mutation ($_id: String!) {
    products_color__delete(_id: $_id) {
        deleted
    }
}`);



/**
 * SIZE
 */
var productsSizeGetAll = graph(`query ($limit: Int, $after: String, $before: String) {
    products_size__getAll(limit: $limit, after: $after, before: $before) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsSizeGetById = graph(`query ($_id: String!) {
    products_size__getById(_id: $_id) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsSizeCreate = graph(`mutation ($name: String!) {
    products_size__create(name: $name) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsSizeUpdate = graph(`mutation ($_id: String!, $name: String!) {
    products_size__update(_id: $_id, name: $name) {
        __v
        _id
        created_at
        enabled
        name
        updated_at
    }
}`);

var productsSizeDelete = graph(`mutation ($_id: String!) {
    products_size__delete(_id: $_id) {
        deleted
    }
}`);


var measurementUnitsGetAll = graph(`query {
    measurement_units__getAll {
        __v
        _id
        code
        created_at
        enabled
        name
        updated_at
    }
}`);


/**
 * PRODUCTS INVENTARY
 */
var productsInventaryGetAll = graph(`query ($limit: Int, $after: String, $before: String) {
    products_inventary__getAll(limit: $limit, after: $after, before: $before) {
        _id
        __v
        __seq
        local_account_id
        name
        totals {
            items
            quantity
            amount
        }
        created_at
        updated_at
        status
    }
}`);

var productsInventaryGetById = graph(`query ($_id: String!) {
    products_inventary__getById(_id: $_id) {
        _id
        __v
        __seq
        local_account_id
        name
        totals {
            items
            quantity
            amount
        }
        created_at
        updated_at
        status
    }
}`);

var productsInventaryCreate = graph(`mutation ($local_account_id: String!, $name: String!) {
    products_inventary__create(local_account_id: $local_account_id, name: $name) {
        _id
        __v
        __seq
        local_account_id
        name
        totals {
            items
            quantity
            amount
        }
        created_at
        updated_at
        status
    }
}`);

var productsInventaryUpdate = graph(`mutation ($_id: String!, $name: String) {
    products_inventary__update(_id: $_id, name: $name) {
        _id
        __v
        __seq
        local_account_id
        name
        totals {
            items
            quantity
            amount
        }
        created_at
        updated_at
        status
    }
}`);

var productsInventarySetStatus = graph(`mutation ($_id: String!, $status: String!) {
    products_inventary__setStatus(_id: $_id, status: $status) {
        success
    }
}`);

var productsInventaryCancel = graph(`mutation ($_id: String!) {
    products_inventary__cancel(_id: $_id) {
        success
    }
}`);

var productsInventaryProcess = graph(`mutation ($_id: String!) {
    products_inventary__process(_id: $_id) {
        success
    }
}`);

var productsInventaryDelete = graph(`mutation ($_id: String!) {
    products_inventary__delete(_id: $_id) {
        deleted
    }
}`);


/**
 * PRODUCTS INVENTARY ITEMS
 */
var productsInventary_itemsGetAll = graph(`query ($inventary__id: String!, $q: String, $limit: Int, $after: String, $before: String) {
    products_inventary_items__getAll(inventary__id: $inventary__id, q: $q, limit: $limit, after: $after, before: $before) {
        _id
        __v
        inventary__id
        code
        name
        price
        currency
        quantity
    }
}`);

var productsInventary_itemsGetById = graph(`query ($_id: String!) {
    products_inventary_items__getById(_id: $_id) {
        _id
        __v
        inventary__id
        code
        name
        price
        currency
        quantity
    }
}`);

var productsInventary_itemsCreate = graph(`mutation ($name: String!) {
    products_inventary_items__create(name: $name) {
        _id
        __v
        inventary__id
        code
        name
        price
        currency
        quantity
    }
}`);

var productsInventary_itemsUpdate = graph(`mutation ($_id: String!, $quantity: Int!) {
    products_inventary_items__update(_id: $_id, quantity: $quantity) {
        _id
        __v
        inventary__id
        code
        name
        price
        currency
        quantity
    }
}`);

var productsInventary_itemsDelete = graph(`mutation ($_id: String!) {
    products_inventary_items__delete(_id: $_id) {
        deleted
    }
}`);




/**
 * Franchise
 */
var franchiseSearch = graph(`query ($q: String, $status: String) {
    franchise__search(q: $q, status: $status) {
        __v
        _id
        created_at
        status
        uid
        code
        updated_at
        type
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);

var franchiseGetById = graph(`query ($_id: String!) {
    franchise__getById (_id: $_id) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            about_me
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        bank {
            bank_number
            bank_name
            agency_number
            agency_digit
            account_number
            account_digit
            operation
            account_type
            holder {
                name
                doc
            }
        }
        access {
            username
        }
        validation {
            status
        }
        sell_negative
        block_sale
    }
}`);

var franchiseGetAll__singleList = graph(`query ($q: String, $status: String, $limit: Int, $after: String, $before: String) {
    franchise__search(q: $q, status: $status, limit: $limit, after: $after, before: $before) {
        __v
        _id
        created_at
        status
        uid
        code
        updated_at
        type
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);

var franchiseGetAll = graph(`query ($profile__full_name: String) {
    franchise__getAll(profile__full_name: $profile__full_name) {
        __v
        _id
        created_at
        status
        uid
        code
        updated_at
        type
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);


/**
 * Distribution center
 */
var distribution_centerSearch = graph(`query ($q: String, $status: String) {
    distribution_center__search(q: $q, status: $status) {
        __v
        _id
        created_at
        status
        uid
        code
        updated_at
        type
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);

var distribution_centerGetById = graph(`query ($_id: String!) {
    distribution_center__getById (_id: $_id) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            about_me
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        bank {
            bank_number
            bank_name
            agency_number
            agency_digit
            account_number
            account_digit
            operation
            account_type
            holder {
                name
                doc
            }
        }
        access {
            username
        }
        validation {
            status
        }
        sell_negative
        block_sale
    }
}`);

var distribution_centerGetAll__singleList = graph(`query ($q: String, $status: String, $limit: Int, $after: String, $before: String) {
    distribution_center__search(q: $q, status: $status, limit: $limit, after: $after, before: $before) {
        __v
        _id
        created_at
        status
        uid
        code
        updated_at
        type
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);

var distribution_centerGetAll = graph(`query ($profile__full_name: String) {
    distribution_center__getAll(profile__full_name: $profile__full_name) {
        __v
        _id
        created_at
        status
        uid
        code
        updated_at
        type
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);


/**
 * Selling_point
 */
var selling_pointSearch = graph(`query ($q: String, $status: String) {
    selling_point__search(q: $q, status: $status) {
        __v
        _id
        created_at
        status
        uid
        code
        updated_at
        type
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);

var selling_pointGetById = graph(`query ($_id: String!) {
    selling_point__getById (_id: $_id) {
        __v
        _id
        created_at
        last_access
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            about_me
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        bank {
            bank_number
            bank_name
            agency_number
            agency_digit
            account_number
            account_digit
            operation
            account_type
            holder {
                name
                doc
            }
        }
        access {
            username
        }
        validation {
            status
        }
        sell_negative
        block_sale
    }
}`);

var selling_pointGetAll__singleList = graph(`query ($q: String, $status: String, $limit: Int, $after: String, $before: String) {
    selling_point__search(q: $q, status: $status, limit: $limit, after: $after, before: $before) {
        __v
        _id
        created_at
        status
        uid
        code
        updated_at
        type
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);

var selling_pointGetAll = graph(`query ($profile__full_name: String) {
    selling_point__getAll(profile__full_name: $profile__full_name) {
        __v
        _id
        created_at
        status
        uid
        code
        updated_at
        type
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        access {
            username
        }
        validation {
            status
        }
    }
}`);



/**
 * PROVIDERS
 */
var providersGetBalance = graph(`query {
    providers__getBalance {
        count {
            active
            inactive
        }
    }
}`);

var providersCreate = graph(`mutation ($full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $rg: String, $email: String!, $phone: String, $mobile_phone: String!, $number: String, $complement: String, $city: String, $postal_code: String, $state: String, $street: String, $district: String, $ bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String, $holder__name: String, $holder__doc: String, $about_me: String, $maps_embed_url: String, $sell_negative: Boolean, $type: String!) {
    providers__create(full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, rg: $rg, email: $email, phone: $phone, mobile_phone: $mobile_phone, number: $number, complement: $complement, city: $city, postal_code: $postal_code, state: $state, street: $street, district: $district,  bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, holder__name: $holder__name, holder__doc: $holder__doc, about_me: $about_me, maps_embed_url: $maps_embed_url, sell_negative: $sell_negative, type: $type) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
          about_me
          birthdate
          full_name
          sex
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var providersUpdate = graph(`mutation ($_id: String!, $full_name: String!, $sex: String, $birthdate: String, $cpf: String, $cnpj: String, $rg: String, $email: String!, $phone: String, $mobile_phone: String!, $number: String, $complement: String, $city: String, $address__seq: Int, $postal_code: String, $state: String, $street: String, $district: String, $ bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String, $holder__name: String, $holder__doc: String, $about_me: String, $maps_embed_url: String, $sell_negative: Boolean, $type: String!) {
    providers__update(_id: $_id, full_name: $full_name, sex: $sex, birthdate: $birthdate, cpf: $cpf, cnpj: $cnpj, rg: $rg, email: $email, phone: $phone, mobile_phone: $mobile_phone, number: $number, complement: $complement, city: $city, address__seq: $address__seq, postal_code: $postal_code, state: $state, street: $street, district: $district,  bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, holder__name: $holder__name, holder__doc: $holder__doc, about_me: $about_me, maps_embed_url: $maps_embed_url, sell_negative: $sell_negative, type: $type) {
        __v
        _id
        classification
        code
        created_at
        last_access
        status
        type
        uid
        updated_at
        access {
          role
          username
        }
        validation {
            status
        }
        profile {
            about_me
            birthdate
            full_name
            sex
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
          email
          mobile_phone
          phone
        }
        affiliation
        discount
    }
}`);

var providersSearch = graph(`query ($q: String, $status: String) {
    providers__search(q: $q, status: $status) {
        __v
        _id
        uid
        code
        created_at
        status
        updated_at
        profile {
            full_name
            company_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            mobile_phone
            email
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        type
    }
}`);

var providersGetAll__singleList = graph(`query ($q: String, $status: String, $limit: Int, $after: String, $before: String) {
    providers__getAll(q: $q, status: $status, limit: $limit, after: $after, before: $before) {
        __v
        _id
        uid
        code
        created_at
        status
        updated_at
        profile {
            full_name
            company_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            mobile_phone
            email
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        type
    }
}`);

var providersGetById = graph(`query ($_id: String!) {
    providers__getById (_id: $_id) {
        __v
        _id
        created_at
        status
        uid
        code
        type
        updated_at
        profile {
            full_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            email
            mobile_phone
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
    }
}`);

var providersGetAll = graph(`query ($profile__full_name: String) {
    providers__getAll(profile__full_name: $profile__full_name) {
        __v
        _id
        uid
        code
        created_at
        status
        updated_at
        profile {
            full_name
            company_name
            docs {
                cpf
                rg
                cnpj
            }
        }
        contact {
            mobile_phone
            email
        }
        address {
            seq
            street
            city
            complement
            district
            number
            postal_code
            state
            default
            maps_embed_url
        }
        type
    }
}`);

var providersDelete = graph(`mutation ($_id: String!) {
    providers__delete(_id: $_id) {
        deleted
    }
}`);




/**
 * USERS
 */
var usersCreate = graph(`mutation ($role: String!, $full_name: String!, $email: String!, $username: String!, $password: String!) {
    users__create(role: $role, full_name: $full_name, email: $email, username: $username, password: $password) {
        __v
        _id
        uid
        code
        created_at
        status
        updated_at
        profile {
            full_name
        }
        contact {
            email
        }
        access {
            username
            role
        }
        validation {
            status
        }
    }
}`);

var usersUpdate = graph(`mutation ($_id: String!, $role: String!, $full_name: String!, $email: String!, $status: String!) {
    users__update(_id: $_id, role: $role, full_name: $full_name, email: $email, status: $status) {
        __v
        _id
        uid
        code
        created_at
        status
        updated_at
        profile {
            full_name
        }
        contact {
            email
        }
        access {
            username
            role
        }
        validation {
            status
        }
    }
}`);

var usersGetById = graph(`query ($_id: String!) {
    users__getById (_id: $_id) {
        __v
        _id
        uid
        code
        created_at
        status
        updated_at
        profile {
            full_name
        }
        contact {
            email
        }
        access {
            username
            role
        }
        validation {
            status
        }
    }
}`);

var usersGetAll = graph(`query ($q: String, $status: String) {
    users__getAll(q: $q, status: $status) {
        __v
        _id
        uid
        code
        created_at
        status
        updated_at
        profile {
            full_name
        }
        contact {
            email
        }
        access {
            username
            role
        }
        validation {
            status
        }
    }
}`);

var usersDelete = graph(`mutation ($_id: String!) {
    users__delete(_id: $_id) {
        deleted
    }
}`);



/**
 * Users plan
 */
var accountsUpdatePlan = graph(`mutation ($_id: String!, $plan: Int!, $active_until: String, $status: String) {
    accounts__updatePlan(_id: $_id, plan: $plan, active_until: $active_until, status: $status) {
        success
    }
}`);



/**
 * Points
 */
var pointsGetAll = graph(`query ($username: String, $subtype: [String], $reason: String, $date_of: String, $date_until: String) {
    points__getAll (username: $username, subtype: $subtype, reason: $reason, date_of: $date_of, date_until: $date_until) {
        __v
        _id
        created_at
        history
        origin {
            _id
            username
            level
        }
        plan__id
        reason
        type
        subtype
        updated_at
        username
        value
        doc__people {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
            }
        }
        doc__invoices {
            username
            amount
            code
            purchase_details {
                subsidize_amount
            }
        }
    }
}`);

var pointsGetBalance = graph(`query ($username: String, $subtype: [String]!, $reason: String, $date_of: String!, $date_until: String!) {
    points__getBalance(username: $username, subtype: $subtype, reason: $reason, date_of: $date_of, date_until: $date_until) {
        value
    }
}`);



/**
 * INVOICES
 */
var invoicesGetBalance = graph(`query {
    invoices__getBalance {
        total {
            waiting {
                count
                value
            }
            paid {
                count
                value
            }
            settled {
                count
                value
            }
            canceled {
                count
                value
            }
        }
        month {
            waiting {
                count
                value
            }
            paid {
                count
                value
            }
            settled {
                count
                value
            }
            canceled {
                count
                value
            }
        }
        count {
            month
            total
        }
    }
}`);

var invoicesGetAll = graph(`query ($code: Int, $username: String, $type: String, $date_until: String, $date_of: String, $status: String, $limit: Int, $after: String, $order: String, $before: String) {
    invoices__getAll(code: $code, username: $username, type: $type, date_until: $date_until, date_of: $date_of, status: $status, limit: $limit, after: $after, order: $order, before: $before) {
        __seq
        __v
        _id
        code
        type
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        purchase_details {
            discount_amount
            gross_amount
            items_count
            net_amount
            subsidize_amount
            items {
                id
                code
                description
                price_amount
                quantity
                shipping_cost
                punctuation {
                    indication {
                        points
                        qualification
                    }
                    matriz {
                        points
                        qualification
                    }
                }
            }
        }
        shipping {
            cost
            tracking_code
            type
            address {
                city
                complement
                country
                district
                number
                postal_code
                state
                street
            }
            withdrawal {
                date
                local_account_id
                notes
            }
            status
        }
        transaction {
            code
            payment_date
            payment_provider
            voucher {
                value
                date
            }
            parts {
                provider
                value
                date
            }
            to_receive
        }
        categorization
    }
}`);

var invoicesGetAll__singleList = graph(`query ($code: Int, $username: String, $type: String, $date_until: String, $date_of: String, $status: String, $limit: Int, $after: String, $order: String, $before: String) {
    invoices__getAll(code: $code, username: $username, type: $type, date_until: $date_until, date_of: $date_of, status: $status, limit: $limit, after: $after, order: $order, before: $before) {
        __seq
        __v
        _id
        code
        type
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        purchase_details {
            items_count
        }
        shipping {
            cost
            tracking_code
            type
            withdrawal {
                date
                local_account_id
                notes
            }
            status
        }
        transaction {
            code
            payment_date
            payment_provider
            voucher {
                value
                date
            }
            parts {
                provider
                value
                date
            }
            to_receive
        }
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
            }
        }
        categorization
    }
}`);

var invoicesGetById = graph(`query ($_id: String!) {
    invoices__getById(_id: $_id) {
        __seq
        __v
        _id
        code
        type
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        purchase_details {
            discount_amount
            gross_amount
            items_count
            net_amount
            subsidize_amount
            items {
                id
                code
                description
                price_amount
                quantity
                shipping_cost
                punctuation {
                    indication {
                        points
                        qualification
                    }
                    matriz {
                        points
                        qualification
                    }
                }
            }
        }
        transaction {
            code
            payment_date
            payment_provider
            voucher {
                value
                date
            }
            parts {
                provider
                value
                date
            }
            to_receive
        }
        shipping {
            cost
            tracking_code
            type
            address {
                city
                complement
                country
                district
                number
                postal_code
                state
                street
            }
            withdrawal {
                date
                local_account_id
                notes
            }
            status
        }
        categorization
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
            address {
                street
                city
                complement
                district
                number
                postal_code
                state
            }
        }
        doc__shipping_withdrawal_local__account {
            access {
                username
            }
            profile {
                full_name
            }
            contact {
                email
                mobile_phone
            }
            address {
                street
                city
                complement
                district
                number
                postal_code
                state
            }
        }
    }
}`);


var invoicesGetFullById = graph(`query ($_id: String!) {
    invoices__getById(_id: $_id) {
        __seq
        __v
        _id
        code
        type
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        purchase_details {
            discount_amount
            gross_amount
            items_count
            net_amount
            subsidize_amount
            items {
                id
                code
                description
                price_amount
                quantity
                shipping_cost
                punctuation {
                    indication {
                        points
                        qualification
                    }
                    matriz {
                        points
                        qualification
                    }
                }
            }
        }
        transaction {
            code
            payment_date
            payment_provider
            voucher {
                value
                date
            }
            parts {
                provider
                value
                date
            }
            to_receive
        }
        shipping {
            cost
            tracking_code
            type
            address {
                city
                complement
                country
                district
                number
                postal_code
                state
                street
            }
            withdrawal {
                date
                local_account_id
                notes
            }
            status
        }
        categorization
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
            address {
                street
                city
                complement
                district
                number
                postal_code
                state
            }
        }
        doc__shipping_withdrawal_local__account {
            access {
                username
            }
            profile {
                full_name
            }
            contact {
                email
                mobile_phone
            }
            address {
                street
                city
                complement
                district
                number
                postal_code
                state
            }
        }
    }
}`);


/* var invoiceGetByCode = graph(`query ($code: String!) {
    invoices__getByCode(code: $code) {
        __seq
        __v
        _id
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        type
        updated_at
        username
    }
}`); */

var invoicesCancel = graph(`mutation ($_id: String!) {
    invoices__cancel(_id: $_id) {
        canceled
    }
}`);

var invoicesSetSettled = graph(`mutation ($_id: String!) {
    invoices__setSettled(_id: $_id) {
        success
    }
}`);

var invoicesSetWithdrawalLocal = graph(`mutation ($_id: String!, $local_account_id: String!) {
    invoices__setWithdrawalLocal(_id: $_id, local_account_id: $local_account_id) {
        success
    }
}`);

/* var invoicesCancel = graph(`mutation ($_id: String!) {
    invoices__cancel(_id: $_id) {
        canceled
    }
}`); */

var invoicesDecategorize = graph(`mutation ($_id: String!) {
    invoices__decategorize(_id: $_id) {
        success
    }
}`);

var invoicesCategorize = graph(`mutation ($_id: String!) {
    invoices__categorize(_id: $_id) {
        success
    }
}`);




/**
 * MY STORE
 */
var my_storeGetAll__singleList = graph(`query ($code: Int, $username: String, $type: String, $date_until: String, $date_of: String, $status: String, $limit: Int, $after: String, $order: String, $before: String) {
    my_store__getAll(code: $code, username: $username, type: $type, date_until: $date_until, date_of: $date_of, status: $status, limit: $limit, after: $after, order: $order, before: $before) {
        __seq
        __v
        _id
        code
        type
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        purchase_details {
            items_count
        }
        shipping {
            cost
            tracking_code
            type
            withdrawal {
                date
                local_account_id
                notes
            }
            status
        }
        transaction {
            code
            payment_date
            payment_provider
            voucher {
                value
                date
            }
            parts {
                provider
                value
                date
            }
            to_receive
        }
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                }
            }
            contact {
                mobile_phone
            }
            type
        }
        plan {
            current__seq
            registration__seq
            upgrade__seq
        }
        categorization
    }
}`);

var my_storeGetById = graph(`query ($_id: String!) {
    my_store__getById(_id: $_id) {
        __seq
        __v
        _id
        code
        type
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        purchase_details {
            discount_amount
            gross_amount
            items_count
            net_amount
            subsidize_amount
            items {
                id
                code
                description
                price_amount
                quantity
                shipping_cost
                punctuation {
                    indication {
                        points
                        qualification
                    }
                    matriz {
                        points
                        qualification
                    }
                }
            }
        }
        transaction {
            code
            payment_date
            payment_provider
            voucher {
                value
                date
            }
            parts {
                provider
                value
                date
            }
            to_receive
        }
        shipping {
            cost
            tracking_code
            type
            address {
                city
                complement
                country
                district
                number
                postal_code
                state
                street
            }
            withdrawal {
                date
                local_account_id
                notes
            }
            status
        }
        categorization
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                }
            }
            contact {
                mobile_phone
            }
            type
        }
        plan {
            current__seq
            registration__seq
            upgrade__seq
        }
    }
}`);


var unilevelInvoicesGetAll__singleList = graph(`query ($code: Int, $username: String, $type: String, $date_until: String, $date_of: String, $status: String, $limit: Int, $after: String, $order: String, $before: String) {
    unilevel__invoicesGetAll(code: $code, username: $username, type: $type, date_until: $date_until, date_of: $date_of, status: $status, limit: $limit, after: $after, order: $order, before: $before) {
        __seq
        __v
        _id
        code
        type
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        purchase_details {
            items_count
        }
        shipping {
            cost
            tracking_code
            type
            withdrawal {
                date
                local_account_id
                notes
            }
            status
        }
        transaction {
            code
            payment_date
            payment_provider
            voucher {
                value
                date
            }
            parts {
                provider
                value
                date
            }
            to_receive
        }
        categorization
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
            address {
                street
                city
                complement
                district
                number
                postal_code
                state
            }
        }
        doc__shipping_withdrawal_local__account {
            access {
                username
            }
            profile {
                full_name
            }
            contact {
                email
                mobile_phone
            }
            address {
                street
                city
                complement
                district
                number
                postal_code
                state
            }
        }
        plan {
            current__seq
            registration__seq
            upgrade__seq
        }
    }
}`);

var unilevelInvoicesGetById = graph(`query ($_id: String!) {
    unilevel__invoicesGetById(_id: $_id) {
        __seq
        __v
        _id
        code
        type
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        purchase_details {
            discount_amount
            gross_amount
            items_count
            net_amount
            subsidize_amount
            items {
                id
                code
                description
                price_amount
                quantity
                shipping_cost
                punctuation {
                    indication {
                        points
                        qualification
                    }
                    matriz {
                        points
                        qualification
                    }
                }
            }
        }
        transaction {
            code
            payment_date
            payment_provider
            voucher {
                value
                date
            }
            parts {
                provider
                value
                date
            }
            to_receive
        }
        shipping {
            cost
            tracking_code
            type
            address {
                city
                complement
                country
                district
                number
                postal_code
                state
                street
            }
            withdrawal {
                date
                local_account_id
                notes
            }
            status
        }
        categorization
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
            address {
                street
                city
                complement
                district
                number
                postal_code
                state
            }
        }
        doc__shipping_withdrawal_local__account {
            access {
                username
            }
            profile {
                full_name
            }
            contact {
                email
                mobile_phone
            }
            address {
                street
                city
                complement
                district
                number
                postal_code
                state
            }
        }
        plan {
            current__seq
            registration__seq
            upgrade__seq
        }
    }
}`);

var storeSetLocal = graph(`mutation ($local_account_id: String) {
    store__setLocal(local_account_id: $local_account_id) {
        success
    }
}`);



/**
 * LOGISTICS
 */
var logisticsGetAll = graph(`query ($code: Int, $username: String, $type: String, $date_until: String, $date_of: String, $status: String, $limit: Int, $after: String, $order: String, $before: String) {
    logistics__getAll(code: $code, username: $username, type: $type, date_until: $date_until, date_of: $date_of, status: $status, limit: $limit, after: $after, order: $order, before: $before) {
        __seq
        __v
        _id
        code
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        purchase_details {
            discount_amount
            gross_amount
            items_count
            net_amount
            subsidize_amount
            items {
                id
                code
                description
                price_amount
                quantity
                shipping_cost
                punctuation {
                    indication {
                        points
                        qualification
                    }
                    matriz {
                        points
                        qualification
                    }
                }
            }
        }
        shipping {
            cost
            tracking_code
            type
            address {
                city
                complement
                country
                district
                number
                postal_code
                state
                street
            }
            withdrawal {
                date
                local_account_id
                notes
            }
            status
        }
    }
}`);

var logisticsGetAll__singleList = graph(`query ($code: Int, $username: String, $type: String, $date_until: String, $date_of: String, $status: String, $limit: Int, $after: String, $order: String, $before: String) {
    logistics__getAll(code: $code, username: $username, type: $type, date_until: $date_until, date_of: $date_of, status: $status, limit: $limit, after: $after, order: $order, before: $before) {
        __seq
        __v
        _id
        code
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        shipping {
            cost
            type
            status
        }
        purchase_details {
            items_count
        }
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
            }
        }
    }
}`);

var logisticsGetById = graph(`query ($_id: String!) {
    logistics__getById(_id: $_id) {
        __seq
        __v
        _id
        code
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        purchase_details {
            discount_amount
            gross_amount
            items_count
            net_amount
            subsidize_amount
            items {
                id
                code
                description
                price_amount
                quantity
                shipping_cost
                punctuation {
                    indication {
                        points
                        qualification
                    }
                    matriz {
                        points
                        qualification
                    }
                }
            }
        }
        shipping {
            cost
            tracking_code
            type
            address {
                city
                complement
                country
                district
                number
                postal_code
                state
                street
            }
            withdrawal {
                date
                local_account_id
                notes
            }
            status
        }
    }
}`);

var logisticsGetFullById = graph(`query ($_id: String!) {
    logistics__getById(_id: $_id) {
        __seq
        __v
        _id
        code
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        updated_at
        username
        purchase_details {
            discount_amount
            gross_amount
            items_count
            net_amount
            subsidize_amount
            items {
                id
                code
                description
                price_amount
                quantity
                shipping_cost
                punctuation {
                    indication {
                        points
                        qualification
                    }
                    matriz {
                        points
                        qualification
                    }
                }
            }
        }
        shipping {
            cost
            tracking_code
            type
            address {
                city
                complement
                country
                district
                number
                postal_code
                state
                street
            }
            withdrawal {
                date
                local_account_id
                notes
            }
            status
        },
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
            address {
                street
                city
                complement
                district
                number
                postal_code
                state
                default
                maps_embed_url
            }
        }
    }
}`);


/* var invoiceGetByCode = graph(`query ($code: String!) {
    logistics__getByCode(code: $code) {
        __seq
        __v
        _id
        amount
        created_at
        currency
        due_date
        seller_account_id
        status
        type
        updated_at
        username
    }
}`); */

var logisticsCancel = graph(`mutation ($_id: String!) {
    logistics__cancel(_id: $_id) {
        canceled
    }
}`);

var logisticsSetSettled = graph(`mutation ($_id: String!) {
    logistics__setSettled(_id: $_id) {
        success
    }
}`);

/* var logisticsCancel = graph(`mutation ($_id: String!) {
    logistics__cancel(_id: $_id) {
        canceled
    }
}`); */



/**
 * VOUCHER
 */
var voucherGetAll = graph(`query ($username: String, $type: String, $date_until: String, $date_of: String, $limit: Int, $after: String, $before: String, $order: String) {
    voucher__getAll(username: $username, type: $type, date_until: $date_until, date_of: $date_of, limit: $limit, after: $after, before: $before, order: $order) {
        _id
        __v
        type
        username
        amount
        currency
        date
        origin {
            _id
            username
            level
        }
        history
        utilization {
            _id
            date
        }
        created_at
        updated_at
        status
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
        }
    }
}`);

var voucherGetAll__singleList = graph(`query ($username: String, $type: String, $date_until: String, $date_of: String, $limit: Int, $after: String, $before: String, $order: String) {
    voucher__getAll(username: $username, type: $type, date_until: $date_until, date_of: $date_of, limit: $limit, after: $after, before: $before, order: $order) {
        _id
        __v
        type
        username
        amount
        currency
        date
        origin {
            _id
            username
            level
        }
        history
        utilization {
            _id
            date
        }
        created_at
        updated_at
        status
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
        }
    }
}`);

var voucherGetById = graph(`query ($_id: String!) {
    voucher__getById(_id: $_id) {
        _id
        __v
        type
        username
        amount
        currency
        date
        origin {
            _id
            username
            level
        }
        history
        utilization {
            _id
            date
        }
        created_at
        updated_at
        status
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
        }
    }
}`);



/**
 * WALLET
 */
var walletGetBalance = graph(`query ($username: String) {
    wallet__getBalance(username: $username) {
        blocked
        available
        credit {
            month
            total
        }
        debit {
            month
            total
        }
        voucher {
            available
            blocked
        }
    }
}`);

var walletGetAll = graph(`query ($username: String, $type: String, $subtype: String, $reason__code: String, $date_until: String, $date_of: String, $release_status__pending: Boolean, $limit: Int, $after: String, $before: String, $order: String) {
    wallet__getAll(username: $username, type: $type, subtype: $subtype, reason__code: $reason__code, date_until: $date_until, date_of: $date_of, release_status__pending: $release_status__pending, limit: $limit, after: $after, before: $before, order: $order) {
        __v
        _id
        created_at
        currency
        date
        history
        subtype
        reason__code
        type
        updated_at
        username
        amount
        transfer {
            from {
                username
            }
            to {
                username
            }
        }
        withdrawal {
            bank {
                holder {
                    doc
                    name
                }
            }
            pix {
                key
                institution
                holder {
                    doc
                    name
                }
            }
            effective_date
            authentication
        }
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
        }
        origin {
            _id
            level
            username
        }
        status
    }
}`);

var walletGetAll__singleList = graph(`query ($username: String, $type: String, $subtype: String, $reason__code: String, $date_until: String, $date_of: String, $release_status__pending: Boolean, $limit: Int, $after: String, $before: String, $order: String) {
    wallet__getAll(username: $username, type: $type, subtype: $subtype, reason__code: $reason__code, date_until: $date_until, date_of: $date_of, release_status__pending: $release_status__pending, limit: $limit, after: $after, before: $before, order: $order) {
        __v
        _id
        created_at
        currency
        date
        history
        subtype
        reason__code
        type
        updated_at
        username
        amount
        transfer {
            from {
                username
            }
            to {
                username
            }
        }
        withdrawal {
            bank {
                holder {
                    doc
                    name
                }
            }
            pix {
                key
                institution
                holder {
                    doc
                    name
                }
            }
            effective_date
            authentication
        }
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
        }
        origin {
            _id
            level
            username
        }
        status
    }
}`);

var walletGetById = graph(`query ($_id: String!) {
    wallet__getById(_id: $_id) {
        __v
        _id
        created_at
        currency
        date
        history
        subtype
        reason__code
        type
        updated_at
        username
        amount
        transfer {
            from {
                username
            }
            to {
                username
            }
        }
        withdrawal {
            bank {
                bank_number
                bank_name
                agency_number
                agency_digit
                account_number
                account_digit
                operation
                account_type
                holder {
                    name
                    doc
                }
            }
            pix {
                key
                institution
                holder {
                    doc
                    name
                }
            }
            effective_date
            authentication
        }
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
        }
        status
    }
}`);

var walletGetFullById = graph(`query ($_id: String!) {
    wallet__getById(_id: $_id) {
        __v
        _id
        created_at
        currency
        date
        history
        subtype
        reason__code
        type
        updated_at
        username
        amount
        transfer {
            from {
                username
            }
            to {
                username
            }
        }
        withdrawal {
            bank {
                bank_number
                bank_name
                agency_number
                agency_digit
                account_number
                account_digit
                operation
                account_type
                holder {
                    name
                    doc
                }
            }
            pix {
                key
                institution
                holder {
                    doc
                    name
                }
            }
            effective_date
            authentication
        }
        doc__account {
            access {
                username
            }
            validation {
                status
            }
            profile {
                full_name
                docs {
                    cpf
                    rg
                    cnpj
                }
            }
            contact {
                email
                mobile_phone
            }
        }
        status
    }
}`);

var walletGetChart = graph(`query ($username: String, $type: String, $subtype: String, $date_of: String!, $date_until: String!) {
    wallet__getChart(username: $username, type: $type, subtype: $subtype, date_of: $date_of, date_until: $date_until) {
        _id
        value
    }
}`);


var walletTransfer = graph(`mutation ($to_username: String!, $amount: Int!) {
    wallet__transfer(to_username: $to_username, amount: $amount) {
        __v
        _id
        created_at
        currency
        date
        history
        subtype
        reason__code
        type
        updated_at
        username
        amount
        transfer {
            from {
                username
            }
            to {
                username
            }
        }
        withdrawal {
            bank {
                holder {
                    doc
                    name
                }
            }
            pix {
                key
                institution
                holder {
                    doc
                    name
                }
            }
            effective_date
            authentication
        }
        status
    }
}`);

var walletWithdrawalRequest = graph(`mutation ($bank_number: String, $bank_name: String, $agency_number: String, $agency_digit: String, $account_number: String, $account_digit: String, $operation: String, $account_type: String, $key: String, $instituition: String, $name: String!, $doc: String!, $amount: Int!) {
    wallet__withdrawalRequest(bank_number: $bank_number, bank_name: $bank_name, agency_number: $agency_number, agency_digit: $agency_digit, account_number: $account_number, account_digit: $account_digit, operation: $operation, account_type: $account_type, key: $key, instituition: $instituition, name: $name, doc: $doc, amount: $amount) {
        __v
        _id
        created_at
        currency
        date
        history
        subtype
        reason__code
        type
        updated_at
        username
        amount
        transfer {
            from {
                username
            }
            to {
                username
            }
        }
        withdrawal {
            bank {
                holder {
                    doc
                    name
                }
            }
            pix {
                key
                institution
                holder {
                    doc
                    name
                }
            }
            effective_date
            authentication
        }
        status
    }
}`);

var walletAddCredit = graph(`mutation ($username: String!, $amount: Int!, $history: String!, $is_voucher: Boolean) {
    wallet__addCredit(username: $username, amount: $amount, history: $history, is_voucher: $is_voucher) {
        success
    }
}`);

var walletAddDebit = graph(`mutation ($username: String!, $amount: Int!, $history: String!, $is_voucher: Boolean) {
    wallet__addDebit(username: $username, amount: $amount, history: $history, is_voucher: $is_voucher) {
        success
    }
}`);

var walletWithdrawalConfirm = graph(`mutation ($_id: String!, $effective_date: String!, $authentication: String!) {
    wallet__withdrawalConfirm(_id: $_id, effective_date: $effective_date, authentication: $authentication) {
        success
    }
}`);

var walletWithdrawalCancel = graph(`mutation ($_id: String!) {
    wallet__withdrawalCancel(_id: $_id) {
        success
    }
}`);



var walletCancelWithdrawal = graph(`mutation ($_id: String!) {
    wallet__cancelWithdrawal(_id: $_id) {
        canceled
    }
}`);

var walletConfirmWithdrawal = graph(`mutation ($_id: String!) {
    wallet__confirmWithdrawal(_id: $_id) {
        success
    }
}`);





/**
 * BUDGETS
 */
var budgetsGetAll__singleList = graph(`query ($code: Int, $date_until: String, $date_of: String, $status: String, $limit: Int, $after: String, $before: String) {
    budgets__getAll(code: $code, date_until: $date_until, date_of: $date_of, status: $status, limit: $limit, after: $after, before: $before) {
        __seq
        __v
        _id
        additional_information
        brand
        code
        contact_phone
        created_at
        defect
        defect_other
        device
        email
        full_name
        locality
        model
        other_brand
        services
        services_other
        status
        updated_at
    }
}`);

var budgetsGetFullById = graph(`query ($_id: String!) {
    budgets__getById(_id: $_id) {
        __seq
        __v
        _id
        additional_information
        brand
        code
        contact_phone
        created_at
        defect
        defect_other
        device
        email
        full_name
        locality
        model
        other_brand
        services
        services_other
        status
        updated_at
    }
}`);


/**
 * SETTINGS
 */
var settingsGetData = graph(`query {
    settings__getData {
        _id
        __v
        app_modules
        company {
            name
            address
            contact {
                phone
                phone_mobile
                email
            }
            social {
                facebook
                twitter
                youtube
                instagram
            },
            legal {
                name
                cnpj
            }
            copyright_year
            copyright
        }
        site {
            name
            url
        }
        office {
            name
            url
            user_root
            register {
                url
                duplicity {
                    cpf
                    cnpj
                    email
                    mobile_phone
                }
                force_address_fill
                use_account_validation
            }
            login {
                url
            }
        }
        store {
            name
            url
            default_postal_code
            register {
                url
            }
            login {
                url
            }
            purchase {
                min_value
                pre_shipping
            }
            discount {
                franchise
                distribution_center
                simple_customer
                marketing_customer
                selling_point
            }
            invoices {
                mirror {
                    print {
                        quantity_pos
                    }
                }
                lifespan {
                    value
                    type
                }
            }
            payment {
                intermediaries {
                    gerencianet {
                        client_id
                        client_secret
                        enabled
                        mode
                    }
                    pagseguro {
                        email
                        mode
                        token
                        enabled
                    }
                    pagarme {
                        secret_key
                        public_key
                        mode
                        enabled
                    }
                    asaas {
                        api_key
                        enabled
                    }
                }
                voucher_credit_as
                message
            }
            default_local_account_id
        }
        payment {
            currency
        }
        commissioning {
            single_link
        }
        withdrawal {
            min_value
            max_value
            fee_fixed_value
            fee_percentage
            release_type
            enabled
            days
            days_of_week
            start_time
            end_time
        }
        wallet {
            transfer {
                user {
                    enabled
                }
                distribution_center {
                    enabled
                }
                franchise {
                    enabled
                }
                selling_point {
                    enabled
                }
            }
        }
        career_plan {
            period
            activation {
                value
            }
        }
        spaces {
            bucket
        }
        smtp {
            email_finalized_invoices
            email_sent_from
            email_contact_us
            email_unsubscribe
        }
    }
}`);

var settingsUpdate = graph(`mutation ($office__register__force_address_fill: Boolean, $office__register__use_account_validation: Boolean, $office__register__duplicity__cpf: Boolean, $office__register__duplicity__cnpj: Boolean, $office__register__duplicity__email: Boolean, $office__register__duplicity__mobile_phone: Boolean, $store__default_postal_code: String, $store__purchase__min_value: Int, $store__purchase__pre_shipping: Boolean, $store__default_local_account_id: String, $store__payment__voucher_credit_as: String, $store__payment__intermediaries__pagseguro__email: String, $store__payment__intermediaries__pagseguro__token: String, $store__payment__intermediaries__pagseguro__mode: String, $store__payment__intermediaries__pagseguro__enabled: Boolean, $store__payment__intermediaries__gerencianet__client_id: String, $store__payment__intermediaries__gerencianet__client_secret: String, $store__payment__intermediaries__gerencianet__enabled: Boolean, $store__payment__intermediaries__gerencianet__mode: String, $store__payment__intermediaries__pagarme__secret_key: String, $store__payment__intermediaries__pagarme__public_key: String, $store__payment__intermediaries__pagarme__enabled: Boolean, $store__payment__intermediaries__pagarme__mode: String, $store__payment__intermediaries__asaas__api_key: String, $store__payment__intermediaries__asaas__enabled: Boolean, $store__payment__default_intermediate: String, $store__payment__message: String, $commissioning__single_link: Boolean, $withdrawal__min_value: Int, $withdrawal__max_value: Int, $withdrawal__fee_fixed_value: Int, $withdrawal__fee_percentage: Int, $withdrawal__release_type: String, $withdrawal__days: String, $withdrawal__days_of_week: String, $withdrawal__start_time: String, $withdrawal__end_time: String, $withdrawal__enabled: Boolean, $career_plan__period: String, $career_plan__activation__value: Int, $smtp__email_finalized_invoices: String, $smtp__email_sent_from: String, $smtp__email_contact_us: String, $smtp__email_unsubscribe: String, $store__invoices__lifespan__value: Int, $store__invoices__lifespan__type: String, $wallet__transfer__user__enabled: Boolean, $wallet__transfer__distribution_center__enabled: Boolean, $wallet__transfer__franchise__enabled: Boolean, $wallet__transfer__selling_point__enabled: Boolean) {
    settings__update(office__register__force_address_fill: $office__register__force_address_fill, office__register__use_account_validation: $office__register__use_account_validation, office__register__duplicity__cpf: $office__register__duplicity__cpf, office__register__duplicity__cnpj: $office__register__duplicity__cnpj, office__register__duplicity__email: $office__register__duplicity__email, office__register__duplicity__mobile_phone: $office__register__duplicity__mobile_phone, store__default_postal_code: $store__default_postal_code, store__purchase__min_value: $store__purchase__min_value, store__purchase__pre_shipping: $store__purchase__pre_shipping, store__default_local_account_id: $store__default_local_account_id, store__payment__voucher_credit_as: $store__payment__voucher_credit_as, store__payment__intermediaries__pagseguro__email: $store__payment__intermediaries__pagseguro__email, store__payment__intermediaries__pagseguro__token: $store__payment__intermediaries__pagseguro__token, store__payment__intermediaries__pagseguro__mode: $store__payment__intermediaries__pagseguro__mode, store__payment__intermediaries__pagseguro__enabled: $store__payment__intermediaries__pagseguro__enabled, store__payment__intermediaries__gerencianet__client_id: $store__payment__intermediaries__gerencianet__client_id, store__payment__intermediaries__gerencianet__client_secret: $store__payment__intermediaries__gerencianet__client_secret, store__payment__intermediaries__gerencianet__enabled: $store__payment__intermediaries__gerencianet__enabled, store__payment__intermediaries__gerencianet__mode: $store__payment__intermediaries__gerencianet__mode, store__payment__intermediaries__pagarme__secret_key: $store__payment__intermediaries__pagarme__secret_key, store__payment__intermediaries__pagarme__public_key: $store__payment__intermediaries__pagarme__public_key, store__payment__intermediaries__pagarme__enabled: $store__payment__intermediaries__pagarme__enabled, store__payment__intermediaries__pagarme__mode: $store__payment__intermediaries__pagarme__mode, store__payment__intermediaries__asaas__api_key: $store__payment__intermediaries__asaas__api_key, store__payment__intermediaries__asaas__enabled: $store__payment__intermediaries__asaas__enabled, store__payment__default_intermediate: $store__payment__default_intermediate, store__payment__message: $store__payment__message, commissioning__single_link: $commissioning__single_link, withdrawal__min_value: $withdrawal__min_value, withdrawal__max_value: $withdrawal__max_value, withdrawal__fee_fixed_value: $withdrawal__fee_fixed_value, withdrawal__fee_percentage: $withdrawal__fee_percentage, withdrawal__release_type: $withdrawal__release_type, withdrawal__days: $withdrawal__days, withdrawal__days_of_week: $withdrawal__days_of_week, withdrawal__start_time: $withdrawal__start_time, withdrawal__end_time: $withdrawal__end_time, withdrawal__enabled: $withdrawal__enabled, career_plan__period: $career_plan__period, career_plan__activation__value: $career_plan__activation__value, smtp__email_finalized_invoices: $smtp__email_finalized_invoices, smtp__email_sent_from: $smtp__email_sent_from, smtp__email_contact_us: $smtp__email_contact_us, smtp__email_unsubscribe: $smtp__email_unsubscribe, store__invoices__lifespan__value: $store__invoices__lifespan__value, store__invoices__lifespan__type: $store__invoices__lifespan__type, wallet__transfer__user__enabled: $wallet__transfer__user__enabled, wallet__transfer__distribution_center__enabled: $wallet__transfer__distribution_center__enabled, wallet__transfer__franchise__enabled: $wallet__transfer__franchise__enabled, wallet__transfer__selling_point__enabled: $wallet__transfer__selling_point__enabled) {
        _id
        __v
        app_modules
        company {
            name
            address
            contact {
                phone
                phone_mobile
                email
            }
            social {
                facebook
                twitter
                youtube
                instagram
            },
            legal {
                name
                cnpj
            }
            copyright_year
            copyright
        }
        site {
            name
            url
        }
        office {
            name
            url
            user_root
            register {
                url
                duplicity {
                    cpf
                    cnpj
                    email
                    mobile_phone
                }
                force_address_fill
                use_account_validation
            }
            login {
                url
            }
        }
        store {
            name
            url
            default_postal_code
            register {
                url
            }
            login {
                url
            }
            purchase {
                min_value
                pre_shipping
            }
            discount {
                franchise
                distribution_center
                simple_customer
                marketing_customer
                selling_point
            }
            invoices {
                mirror {
                    print {
                        quantity_pos
                    }
                }
                lifespan {
                    value
                    type
                }
            }
            default_local_account_id
            payment {
                intermediaries {
                    gerencianet {
                        client_id
                        client_secret
                        enabled
                        mode
                    }
                    pagseguro {
                        email
                        mode
                        token
                        enabled
                    }
                    pagarme {
                        secret_key
                        public_key
                        mode
                        enabled
                    }
                    asaas {
                        api_key
                        enabled
                    }
                }
                voucher_credit_as
                message
            }
        }
        payment {
            currency
        }
        commissioning {
            single_link
        }
        withdrawal {
            min_value
            max_value
            fee_fixed_value
            fee_percentage
            release_type
            enabled
            days
            days_of_week
            start_time
            end_time
        }
        wallet {
            transfer {
                user {
                    enabled
                }
                distribution_center {
                    enabled
                }
                franchise {
                    enabled
                }
                selling_point {
                    enabled
                }
            }
        }
        career_plan {
            period
            activation {
                value
            }
        }
        spaces {
            bucket
        }
        smtp {
            email_finalized_invoices
            email_sent_from
            email_contact_us
            email_unsubscribe
        }
    }
}`);


/**
 * SYSTEM EMAILS
 */
var system_emailsGetByObject = graph(`query ($object: String!) {
    system_emails__getByObject(object: $object) {
        _id
        __v
        object
        name
        subject
        keywords
        content
        created_at
        updated_at
        enabled
    }
}`);

var system_emailsUpdate = graph(`mutation ($object: String!, $subject: String!, $content: String!, $enabled: Boolean!) {
    system_emails__update(object: $object, subject: $subject, content: $content, enabled: $enabled) {
        _id
        __v
        object
        name
        subject
        keywords
        content
        created_at
        updated_at
        enabled
    }
}`);



/*
account: accounts__getByUsername (username: $username) {
        __v
        _id
        created_at
        email
        last_access
        status
        uid
        updated_at
        username
        
    }
*/





/**
 * SPACES
 */
var spacesGenKey = graph(`mutation ($path: String!, $permission: Int!) {
    spaces__genKey(path: $path, permission: $permission) {
        key
    }
}`);










/*
function productsGetFromCode(product_code){
    xdrpub(
        'GET',
        '/store/products/'+product_code,
        null,
        function callback(data) {
            var response = JSON.parse(data);
            
            if ((isObjEmpty(response.error)) && (response.result)) {
                var result = response.result;
                console.log(result);
                
                document.getElementById('product_figure').style.backgroundImage = "url('"+_V1API+"/store/products/" + result.code + "/images/cover')";
                document.getElementById('product_image').src = _V1API+'/store/products/' + result.code + '/images/cover';
                document.getElementById('product_name').innerHTML = result.name;
                document.getElementById('product_code').innerHTML = '<strong>Cód.: ' + result.code + '</strong>';
                document.getElementById('product_description').innerHTML = result.description;
                document.getElementById('product_price').innerHTML = numberToRealSupHtml(result.price);
            } else {
                switch (data.error.code) {
                    case -32602:
                        View.showNotification('Ocorreu um erro inesperado ao requisitar informações. Tente atualizar.', 'danger');
                    break;
                }
            }
        },
        function errback(err){
            alert('Erro', 'Ocorreu um erro inesperado ao requisitar informações. Tente atualizar.');
        }
    );
}

function productsGetListing(){
    //var url  = window.location.href;
    var pathname = window.location.pathname;
    
    if (pathname == "/") {
        var endpoint = "/store/products?category=purchase";
        document.getElementById('view_title').innerHTML = 'Todos os produtos';
    } else if (pathname == "/nutraceuticos") {
        var endpoint = "/store/products?category=purchase&classification=nutraceutical";
        document.getElementById('view_title').innerHTML = 'Nutraceuticos';
    } else if (pathname == "/shakes") {
        var endpoint = "/store/products?category=purchase&classification=shake";
        document.getElementById('view_title').innerHTML = 'Shakes';
    } else if (pathname == "/suplementos") {
        var endpoint = "/store/products?category=purchase&classification=supplements";
        document.getElementById('view_title').innerHTML = 'Suplementos';
    }
    
    xdrpub(
        'GET',
        endpoint,
        null,
        function callback(data) {
            var response = JSON.parse(data);
            
            if ((isObjEmpty(response.error)) && (response.result)) {
                
                document.getElementById('productsList').innerHTML = '';
                
                var
                    arr = response.result,
                    _tbody1 = "",
                    count_view = 0,
                    view_info_count_items = 0;
                
                
                for (var i = 0; i < arr.length; i++){
                    var id = arr[i]._id,
                        code = arr[i].code,
                        name = arr[i].name,
                        //category = formatProductsCategory(arr[i].category),
                        price = arr[i].price,
                        price_html = numberToRealSupHtml(price),
                        enabled = arr[i].enabled; //formatProductsEnabled(arr[i].enabled); //formatAccountStatus(arr[i].enabled);
                    
                    if (arr[i].enabled == true) {
                        /*_tbody1 += '<div class="product-container-mx">'+
                                    '    <div class="product-container">'+
                                    '        <div class="product-image-container text-center">'+
                                    '            <a href="/produto/'+code+'" title="'+name+'">'+
                                    '                <img class="product-image-responsive" src="https://api.renovelife.com/services/v1/rest/store/products/'+code+'/images/cover" alt="'+name+'" title="'+name+'">'+
                                    '            </a>'+
                                    '        </div>'+
                                    '        <div class="product-details">'+
                                    '            <h5>'+
                                    '                <a href="/produto/'+code+'"  title="'+name+'">'+
                                    '                    <span style="margin-bottom: 14px; font-size: 15px;">'+name+'</span>'+
                                    '                </a>'+
                                    '            </h5>'+
                                    '            <div class="product-content-price">'+
                                                     price_html +
                                    '                <meta content="BRL">'+
                                    '            </div>'+
                                    '            <div class="product-button-container">'+
                                    '                <a id="btn-h_'+code+'" class="btn primary btn-block" href="javascript:;" onclick="productsAddItemsBtn(\'btn-h_'+code+'\', \''+code+'\');" rel="nofollow" title="Adicionar" data-id-product="8" style="margin-left: 20%; width: 60%;">'+
                                    '                    <span>Adicionar</span>'+
                                    '                </a>'+
                                    '            </div>'+
                                    '        </div>'+
                                    '    </div>'+
                                    '</div>';*/
/*                        _tbody1 += `
                            <section>
                                <a href="/produto/`+code+`" title="`+name+`">
                                    <img src="`+_V1API+`/store/products/`+code+`/images/cover" alt="`+name+`" title="`+name+`" />
                                </a>
                                <h2><a href="/produto/`+code+`" title="`+name+`">`+name+`</a></h2>
                                <!--<p>Description</p>-->
                                <aside>
                                    <ul>
                                        <li>`+price_html+`</li>
                                        <!--<li>Spec</li>-->
                                    </ul>
                                    <button onclick="productsAddItemsBtn('btn-h_`+code+`', '`+code+`');">Adicionar</button>
                                </aside>
                            </section>
                        `;
                        
                        view_info_count_items++;
                    }
                }
                
                var elViewInfo = document.getElementById('view_info');
                if (elViewInfo != null) {
                    if (view_info_count_items <= 0) {
                        elViewInfo.innerHTML = 'Nenhum produto encontrado';
                        _tbody1 = '<span class="no-product">Nenhum produto encontrado.</span>'
                    } else if (view_info_count_items == 1) {
                            elViewInfo.innerHTML = view_info_count_items + ' produto';
                        } else if (view_info_count_items > 1) {
                            elViewInfo.innerHTML = view_info_count_items + ' produtos';
                        }
                }
                
                document.getElementById('productsList').innerHTML = _tbody1;
                
            } else {
                switch (data.error.code) {
                    case -32602:
                        View.showNotification('Ocorreu um erro inesperado ao requisitar informações. Tente atualizar.', 'danger');
                    break;
                }
            }
        },
        function errback(err){
            alert('Erro', 'Ocorreu um erro inesperado ao requisitar informações. Tente atualizar.');
        }
    );
}

function productsAddItemsBtn(elId, code) {
    Controller.storeItemsAdd(code, 1);
}
*/


function commerce__formatAccountStatus(status) {
    switch(status){
        case "active":
            return '<span class="badge bg-green">Enabled</span>';
        break;
        case "under_verification":
            return '<span class="badge">Under verification</span>';
        break;
        case "suspended_by_admin":
            return '<span class="badge">Disabled&nbsp;<sup>adm</sup></span>';
        break;
        case "automatically_suspended":
            return '<span class="badge">Disabled&nbsp;<sup>auto</sup></span>';
        break;
    }
}

function commerce__formatAccountPlanStatus(plan__mode, network__active_until, network__status) {
    if (network__status != "receiving") {
        switch(network__status){
            case "waiting_for_plan":
                return '<span class="badge bg-yellow">Aguardando plano</span>';
            break;
            case "awaiting_invoice":
                return '<span class="badge bg-yellow">Aguardando pedido</span>';
            break;
            case "awaiting_payment":
                return '<span class="badge bg-yellow">Aguardando pgto</span>';
            break;
            /*case "receiving":
                return '<span class="badge bg-green">Recebendo</span>';
            break;*/
            case "suspended":
                return '<span class="badge">Suspendido</span>';
            break;
        }
    } else {
        if (plan__mode == "non-recurring") {
            return '<span class="badge bg-green">Ativo</span>';
        } else {
            var n1 = newActivationStatus2B(network__active_until);
            if (n1 != null) {
                if (n1[0] == false) {
                    return '<span class="badge">Inativo</span>';
                } else {
                    return '<span class="badge bg-green">Ativo</span>';
                }
            } else {
                return '<span class="badge">Indefinido</span>';
            }
        }
    }
}

function commerce__formatAccountRole(role) {
    switch(role){
        case "administrator":
            return '<span class="badge bg-blue">Adminsitrator</span>';
        break;
        case "attendant":
            return '<span class="badge bg-blue">Atendente</span>';
        break;
        case "financial":
            return '<span class="badge bg-blue">Financeiro</span>';
        break;
        case "support":
            return '<span class="badge bg-blue">Suporte</span>';
        break;
    }
}

function commerce__formatProductsClassification(classification) {
    switch(classification){
        case "00":
            return '00 - Mercadoria para Revenda';
        break;
        case "01":
            return '01 - Materia prima';
        break;
        case "02":
            return '02 - Embalagem';
        break;
        case "03":
            return '03 - Produto em processo';
        break;
        case "04":
            return '04 - Produto acabado';
        break;
        case "05":
            return '05 - Subproduto';
        break;
        case "06":
            return '06 - Produto intermediário';
        break;
        case "07":
            return '07 - Material de uso e consumo';
        break;
        case "08":
            return '08 - Ativo imobilizado';
        break;
        case "09":
            return '09 - Serviços';
        break;
        case "10":
            return '10 - Outros insumos';
        break;
        case "99":
            return '99 - Outras';
        break;
        default:
            return '*';
    }
}

function commerce__formatInventaryStatus(status) {
    switch(status){
        case "waiting":
            return '<span class="badge bg-yellow">Aguardando</span>';
        break;
        case "in_progress":
            return '<span class="badge bg-green">Em progresso</span>';
        break;
        case "finished":
            return '<span class="badge bg-green">Finalizado</span>';
        break;
        case "processed":
            return '<span class="badge bg-blue">Processado</span>';
        break;
        case "canceled":
            return '<span class="badge">Cancelado</span>';
        break;
    }
}

function commerce__formatAccountFormatDoc(data) {
    if (data.type == "natural_person") {
        return Inputmask.format(data.profile.docs.cpf, { mask: "999.999.999-99" });
    } else if (data.type == "legal_person") {
        return Inputmask.format(data.profile.docs.cnpj, { mask: "99.999.999/9999-99" });
    } else if (data.type == "foreign") {
        return "Extrangeiro";
    } else {
        return "Não informado";
    }
}

function commerce__formatInvoicesStatus(status){
    switch(status){
        case 'waiting':
            //return 'Aguardando';
            return '<span class="badge bg-yellow">Pendente</span>';
        break;
        case 'paid':
            return '<span class="badge bg-green">Pago</span>';
        break;
        case 'settled':
            return '<span class="badge bg-green">Marcado como pago</span>';
        break;
        case 'unpaid':
            return '<span class="badge">Não pago</span>';
        break;
        case 'refunded':
            return '<span class="badge">Devolvido</span>';
        break;
        case 'canceled':
            return '<span class="badge bg-red">Cancelado</span>';
        break;
        case 'partially_paid':
            return '<span class="badge bg-yellow">Pago parcialmente</span>';
        break;
        default:
            return '<span class="badge">Indefinido</span>';
    }
}

function commerce__formatLogisticsShippingType(status){
    switch(status){
        case 'presential':
            return '<span class="badge bg-blue">Presencial</span>';
        break;
        case 'delivery':
            return '<span class="badge bg-blue">Delivery</span>';
        break;
        case 'pac':
            return '<span class="badge bg-blue">PAC</span>';
        break;
        case 'sedex':
            return '<span class="badge bg-blue">SEDEX</span>';
        break;
        case 'others':
            return '<span class="badge bg-blue">Outros</span>';
        break;
        default:
            return '<span class="badge">Indefinido</span>';
    }
}

function commerce__formatLogisticsShippingStatus(status){
    switch(status){
        case 'waiting':
            return '<span class="badge bg-yellow">Pendente</span>';
        break;
        case 'in_dispatch':
            return '<span class="badge bg-red">Em despache</span>';
        break;
        case 'dispatched':
            return '<span class="badge bg-red">Despachado</span>';
        break;
        case 'delivered':
            return '<span class="badge bg-green">Pedido entregue</span>';
        break;
        case 'canceled':
            return '<span class="badge bg-red">Cancelado</span>';
        break;
        default:
            return '<span class="badge">Indefinido</span>';
    }
}

function commerce__formatInvoicesPayment_provider(payment_provider){
    switch(payment_provider){
        case 'wallet':
            return 'Saldo';
        break;
        case 'pagseguro':
            return 'PagSeguro';
        break;
        case 'gerencianet':
            return 'GerenciaNet';
        break;
        case 'mercadopago':
            return 'Mercado Pago';
        break;
        case 'picpay':
            return 'PicPay';
        break;
        case 'compound':
            return 'Saldo <sup>(Composto)</sup>';
        break;
        default:
            return 'Indefinido';
    }
}

function commerce__formatNetworkGraduationStatus(status){
    switch(status){
        case 'to_deliver':
            return '<span class="badge bg-yellow">A premiar</span>';
        break;
        case 'delivered':
            return '<span class="badge bg-green">Retirado</span>';
        break;
        default:
            return '<span class="badge">Indefinido</span>';
    }
}

function commerce__formatCommissioning_bonusCalculation_based(status){
    switch(status){
        case 'net_invoices_value':
            return '<span class="badge bg-green">Valor líquido</span>';
        break;
        case 'invoice_points':
            return '<span class="badge bg-green">Pontos</span>';
        break;
        default:
            return '<span class="badge">Indefinido</span>';
    }
}




/* Accounts *//**
function formatAccountStatus(status){
    switch(status){
        case true:
            return 'Habilitado';
        break;
        case false:
            return 'Desativado';
        break;
    }
}*/

/* Invoices *//**
function formatInvoicesStatus(status){
    switch(status){
        case 1:
            return 'Pendente';
        break;
        case 2:
        case 4:
        case 5:
            return 'Pago <sup>(a baixar)';
        break;
        case 3:
            return 'Pago';
        break;
        case 7:
            return 'Cancelado';
        break;
    }
}*/

/* Wallet */
function commerce__formatWalletType(type){
    switch(type){
        case "withdraw":
            return '<span class="badge bg-red">Withdraw</span>';
        break;
        case "tariff":
            return '<span class="badge bg-red">Tariff</span>';
        break;
        case "insertion":
            return '<span class="badge bg-green">Insertion</span>';
        break;
        case "purchase":
            return '<span class="badge bg-red">Purchase</span>';
        break;
        case "credit":
            return '<span class="badge bg-green">Credit</span>';
        break;
        case "debit":
            return '<span class="badge bg-red">Debit</span>';
        break;
        case "bonus":
            return '<span class="badge bg-green">Bonus</span>';
        break;
        case "profit":
            return '<span class="badge bg-green">Profit</span>';
        break;
        default:
            return '<span class="badge">Undefined</span>'
    }
}

function commerce__formatWalletSubtype(subtype){
    switch(subtype){
        case 'credit':
            return 'Credit';
        break;
        case 'debit':
            return 'Debit';
        break;
        case 'transfer':
            return 'Transfer';
        break;
        case 'chargeback':
            return 'CashBack';
        break;
        case 'purchase':
            return 'Purchase';
        break;
        case 'withdrawal':
            return 'Withdrawal';
        break;
        case 'tariff':
            return 'Tariff';
        break;
        case 'profit':
            return 'Profit';
        break;
        case 'bonus':
            return 'Bonus';
        break;
        default:
            return 'Undefined'
    }
}

function commerce__formatVoucherType(type){
    switch(type){
        case 'credit':
            return 'Credit';
        break;
        case 'debit':
            return 'Debit';
        break;
        default:
            return 'Undefined'
    }
}

function commerce__formatWalletStatus(status){
    switch(status){
        case 'pending':
            return '<span class="badge bg-yellow">Pending</span>';
        break;
        case 'blocked':
            return '<span class="badge bg-red">Blocked</span>';
        break;
        case 'effected':
            return '<span class="badge bg-green">Processed</span>';
        break;
        case 'canceled':
            return '<span class="badge bg-red">Canceled</span>';
        break;
        default:
            return '<span class="badge">Undefined</span>'
    }
}

function commerce__formatCommissioning_plansMode(mode){
    switch(mode){
        case 'non-recurring':
            return '<span class="badge">Não recorrente</span>';
        break;
        case 'monthly':
            return '<span class="badge bg-green">Mensal</span>';
        break;
        case 'yearly':
            return '<span class="badge bg-green">Anual</span>';
        break;
        case 'period':
            return '<span class="badge bg-green">Período</span>';
        break;
        default:
            return '<span class="badge">Indefinido</span>'
    }
}


var newActivationStatus2B = function(activeUntilDate) {
    var date_curr = new Date();
    date_curr.setHours(00, 00, 00);
    
    var date_end = new Date(activeUntilDate);
    date_end.setHours(23, 59, 59);
    var timeDiff = Math.abs(date_end.getTime() - date_curr.getTime());
    var diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));
    
    //console.log('1 :: '+(date_end > date_curr));
    //console.log('2 :: '+(diffDays > 30));
    
    if (date_end < date_curr) {
        return [false, diffDays]
    } else if (date_end >= date_curr) {
        return [true, diffDays]
    } else {
        return null
    }
}

var getInitials = function (string) {
    var names = string.split(' '),
        initials = names[0].substring(0, 1).toUpperCase();
    
    if (names.length > 1) {
        initials += names[names.length - 1].substring(0, 1).toUpperCase();
    }
    return initials;
};

/* Products */
/**
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
}*/
