<%-- 
    Document   : index
    Created on : Jul 12, 2020, 5:27:37 PM
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
    </head>

    <body>
        <div class="back-to-top-wrapper" onclick="handleBackToTop();">
            <svg version="1.1" id="back-to-top-button" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                 viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve">
            <path style="fill:#4CAF50;" d="M263.432,3.136c-4.16-4.171-10.914-4.179-15.085-0.019c-0.006,0.006-0.013,0.013-0.019,0.019
                  l-192,192c-4.093,4.237-3.975,10.99,0.262,15.083c4.134,3.992,10.687,3.992,14.82,0L245.213,36.416v464.917
                  c0,5.891,4.776,10.667,10.667,10.667c5.891,0,10.667-4.776,10.667-10.667V36.416l173.781,173.781
                  c4.093,4.237,10.845,4.355,15.083,0.262c4.237-4.093,4.354-10.845,0.262-15.083c-0.086-0.089-0.173-0.176-0.262-0.262L263.432,3.136
                  z"/>
            <path d="M447.88,213.333c-2.831,0.005-5.548-1.115-7.552-3.115L255.88,25.749L71.432,210.219c-4.237,4.093-10.99,3.975-15.083-0.262
                  c-3.992-4.134-3.992-10.687,0-14.82l192-192c4.165-4.164,10.917-4.164,15.083,0l192,192c4.159,4.172,4.149,10.926-0.024,15.085
                  C453.409,212.214,450.702,213.333,447.88,213.333z"/>
            <path d="M255.88,512c-5.891,0-10.667-4.776-10.667-10.667V10.667C245.213,4.776,249.989,0,255.88,0
                  c5.891,0,10.667,4.776,10.667,10.667v490.667C266.546,507.224,261.771,512,255.88,512z"/>
            </svg>
        </div>
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
                        <form id="search-form" onsubmit="handleSearchSubmit(); return false;" novalidate="true">
                            <input type="text" class="search-input" placeholder="Product name" required="true">
                            <button type="submit" class="search-button search-button-color">Discover</button>
                            <div class="search-button-color blur"></div>
                        </form>
                        <span class="input-message hidden-text">Please type something in the search box!</span>
                    </div>

                    <a class="show-recommend-button" onclick="handleGetRecommendations(); return false;">More recommendations</a>
                </div>
            </div>
            <div class="right-col">
                <div class="right-col-wrapper">
                    <div class="heading-wrapper">
                        <div class="back-to-recommends-wrapper hidden-back-button" onclick="handleGetRecommendations();">
                            <svg id="Chevron_Right" version="1.1" id="Capa_1" 
                                 xmlns="http://www.w3.org/2000/svg" 
                                 xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 240.823 240.823" style="enable-background:new 0 0 240.823 240.823;" xml:space="preserve">
                            <path d="M57.633,129.007L165.93,237.268c4.752,4.74,12.451,4.74,17.215,0c4.752-4.74,4.752-12.439,0-17.179
                                  l-99.707-99.671l99.695-99.671c4.752-4.74,4.752-12.439,0-17.191c-4.752-4.74-12.463-4.74-17.215,0L57.621,111.816
                                  C52.942,116.507,52.942,124.327,57.633,129.007z"/>
                            </svg>
                            <h4 class="back-to-recommends">Back to recommendations</h4>
                        </div>
                        <h4 class="heading-text">Hi, here are some recommendations</h4>
                    </div>
                    <h1 class="search-name"></h1>
                    <div class="container">
                        <div class="route-content">
                            <div class="loading"></div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <footer>
            <svg id="footer-cover" viewBox="0 0 1525 318" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M694.525 76.0901C272.777 59.0406 395.577 178.88 0 242V338H1535V8.61772C1224.48 -33.462 1116.27 93.1396 694.525 76.0901Z" fill="#F9F8EB"/>
            </svg>
        </footer>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/index.js"></script>
    </body>
</html>
