
<%@page import="javafx.application.Platform"%>

<base href="http://localhost:8080/cusat/">
<%
    try {
       
        String email = session.getAttribute("email").toString();
        if (email.compareTo("") == 0 || null == email) {
            
          %>
          <script>
    alert("Session expired login again");
    window.location="index.jsp";
</script>
          <%
            response.sendError(response.SC_UNAUTHORIZED);
        }
    } catch (Exception ex) {
        
         %>
          <script>
    alert("Session expired login again");
    window.location="index.jsp";
</script>
          <%
         response.sendError(response.SC_UNAUTHORIZED);
    }
    
    
%>

