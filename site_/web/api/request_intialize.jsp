<%--

used to initialize request to api

input : clientid,clientsecret
output : state 


state is used to prevent cross site req forgries
--%>
<%!String clientid,clientsecret,state;%>

<%
    clientid =  request.getParameter("clientid").toString();
    clientsecret = (String) request.getParameter("clientsecretkey");
    System.out.println("Got in request initailize : clid="+clientid+" key= "+clientsecret);
 %>
<jsp:useBean id="website_obj"  class="bean.Website" scope="page"/> 
<jsp:useBean id="api_obj"  class="bean.api" scope="page"/> 
<jsp:setProperty name="website_obj" property="client_secretkey" value="<%= clientsecret%>" /> 
<jsp:setProperty name="website_obj" property="client_id" value="<%=clientid%>" />
<jsp:setProperty name="api_obj" property="clientid" value="<%=clientid%>" />
<%

if(website_obj.isValidWebsite()){
    out.print(api_obj.initialize().trim());
}else{
    out.print("Error");
}
    

%>