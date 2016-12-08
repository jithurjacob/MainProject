<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.taglibs.standard.tag.common.core.Util"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="sequoroOAuth"  class="bean.SequoroOAuth" scope="session"/> 
<jsp:useBean id="user_obj" class="bean.user" scope="page"/>
<%
user_obj.setAge(request.getParameter("age_txt").toString());
user_obj.setName(request.getParameter("name_txt").toString());
if(request.getParameter("email_txt")!=null)
user_obj.setEmail(request.getParameter("email_txt").toString());
if(request.getParameter("pwd_txt")!=null)
user_obj.setPwd(request.getParameter("pwd_txt").toString());
else
    user_obj.setPwd("null");
user_obj.setProovider(request.getParameter("provider").toString());
if(user_obj.email_exists())
    out.print("Email exists");
else if(user_obj.register())
    response.sendRedirect("index.jsp");

session.invalidate();

%>