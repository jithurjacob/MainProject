<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="javax.crypto.spec.SecretKeySpec"%>
<%@page import="javax.crypto.Mac"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%! String client_id,original_client_id, redirect_url,original_redirect_url,nonce,clientsecret;Timestamp time;Boolean valid=true; %>

<%
    client_id = (String) request.getParameter("clientid");
    redirect_url = (String) request.getParameter("redirecturl");
   // nonce =URLDecoder.decode( (String) request.getParameter("nonce"),"UTF-8");
    nonce=(String) request.getParameter("nonce");
    System.out.println("Recvd nonce : "+nonce);
    time = Timestamp.valueOf( request.getParameter("time"));
    Timestamp ts_now = new Timestamp(new Date().getTime());
    
    System.out.println("diff : "+(((ts_now.getTime()-time.getTime())/1000)/60));
    if((((ts_now.getTime()-time.getTime())/1000)/60)>5)
        valid=false;
    
       
    
%>
<jsp:useBean id="website_obj"  class="bean.Website" scope="session"/> 
<jsp:setProperty name="website_obj" property="site_redirecturl" value="<%= redirect_url%>" /> 
<jsp:setProperty name="website_obj" property="client_id" value="<%=client_id%>" />
<%
 clientsecret= website_obj.getSite_details(website_obj.getClient_id()).get("client_secretkey").toString();
 original_client_id= website_obj.getSite_details(website_obj.getClient_id()).get("client_id").toString();
 original_redirect_url= website_obj.getSite_details(website_obj.getClient_id()).get("site_redirecturl").toString();
