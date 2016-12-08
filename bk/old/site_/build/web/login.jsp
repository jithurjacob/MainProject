 
  <%@page import="org.json.simple.JSONObject"%>
<jsp:useBean id="obj"  class="bean.User" scope="session"/>  
<%
    
    String email = request.getParameter("email").toString();
    String pasw =  request.getParameter("pasw").toString();
    String platform = request.getParameter("platform").toString();
%> 

<jsp:setProperty name="obj" property="email" value="<%= email %>" />  
<jsp:setProperty name="obj" property="pasw" value="<%= pasw %>" />  
  
    
<%  
    try{
        JSONObject replyObj=new JSONObject();
        //out.print(obj.getEmail());
         replyObj=obj.check_login();
         response.setContentType("application/json");
        if(replyObj.get("status").toString().compareTo("ok")==0){
             session.setAttribute("email", email);
             if(platform.compareTo("1")==0){
             replyObj.put("status","<script>document.location='dashboard.jsp'</script>");
             out.print(replyObj);
             }else{
             
             out.print(replyObj);
             }
        }else{
            
            out.print(replyObj);
        }
    
    }catch(Exception ex){
    System.out.print(ex);
    }
    /*
int status=RegisterDao.register(obj);  
if(status>0)  
out.print("You are successfully registered");  
  */
%>  

