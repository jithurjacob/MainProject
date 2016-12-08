<jsp:useBean id="conb_obj" class="bean.ConnectionProvider" scope="page"/>

<base href="<%=conb_obj.baseurl%>" >
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

