<%@include file="../security_check.jsp" %>
<jsp:useBean id="obj"  class="bean.User" scope="session"/>  

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <%@include file="../nav _login.jsp" %> 
        <section id="demo">
            <div class="container">




                <div class="row spacer30"></div> 
                <div class="row">


                    <div class="row spacer20"></div> 
                    <div class="responsive-table" id="demo_form_cover">
                        <form id="demo_form" role="form" action="javascript:change_level();" class="form-horizontal form-main">
                            <div class="row spacer20"></div> 
                            <div class="text-center">
                                <h3 class="text-center">Change Password</h3>         
                            </div> 

                            <div class="form-group">
                                <Label for="oldpasw_txt"> Enter Old Password</Label>

                                <input id="oldpasw_txt" class="form-control disabled" type="text" name="oldpasw_txt" placeholder="Enter Old Password" required="required">
                            </div>
                            <div class="form-group">
                                <Label for="oldpasw_txt"> Enter New Password</Label>

                                <input id="newpasw_txt" class="form-control disabled" type="text" name="newpasw_txt" placeholder="Enter New Password" required="required">
                            </div>
                            <div class="form-group">
                                <Label for="oldpasw_txt"> Re Enter New Password</Label>

                                <input id="repasw_txt" class="form-control disabled" type="text" name="repasw_txt" placeholder="Re Enter Password" required="required">
                            </div>
                            <div>
                                <div id="result_txt">

                                </div>
                            </div>
                            <div class="spacer20"></div>
                            <div class=" text-center">
                                <input id="Change" class="btn btn-default" type="submit" value="Change Now">  
                            </div>

                        </form>
                        
                    </div>
                </div>
            </div></section>

        <%@include file="../footer.jsp" %> 
        <script>
            function change_password() {
                $.ajax({
                    url: "./changepasw.jsp",
                    type: 'POST',
                    data: {
                        oldpasw: $('#oldpasw_txt').val(),
                        repasw: $('#repasw_txt').val(),
                        newpasw: $('#newpasw_txt').val(),
                    },
                    success: function (result) {
                        $('#result_txt').html(result);
                        $("#oldpasw_txt,#repasw_txt,#newpasw_txt").val('');
                    }

                });
            }
        </script>
    </body>
</html>
