 
<jsp:useBean id="obj"  class="bean.User"/>  
<%
    String email = (String) request.getParameter("email_txt");
    String pasw = (String) request.getParameter("pasw_txt");
%> 
<jsp:setProperty property="email" value="<%= email %>" name="obj"/>  
<jsp:setProperty property="pasw" value="<%= pasw %>" name="obj"/>  
  
    
<%  
    try{
    out.print(obj.registration());
    }catch(Exception ex){
    System.out.print(ex);
    }
    /*
int status=RegisterDao.register(obj);  
if(status>0)  
out.print("You are successfully registered");  
  */
%>  
