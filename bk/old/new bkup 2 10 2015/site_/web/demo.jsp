<%-- 
    Document   : demo
    Created on : Dec 29, 2014, 11:14:02 PM
    Author     : Jithu R Jacob
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="obj"  class="bean.User"/>  
<%
    String name="demo_" + (int) (Math.random() * 1000);
    String email = "demo_" + (int) (Math.random() * 1000) + "@sequoro.com";
    String pasw = "ab" + (int) (Math.random() * 100) + "cd" + (int) (Math.random() * 100) + "seq";
%> 
<jsp:setProperty property="name" value="<%= name%>" name="obj"/>  
<jsp:setProperty property="email" value="<%= email%>" name="obj"/>  
<jsp:setProperty property="pasw" value="<%= pasw%>" name="obj"/>  
<jsp:setProperty property="verified" value="1" name="obj"/>  

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
        <%@include file="css imports.jsp" %> 
    </head>

    <body>
        <%@include file="nav.jsp" %> 
        <section id="demo">
            <div class="container">

                <div class="row">
                    <div class="col-md-12 text-center">
                        <h2 class="section-title">How it works</h2>         
                    </div>
                </div>


                <div class="row spacer80"></div>
                <div class="row">
                    <div class="col-md-5 col-sm-5">
                        <div class="spacer30"></div>

                        <p>Sequoro login consists of three stages
                        <ul>
                            <li><p>Stage One<br>This stage consists of normal login procedures where user enters his credential Eamil/Password</p></li>
                            <li><p>Stage Two<br>THe users credentials are validated and a QR code is displayed which contains the OTP.It can only be read by correct user.THe user reads the OTP using sequor app.</p></li>
                            <li><p>Stage THree<br>THe user verifies his identity by enerinh his OTP and thus completing the login process</p></li>
                        </ul>

                        </p>

                    </div>
                    <div class="col-md-7 col-sm-7">
                        <div class="laptop">
                            <img src="img/slider-laptop/laptop.png" alt="">
                            <div class="laptop-slider">

                                <ul class="slides"> 
                                    <li>        
                                        <img src="img/slider-laptop/0.jpg" alt="">
                                    </li>  
                                    <li>
                                        <img src="img/slider-laptop/00.jpg" alt="">
                                    </li>


                                </ul>
                            </div>
                        </div>
                    </div>
                </div>      
                <div class="row spacer100"></div>
                <div class="col-md-12 text-center">
                    <h2 class="section-title">Demo</h2>         
                </div>  
                <div class="row spacer40"></div> 
                <h3 class="text-left">Registration</h3>
                <div class="row spacer20"></div> 
                <p>Please register to access Sequoro services</p>
                <form id="demo_form" role="form" class="form-horizontal form-main">
                    <div class="text-center">
                        <h3 class="text-center">Register Now</h3>         
                    </div> 
                    <div class="form-group">
                        <label for="exampleInputName">Name</label>
                        <input type="name" disabled="" class="form-control disabled" id="exampleInputName" placeholder="Enter name">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputEmail1">Email address</label>
                        <input type="email" disabled="" class="form-control disabled" id="exampleInputEmail1" placeholder="Enter email">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">Password</label>
                        <input type="password" disabled="" class="form-control disabled" id="exampleInputPassword1" placeholder="Password">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword2">Confirm Password</label>
                        <input type="password" disabled="" class="form-control disabled" id="exampleInputPassword2" placeholder="Confirm Password">
                    </div>

                    <button type="submit" disabled="disabled" class="btn btn-default">Submit</button>
                    <div class="row spacer20"></div> 
                    <div>
                        <%
                            try {
                                obj.registration();
                            } catch (Exception ex) {
                                System.out.print(ex);
                            }

                        %>
                    </div>
                    <p>Don't worry we saved your time :-)<br> Please use <b><%=email%></b> as your email address and <b><%=pasw%></b> as password for demo</p>
                </form>
                <div class="row spacer40"></div> 
                <p>Please use the above created temporary email address for checking out the demo.</p>

                <div class="row spacer20"></div> 
                <h3 class="text-left">Download Sequoro app</h3>
                <div class="row spacer20"></div> 
                <p>Please download sequoro app from the corresponding app store or by clicking in the link and install it in your device</p>

                <div class="row">

                    <div class="col-md-4 col-xs-6">
                        <div class="services-1">
                            <div class="services-1-icon">
                                <i class="fa fa-android"></i>
                            </div>
                            <div class="services-1-title">ANDROID</div>
                        </div>
                    </div>
                    <div class="col-md-4 col-xs-6">
                        <div class="services-1">
                            <div class="services-1-icon">
                                <i class="fa fa-windows"></i>
                            </div>
                            <div class="services-1-title">WINDOWS</div>
                        </div>
                    </div>
                    <div class="col-md-4 col-xs-6">
                        <div class="services-1">
                            <div class="services-1-icon">
                                <i class="fa fa-apple"></i>
                            </div>
                            <div class="services-1-title">IOS</div>
                        </div>
                    </div>                
                </div>

                <div class="row spacer20"></div> 
                <h3 class="text-left">Creating security keys</h3>
                <div class="row spacer20"></div> 

                <p>Secure RSA 2048 keys would be generated for your account the first time you login from the device.
                    Login to our app using the credentials to generate secure RSA 2048 keys.Public key would uploaded to our servers and private key
                    would be securely saved in your device.
                    After successful login you would enter the dashboard of Sequoro app which gives you option scan the QR codes</p>

                <div class="row spacer20"></div> 
                <div class="row">
                    <div class="col-md-5 col-sm-5">
                        <h3 class="text-left">Login</h3>
                        <div class="row spacer20"></div> 
                        <p>Sequoro protects you from possible malware like keyloggers and hacker attacks like social engineering.Hackers couldn't access your account without physical access to your device.</p>
                        <p>How Sequoro differs from other two step authentication mechanisms is that Sequoro provides authentication with zero delay.THis is made possible by the use of QR codes.Popular sites like Google,Twitter etc uses SMS or voice calls for the delivery of One Timr PAsswords (OTPs).There may infinte delay in receving an SMS or even network may be unavailable.THere might also be the problems of international roaming.These problems prevent smaller websites to provide this awesome facilities to their customers.Sequoro provides a universal solution to Two Step Authentication.</p>
                    </div>
                    <div class="col-md-7 col-sm-7">
                        <div id="phone" class="phone_">
                            <img src="img/screens/00.png" alt="">
                            <div class="phone_-slider">

                                <ul class="slides"> 
                                    <li>        
                                        <img src="img/screens/1.png" alt="">
                                    </li>  
                                    <li>
                                        <img src="img/screens/2.png" alt="">
                                    </li>
                                    <li>
                                        <img src="img/screens/3.png" alt="">
                                    </li>
                                    <li>
                                        <img src="img/screens/4.png" alt="">
                                    </li>
                                    <li>
                                        <img src="img/screens/5.png" alt="">
                                    </li>
                                    <li>
                                        <img src="img/screens/6.png" alt="">
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row spacer10"></div> 
                <p>If every thing has worked correctly you could see the option for scanning.Please use our help forums for solving any errors encountered during setup</p>
                <p>Proceed to login if everything worked out ok.</p>
                <div class="row spacer30"></div> 
                <div class="row">
                    <form id="demo_form" role="form" action="javascript:loadqr();" class="form-horizontal form-main">
                        <div class="text-center">
                            <h3 class="text-center">Login </h3>         
                        </div> 

                        <div class="form-group" >
                            <label for="email">Email address</label>
                            <input type="email" class="form-control" id="email" placeholder="Enter email">
                        </div>
                        <div class="form-group">
                            <label for="pwd">Password</label>
                            <input type="password" class="form-control" id="pwd" placeholder="Password">
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> Remember Me
                            </label>
                        </div>
                        <div class="form-group qr" id="qr_div">
                            <img id="qr">
                        </div>
                        <div class="form-group" id="otp_div">
                            <label for="otp">OTP</label>
                            <input type="password" class="form-control" id="otp" placeholder="OTP">
                        </div>
                        <button  type="submit" class="btn btn-default">Submit</button>
                        <div class="row spacer20"></div> 
                        <div>

                        </div>
                        <p><br> Please use <b><%=email%></b> as email and <b><%=pasw%></b> as password for demo</p>
                    </form>

                </div>

                <div class="row spacer40"></div> 

                <!--                end of demo-->
            </div>
        </section>

        <%@include file="footer.jsp" %> 

        <script>
            function loadqr(){
                
                if($('#email').val()!="<%=email%>"){
                    alert("Demo only allows to use <%=email%> as Email address");
                    return false;
                }else if($('#pwd').val()!="<%=pasw%>"){
                    alert("Demo only allows to use <%=pasw%> as password");
                    return false;
                }else{
                    
                     $.ajax({
                        url:"demo_qr.jsp",
                        type:'POST',
                       
                        data:{
                            email : "<%=email%>"
                            
                        },
                        success:function(result){
                            $('#pwd,#email').prop("disabled","disabled"); 
                            $('#qr_div,#otp_div').show();
                            $("#qr").prop("src",result);
                        }
                   
                    });
                    
                }
            }
        </script>
    </body>
</html>
