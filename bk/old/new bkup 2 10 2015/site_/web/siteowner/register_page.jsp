
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

    <body>
        <%@include file="../nav_default.jsp" %> 
        <section id="demo">
            <div class="container">

                      
                
               
               <h3 class="text-left">Site Owner Registration</h3>
                <div class="row spacer20"></div> 
                <p>Please register to access Sequoro services.If you are a user for for accessing<a href="users_pages/register_page.jsp"> click here</a></p>
                <form id="demo_form" method="POST" role="form" action="javascript:register();" class="form-horizontal form-main">
                    <div class="text-center">
                        <h3 class="text-center">Register Now</h3>         
                    </div> 
                    <div class="form-group">
                        <label for="name_txt">Name</label>
                        <input type="name" required=""  class="form-control disabled" id="name_txt" name="name_txt" placeholder="Enter name">
                    </div>
                    <div class="form-group">
                        <label for="email_txt">Email address</label>
                        <input type="email" required="" class="form-control disabled" id="email_txt" name="email_txt" placeholder="Enter email">
                    </div>
                    <div class="form-group">
                        <label for="pasw_txt">Password</label>
                        <input type="password"  class="form-control disabled" id="pasw_txt" name="pasw_txt" required="" placeholder="Password">
                    </div>
                    <div class="form-group">
                        <label for="cpasw_txt">Confirm Password</label>
                        <input type="password"  class="form-control disabled" id="cpasw_txt" name="cpasw_txt" required="" placeholder="Confirm Password">
                    </div>
                        <div class="spacer20"></div>
                        <div id="result_div"></div>
                         <div class="spacer20"></div>
                        <div class=" text-center">
                        <button  type="submit" class="btn btn-default">Register Now</button>
                        </div>
                    
                   
                </form>
                <div class="row spacer40"></div> 

                <!--                end of demo-->
            </div>
        </section>

        <%@include file="../footer.jsp" %> 

        <script>
            function register(){
               
                if($('#name_txt').val()=="" || $('#name_txt').val().length<3){
                    alert("Name must be greater than 3 characters in length");
                    
                    return false;
                }else if($('#email_txt').val()=="" || $('#email_txt').val().length<6){
                    alert("Email must be greater than 6 characters in length");
                    
                    return false;
                }else if($('#pasw_txt').val()=="" || $('#pasw_txt').val().length<6){
                    alert("Password must be greater than 6 characters in length");
                    return false;
                }else if($('#pasw_txt').val() != $('#cpasw_txt').val()){
                    alert("Password and Confirm PAsswords must match");
                    return false;
                }else{
                    
                     $.ajax({
                        url:"reg.jsp",
                        type:'POST',
                       dataType: 'json',
                        data:{
                            "name_txt" : $("#name_txt").val(),
                            "email_txt" : $("#email_txt").val(),
                            "pasw_txt": $("#pasw_txt").val(),
                            "platform":"1"
                            
                        },
                        success:function(result){
                            var res=result.status;
                            
                               
                            if(res == "Registerd successfully"){
                                $('#name_txt , #email_txt , #pasw_txt ,#cpasw_txt').val('');
                                $('#result_div').html(res + "<br>Automatically redirecting you to login page in 5<script>setTimeout(function (){window.location=(\"./login_page.jsp\");}, 5000);<\/script> seconds or <a href=\"./login_page.jsp\">click here</a>");
                            }
                            else{
                                 $('#result_div').html(res);
                            }
                        }
                   
                    });
                    
                }
                return false;
            }
        </script>
    </body>
</html>
