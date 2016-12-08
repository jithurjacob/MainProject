 
  <%@page import="org.json.simple.JSONObject"%>
<jsp:useBean id="obj"  class="bean.User" scope="session"/>  
<%
    
    String email = request.getParameter("email").toString();
    String hash = request.getParameter("hash").toString();
    String platform = request.getParameter("platform").toString();
%> 

<jsp:setProperty name="obj" property="email" value="<%= email %>" />  

  
    
<%  
    try{
        JSONObject replyObj=new JSONObject();
        //out.print(obj.getEmail());
         replyObj=obj.check_key(hash);
         response.setContentType("application/json");
        out.print(replyObj);
             
    }catch(Exception ex){
    System.out.print(ex);
    }
    /*
int status=RegisterDao.register(obj);  
if(status>0)  
out.print("You are successfully registered");  
  */
%>  

