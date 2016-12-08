<%-- 
    Document   : index
    Created on : Mar 16, 2015, 7:16:25 PM
    Author     : Jithu R Jacob
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="sequoroOAuth"  class="bean.SequoroOAuth" scope="session"/> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" media="screen" />
        <link href="css/animate.css" rel="stylesheet" media="screen" />
        <link href="css/magnific-popup.css" rel="stylesheet" media="screen" />  
         <link href="css/style.css" rel="stylesheet" media="screen" /> 
	<!-- Components css -->
  <link href="css/components.css" rel="stylesheet" media="screen" /> 
  <link href="css/style_override.css" rel="stylesheet" media="screen" /> 
	<!-- Responsive css -->
  <link href="css/responsive.css" rel="stylesheet" media="screen" />
    </head>
    <body class="bg">
        <section id="demo">
            <div class="container">



                <div class="row spacer100"></div> 
                <h3 class="text-left">Demo page for Sequoro login / registration</h3>
                <div class="row spacer20"></div> 
                <div id="demo_form_cover">
                    <form id="demo_form" method="POST" role="form" action="login.jsp" class="form-horizontal form-main">
                    <div class="text-center">
                        <h3 class="text-center">Login</h3>         
                    </div>
                         <div class="form-group">
                        <label for="email_txt">Email address</label>
                        <input type="email" required="" class="form-control disabled" id="email_txt" name="email_txt" placeholder="Enter email">
                    </div>
                    <div class="form-group">
                        <label for="pasw_txt">Password</label>
                        <input type="password"  class="form-control disabled" id="pasw_txt" name="pasw_txt" required="" placeholder="Password">
                    </div>
                    <div class=" text-center">
                        <button  type="submit" class="btn btn-default">Login</button>
                        <button  type="button" id="sequoro_btn" onclick="sequoro()" class="btn btn-default">Login using Sequoro</button>
                  
                    </div>
                         <div class="row spacer5"></div> 
                    <div class=" text-center">
                             <h4 class=" text-center">OR</h4>
                    </div>
                        
                    <div class=" text-center">
                        <h3 class=" text-center"><a href="reg.jsp">Register</a></h3>
                       
                    </div>
                        
                        
                        </form>
                    
                    
                </div>
            </div>
        </section>
        
        
        
        
        
        <script src="js/jquery.js"></script>  
  <script src="js/bootstrap.min.js"></script>  
  <script src="js/jquery.easing.js"></script>  
  <script src="js/jquery.magnific-popup.min.js"></script>
  
  
  <script src="js/jquery.popupWindow.js"></script>
        <script>
        <%@include file="js/SequoroOAuth.js" %>
        </script>
 
    </body>
</html>
