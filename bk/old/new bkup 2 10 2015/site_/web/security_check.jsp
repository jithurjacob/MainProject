<%-- 
    Document   : security_check
    Created on : Jan 30, 2015, 10:09:06 PM
    Author     : Jithu R Jacob
--%>

<%
    try {
        String email = session.getAttribute("email").toString();
        if (email.compareTo("") == 0 || null == email) {
            response.sendError(response.SC_UNAUTHORIZED);
        }
    } catch (Exception ex) {
        response.sendError(response.SC_UNAUTHORIZED);
    }
%>
