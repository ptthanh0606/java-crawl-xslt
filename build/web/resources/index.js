
window.onload = async () => {
    await initHome();
    window.scrollTo(0, 0);
};

// Event handlers --------------------------------------------------------------

async function handleSearchSubmit() {
    window.scrollTo(0, 0);

    let searchValue = document.querySelector('.search-input').value;
    let container = document.querySelector('.route-content');

    if (searchValue.trim()) {
        document.querySelector('.loading').classList.remove('loading-collapse');

        setTimeout(async () => {
            let serverResponse = await requestServer('SearchProductServlet', 'POST', searchValue);
            removeAllChildExceptFirst(container);
            document.querySelector('.heading-text').textContent = 'Base on your search...';
            document.querySelector('.search-name').textContent = searchValue;

            if (parseXMLResponseProducts(serverResponse)) {
                document.querySelector('.loading').textContent = '';
                document.querySelector('.loading').classList.add('loading-collapse');
                document.querySelector('.back-to-recommends-wrapper').classList.remove('hidden-back-button');
            } else {
                document.querySelector('.loading').textContent = 'Sorry, No Result found.';
            }
        }, 700);
    } else {
        document.querySelector('.input-message').classList.remove('hidden-text');
        document.querySelector('.search-input').classList.add('red-border');
        document.querySelector('.search-input').value = '';
        setTimeout(() => {
            document.querySelector('.input-message').classList.add('hidden-text');
            document.querySelector('.search-input').classList.remove('red-border');
        }, 5000)
    }
}

async function handleGetRecommendations() {
    window.scrollTo(0, 0);
    document.querySelector('.loading').classList.remove('loading-collapse');
    let response;

    let container = document.querySelector(".route-content");

    setTimeout(async () => {
        removeAllChildExceptFirst(container);

        document.querySelector('.heading-text').textContent = 'Hi, here are some recommendations';
        document.querySelector('.search-name').textContent = '';

        response = await requestServer('GetAllProductServlet', 'GET', null);
        if (parseXMLResponseProducts(response)) {
            document.querySelector('.loading').textContent = '';
            document.querySelector('.loading').classList.add('loading-collapse');
            document.querySelector('.back-to-recommends-wrapper').classList.add('hidden-back-button');
        } else {
            let loadingHeart = createEl('div', [
                {
                    name: 'class',
                    value: 'lds-heart'
                }
            ])
            let innerHeart = createEl('div');

            loadingHeart.appendChild(innerHeart);
            loadingWrapper.appendChild(document.createTextNode('Please be patient, requesting data...'));
            loadingWrapper.appendChild(loadingHeart);

            response = await requestServer('InitDataServlet', 'GET', null);
            if (parseXMLResponseProducts(response)) {
                loadingWrapper.textContent = '';
                loadingWrapper.classList.add('loading-collapse');
                document.querySelector('.back-to-recommends-wrapper').classList.add('hidden-back-button');
            }
        }

    }, 700);

}

let handleBackToTop = () => {
    window.scrollTo(0, 0);
}

// Home page functions ---------------------------------------------------------

let initHome = async () => {
    let response;

    let loadingWrapper = document.querySelector('.loading');

    response = await requestServer('GetAllProductServlet', 'GET', null);

    if (parseXMLResponseProducts(response)) {
        loadingWrapper.textContent = '';
        loadingWrapper.classList.add('loading-collapse');
        document.querySelector('.back-to-recommends-wrapper').classList.add('hidden-back-button');
    } else {
        let loadingHeart = createEl('div', [
            {
                name: 'class',
                value: 'lds-heart'
            }
        ])
        let innerHeart = createEl('div');

        loadingHeart.appendChild(innerHeart);
        loadingWrapper.appendChild(document.createTextNode('Please be patient, requesting data...'));
        loadingWrapper.appendChild(loadingHeart);

        response = await requestServer('InitDataServlet', 'GET', null);
        if (parseXMLResponseProducts(response)) {
            loadingWrapper.textContent = '';
            loadingWrapper.classList.add('loading-collapse');
            document.querySelector('.back-to-recommends-wrapper').classList.add('hidden-back-button');
        }
    }
}

