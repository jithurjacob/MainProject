
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
        <%@include file="css imports.jsp" %> 
    </head>

    <body>
        <%@include file="nav_default.jsp" %> 
        <section id="demo">
            <div class="container">

                      
                
               
                <div class="row spacer30"></div> 
                <div class="row">
                    <form id="demo_form" role="form" action="javascript:login_primary();" class="form-horizontal form-main">
                        <div class="text-center">
                            <h3 class="text-center">Login </h3>         
                        </div> 

                        <div class="form-group" >
                            <label for="email">Email address</label>
                            <input type="email" class="form-control" id="email" placeholder="Enter email">
                        </div>
                        <div class="form-group">
                            <label for="pwd">Password</label>
                            <input type="password" class="form-control" id="pwd" placeholder="Password">
                        </div>

                        <div class="checkbox">
                            <label>
                                <input type="checkbox"> Remember Me
                            </label>
                        </div>
                        <div class="form-group qr text-center" id="qr_div">
                            <img id="qr">
                            <div id="qr_secureid" class="hidden"></div>
                        </div>
                        <div class="form-group" id="otp_div">
                            <label for="otp">OTP</label>
                            <input type="password" class="form-control" id="otp"  placeholder="OTP">
                        </div>
                        <div class="spacer20"></div>
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

                <div class="row spacer40"></div> 

                <!--                end of demo-->
            </div>
        </section>

        <%@include file="footer.jsp" %> 

        <script>
            function login_primary(){
                
                if($('#email').val()=="" || $('#email').val().length<6){
                    alert("Email must be greater than 6 characters in length");
                    
                    return false;
                }else if($('#pwd').val()=="" || $('#pwd').val().length<6){
                    alert("Password must be greater than 6 characters in length");
                    return false;
                }else{
                    
                     $.ajax({
                        url:"login.jsp",
                        type:'POST',
                       dataType: 'json',
                        data:{
                            "email" : $("#email").val(),
                            "pasw": $("#pwd").val(),
                            "platform":"1"
                            
                        },
                        success:function(result){
                            var res=result.status;
                            if(res === "ok" ){
                                $('#pwd,#email').prop("disabled","disabled"); 
                            $('#qr_div,#otp_div').show();
                            $("#qr").prop("src",result.qrcode);
                            $("#qr_secureid").val(result.secureid);
                            $("#demo_form").prop("action","javascript:login_secondary();");
                            }else{
                                $('#result_div').html(res);
                            }
                            
                        }
                   
                    });
                    
                }
                return false;
            }
            
             function login_secondary(){
                
                if($('#otp').val()==""){
                    alert("OTP must be entered");
                    
                    return false;
                
                }else{
                    
                     $.ajax({
                        url:"login_twostep.jsp",
                        type:'POST',
                       dataType: 'json',
                        data:{
                            "email" : $("#email").val(),
                            "pasw": $("#pwd").val(),
                            "otp": $("#otp").val(),
                             "secureid": $("#qr_secureid").val(),
                            "platform":"1"
                            
                        },
                        success:function(result){
                            var res=result.status;
                            if(res=="notok"){
                                $("#otp").val('');
                                $("#qr").prop("src",result.qrcode);
                                $("#qr_secureid").val(result.secureid);
                                $('#result_div').html("Invalid OTP<br> New OTP has been generated please scan again");
                            }else
                            $('#result_div').html(res);
                        }
                   
                    });
                    
                }
                return false;
            }
        </script>
    </body>
</html>
