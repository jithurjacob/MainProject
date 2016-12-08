<%-- 
    Document   : index
    Created on : Mar 16, 2015, 7:16:25 PM
    Author     : Jithu R Jacob
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="sequoroOAuth_reg"  class="bean.SequoroOAuth_Reg" scope="page"/> 
<%!String name="",email="",provider="null";%>
<%
    
    if(request.getParameter("provider")!=null)
{
    System.out.print("in here");
    String provider=(String)request.getParameter("provider");
    if(provider.compareTo("sequoro")==0){
        session.setAttribute("provider", "Sequoro");
        if(!sequoroOAuth_reg.authenticate((String)request.getParameter("requestcode"),request))
        response.sendError(response.SC_UNAUTHORIZED);
        
        }
    }
   
    
if(session.getAttribute("email")!=null){
    email=session.getAttribute("email").toString();
    name=session.getAttribute("name").toString();
    provider=session.getAttribute("provider").toString();
}
%>

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
        <%-- Enumeration<String> ir=session.getAttributeNames();  while(ir.hasMoreElements())out.print(ir.nextElement().toString()); --%>
        <section id="demo">
            <div class="container">



                <div class="row spacer100"></div> 
                <h3 class="text-left">Demo page for Sequoro login / registration</h3>
                <div class="row spacer20"></div> 
                <div id="demo_form_cover">
                    <form id="demo_form" method="POST" role="form" action="register.jsp?provider=<%=provider%>" class="form-horizontal form-main">
                    <div class="text-center">
                        <h3 class="text-center">Register</h3>         
                    </div>
                        <div class="form-group">
                        <label for="name_txt">Name</label>
                        <input type="text" required="" class="form-control disabled" value="<%=name%>" id="name_txt" name="name_txt" placeholder="Enter name">
                    </div>
                     
                         <div class="form-group">
                        <label for="email_txt">Email address</label>
                        <input type="email" <%if(session.getAttribute("email")!=null){%> disabled="disabled" <%}%> required="" class="form-control disabled" value="<%=email%>" id="email_txt" name="email_txt" placeholder="Enter email">
                    </div>
                       <%
                            if(session.getAttribute("email")==null){%>
                    <div class="form-group">
                        <label for="pwd_txt">Password</label>
                        <input type="password"  class="form-control disabled" id="pwd_txt" name="pwd_txt" required="" placeholder="Password">
                    </div>
                    <%}%>
                        <div class="form-group">
                        <label for="age_txt">Age</label>
                        <input type="number" required="" class="form-control disabled" id="age_txt" name="age_txt" placeholder="Enter age">
                    </div>
                    <div class=" text-center">
                        <button  type="submit" class="btn btn-default">Register</button>
                      <button  type="button" id="sequoro_btn" onclick="sequoro_reg()" class="btn btn-default">Register using Sequoro</button>
                  
                    </div>
                         <div class="row spacer5"></div> 
                    <div class=" text-center">
                             <h4 class=" text-center">OR</h4>
                    </div>
                        
                    <div class=" text-center">
                        <h3 class=" text-center"> <a href="index.jsp">Login </a></h3>
                       
                    </div>
                        
                        
                        </form>
                    
                    
                </div>
            </div>
        </section>
        
        
        
        
        
        <script src="js/jquery.js"></script>  
  <script src="js/bootstrap.min.js"></script>  
  <script src="js/jquery.easing.js"></script>  
  <script src="js/jquery.magnific-popup.min.js"></script>
  
  
  <script src="js/jquery.popupWindow.js?time=<%=new Date().getTime()%>"></script>
        <script>
        <%@include file="js/SequoroOAuth_reg.js" %>
        </script>
 
    </body>
</html>
