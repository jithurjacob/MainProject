 
<%@page import="org.json.simple.JSONObject"%>
<jsp:useBean id="obj"  class="bean.User"/>  
<%
     String name = (String) request.getParameter("name_txt");
    String email = (String) request.getParameter("email_txt");
    String pasw = (String) request.getParameter("pasw_txt");
     int siteowner = Integer.parseInt( request.getParameter("siteowner"));
%> 
<jsp:setProperty property="name" value="<%= name %>" name="obj"/> 
<jsp:setProperty property="email" value="<%= email %>" name="obj"/>  
<jsp:setProperty property="pasw" value="<%= pasw %>" name="obj"/>  
<jsp:setProperty property="isSiteOwner" value="<%= siteowner %>" name="obj"/>  
    
<%  
    try{
        JSONObject jsobj=new JSONObject();
        jsobj.put("status", obj.registration());
    out.print(jsobj.toJSONString());
    }catch(Exception ex){
    System.out.print(ex);
    }
   
%>  
