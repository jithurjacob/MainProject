 
<%@page import="java.io.FileInputStream"%>
<%@page import="crypto.RSAEncryptionDescription"%>
<%@page import="java.io.File"%>
<%@page import="java.security.spec.RSAPublicKeySpec"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.KeyFactory"%>
<%@page import="org.json.simple.JSONObject"%>
<jsp:useBean id="obj"  class="bean.User" scope="session"/>  
<%

    String email = request.getParameter("email").toString();
    String hash = request.getParameter("hash").toString();
    String platform = request.getParameter("platform").toString();
%> 

<jsp:setProperty name="obj" property="email" value="<%= email%>" />  



<%
    File d = new File(application.getRealPath("/"));
    String filepath1 = d.getAbsolutePath() + "/server_keys/ServerPublic.key";
    try {

        FileInputStream fis = new FileInputStream(new File(filepath1));
    } catch (Exception ex) {
        System.out.println("Server Key doesn't exist creating new server key");
        String prikeypath = d.getAbsolutePath() + "/server_keys/ServerPrivate.key";
        String pubkeypath = d.getAbsolutePath() + "/server_keys/ServerPublic.key";

        RSAEncryptionDescription rsa_obj = new RSAEncryptionDescription();
        if (rsa_obj.keygen(prikeypath, pubkeypath)) {
            System.out.print("Server key generated");
        } else {
            System.out.print("Server key generation failed");
        }
    }

    try {

        System.out.println("serverkey filepath : " + filepath1);
        RSAEncryptionDescription robj = new RSAEncryptionDescription();
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PublicKey publicKey = robj.readPublicKeyFromFile(filepath1);
        RSAPublicKeySpec rsaPubKeySpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
        JSONObject jo = new JSONObject();
        jo = obj.check_key(hash);
        jo.put("Modulus", rsaPubKeySpec.getModulus().toString());
        jo.put("Exponent", rsaPubKeySpec.getPublicExponent().toString());
        jo.put("keystatus", "not ok");
        response.setContentType("application/json");
        out.print(jo);

    } catch (Exception ex) {
        System.out.print("excn in keycheck : " + ex.toString());
    }
    /*
     int status=RegisterDao.register(obj);  
     if(status>0)  
     out.print("You are successfully registered");  
     */
%>  
