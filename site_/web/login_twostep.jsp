<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
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
<jsp:useBean id="api_obj"  class="bean.api" scope="session"/>  
<%
    
    String email = request.getParameter("email").toString();
    String secureid = request.getParameter("secureid").toString();
    String pasw = request.getParameter("pasw").toString();
    String otp = request.getParameter("otp").toString();
    String platform = request.getParameter("platform").toString();
    Timestamp ts_now = new Timestamp(new Date().getTime());
        String now = ts_now.toString();
String clientid=null,state=null;
 if(request.getParameter("state")!=null){
            
             state = request.getParameter("state").toString();
      }
     if(request.getParameter("clientid")!=null){
            clientid=(String)request.getParameter("clientid"); 
           
      }
%> 

<jsp:setProperty name="otp_obj" property="email" value="<%= email%>" />  
<jsp:setProperty name="otp_obj" property="otp_hash" value="<%= otp%>" />  
<jsp:setProperty name="otp_obj" property="secure_otp_hash_id" value="<%= secureid%>" />
<jsp:setProperty name="otp_obj" property="time" value="<%= now%>" />  
<jsp:setProperty name="obj" property="email" value="<%= email%>" />  
<jsp:setProperty name="obj" property="pasw" value="<%= pasw%>" /> 
<%! JSONObject matrixObj = new JSONObject();%>
<%
    try {
        JSONObject replyObj = new JSONObject();
        // out.print(obj.getEmail());
        obj.check_login();
        replyObj = otp_obj.check_login();
        JSONObject js = new JSONObject();
        File d = new File(application.getRealPath("/"));
        response.setContentType("application/json");
        if (replyObj.get("status").toString().compareTo("ok") != 0) {
            session.setAttribute("email", email);
            session.setAttribute("name", obj.getName(email));
            System.out.println("NAME!!!!");
            System.out.println(obj.getName(email));
            if (platform.compareTo("1") == 0 || platform.compareTo("3") == 0) {

                if (obj.allok() == true) {

                  out.print( qr_obj.generate_qrcode(platform,obj.getProtocol(),otp_obj,obj,d,2,clientid));
                   
                } else {

                    //   replyObj.put("status", "<script>document.location='dashboard.jsp'</script>");
                    replyObj.put("status", "Your security key is missing.Please use our app to generate your security keys.<br>Please visit our demo page for detailed information");
                    out.println(replyObj.toJSONString().trim());
                }
            } else {

                out.println(replyObj.toJSONString().trim());

            }
        } else {
            if (platform.compareTo("3") == 0) {//////////// API
               // replyObj.put("name", obj.getName(email));
               // replyObj.put("email", email);
               
                otp_obj.setAccesscode(api_obj.getAccesscode(state));
                replyObj.put("requestcode",api_obj.getRequestcode(state));
            } else {
                session.setAttribute("email", email);
                session.setAttribute("name", obj.getName(email));
                if (obj.getIsSiteOwner(email) == 0) {
                    replyObj.put("status", "<script>document.location='users_pages/dashboard.jsp'</script>");
                } else {
                    replyObj.put("status", "<script>document.location='siteowner/dashboard.jsp'</script>");
                }
            }
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

