<%@include file="security_check.jsp" %>
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
        <%@include file="css imports.jsp" %> 
    </head>    
    
    <body>
        
        <%@include file="nav _login.jsp" %> 
        <section id="demo">
            <div class="container">

                      
                
               
                <div class="row spacer30"></div> 
                <div class="row">
        
         <h3 class="text-left"><h2>Hello <%=session.getAttribute("email")%>!</h2></h3>
                <div class="row spacer20"></div> 
                <p>Hope you are having a good time with our services :) Your Sequoro usage is shown below</p>
                 <div class="row spacer20"></div> 
                 <div class="responsive-table">
                        <table id="placement_table" class="table table-striped table-condense table-hover table-bordere text-left verify_table">
                            <tr>
                              <td>Total login attempts </td>
                              <td></td>
                              <td><a>View Details</a></td>
                            </tr>
                            <tr>
                              <td>Total successful logins</td>
                              <td></td>
                              <td><a>View Details</a></td>
                            </tr>
                             <tr>
                              <td>Total Website's accessed</td>
                              <td></td>
                              <td><a>View Details</a></td>
                            </tr>
                            
                            </table>
                            </div>
                </div>
            </div></section>
        
        <%@include file="footer.jsp" %> 
    </body>
</html>