let createProductStandard = ({productImgUrl, productName, productVendor, productPrice, productLink}) => {
    let priceNumber = (productPrice * 1).toLocaleString();

    let productWrapper = createEl("div", [
        {name: "class", value: "product-wrapper"},
    ]);

    let productImageLink = createEl("a");

    let productImageEl = createEl("img", [
        {name: "class", value: "product-image"},
        {name: "src", value: productImgUrl},
    ]);

    let productNameEl = createEl("a", [
        {name: "class", value: "product-name"},
    ], productName);

    productNameEl.addEventListener('click', () => {
        routeToComparePageHandler(productImgUrl, productName, productVendor, productPrice, productLink)
    });

    let vendorName = createEl("h4", [
        {name: "class", value: "vendor-name"}
    ], productVendor);

    let priceWrapper = createEl("div", [
        {name: "class", value: "price-wrapper"},
    ]);

    let priceLabel = createEl("p", [
        {name: "class", value: "price"}
    ], priceNumber);

    let unitLabel = createEl("span", [], "VND");

    productImageLink.appendChild(productImageEl);
    priceWrapper.appendChild(priceLabel);
    priceWrapper.appendChild(unitLabel);

    productWrapper.appendChild(productImageLink);
    productWrapper.appendChild(productNameEl);
    productWrapper.appendChild(vendorName);
    productWrapper.appendChild(priceWrapper);

    return productWrapper;
};

let parseXMLResponseProducts = (data) => {
    let container = document.querySelector(".route-content");

    if (!data.childNodes[0].childNodes.length) {
        return false;
    }

    data.childNodes[0].childNodes.forEach(productNode => {
        if (productNode.tagName === 'product') {
            let product = {};
            product.productId = productNode.querySelector('id').textContent;
            product.productName = productNode.querySelector('name').textContent;
            product.productImgUrl = productNode.querySelector('img-src').textContent;
            product.productVendor = productNode.querySelector('store-name').textContent;
            product.productPrice = productNode.querySelector('price').textContent;
            product.productLink = productNode.querySelector('link-url').textContent;

            container.appendChild(createProductStandard(product));
        }
    });
    return true;
}

let routeToComparePageHandler = async (productImgUrl, productName, productVendor, productPrice, productLink) => {
    let container = document.querySelector(".route-content");
    document.querySelector('.heading-text').textContent = 'Comparing...';
    window.scrollTo(0, 0);
    document.querySelector('.loading').classList.remove('loading-collapse');
    setTimeout(async () => {
        removeAllChildExceptFirst(container);

        let priceNumber = (productPrice * 1).toLocaleString();

        let response = await requestServer('CompareServlet', 'POST', `${productName}&${productVendor}`);
        let contentCol = createEl('div', [
            {name: 'class', value: 'content-col'}
        ])

        contentCol.innerHTML = `
        <div class="compare-wrapper">
            <div class="product-compare-wrapper">
                <img class="compare-img"
                    src="${productImgUrl}" alt="">
                <div class="price-vendors-wrapper">
                    <div class="compare-price-wrapper">
                        <span class="compare-price">${priceNumber}</span>
                        VND
                    </div>
                    <div class="vendors-wrapper">
                        from
                        <span class="compare-vendor-name">${productVendor}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="best-price-wrapper">
            Best price goes to...
            <h1 class="best-price-vendor"></h1>
        </div>

        <div class="product-link-wrapper">
            Here is your link to the product
            <a class="result-link" href=""></a>
        </div>

        <div class="similar-wrapper">
            <span class="more-similar-label">More similar products..</span>
            <div class="similar-product-wrapper">No others found!</div>
        </div>
    `;

        document.querySelector('.route-content').appendChild(contentCol);

        if (!parseXMLResponseProductCompare(response, {
            productImgUrl, productName, productVendor, productPrice, productLink
        })) {
            document.querySelector('.best-price-vendor').textContent = productVendor;
            document.querySelector('.result-link').textContent = productLink;
        }
        document.querySelector('.search-name').textContent = productName;
        document.querySelector('.back-to-recommends-wrapper').classList.remove('hidden-back-button');
        document.querySelector('.loading').classList.add('loading-collapse');
    }, 700);
}

