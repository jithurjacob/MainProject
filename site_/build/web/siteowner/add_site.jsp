<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="com.sun.mail.iap.ByteArray"%>
<%@page import="sun.misc.BASE64Decoder"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.crypto.Cipher"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="org.json.simple.JSONObject"%>
<jsp:useBean id="website_obj"  class="bean.Website" scope="session"/> 
<%! String fileName, owner_email, site_name, site_url, site_redirecturl, site_logo, site_desc,client_secretkey,client_id;
             %>
<%
    try {
        owner_email = (String) session.getAttribute("email");
        site_name = (String) request.getParameter("site_name");
        site_url = (String) request.getParameter("site_url");
        site_redirecturl = (String) request.getParameter("site_redirecturl");
        site_logo = (String) request.getParameter("site_logo");
        site_desc = (String) request.getParameter("site_desc");
        File d = new File(application.getRealPath("/"));
        fileName = d.getAbsolutePath() + "/img/sitelogos/" + site_name + (Math.random() * 10000) + ".jpg";//
    } catch (Exception ex) {
        System.out.println("Excn in initializing: " + ex.toString());
    }
%>
<jsp:setProperty name="website_obj" property="site_name" value="<%= site_name%>" /> 
<jsp:setProperty name="website_obj" property="site_url" value="<%= site_url%>" /> 
<jsp:setProperty name="website_obj" property="site_redirecturl" value="<%= site_redirecturl%>" /> 
<jsp:setProperty name="website_obj" property="site_desc" value="<%= site_desc%>" /> 
<jsp:setProperty name="website_obj" property="owner_email" value="<%= owner_email%>" /> 
<jsp:setProperty name="website_obj" property="site_logo" value="<%= fileName%>" />  
<%
    try {

        site_logo = site_logo.replace("data:image/jpeg;base64,", "");
        site_logo = site_logo.replace("data:image/jpg;base64,", "");
        site_logo = site_logo.replace(" ", "+");
        // site_logo = new String(Base64.decodeBase64(site_logo.getBytes("UTF8")));
      //  System.out.println("File name : " + fileName + " img : " + site_logo);
        BufferedImage img = null;//ImageIO.read(new File(fileName));
        byte[] imgbyte;
        BASE64Decoder decoder = new BASE64Decoder();
        imgbyte = decoder.decodeBuffer(site_logo);
        ByteArrayInputStream bis = new ByteArrayInputStream(imgbyte);
        img = ImageIO.read(bis);
        ImageIO.write(img, "jpg", new File(fileName));
        //FileOutputStream fout = new FileOutputStream(new File(fileName));

        //fout.write(site_logo.getBytes("UTF8"));
      //  fout.flush();
        //  fout.close();
    } catch (Exception e) {
        System.out.println("Excn in saving pic: " + e.toString());
    }
    try {
        int keysize = 256,f=0;
        String input=(int)( Math.random() * 1000000000)+owner_email + site_name + site_url +(int)( Math.random() * 1000000000);
        System.out.println(input);
        byte[] key = (input).getBytes("UTF-8"), clienti=(input).getBytes("UTF-8");
        MessageDigest sha = MessageDigest.getInstance("SHA-1");
        
        while(new String(Base64.encodeBase64(clienti)).contains("+") || f==0){
        clienti = sha.digest(sha.digest(key));
        key = Arrays.copyOf(key, 32); // use only first 128 bit
        f=1;
        }
        
        System.out.println("key len : " + key.length + " key: " + new String(Base64.encodeBase64(key)) + " cid: " + new String(Base64.encodeBase64(clienti)));
    client_secretkey=new String(Base64.encodeBase64(key));
    client_id=new String(Base64.encodeBase64(clienti));
//    SecretKeySpec secretKeySpec = new SecretKeySpec(key, "AES");

//    Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
//    cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);
//    String data = "jithu";
//    byte[] encrypted = cipher.doFinal((data).getBytes());
//    System.out.println("encrypted string: " + new String(Base64.encodeBase64(encrypted)));
//
//    cipher.init(Cipher.DECRYPT_MODE, secretKeySpec);
//    byte[] original = cipher.doFinal(encrypted);
//    String originalString = new String(original);
//    System.out.println("Original string: " + originalString + "\nOriginal string (Hex): " + data);
    } catch (Exception ex) {
        System.out.println("Excn in encryptn :" + ex.toString());
    }%>
    <jsp:setProperty name="website_obj" property="client_secretkey"  value="<%=client_secretkey%>"/> 
    <jsp:setProperty name="website_obj" property="client_id"  value="<%=client_id%>"/>
    <%
    JSONObject reply = new JSONObject();
    if (website_obj.add_site()) {
        reply.put("status", "ok");
        reply.put("client_secretkey", client_secretkey);
        reply.put("client_id",client_id);
    } else {
reply.put("status", "fail");
    }
out.print(reply.toJSONString());
%>