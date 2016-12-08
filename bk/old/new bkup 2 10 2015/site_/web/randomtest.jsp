<%-- 
    Document   : randomtest
    Created on : Dec 26, 2014, 9:37:31 PM
    Author     : Jithu R Jacob
--%>

<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.security.spec.RSAPublicKeySpec"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.KeyFactory"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="crypto.*"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.File"%>

<%@page import="org.json.simple.*" %>
<jsp:useBean id="obj"  class="bean.User" scope="session"/> 
<%!String enc=null;%>
<%!String data=null;%>
<%
  String key=null,hash=null;
    String email= request.getParameter("email").toString(),fileName=null;// = request.getParameter("email").toString();
%> 
<jsp:setProperty name="obj" property="email" value="<%= email %>" />  

<%

 File d = new File(application.getRealPath("/"));
     data = ""+(int)(Math.random()*10000);
    try {
        fileName = d.getAbsolutePath() + "/server_keys/ServerPrivate.key";
       RSAEncryptionDescription rsa_obj = new RSAEncryptionDescription();
       JSONObject js=new JSONObject();
     enc=rsa_obj.encryptData(data, obj.getKeydetails());
    js.put("data",enc );
    enc=new String(Base64.encodeBase64(js.toJSONString().getBytes("UTF8")));
    //   out.print(js.toJSONString());
      
    } catch (Exception ex) {
        out.println("excn : " + ex.toString());
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Test</title>
    </head>
    <body>
        <img src="http://qrickit.com/api/qr?d=<%=enc%>&addtext=<%=data%>&qrsize=250">
    </body>
</html>