// Compare page functions ------------------------------------------------------

let parseXMLResponseProductCompare = (data, selectedProduct) => {
    let compareWrapper = document.querySelector('.compare-wrapper');
    let similarProductWrapper = document.querySelector('.similar-product-wrapper');
    let isFirst = true;

    if (!data.childNodes[0].childNodes.length) {
        return false;
    }

    for (let i = 0; i < data.childNodes[0].childNodes.length; i++) {
        let productNode = data.childNodes[0].childNodes[i];
        if (productNode.tagName === 'product') {
            let product = {};

            product.productId = productNode.querySelector('id').textContent;
            product.productName = productNode.querySelector('name').textContent;
            product.productImgUrl = productNode.querySelector('img-src').textContent;
            product.productVendor = productNode.querySelector('store-name').textContent;
            product.productPrice = productNode.querySelector('price').textContent;
            product.productLink = productNode.querySelector('link-url').textContent;

            if (isFirst) { // First product result
                isFirst = false;
                compareWrapper.appendChild(createProductCompare(product));
                comparePrices(selectedProduct, product);
            } else { // Remaining products
                if (similarProductWrapper.textContent === 'No others found!') {
                    removeAllChild(similarProductWrapper);
                }
                similarProductWrapper.appendChild(createProductStandard(product));
            }
        }
    }

    return true;
}

let comparePrices = (product1, product2) => {
    let bestPriceVendorName = document.querySelector('.best-price-vendor');
    let bestPriceVendorLink = document.querySelector('.result-link');

    if (product1.productPrice * 1 > product2.productPrice * 1) {
        bestPriceVendorName.textContent = product2.productVendor;
        bestPriceVendorLink.textContent = product2.productLink;
        bestPriceVendorLink.href = product2.productLink;
    } else {
        bestPriceVendorName.textContent = product1.productVendor;
        bestPriceVendorLink.textContent = product1.productLink;
        bestPriceVendorLink.href = product1.productLink;
    }
}

let createProductCompare = ({productImgUrl, productVendor, productPrice}) => {
    let productCompare = createEl('div', [{
            name: 'class',
            value: 'product-compare-wrapper'
        }])

    let priceNumber = (productPrice * 1).toLocaleString();
    productCompare.innerHTML = `
        <img class="compare-img"
            src="${productImgUrl}" alt="">
        <div class="price-vendors-wrapper">
            <div class="compare-price-wrapper">
                <span class="compare-price">${priceNumber}</span>
                VND
            </div>
            <div class="vendors-wrapper">
                from
                <span class="compare-vendor-name">${productVendor}</span>
            </div>
        </div>
    `;

    return productCompare;
}

// Element utils ---------------------------------------------------------------

let createEl = (elName, elAttrList, elValue) => {
    let element = document.createElement(elName);
    if (elAttrList) {
        elAttrList.forEach((att) => {
            element.setAttribute(att.name, att.value);
        });
    }

    if (elValue) {
        element.appendChild(document.createTextNode(elValue));
    }

    return element;
};

let removeAllChild = (element) => {
    while (element.firstChild) {
        element.removeChild(element.firstChild);
    }
}

let removeAllChildExceptFirst = (element) => {
    let pos = element.childNodes.length;
    while (pos !== 2) {
        element.removeChild(element.childNodes[pos - 1]);
        pos--;
    }
}

// Server utils ----------------------------------------------------------------

let getXMLHttpObject = () => {
    let xmlHttp = null;

    try {
        xmlHttp = new XMLHttpRequest();
    } catch (error) {
        alert('XMLHTTPRequest is not supported by your browser!');
    }

    return xmlHttp;
};

let requestServer = (actionServletUrl, method, param) => {
    return new Promise((resolve) => {
        let xmlHttp = getXMLHttpObject();

        xmlHttp.open(method, actionServletUrl);
        xmlHttp.onreadystatechange = () => {
            if ((xmlHttp.readyState === 4) || (xmlHttp.status === 200)) {
                if (xmlHttp.responseXML) {
                    resolve(xmlHttp.responseXML);
                }
            }
        }
        xmlHttp.send(param);
    })
};



