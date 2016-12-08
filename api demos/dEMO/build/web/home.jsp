<%-- 
    Document   : index
    Created on : Mar 16, 2015, 7:16:25 PM
    Author     : Jithu R Jacob
--%>
<%@include file="security_check.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
                    <form id="demo_form" method="POST" role="form" action="javascript:login();" class="form-horizontal form-main">
                    <div class="text-center">
                        <%try{%>
                                Hi <%=session.getAttribute("name").toString()%> you have logged in using <%=session.getAttribute("provider").toString()%>
                    <%}catch(Exception ex){
                    
System.out.println("Excn in home: "+ex.toString());
}%>
                    </div>
                      <div class="text-center">
                          <a href="logout.jsp">Logout</a>
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
     
 
    </body>
</html>
