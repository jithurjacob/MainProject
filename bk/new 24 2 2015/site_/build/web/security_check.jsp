
<base href="http://localhost:8080/site/">
<%
    try {
        String email = session.getAttribute("email").toString();
        if (email.compareTo("") == 0 || null == email) {
            response.sendError(response.SC_UNAUTHORIZED);
          %>
          <script>
    alert("Session expired login again");
    window.location="login_page.jsp";
</script>
          <%
        }
    } catch (Exception ex) {
         %>
          <script>
    alert("Session expired login again");
    window.location="login_page.jsp";
</script>
          <%
    }
%>