%>
<%!
 boolean verifyNonce() throws UnsupportedEncodingException{
     String requestUrl="http://localhost:8080/site/api/login_api.jsp?clientid=" + this.original_client_id+ "&redirecturl=" + this.original_redirect_url + "&time=" + time;
     System.out.println("expected req url:"+requestUrl);
     System.out.println("recvd nonce : "+nonce+" computed : "+HMACSHA256(requestUrl, this.clientsecret));
     return this.nonce.compareTo(HMACSHA256(requestUrl, this.clientsecret))==0;
}
%>
<%!
 private String HMACSHA256(String message,String secret) throws UnsupportedEncodingException {
        String hash = null;
        try {
            

            Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
            SecretKeySpec secret_key = new SecretKeySpec(secret.getBytes(), "HmacSHA256");
            sha256_HMAC.init(secret_key);

            hash = new String(Base64.encodeBase64(sha256_HMAC.doFinal(message.getBytes())));

        } catch (Exception e) {
            System.out.println("Excn hmac :" + e.toString());
        }
        return hash;
        //return URLEncoder.encode(hash,"UTF-8");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sequoro API</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <base href="http://localhost:8080/site/" >
        <%@include file="../css imports.jsp" %> 
    </head>
    <body class="bg api">
        <section id="demo" style="padding: 10px">
            <div class="container">




                <div class="row spacer10"></div> 
                <div class="row">
                    <div class="text-center">
                        <h2 class="text-center">Sequoro</h2>         
                    </div> 
                </div>


                <%
                System.out.print(website_obj.isValidRequest()+""+valid+""+verifyNonce());
                    if (website_obj.isValidRequest() && valid && verifyNonce()) {

                %>
                <div id="page1">
                    <div class="row spacer5"></div> 

                    <div class="row">
                        <h4> You are about to grant access privilege to this site</h4>
                        <div class="row spacer50"></div> 

                        <h2 class="text-center "><img class="text-left" style="width:100px;height: 100px;border-radius: 50%;display: inline " src="<% String logo = website_obj.getSite_details(website_obj.getClient_id()).get("site_logo").toString();
                            logo = logo.substring(logo.lastIndexOf("img/sitelogos/"));
                            out.print(logo);%>">
                            <%= website_obj.getSite_details(website_obj.getClient_id()).get("site_name")%></h2> 

                        <%=website_obj.getSite_details(website_obj.getClient_id()).get("site_desc")%>
                        <div class="row spacer30"></div> 
                        
                        <div class="text-center">

                            <button type="button" class="example4demo btn btn-default text-center"  onclick="$('#page1').fadeOut();
                                        $('#demo_form_cover').fadeIn();">Accept</button>

                            <button type="button" class="example4demo btn btn-default text-center"  result="reject" onclick="CloseMySelf(this);">Reject</button>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div id="demo_form_cover" style="display: none">   
                    <form id="demo_form" role="form" action="javascript:login_primary();"  class="form-horizontal form-main">
                        <div class="form-group" id="name_div" >
                        </div>
                        <div class="form-group" id="email_div" >
                            <label for="email">Email address</label>
                            <input type="email" class="form-control" id="email" placeholder="Enter email">
                        </div>
                        <div class="form-group" id="pwd_div">
                            <label for="pwd">Password</label>
                            <input type="password" class="form-control" id="pwd" placeholder="Password">
                        </div>


                        <div class="form-group qr text-center" id="qr_div">
                            <img id="qr">

                            <div id="qr_secureid" class="hidden"></div>



                            <div class=" text-center">
                                <table id="matrix" class=" text-center">
                                    <tr>
                                        <td><div class="key" data="0"></div></td>
                                        <td><div class="key" data="1"></div></td>
                                        <td><div class="key" data="2"></div></td>
                                        <td><div class="key" data="3"></div></td>
                                        <td><div class="key" data="4"></div></td>
                                    </tr>
                                    <tr>
                                        <td><div class="key" data="5"></div></td>
                                        <td><div  class="key" data="6"></div></td>
                                        <td><div class="key" data="7"></div></td>
                                        <td><div class="key" data="8"></div></td>
                                        <td><div class="key" data="9"></div></td>
                                    </tr>
                                    <tr>
                                        <td><div class="key" data="10"></div></td>
                                        <td><div class="key" data="11"></div></td>
                                        <td><div class="key" data="12"></div></td>
                                        <td><div class="key" data="13"></div></td>
                                        <td><div class="key" data="14"></div></td>
                                    </tr>
                                    <tr>
                                        <td><div class="key" data="15"></div></td>
                                        <td><div class="key" data="16"></div></td>
                                        <td><div class="key" data="17"></div></td>
                                        <td><div class="key" data="18"></div></td>
                                        <td><div class="key" data="19"></div></td>
                                    </tr>
                                    <tr>
                                        <td><div  class="key" data="20"></div></td>
                                        <td><div class="key" data="21"></div></td>
                                        <td><div class="key" data="22"></div></td>
                                        <td><div  class="key" data="23"></div></td>
                                        <td><div class="key" data="24"></div></td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                        <div class="form-group" id="otp_div">
                            <label for="otp">OTP</label>
                            <input type="password" class="form-control" id="otp"  placeholder="OTP">
                        </div>

                        <div id="result_div"></div>
                        <div class="spacer20"></div>
                        <div class=" text-center">
                            <button  type="submit" class="btn btn-default">Submit</button>
                        </div>
                        <div class="row spacer20"></div> 
                        <div>

                        </div>

                    </form>
                </div>
                </div>
                    <%} else {%>
                    <div class="row spacer100"></div>  <div class="row spacer100"></div>  <div class="row spacer100"></div> 
                    <div class="text-center">
                        <h3 class="text-center"><%    out.print("Invalid Request");%></h3>         
                    </div>  
                    <div class=" text-center">
                        <button type="button" class="example4demo btn btn-default" result="invalid" onclick="CloseMySelf(this);">Close</button>
                    </div>
                
                <%
                    }%>

            </div>
        </section>
        <script src="js/jquery.js"></script>  
        <script src="js/bootstrap.min.js"></script>   
        <script>

                            function CloseMySelf(sender) {

                                try {
                                    window.opener.document.body.style.backgroundColor = "grren";
                                    window.opener.HandlePopupResult(sender.getAttribute("result"));

                                }
                                catch (err) {
                                }
                                setConfirmUnload(false);
                                window.close();
                                return false;
                            }

                            // Prevent accidental navigation away
                            $(':input').bind(
                                    'change', function () {
                                        setConfirmUnload(true);
                                    });
                            $('.noprompt-required').click(
                                    function () {
                                        setConfirmUnload(false);
                                    });

                            function setConfirmUnload(on)
                            {
                                window.onbeforeunload = on ? unloadMessage : null;
                            }
                            function unloadMessage()
                            {
                                return(
                                        'If you navigate away from this page ' +
                                        'you will not be logged in to this page.');

                            }

                            window.onerror = UnspecifiedErrorHandler;
                            function UnspecifiedErrorHandler()
                            {
                                return true;
                            }


                            setConfirmUnload(true);
        </script>

        <script>

            $('div.key').click(function () {

                $("#otp").val($("#otp").val() + $(this).attr('data') + ";");
            });
            function login_primary() {

                if ($('#email').val() == "" || $('#email').val().length < 6) {
                    alert("Email must be greater than 6 characters in length");

                    return false;
                } else if ($('#pwd').val() == "" || $('#pwd').val().length < 6) {
                    alert("Password must be greater than 6 characters in length");
                    return false;
                } else {

                    $.ajax({
                        url: "login.jsp",
                        type: 'POST',
                        dataType: 'json',
                        data: {
                            "email": $("#email").val(),
                            "pasw": $("#pwd").val(),
                            "platform": "3"

                        },
                        success: function (result) {
                            var res = result.status;
                            if (res === "ok") {
                                $('#name_div').html("Hi " + result.name + ", scan your QR Code");
                                $('#pwd,#email').prop("disabled", "disabled");
                                $('#qr_div,#otp_div,#name_div').show();
                                $("#qr").prop("src", result.qrcode);
                                $("#qr_secureid").val(result.secureid);
                                $("#demo_form").prop("action", "javascript:login_secondary();");
                                $('#result_div').html('');
                                $("#email_div,#pwd_div,#remember_div").hide();
                                if (result.protocol == 0)
                                    $("#matrix").hide();
                                else
                                    $("#matrix").show();
                            } else {
                                $('#result_div').html(res);
                            }

                        }

                    });

                }
                return false;
            }

            function login_secondary() {

                if ($('#otp').val() == "") {
                    alert("OTP must be entered");

                    return false;

                } else {

                    $.ajax({
                        url: "login_twostep.jsp",
                        type: 'POST',
                        dataType: 'json',
                        data: {
                            "email": $("#email").val(),
                            "pasw": $("#pwd").val(),
                            "otp": $("#otp").val(),
                            "secureid": $("#qr_secureid").val(),
                            "platform": "3"

                        },
                        success: function (result) {
                            var res = result.status;
                            if (res == "notok") {
                                $("#otp").val('');
                                $("#qr").prop("src", result.qrcode);

                                $("#qr_secureid").val(result.secureid);
                                if (result.protocol == 0)
                                    $("#matrix").hide();
                                else
                                    $("#matrix").show();
                                $('#result_div').html("Invalid OTP<br> New OTP has been generated please scan again");
                            } else
                                $('#result_div').html(res);
                        }

                    });

                }
                return false;
            }
        </script>
    </body>
</html>