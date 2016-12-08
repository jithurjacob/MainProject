


<jsp:useBean id="obj"  class="bean.User" scope="session"/>  
<%
    String email= (String)session.getAttribute("email");
    String oldpasw = (String) request.getParameter("oldpasw");
    String repasw = (String) request.getParameter("repasw");
    String newpasw = (String)request.getParameter("newpasw");
%>
<jsp:setProperty property="email" value="<%= email %>" name="obj"/>
<%
    try{
        if(newpasw.compareTo(repasw)!=0){
                out.print("New password and reentrd doesnot match");
        }else{
    String reply=obj.check_password(oldpasw);
    
    if(reply.compareTo("ok")==0)
    {
        out.print(obj.change_password(newpasw));
        
    }else{
        out.print("Wrong Password");
    }
        }
    }catch(Exception ex){
        System.out.println("Exception found : "+ex);
    }
    %>