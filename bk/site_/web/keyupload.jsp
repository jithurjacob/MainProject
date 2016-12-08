

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
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="org.json.simple.*" %>
<jsp:useBean id="obj"  class="bean.User" scope="session"/>  
<%
  String key=null,hash=null;
    String email=null,fileName=null;// = request.getParameter("email").toString();
%> 

<%!RSAEncryptionDescription rsa_obj = new RSAEncryptionDescription();%>
<%

    File d = new File(application.getRealPath("/"));
    MultipartRequest a = new MultipartRequest(request, d.getAbsolutePath() + "/");
//out.println("mail : "+a.getParameter("email"));
  //  out.println("hash : " + a.getParameter("hash"));
//out.println("plat : "+a.getParameter("platform"));
//out.println("key : "+a.getParameter("key"));
    try {
        fileName = d.getAbsolutePath() + "/keys/" + a.getParameter("email").toString() + (Math.random() * 10000) + ".key";
        key = a.getParameter("key").toString();
         email = a.getParameter("email").toString();
        hash = a.getParameter("hash").toString();
//out.print(d.getAbsolutePath()+"/keys/1.key");
        //out.println(fileName);
        JSONParser parser = new JSONParser();
        //out.print("Received key : " + key);
        Object obj1 = parser.parse(key);
        JSONObject array = (JSONObject) obj1;

        
        BigInteger mod = new BigInteger(array.get("Modulus").toString());
        BigInteger exp = new BigInteger(array.get("Exponent").toString());
        rsa_obj.saveKeys(fileName, mod, exp);
        md5 mobj = new md5();
     //   out.print("hash : " + mobj.getMD5EncryptedString(fileName));
    } catch (Exception ex) {
        out.println("excn : " + ex.toString());
    }
    
%>
<jsp:setProperty name="obj" property="email" value="<%= email %>" />  
<jsp:setProperty name="obj" property="public_key" value="<%= fileName %>" />  
<jsp:setProperty name="obj" property="keyhash" value="<%= hash %>" />  
<%
try{
JSONObject jo=new JSONObject();
if(obj.setKeydetails().compareTo("ok")==0){
    
    String filepath1=d.getAbsolutePath() + "/server_keys/ServerPublic.key";
    System.out.println("filepath : " + filepath1);
    
    KeyFactory keyFactory = KeyFactory.getInstance("RSA");
    PublicKey publicKey=rsa_obj.readPublicKeyFromFile(filepath1);
    RSAPublicKeySpec rsaPubKeySpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
    JSONObject js=new JSONObject();
    jo.put("Modulus", rsaPubKeySpec.getModulus().toString());
    jo.put("Exponent",rsaPubKeySpec.getPublicExponent().toString());
    
    jo.put("status","ok");
}else{
    jo.put("status","error");
}

out.print(jo.toJSONString());
}catch(Exception ex){
out.print("sending serv key : "+ex.toString());
}
%>