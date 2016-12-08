<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.taglibs.standard.tag.common.core.Util"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="sequoroOAuth"  class="bean.SequoroOAuth" scope="request"/> 
<jsp:useBean id="user_obj" class="bean.user" scope="page"/>
<%!String email,pwd;%>
<%
    System.out.print("in login");
 if(request.getParameter("provider")!=null)
{
    String provider=(String)request.getParameter("provider");
    if(provider.compareTo("sequoro")==0){
        session.setAttribute("provider", "Sequoro");
        if(!sequoroOAuth.authenticate((String)request.getParameter("requestcode"),request))
               
        
        response.sendError(response.SC_UNAUTHORIZED);
        else{// check in db
            user_obj.setEmail(session.getAttribute("email").toString());
//        if(!user_obj.email_exists())
//        response.sendRedirect("reg.jsp");
//        else
            response.sendRedirect("home.jsp");
        }
        
    }else{
        session.setAttribute("provider", "Other");
    // other providers like fb github etc
    
    }
}else{
     session.setAttribute("provider", "Normal Authentication");
     try{
 email=request.getParameter("email_txt").toString();
 pwd=request.getParameter("pasw_txt").toString();
     user_obj.setEmail(email);
     user_obj.setPwd(pwd);
     if(user_obj.login()){
         session.setAttribute("email", email);
         session.setAttribute("name",user_obj.getName_email());
 ////// normal authentication
 response.sendRedirect("home.jsp");
     }else
       response.sendError(response.SC_UNAUTHORIZED);  
     }catch(Exception ex){
     System.out.println("excn in normal");
     }
 }
 
 
%>
