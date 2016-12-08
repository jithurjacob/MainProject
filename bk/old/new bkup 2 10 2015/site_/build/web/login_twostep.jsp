<%@page import="java.sql.Timestamp"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.io.File"%>
<%@page import="crypto.RSAEncryptionDescription"%>
<%@page import="org.json.simple.JSONObject"%>
<jsp:useBean id="obj"  class="bean.User" scope="session"/> 
<jsp:useBean id="otp_obj"  class="bean.Otp" scope="session"/>  
<jsp:useBean id="qr_obj"  class="bean.QrGen" scope="session"/>  
<%

    String email = request.getParameter("email").toString();
    String secureid = request.getParameter("secureid").toString();
    String pasw = request.getParameter("pasw").toString();
    String otp = request.getParameter("otp").toString();
    String platform = request.getParameter("platform").toString();
    Timestamp ts_now = new Timestamp( new Date().getTime());
    String now=ts_now.toString();
    String secure_otp_id = DigestUtils.shaHex(now+"$#@#$%^salt");
%> 

<jsp:setProperty name="otp_obj" property="email" value="<%= email%>" />  
<jsp:setProperty name="otp_obj" property="otp_hash" value="<%= otp%>" />  
<jsp:setProperty name="otp_obj" property="secure_otp_hash_id" value="<%= secureid%>" />
<jsp:setProperty name="otp_obj" property="time" value="<%= now%>" />  
<jsp:setProperty name="obj" property="email" value="<%= email%>" />  
<jsp:setProperty name="obj" property="pasw" value="<%= pasw%>" /> 

<%
    try {
        JSONObject replyObj = new JSONObject();
        // out.print(obj.getEmail());
        replyObj = otp_obj.check_login();
        response.setContentType("application/json");
        if (replyObj.get("status").toString().compareTo("ok") != 0) {
            session.setAttribute("email", email);
            if (platform.compareTo("1") == 0) {

                if (obj.allok() == true) {

                    File d = new File(application.getRealPath("/"));
                    String data = null;
                    if (obj.getProtocol() == 0) {
                        int num=0;
                        while(num<1000 || num>10000)
                        num=(int) (Math.random() * 10000);
                       data = "" + num;
                    } else {//protocol 2
                        data = "sample";
                    }
                    try{
                        otp_obj.setOtp_hash(data);
                        otp_obj.setSecure_otp_hash_id(secure_otp_id);
                    otp_obj.insert();
                    
                    }catch(Exception ex){
                    System.out.println("Excn in entering otp :"+ex.toString());
                    }
                    String enc = null;
                    try {
                        String fileName = d.getAbsolutePath() + "/server_keys/ServerPrivate.key";
                        RSAEncryptionDescription rsa_obj = new RSAEncryptionDescription();
                        JSONObject js = new JSONObject();
                        enc = rsa_obj.encryptData(data, obj.getKeydetails());
                        js.put("data", enc);
                        enc = new String(Base64.encodeBase64(js.toJSONString().getBytes("UTF8")));
                        replyObj.put("status", "notok");
                      //  replyObj.put("qrcode", "http://qrickit.com/api/qr?d=" + enc + "&addtext=" + data + "&qrsize=250");
                     String path="./img/keys/"+(int)(Math.random()*100000)+".PNG";
                        qr_obj.generate_qrcode(enc,d.getAbsolutePath() +path);
                        replyObj.put("qrcode",path);
                        replyObj.put("secureid",secure_otp_id);
                        
                        out.print(replyObj.toJSONString().trim());
                    } catch (Exception ex) {
                        replyObj.put("status", "exception :" + ex.toString());

                        out.println(replyObj.toJSONString().trim());
                    }
                } else {
                    
                    //   replyObj.put("status", "<script>document.location='dashboard.jsp'</script>");
                    replyObj.put("status", "Your security key is missing.Please use our app to generate your security keys.<br>Please visit our demo page for detailed information");
                    out.println(replyObj.toJSONString().trim());
                }
            } else {

                out.println(replyObj.toJSONString().trim());

            }
        } else {
            replyObj.put("status","<script>document.location='dashboard.jsp'</script>");
            out.print(replyObj.toJSONString().trim());
        }

    } catch (Exception ex) {
        System.out.println("Excn in login : " + ex.toString().trim());
    }
    /*
     int status=RegisterDao.register(obj);  
     if(status>0)  
     out.print("You are successfully registered");  
     */
%>  

