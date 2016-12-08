<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.taglibs.standard.tag.common.core.Util"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="sequoroOAuth"  class="bean.SequoroOAuth" scope="page"/> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <!-- Set the viewport so this responsive site displays correctly on mobile devices -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Facebook</title>
        <base href="http://localhost:8080/facebook/" >
        <style type="text/css">
            #spinner{position:fixed;left:0;top:0;width:100%;height:100%;z-index:9999;background:url("css/images/395.gif") 50% 50% no-repeat #030303}#spinner #load{position:fixed;left:47%;top:63%;font-size:25px}
        </style>
        <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
        <!-- Include bootstrap CSS -->
        <!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" type='text/css'> -->
        <link href="css/bootstrap.min.css" rel="stylesheet" type='text/css'>
        <link href="css/style_exam.css" rel="stylesheet" type='text/css'>
        <link href="css/style_body_override.css" rel="stylesheet" type='text/css'>
        <link href="css/flexslider.css" rel="stylesheet" type='text/css'>
        <!--<script type="text/javascript">
            // function cssLoaded(href) {//alert(0);
            //     var cssFound = false;
            //     for (var i = 0; i < document.styleSheets.length; i++) {
            //         var sheet = document.styleSheets[i];
            //         //alert(sheet['href']);
            //         if(sheet[href]!=null)
            //         if (sheet['href'].indexOf(href) >= 0 && sheet['cssRules'].length > 0) {
            //             cssFound = true;
            //         }
            //     };
        
            //     return cssFound;
            // }
        
            // if (!cssLoaded('bootstrap.min.css')) {//-combined
            //     local_bootstrap = document.createElement('link');
            //     local_bootstrap.setAttribute("rel", "stylesheet");
            //     local_bootstrap.setAttribute("type", "text/css");
            //     local_bootstrap.setAttribute("href", "css/bootstrap.min.css" );
            //     document.getElementsByTagName("head")[0].appendChild(local_bootstrap);
            // }
         </script>-->

        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
        <script>
            if (!window.jQuery) {
                document.write('<script src="js/jquery-2.1.0.min.js"><\/script>');
            }
        </script>
        <script src="js/lazyload.min.js"></script>




        <!-- Preloader -->
        <script type="text/javascript">// <![CDATA[
            $(window).load(function () {
                $("#spinner").fadeOut("normal");
            })
                    // ]]></script>

    </head>

    <body>
        <div id="spinner"><div id="load">Loading...</div></div>

        <!-- <div class="alert   alert-danger  alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        Site is currently under testing if you find any bugs please report it to developer immediately  
         </div> -->
        <div class="header">
            <div class="container center-block">
                <div id="header_wrap" class="row center-block">

                    <img alt="logo image" src="css/images/Logow_copy.png" class="img-responsive center-block inline logo">
                    <!-- <h2 class="inline title">College of Engineering,Poonjar</h2> -->
                </div>
            </div>
        </div>

        <!-- <div id="feedback">
            <a href="http://www.123contactform.com/form-1130118/Report-Bugs" target="_blank" class="blueLink13">Report Bugs</a>
        </div> -->
        <nav id="jithu_nav" class="navbar navbar-default navbar-static-top navbar-inverse jithu_nav" role="navigation">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>


                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                    <ul class="nav navbar-nav">

                        <li class="active">
                            <a href="#">Home</a>                </li>
                        <li class="">
                            <a href="#">Instructions</a>                </li>
                        <li class="">
                            <a href="#">Downloads</a>                </li>

                        <li class="">
                            <a href="#">Contact Us</a>                </li>

                    </ul>


                </div>
                <!-- /.navbar-collapse -->

            </div>
        </nav>
        <div class="middle">
            <div class="container">
                <!-- <div class="row about">
                    
                </div> -->
                <div class="row about">
                    <div class="col-md-9">
                        <div class="home_steps well text-justify noborder">
                            <!-- slider -->
                            <div class="row slider ">
                                <div class="col-md-12">
                                    <div class="bs-example">
                                        <div id="carousel-example-captions" class="carousel slide " data-ride="carousel">
                                            <ol class="carousel-indicators">
                                                <li data-target="#carousel-example-captions" data-slide-to="0" class="active"></li>
                                                <li data-target="#carousel-example-captions" data-slide-to="1" class=""></li>
                                                <li data-target="#carousel-example-captions" data-slide-to="2" class=""></li>
                                                <li data-target="#carousel-example-captions" data-slide-to="3" class=""></li>
                                            </ol>
                                            <div class="carousel-inner">
                                                <div class="item active">
                                                    <img alt="slider image 1" src="css/images/slide/1.jpg" class="img-responsive center-block">
                                                    <div class="carousel-caption">
                                                        <h3>First slide label</h3>
                                                        <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <img alt="slider image 2" src="css/images/slide/2.jpg" class="img-responsive center-block">
                                                    <div class="carousel-caption">
                                                        <h3>Second slide label</h3>
                                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <img alt="slider image 3" src="css/images/slide/3.jpg" class="img-responsive center-block">
                                                    <div class="carousel-caption">
                                                        <h3>Second slide label</h3>
                                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                                    </div>
                                                </div>
                                                <div class="item">
                                                    <img  alt="slider image 4" src="css/images/slide/4.jpg" class="img-responsive center-block">
                                                    <div class="carousel-caption">
                                                        <h3>Third slide label</h3>
                                                        <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p>
                                                    </div>
                                                </div>
                                            </div>
                                            <a class="left carousel-control" href="#carousel-example-captions" data-slide="prev">
                                                <span class="glyphicon glyphicon-chevron-left"></span>
                                            </a>
                                            <a class="right carousel-control" href="#carousel-example-captions" data-slide="next">
                                                <span class="glyphicon glyphicon-chevron-right"></span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- slider -->

                            <br>
                            <br>


                            <p>CUSAT EXAM CELL</p>

                            <br>
                            <p>
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                                quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                                consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                                cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
                                proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>
                            <br>
                            <br>
                            <br>
                            <p>
                                Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                                quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                                consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                                cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
                                proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                            </p>
                            <br>
                            <br>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="row">
                            <div class="col-md-12 events well text-justify home_steps" id="events">
                                <marquee direction="up" scrollamount="2" onmouseover="javascript: this.stop();" onmouseout="javascript: this.start();">
                                    <ul>


                                        <li>
                                            <a href="index.php/exam/home/news_details" target="_blank">
                                                Exam Notifiaction Semester 8
                                            </a>
                                        </li>
                                    </ul>
                                </marquee>              
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 login_sidebar events well text-justify home_steps" id="login_sidebar">
                                <!-- <form class="form-signin"  role="form"> -->

                                <form action="index.php/exam/loginverify.cusat" method="post" accept-charset="utf-8" class="form-signin" role="form"><div style="display:none">
                                        <input type="hidden" name="csrf_jithu_name" value="9701d1cb84be977be6e7bddaefd147bf" />
                                    </div>

                                    <h2 class="form-signin-heading">Please sign in</h2>
                                    <br>
                                    <input class="form-control margin_bottom_10" name="username" placeholder="Username" required="required">
                                    <input type="password" name="password" class="form-control margin_bottom_10" placeholder="Password" required="required">




                                    <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
                                    <button id="sequoro_btn" onclick="javascript:sequoro();" class="btn btn-lg btn-primary btn-block" type="reset">Sequoro Sign in</button>
                                    <br>
                                    <div class="text-center">OR</div>
                                    <div class="register">
                                        <h4>Register Now</h4>
                                        <div>
                                            <!-- <ul class="block">
                                                <li class="pull-left text-left inline linktext">
                                            -->
                                            <a href="index.php/exam/students/register.cusat" class="pull-left linktext">Student</a>        <!--             </li>
                                                <li class="pull-right text-right inline linktext"> -->
                                            <!-- </li>
                                    </ul> -->
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div><div class="secondary">
            <div class="container">
                <div id="secondary_wrap" class="row">
                    <div class="col-md-3">
                        <h5 class="address_title"><strong>ADDRESS</strong></h5>
                        <address>
                            <strong>Cochin University</strong>

                            <br>Kochi
                            <br>Ernakulam
                            <br>123456
                            <br>
                            <br>
                            <div><span class="glyphicon glyphicon-phone-alt"></span><a>04822-271737</a></div><!-- 
                            <div><span class="glyphicon glyphicon-earphone"></span><a href="#">+918547924342</a></div> -->
                            <div>  <span class="glyphicon glyphicon-envelope"></span>
                                <a href="mailto:exam@cusat.ac.in">exam (at) cusat (dot) ac (dot) in</a></div>
                        </address>
                    </div>
                    <div class="col-md-3">
                        <ul>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-3">
                        <ul>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                        </ul>
                    </div><div class="col-md-3">
                        <ul>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                            <li>
                                <a >Important Links</a>
                            </li>
                        </ul>
                    </div>



                </div>
            </div>
        </div>
        <!-- Site footer -->
        <div class="footer">
            <div class="container">
                <div class="footer_wrap row">
                    <div class="col-md-3">
                        <p class="text-left">Last updated on 3-February-2015</p>
                    </div>
                    <div class="col-md-4">
                        <p class="text-left">Â© 2015 CUSAT. All rights reserved.</p>
                    </div>
                    <div class="col-md-5">

                        <p class="text-left">Powered by <a id="web">WebDev Team</a> Dept. of Computer Science, CUSAT.</p>
                    </div>

                </div>
            </div>
        </div>




        <!-- Include jQuery and bootstrap JS plugins -->
        <!-- <script src="js/jquery-2.1.0.min.js"></script>-->

        <!-- <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.2.1/js/bootstrap.min.js"></script> -->
        <script>
                    $.fn.modal || document.write('<script src="js/bootstrap.min.js"><\/script>');
        </script>


        <!--<script src="js/bootstrap.hover.js"></script>-->
        <script src="js/jquery.smint.js"></script>
        <script type="text/javascript" src="js/jquery.flexslider.js"></script>
        <script type="text/javascript">

                    jQuery(window).load(function () {


                        $("img.lazy").lazyload(
                                {threshold: 100, skip_invisible: false}
                        );
                        jQuery('.slider1').flexslider({
                            animation: "fade",
                            slideshow: true,
                            animationLoop: true,
                            smoothHeight: true,
                            directionNav: false,
                            direction: "horizontal"


                        });

                    });
        </script>
        <!--<script src="js/jquery.form.js"></script>-->

        <!-- <script src="http://maps.googleapis.com/maps/api/js?sensor=false"></script> -->
        <script type="text/javascript">
                    $(document).ready(function () {

                        $(window).keydown(
                                function (event) {
                                    if (event.keyCode == 13) {
                                        event.preventDefault();
                                        return false;
                                    }
                                }
                        );

                        $('.jithu_nav').smint({
                            'scrollSpeed': 1000
                        });

                        //  //$("#events").html("k");
                        // // var ur = "events/";
                        //new String() ;
                        //+ "/events/";
                        //  $("#events").html(ur);
                        //  $.ajax({
                        //      url: ur,
                        //      success: function(result) {
                        //          $("#events").html(result);
                        //      }
                        //  });
                    });
        </script>


       
        
        <script src="js/jquery.popupWindow.js"></script>
        <script>
        <%@include file="js/SequoroOAuth.js" %>
        </script>
    </body>

</html>
