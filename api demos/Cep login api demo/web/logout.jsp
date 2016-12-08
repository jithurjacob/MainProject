<% 
    session.removeAttribute("email");
    session.invalidate();
    
    

%>
<script>
    window.location="index.jsp";
</script>