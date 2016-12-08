
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.LinkedList"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="org.apache.commons.codec.binary.Hex"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.sun.xml.wss.util.DateUtils"%>
<%@page import="java.sql.Time"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.io.File"%>
<%@page import="crypto.RSAEncryptionDescription"%>
<%@page import="org.json.simple.JSONObject"%>
<jsp:useBean id="obj"  class="bean.User" scope="session"/>  
<jsp:useBean id="qr_obj"  class="bean.QrGen" scope="session"/>  
<jsp:useBean id="otp_obj"  class="bean.Otp" scope="session"/>  
<%

    String email = request.getParameter("email").toString();
    String pasw = request.getParameter("pasw").toString();
    String platform = request.getParameter("platform").toString();
    Timestamp ts_now = new Timestamp(new Date().getTime());
    String now = ts_now.toString();
    String secure_otp_id = DigestUtils.shaHex(now + "$#@#$%^salt");
    String clientid=null;
     if(request.getParameter("clientid")!=null){
            clientid=(String)request.getParameter("clientid");  
      }
%> 
<jsp:setProperty name="otp_obj" property="email" value="<%= email%>" />  
<jsp:setProperty name="otp_obj" property="time" value="<%= now%>" />  
<jsp:setProperty name="otp_obj" property="secure_otp_hash_id" value="<%= secure_otp_id%>" />  
<jsp:setProperty name="obj" property="email" value="<%= email%>" />  
<jsp:setProperty name="obj" property="pasw" value="<%= pasw%>" />  
<%! JSONObject matrixObj = new JSONObject();%>

<%
    try {
        JSONObject replyObj = new JSONObject();
        // out.print(obj.getEmail());
        replyObj = obj.check_login();
        response.setContentType("application/json");
        JSONObject js = new JSONObject();
           File d = new File(application.getRealPath("/"));
        if (replyObj.get("status").toString().compareTo("ok") == 0) {
            session.setAttribute("email", email);
            
            if (platform.compareTo("1") == 0 || platform.compareTo("3") == 0) {/////// website user  genrte qrcode

                if (obj.allok() == true) {
                     out.print( qr_obj.generate_qrcode(platform,obj.getProtocol(),otp_obj,obj,d,1,clientid));
                   
                } else {
                    if (obj.getVerified() == 0) {
                        replyObj.put("status", "Please verify your  mail");
                    } else {
                        replyObj.put("status", "Your security key is missing.Please use our app to generate your security keys.<br><br>If you have already uploaded key and wish to add a new one you have to reset the app data.<br><br>Please visit our demo page for detailed information");
                    }
                    out.println(replyObj.toJSONString().trim());
                }
            } else {//////simply o/p login() usd for logging from app

                out.println(replyObj.toJSONString().trim());

            }
        } else {

            out.print(replyObj.toJSONString().trim());
        }

    } catch (Exception ex) {
        out.print("Excn in login : " + ex.toString().trim());
    }
    /*
     int status=RegisterDao.register(obj);  
     if(status>0)  
     out.print("You are successfully registered");  
     */
%>  

