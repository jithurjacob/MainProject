<jsp:useBean id="obj"  class="bean.User" scope="session"/> 
<%@page import="org.json.simple.JSONObject"%>
<%

    String email = session.getAttribute("email").toString();
   int protocol = Integer.parseInt(request.getParameter("protocol").toString());
   int pwd = Integer.parseInt(request.getParameter("pwd").toString());
   %>
<jsp:setProperty name="obj" property="email" value="<%= email%>" />

<%
JSONObject result=new JSONObject();
if(obj.setProtocol(email, protocol,pwd)){
result.put("status","Security Level changed succcessfully");
}
else
    result.put("status","Security Level changing failed");
out.print(result.toJSONString());
%>