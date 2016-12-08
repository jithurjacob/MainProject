
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
        if (replyObj.get("status").toString().compareTo("ok") == 0) {
            session.setAttribute("email", email);
            if (platform.compareTo("1") == 0 || platform.compareTo("3") == 0 ) {/////// website user  genrte qrcode

                if (obj.allok() == true) {

                    File d = new File(application.getRealPath("/"));
                    String data = null;
                   // out.println("prptocol : "+obj.getProtocol());
                    if (obj.getProtocol() == 0) {
                        replyObj.put("protocol", "0");
                        js.put("protocol", "0");
                        int num = 0;
                        while (num < 1000 || num > 10000) {
                            num = (int) (Math.random() * 10000);
                        }
                        data = "" + num;

                    } else {
                        replyObj.put("protocol", "1");
js.put("protocol", "1");
                        LinkedList ll = new LinkedList();
                        ll.add(new Integer(0));
                        ll.add(new Integer(1));
                        ll.add(new Integer(2));
                        ll.add(new Integer(3));
                        ll.add(new Integer(4));
                        ll.add(new Integer(5));
                        ll.add(new Integer(6));
                        ll.add(new Integer(7));
                        ll.add(new Integer(8));
                        ll.add(new Integer(9));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                        ll.add(new Integer(-1));
                     

                        Collections.shuffle(ll);
                        int i = 0;
                        Iterator li = ll.iterator();
                        while (li.hasNext()) {
                            matrixObj.put(i++, li.next());
                        }

                        data = matrixObj.toJSONString();//new String(Base64.encodeBase64(matrixObj.toJSONString().getBytes("UTF8")));
                    }

                    try {
                        otp_obj.setOtp_hash(data);
                        
                        otp_obj.insert(obj.getProtocol());

                    } catch (Exception ex) {
                        System.out.println("Excn in entering otp :" + ex.toString());
                    }

                    String enc = null;
                    try {

                        String fileName = d.getAbsolutePath() + "/server_keys/ServerPrivate.key";
                        RSAEncryptionDescription rsa_obj = new RSAEncryptionDescription();

                        enc = rsa_obj.encryptData(data, obj.getKeydetails());
                        js.put("data", enc);
                        enc = new String(Base64.encodeBase64(js.toJSONString().getBytes("UTF8")));
                        replyObj.put("status", "ok");
                        //  replyObj.put("qrcode", "http://qrickit.com/api/qr?d=" + enc + "&addtext=" + data + "&qrsize=250");
                        String path = "./img/keys/" + (int) (Math.random() * 100000) + ".PNG";
                        qr_obj.generate_qrcode(enc, d.getAbsolutePath() + path);
                        replyObj.put("name",obj.getName(email));
                        replyObj.put("qrcode", path);
                        replyObj.put("secureid", secure_otp_id);
                        out.print(replyObj.toJSONString().trim());
                    } catch (Exception ex) {
                        replyObj.put("status", "exception :" + ex.toString());

                        out.println(replyObj.toJSONString().trim());
                    }
                } else {
                    if (obj.getVerified() == 0) {
                        replyObj.put("status", "Please verify your  mail");
                    } else {
                        replyObj.put("status", "Your security key is missing.Please use our app to generate your security keys.<br>Please visit our demo page for detailed information");
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

