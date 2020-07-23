<%-- 
    Document   : comparePage
    Created on : Jul 13, 2020, 2:19:22 AM
    Author     : phant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>PRX101</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/index.css">
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/index.js"></script>
    </head>

    <body>
        <main>
            <div class="left-col">
                <svg id="liquid-cover" viewBox="0 0 451 644" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path
                    d="M0 644V0H451C395.923 126.741 496.387 229.696 331.155 339.041C206.567 421.49 342.586 580.452 0 644Z"
                    fill="#F9F8EB" />
                </svg>
                <div class="title-search-wrapper">
                    <div class="logo-wrapper">
                        <h1 class="logo">
                            <span class="p">P</span><span class="r">R</span><span class="x">X</span>101
                        </h1>
                        <span class="sub-title">Discover the best price</span>
                    </div>

                    <div class="search-wrapper">
                        <h4 class="search-label">What do you want to find?</h4>
                        <form action="#">
                            <input type="text" class="search-input" placeholder="Product name">
                            <button type="submit" class="search-button search-button-color">Discover</button>
                            <div class="search-button-color blur"></div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="right-col">
                <h4 class="heading-text">From <span class="number-of-vendors">2</span> vendor(s)!</h4>
                <h1 class="search-name">Morris Motley Matte Styling Balm</h1>
                <div class="container">
                    <div class="route-content">
                        <div class="content-col">
                            <div class="compare-wrapper">
                                <div class="product-compare-wrapper">
                                    <img class="compare-img" src="https://classic.vn/wp-content/uploads/2017/08/blumaan-cavalier-clay-1_1.jpg"
                                         alt="">
                                    <div class="price-vendors-wrapper">
                                        <div class="compare-price-wrapper">
                                            <span class="compare-price">990,000</span>
                                            VND
                                        </div>
                                        <div class="vendors-wrapper">
                                            from
                                            <span class="compare-vendor-name">Classic store</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="product-compare-wrapper">
                                    <img class="compare-img" src="https://classic.vn/wp-content/uploads/2017/08/blumaan-cavalier-clay-1_1.jpg"
                                         alt="">
                                    <div class="price-vendors-wrapper">
                                        <div class="compare-price-wrapper">
                                            <span class="compare-price">990,000</span>
                                            VND
                                        </div>
                                        <div class="vendors-wrapper">
                                            from
                                            <span class="compare-vendor-name">Classic store</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="best-price-wrapper">
                                Best price goes to...
                                <h1 class="best-price-vendor">
                                    CL Men Store
                                </h1>
                            </div>

                            <div class="product-link-wrapper">
                                Here is your link to the product
                                <a class="result-link" href="https://clmensstore.com/cua-hang/morris-motley-matte-styling-balm-2020/">
                                    https://clmensstore.com/cua-hang/morris-motley-matte-styling-balm-2020/
                                </a>
                            </div>

                            <div class="similar-wrapper">
                                More similar..
                                <div class="similar-product-wrapper">

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>

</html>
