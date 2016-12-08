

<%@page import="javafx.application.Platform"%>


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
        System.out.print("here"+ex.toString());
         %>
          <script>
    alert("Session expired login again");
    window.location="index.jsp";
</script>
          <%
         response.sendError(response.SC_UNAUTHORIZED);
         
    }
    
    
%>

