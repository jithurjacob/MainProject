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
        
        <%@include file="../nav_siteowner.jsp" %> 
        <section id="demo">
            <div class="container">

                      
                
               
                <div class="row spacer30"></div> 
                <div class="row">
        
      
                 <div class="row spacer130"></div> 
                 <div class="responsive-table" id="demo_form_cover">
                     <form id="demo_form" role="form" action="javascript:change_level();" class="form-horizontal form-main">
                       <div class="row spacer20"></div> 
                         <table id="placement_table" class="table table-striped table-condense table-hover table-bordere text-left verify_table">
                            <tr>
                              <td>Choose Security level </td>
                            
                              <td>
                                  <input type="radio" name="protocol" onchange="javascript:$('#second_pwd').css('display','none');" value="0" <% if(obj.getProtocol(session.getAttribute("email").toString())==0){%>checked="checked"<%}%>>Normal<br>
                                  <input type="radio" name="protocol" onchange="javascript:$('#second_pwd').css('display','block');" value="1" <% if(obj.getProtocol(session.getAttribute("email").toString())==1){%>checked="checked"<%}%>>Expert<br>
                              </td>
                            </tr>
                                    <tr><td colspan="2">
                                            <input type="number" style="display: none" id="second_pwd" value="0" class="form-control" placeholder="Select Secondary Password" >
                                            <div id="result_div"></div>
                                </td></tr>
                            <tr>
                                <td colspan="2"> <div class=" text-center">
                        <button  type="submit" class="btn btn-default">Submit</button>
                        </div></td>
                            </tr>
                            
                            
                            </table>
                     </form>
                            </div>
                </div>
            </div></section>
        <div class="spacer60"></div>
        <%@include file="../footer.jsp" %> 
         <script>
            function change_level(){
                
                    if( $('input[name=protocol]:checked').val()=="1" && ($("#second_pwd").val()=="" || $("#second_pwd").val().length<6 )){
                        alert("Enter a secondary password of mininumum length 6");
                    }else
                    
                     $.ajax({
                        url:"./change_protocol.jsp",
                        type:'POST',
                        dataType: 'json',
                        data:{
                            "protocol" : $('input[name=protocol]:checked').val(),
                            "pwd":$('#second_pwd').val()
                        },
                        success:function(result){
                            var res=result.status;
                           
                                $('#result_div').html(res);
                            
                            
                        }
                   
                    });
                    
               
            }
           
         </script>
    </body>
</html>
