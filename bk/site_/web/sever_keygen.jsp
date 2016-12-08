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

<%
      File d = new File(application.getRealPath("/"));
   // MultipartRequest a = new MultipartRequest(request, d.getAbsolutePath() + "/");
   
   //   String key = request.getParameter("key").toString();
    try {
        String prikeypath = d.getAbsolutePath() + "/server_keys/ServerPrivate.key";
       String pubkeypath= d.getAbsolutePath() + "/server_keys/ServerPublic.key";

        RSAEncryptionDescription rsa_obj = new RSAEncryptionDescription();
      if( rsa_obj.keygen(prikeypath, pubkeypath))
          out.print("Server key generated");
      else
           out.print("Server key generation failed");
      
    } catch (Exception ex) {
        out.println("excn : " + ex.toString());
    }
    
%> 