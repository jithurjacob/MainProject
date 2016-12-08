
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello <%=session.getAttribute("email")%>!</h1>
         <a href="./changepasw.html">Change Password</a>     
         <a href="./setprotocol.html">Set Protocol</a>
         <a href="./viewlog.html">View Log</a>
         <a href="./help.html">Help</a>
         <a href="./aboutus.html">About Us</a>
         <a href="./logout.html">Logout</a>
    </body>
</html>
