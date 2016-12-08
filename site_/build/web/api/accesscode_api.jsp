<%!String requestcode,clientid,clientsecret,email;%>
<%@page import="org.json.simple.JSONObject"%>
<jsp:useBean id="api_obj"  class="bean.api" scope="session"/> 
<jsp:useBean id="user_obj"  class="bean.User" scope="session"/> 
<jsp:useBean id="otp_obj"  class="bean.Otp" scope="session"/> 
<%
    requestcode =(String)request.getParameter("requestcode");
    clientid =(String)request.getParameter("clientid");
    clientsecret =(String)request.getParameter("clientsecretkey");
   
    JSONObject replyObj=new JSONObject();
    String accesscode=api_obj.getAccesscode(requestcode,clientid,clientsecret);
    email=otp_obj.getEmail(accesscode);
    replyObj.put("accesscode",accesscode);
    if(accesscode.compareTo("Error")!=0){
        replyObj.put("email",email);
        replyObj.put("name",user_obj.getName(email));
    }
out.print(replyObj.toJSONString());

%>