<%@page import="com.sun.xml.ws.runtime.dev.Session"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
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
    Map<String, String> mylogin_list = new HashMap<String, String>();
    JSONArray resu = new JSONArray();
    Set<String> list = new HashSet<String>();
%>
<%    try {
        site_list = site_obj.getSite_list();
        login_list = otp_obj.getLogin_detaills(session.getAttribute("email").toString(), site_obj.getClient_id(session.getAttribute("email").toString()));
//System.out.println("Site_list"+site_list.values().toString()+"\n");
        mylogin_list = mylogin(site_list, login_list, session.getAttribute("email").toString());
    } catch (Exception exc) {
        System.out.print("Excn : " + exc.toString());

    }

%>
<%!    Map mylogin(Map site_list, Map login_list, String email) {
        Map<String, JSONObject> userslogin_list = new HashMap<String, JSONObject>();
        try {
            int i = 0;
            Iterator ir = login_list.values().iterator();
            while (ir.hasNext()) {
                JSONParser parser = new JSONParser();
                JSONObject re = (JSONObject) parser.parse(ir.next().toString());
                // System.out.println("current checkin login : "+re.toJSONString());
                if (re.get("email").toString().compareTo(email) != 0) {
                    continue;
                }
                userslogin_list.put("" + (i++), re);
                //userslogin_list.putAll(re);
            }
        } catch (Exception ex) {
            System.out.println("Excn in userslogin : " + ex.toString());
        }
        return userslogin_list;

    }
%>
<%!
    String distinct_site(Map login_list) throws ParseException {
        if (login_list.values().size() == 0) {
            return "0";
        }
        Iterator ir = login_list.values().iterator();
        //Set<String> list = new HashSet<String>();
        while (ir.hasNext()) {

            JSONParser parser = new JSONParser();
            JSONObject re = (JSONObject) parser.parse(ir.next().toString());

            list.add(re.get("client_id").toString());
        }
        System.out.print(list.toString());
        return "" + list.size();
    }
%>
<%!
    String site_name(Map site_list, String id) throws ParseException {
        // System.out.println("Recvd params in site_name site_list : "+site_list+" id : "+id);
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
        return null;
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




                <div class="row spacer150"></div> 
                <div class="row">

                    <h2 class="text-left"> Hello <%=session.getAttribute("name")%></h2>
                    <div class="row spacer20"></div> 
                    <p>Hope you are having a good time with our services :) Your Sequoro usage is shown below</p>
                    <div class="row spacer20"></div> 
                    <div class="responsive-table">
                        <table id="placement_table" class="table table-striped table-condense table-hover table-bordere text-left verify_table">
                            <tr>
                                <td>Total login attempts </td>
                                <td><%=mylogin_list.size()%></td>
                                <td><a onclick="$('#login_table , #login_title').slideToggle('slow')">View Details</a></td>
                            </tr>

                            <tr>
                                <td>Total Website's accessed</td>
                                <td><%=distinct_site(mylogin_list)%></td>
                                <td><a onclick="$('#site_table , #site_title').slideToggle('slow')">View Details</a></td>
                            </tr>

                        </table>
                    </div>
                    <div class="row spacer100"></div>


                    <div id="site_title" class="col-md-12 text-center">
                        <h2 class="section-title">websites used</h2>         
                    </div>
                    <div class="responsive-table">
                        <table id="site_table" class="table table-striped table-condense  table-hover table-bordere text-left verify_table">
                            <tr>
                                <th>Website's accessed using our Services </th>
                            </tr>
                            <%
                                Iterator ir1 = list.iterator();

                                while (ir1.hasNext()) {

                               //  JSONParser parser = new JSONParser();
                                    //  JSONObject re = (JSONObject) parser.parse(ir.next().toString());

                            %>

                            <tr>

                                <td><%=site_name(site_list, ir1.next().toString())%></td>

                            </tr>

                            <%}%>

                        </table>
                    </div>

                    <div id="login_title" class="col-md-12 text-center">
                        <h2 class="section-title">login details</h2>         
                    </div>
                    <div class="responsive-table">
                        <table id="login_table" class="table table-striped table-condense  table-hover table-bordere text-left verify_table">
                            <tr>
                                <th>Email</th>
                                <th>Website </th>
                                <th>Time</th>
                                <th>Security Level</th>
                            </tr>
                            <%
                                Iterator ir = mylogin_list.values().iterator();

                                while (ir.hasNext()) {

                                    JSONParser parser = new JSONParser();
                                    JSONObject re = (JSONObject) parser.parse(ir.next().toString());


                            %>

                            <tr>
                                <td><%=re.get("email")%></td>
                                <td><%=site_name(site_list, re.get("client_id").toString())%></td>
                                <td><%=re.get("time")%></td>
                                <td><%=re.get("protocol").toString().compareTo("0") == 0 ? "Normal" : "Advanced"%></td>
                            </tr>

                            <%}%>

                        </table>
                    </div>

                </div>
                <div class="row spacer80"></div> 
            </div>
        </section>

        <%@include file="../footer.jsp" %> 
        <script>
            $("#login_table , #login_title , #site_table , #site_title").hide();
        </script>
    </body>
</html>
