<%@include file="../security_check.jsp" %>
<jsp:useBean id="obj"  class="bean.User" scope="session"/>  

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html class="not-ie" lang="en"> <!--<![endif]-->
    <head>
        <!-- Basic Meta Tags -->
        <meta charset="utf-8">
        <title>Sequoro</title>
        <meta name="description" content="your description">
        <meta name="keywords" content="your keywords">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="../css imports.jsp" %> 
    </head>    

    <body class="bg">

        <%@include file="../nav_siteowner.jsp" %> 
        <section id="demo">
            <div class="container">

                <div class="row spacer30"></div> 
                <div class="row">
                    <div class="row spacer20"></div> 

                </div>
                <div class="row">
                    <div class="row spacer40"></div>
                    <div class="col-md-12 text-center">
                        <h2 class="section-title">How Sequoro OAuth works ?</h2>         
                    </div>
                    <div class="row spacer20"></div>
                    <p>By giving Sequoro OAuth protection to your website you need not worry the security of users,we will take care of that.</p>
                    <div class="row spacer40"></div>
                    <div class="text-center"><img class="text-center" src="img/help/sequoro_basic.png"></div>
                    <div class="row spacer40"></div>
                    <p>Sequoro OAuth protection in detail</p>
                    <ul>
                        <li>Session Request<div>The Website server requests a state token from Sequoro Server using its Client Id and client Secret Key.Each request consists of a unique state so that Cross Site Request Forgery attacks can be prevented.Sequoro server replies with a valid session.</div></li>
                        <li>Request Generation<div>Each request consists of client Id, Redirect URL,TimeStamp, State and a nonce.The nonce is a HMacSha256 of the request URL.</div></li>
                        <li>Reuest Validation<div>The nonce and state ensures tamper proofing.</div></li>
                        <li>User Sign In<div>User provides his login details and OTP</div></li>
                        <li>Request Code Generation<div>If the user successfully logged in the Sequoro server provides a request token to the requested site.</div></li>
                        <li>Access Code Request<div>The request website requests for user Auth Code by sending the request code along with its client Id and Client Secret Key</div></li>
                        <li>User Authentication<div>By using the auth code the server could request an authentication request if the user is valid his email and name would be given as JSON Response </div></li>
                        <li>User registration or login<div>By using email,name and auth code the request website could register him as new user or log him in</div></li>
                    </ul>
                    <div class="row spacer150"></div>
                </div>
                
                <div class="row">
                    <div class="row spacer40"></div>
                    <div class="col-md-12 text-center">
                        <h2 class="section-title">How to add sequoro Oauth protection ?</h2>         
                    </div>
                </div>
                <div class="row">
                    <h3 class="text-left">Register Website</h3>
                    <div class="row spacer5"></div>
                    <p>Register the page you want to use Sequoro protection by providing the following details</p>
                    <ul>
                        <li>Website Name<div>The name you want your customers to view</div></li>
                        <li>Website URL<div>The URL of login page</div></li>
                        <li>Redirect URL<div>The URL of page you check authorization</div></li>
                        <li>Website LOGO</li>
                        <li>Website Description </li>
                    </ul>
                    <a onclick="$('#site_register').slideToggle('slow');">Show Image</a>
                    <div class="text-center"> <img id="site_register" style="display: none" src="img/help/site_register.png"></div>

                    <div class="row spacer50"></div>
                    <p>Upon successful registration you would be provided with  client ID and client secret Key save it for future use</p>

                    <a onclick="$('#client_details').slideToggle('slow');">Show Image</a>
                    <div class="text-center"> <img id="client_details" style="display: none" src="img/help/client_details.png"></div>


                </div>
                <div class="spacer30"></div>
                <div class="row">
                    <h3 class="text-left">Download necessary files</h3>
                    <div class="row spacer5"></div>
                    <p>We have provided you the necessary library files in Java.Other languages will be added soon.</p>
                    <ul>
                        <li><a href="api/files/jquery.js">jQuery</a></li>
                        <li><a href="api/files/jquery.popupWindow.js">jQuery Popup Plugin</a></li>
                        <li><a href="api/files/SequoroOAuth.js">Sequoro Plugin</a></li>
                        <li><a href="api/files/SequoroOAuth.java">Sequoro Java File</a></li>
                    </ul>
                    <p>Add the files to your login page </p>
                    <p>Generate Sign Using Sequoro Button set onclick function to sequoro() </p>
                    <p>&lt;button id="sequoro_btn" onclick=&apos;javascript:sequoro()&apos;&gt;Sequoro Sign in&lt;/button&gt;
                    </p>

                    <p>Add your client id and client secret to Java File</p>
                    <div class="spacer10"></div>
                    <p>Now you are good to go :)</p>
                    <div class="spacer150"></div>

                </div>
                
                
                
            </div></section>

        <%@include file="../footer.jsp" %> 

    </body>
</html>
