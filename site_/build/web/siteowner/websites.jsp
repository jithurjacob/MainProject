<%@page import="org.json.simple.parser.ParseException"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@include file="../security_check.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="site_obj"  class="bean.Website" scope="session"/> 
<jsp:useBean id="otp_obj"  class="bean.Otp" scope="session"/> 
<%!
    Map<String, String> site_list = new HashMap<String, String>();
    Map<String, String> login_list = new HashMap<String, String>();
    Map<String, String> userslogin_list = new HashMap<String, String>();
    JSONArray resu = new JSONArray();

%>

<%    try {
        site_list = site_obj.getSite_list(session.getAttribute("email").toString());
        login_list = otp_obj.getLogin_detaills(session.getAttribute("email").toString(), site_obj.getClient_id(session.getAttribute("email").toString()));
        System.out.println("Site_list " + site_list.values().toString() + "\n");
        userslogin_list = userslogin(site_list, login_list);
    } catch (Exception exc) {
        System.out.print("Excn : " + exc.toString());

    }
%>
<%!    Map userslogin(Map site_list, Map login_list)  {
    Map<String, JSONObject> userslogin_list = new HashMap<String, JSONObject>();
    try{
        int i=0;
        Iterator ir = login_list.values().iterator();
        while (ir.hasNext()) {
            JSONParser parser = new JSONParser();
            JSONObject re = (JSONObject) parser.parse(ir.next().toString());
            // System.out.println("current checkin login : "+re.toJSONString());
            if (isNotOwner(site_list, re.get("client_id").toString())) {
                continue;
            }
                 userslogin_list.put("" + (i++), re);
            //userslogin_list.putAll(re);
        }
    }catch(Exception ex){
        System.out.println("Excn in userslogin : "+ex.toString());
    }
        return userslogin_list;

    }
%>
<%!
    String site_name(Map site_list, String id)  {
        try{
        if (id.compareTo("null") == 0) {
            return "Sequoro";
        }
        Iterator ir = site_list.values().iterator();

        while (ir.hasNext()) {

            JSONParser parser = new JSONParser();
            JSONObject re = (JSONObject) parser.parse(ir.next().toString());

            if (re.get("client_id").toString().compareTo(id) == 0) {
                return re.get("site_name").toString();
            }
        }
        }catch(Exception ex){
        System.out.println("Excn in userslogin : "+ex.toString());
    }
        return null;
    }
%>
<%!
    boolean isNotOwner(Map site_list, String client_id) {
        try{
        //System.out.println("Recvd params in isNotOwner site_list : "+site_list+" id : "+client_id);
        if (client_id.compareTo("null") == 0) {
            return true;
        }
        Iterator ir = site_list.values().iterator();

        while (ir.hasNext()) {

            JSONParser parser = new JSONParser();
            JSONObject re = (JSONObject) parser.parse(ir.next().toString());

            if (re.get("client_id").toString().compareTo(client_id) == 0) {
                return false;
            }
        }
        }catch(Exception ex){
        System.out.println("Excn in userslogin : "+ex.toString());
    }
        return true;
    }
