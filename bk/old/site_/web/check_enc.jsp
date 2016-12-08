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
    String data = request.getParameter("data").toString();
   //   String key = request.getParameter("key").toString();
    try {
        String fileName = d.getAbsolutePath() + "/server_keys/ServerPrivate.key";
       

        RSAEncryptionDescription rsa_obj = new RSAEncryptionDescription();
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
    PublicKey publicKey=rsa_obj.readPublicKeyFromFile(fileName);
    RSAPublicKeySpec rsaPubKeySpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
    JSONObject js=new JSONObject();
    js.put("Modulus", rsaPubKeySpec.getModulus().toString());
    js.put("Exponent",rsaPubKeySpec.getPublicExponent().toString());
       out.print("data : "+rsa_obj.decryptData(data.getBytes(), fileName)+"\n key used : "+js.toJSONString()+"\nrecvd key : " );
      
    } catch (Exception ex) {
        out.println("excn : " + ex.toString());
    }
    
%> 