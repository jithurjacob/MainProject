<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.taglibs.standard.tag.common.core.Util"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="sequoroOAuth"  class="bean.SequoroOAuth" scope="session"/> 
<%
 if(request.getParameter("provider")!=null)
{
    String provider=(String)request.getParameter("provider");
    if(provider.compareTo("sequoro")==0){
        if(!sequoroOAuth.authenticate((String)request.getParameter("requestcode"),request))
               
        
        response.sendError(response.SC_UNAUTHORIZED);
        
    }else{
    // other providers like fb github etc
    
    }
}else{
 
 ////// normal authentication
 
 }
 
 response.sendRedirect("home.jsp");
%>