%>
<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html class="not-ie" lang="en"> <!--<![endif]-->
    <head>
        <!-- Basic Meta Tags -->
        <meta charset="utf-8">
        <title>Sequoro</title>
        <meta name="description" content="your description">
        <meta name="keywords" content="your keywords">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <%@include file="../css imports.jsp" %> 
    </head>    

    <body class="bg">

        <%@include file="../nav_siteowner.jsp" %> 
        <section id="demo">
            <div class="container">




                <div class="row spacer80"></div> 
                <div class="row">


                    <div class="row spacer80"></div> 
                    <p>Hope you are having a good time with our services :) Your websites with Sequoro usage is shown below</p>
                    <div class="row spacer5"></div> 
                    <h2 class="text-center">You have saved <%=Math.round(userslogin_list.size() * 0.7)%> INR</h2>
                    <div class="row spacer20"></div> 
                    <div class="responsive-table">
                        <table id="placement_table" class="table table-striped table-condense table-hover table-bordere text-left verify_table">
                            <tr>
                                <td>Total websites registered</td>
                                <td><%=site_list.size()%></td>
                                <td><a>View Details</a></td>
                            </tr>
                            <tr>
                                <td>Total login attempts in registered sites</td>
                                <td><%=userslogin_list.size()%></td>
                                <td><a onclick="$('#login_table , #login_title').slideToggle('slow')">View Details</a></td>
                            </tr>


                        </table>
                    </div>
                    <div class="row spacer100"></div>


                    <div id="login_title" class="col-md-12 text-center">
                        <h2 class="section-title">LOgin details</h2>         
                    </div>

                    <div class="responsive-table">
                        <table id="login_table" class="table table-striped table-condense  table-hover table-bordere text-left verify_table">
                            <tr>
                                <th>Email</th>
                                <th>Website</th>
                                <th>Time</th>
                                <th>Security Level</th>
                            </tr>
                            <%
                            try{
                                Iterator ir = userslogin_list.values().iterator();
                                System.out.println("Usersloginlist : "+userslogin_list.toString());
                                while (ir.hasNext()) {
                                    JSONParser parser = new JSONParser();
                                    JSONObject re = (JSONObject) parser.parse(ir.next().toString());
//                               //  System.out.println("current checkin login : "+re.toJSONString());
//                            if(isNotOwner(site_list, re.get("client_id").toString()) )
//                                continue;
%>

                            <tr>
                                <td><%=re.get("email")%></td>
                                <td><%=site_name(site_list, re.get("client_id").toString())%></td>
                                <td><%=re.get("time")%></td>
                                <td><%=re.get("protocol").toString().compareTo("0") == 0 ? "Normal" : "Advanced"%></td>
                            </tr>

                            <%}
                            
                            }catch(Exception ex){
        System.out.println("Excn in table : "+ex.toString());
    }
                            %>

                        </table>
                    </div>

                </div>
            </div></section>
        <section id="registerd_sites">
            <div class="container">
                <div class="row spacer100"></div>
                <div class="row">

                    <div class="col-md-12 text-center">
                        <h2 class="section-title">registerd websites</h2>         
                    </div>
                </div>
                <div class="row spacer20"></div>
                <div class="row">
                    <div class="col-md-12 text-center">
                        <p class="">Sequoro successfully protects your following websites</p>         
                    </div>
                    <div class="row spacer10"></div>
                    <div class="responsive-table">
                        <table id="reg_sitelist_table" class="table table-striped table-condense table-hover table-bordere text-left verify_table">
                            <tr>
                                <th>Website Name</th>
                                <th>Client SecretKey</th>
                                <th>Client ID</th>
                            </tr>
                            <%
                            try{
                                Iterator w = site_list.values().iterator();
                                while (w.hasNext()) {
                                    // for(int i=0;i<site_list.size();i++){
                                    JSONParser parser = new JSONParser();
                                    JSONObject re = (JSONObject) parser.parse(w.next().toString());
                               // re=(JSONObject) resu.get(i);

                            %>
                            <tr>
                                <td><%=re.get("site_name")%></td>
                                <td><%=re.get("client_secretkey")%></td>
                                <td><%=re.get("client_id")%></td>
                            </tr>

                            <%}
                            }catch(Exception ex){
        System.out.println("Excn in table 2 : "+ex.toString());
    }%>
                        </table>
                    </div>
                </div>
            </div>
        </section>
        <section id="add_site">
            <div class="container">
                <div class="row spacer150"></div>
                <div class="row">

                    <div class="col-md-12 text-center">
                        <h2 class="section-title">add website</h2>         
                    </div>
                </div>
                <div class="row spacer20"></div>
                <div class="row">
                    <div class="col-md-12 text-center">
                        <p class="">Add Sequoro protection to your website easily.</p>         
                    </div>
                    <div class="row spacer10"></div>
                    <div id="demo_form_cover">
                        <form id="demo_form" method="POST" role="form" action="javascript:add_site();" class="form-horizontal form-main">

                            <div class="form-group">
                                <label for="site_name">Website Name</label>
                                <input type="text" required=""  class="form-control disabled" id="site_name" name="site_name" placeholder="Enter website name">
                            </div>
                            <div class="form-group">
                                <label for="site_name">Website URL</label>
                                <input type="url" required=""  class="form-control disabled" id="site_url" name="site_url" placeholder="Enter website url">
                            </div>
                            <div class="form-group">
                                <label for="site_name">Redirect URl</label>
                                <input type="url" required=""  class="form-control disabled" id="site_redirecturl" name="site_redirecturl" placeholder="Enter redirectURL">
                            </div>
                            <div class="form-group">
                                <label for="site_logo">Website Logo</label>
                                <div id="image_preview_pic">
                                    <img id="previewing_pic" src="img/noimage.png" />
                                    <img id="previewing_pic_hidden" class="hide" src="img/noimage.png" />
                                </div>
                                <div class="spacer10"></div>
                                <input type="file" required="" class="form-control disabled" id="site_logo" name="site_logo" >
                                <div id="message_pic"> 
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="site_desc">Website Description</label>
                                <textarea  class="form-control " id="site_desc" name="site_desc" required="" placeholder="Website Description that user views"></textarea>                   
                            </div>

                            <div class="spacer20"></div>
                            <div id="result_div_addsite"></div>
                            <div class="spacer20"></div>
                            <div class=" text-center">
                                <button  type="submit" class="btn btn-default">Add Sequoro protection</button>
                            </div>


                        </form>
                    </div>
                </div>
            </div>
        </section>


        <%@include file="../footer.jsp" %> 

        <script>

            $("#login_table , #login_title").hide();
            function add_site() {
                var pic_h = $("#previewing_pic_hidden").prop("height");
                var pic_w = $("#previewing_pic_hidden").prop("width");
                if ($('#site_name').val() == "") {
                    alert("Enter valid site name");
                    return false;
                } else if ($('#site_url').val() == "") {
                    alert("Enter valid site url");
                    return false;
                } else if ($('#site_redirecturl').val() == "") {
                    alert("Enter valid site redirect url");
                    return false;
                } else if ($('#site_logo').val() == "") {
                    alert("Enter valid site logo");
                    return false;
                } else if ($('#site_desc').val() == "") {
                    alert("Enter valid site description");
                    return false;
                } else {

                    $.ajax({
                        url: "siteowner/add_site.jsp",
                        type: 'POST',
                        dataType: 'json',
                        data: {
                            "site_name": $("#site_name").val(),
                            "site_url": $("#site_url").val(),
                            "site_redirecturl": $("#site_redirecturl").val(),
                            "site_logo": $("#previewing_pic").attr("src"),
                            "site_desc": $("#site_desc").val()

                        },
                        success: function (result) {
                            var res = result.status;
                            if (res === "ok") {
                                $("#reg_sitelist_table tr:last").after('<tr><td>' + $("#site_name").val() + '</td><td>' + result.client_secretkey + '</td><td>' + result.client_id + '</td></tr>');
                                $("#site_name,#site_url,#site_redirecturl,#site_logo,#site_desc").val('');
                                $('#previewing_pic').attr('src', 'img/noimage.png');
                                $("#result_div_addsite").html("Site added successfully<br>Client Secret Key : " + result.client_secretkey + "<br>Client ID :" + result.client_id);
                            } else {
                                $("#result_div_addsite").html("Site adding failed... You might have added this site already");

                            }
                        }
                    });

                }
                return false;
            }
        </script>

        <script>///// script to show image preview
            $("#site_logo").change(function () {//alert(0);
                $("#message_logo").empty();         // To remove the previous error message
                var file = this.files[0];
                var imagefile = file.type;
                var match = ["image/jpeg", "image/jpg"];
                if (!((imagefile == match[0]) || (imagefile == match[1])))
                {
                    $('#previewing_pic').attr('src', 'img/noimage.png');
                    $("#message_pic").html("<p id='error'>Please Select A valid Image File</p><span id='error_message'>Only jpeg and jpg Images type allowed</span>");
                    return false;
                }
                else
                {
                    $("#message_pic").html('');
                    var reader = new FileReader();
                    reader.onload = imageIsLoaded_pic;
                    reader.readAsDataURL(this.files[0]);

                }
            });
            function imageIsLoaded_pic(e) { //alert(3);
                $("#pic").css("color", "green");
                $('#image_preview_pic').css("display", "block");
                $('#previewing_pic').attr('src', e.target.result);
                $('#previewing_pic_hidden').attr('src', e.target.result);
                $('#previewing_pic').css('max-width', '250px');
                $('#previewing_pic').css('max-height', '250px');
            }
            ;
        </script>
    </body>
</html>
