package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.json.simple.JSONObject;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write(" \n");
      out.write("  \n");
      bean.User obj = null;
      synchronized (session) {
        obj = (bean.User) _jspx_page_context.getAttribute("obj", PageContext.SESSION_SCOPE);
        if (obj == null){
          obj = new bean.User();
          _jspx_page_context.setAttribute("obj", obj, PageContext.SESSION_SCOPE);
        }
      }
      out.write("  \n");

    
    String email = request.getParameter("email").toString();
    String pasw =  request.getParameter("pasw").toString();
    String platform = request.getParameter("platform").toString();

      out.write(" \n");
      out.write("\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.handleSetProperty(_jspx_page_context.findAttribute("obj"), "email",
 email );
      out.write("  \n");
      org.apache.jasper.runtime.JspRuntimeLibrary.handleSetProperty(_jspx_page_context.findAttribute("obj"), "pasw",
 pasw );
      out.write("  \n");
      out.write("  \n");
      out.write("    \n");
  
    try{
        JSONObject replyObj=new JSONObject();
        //out.print(obj.getEmail());
         replyObj=obj.check_login();
         response.setContentType("application/json");
        if(replyObj.get("status").toString().compareTo("ok")==0){
             session.setAttribute("email", email);
             if(platform.compareTo("1")==0){
             replyObj.put("status","<script>document.location='dashboard.jsp'</script>");
             out.print(replyObj);
             }else{
             
             out.print(replyObj);
             }
        }else{
            
            out.print(replyObj);
        }
    
    }catch(Exception ex){
    System.out.print(ex);
    }
    /*
int status=RegisterDao.register(obj);  
if(status>0)  
out.print("You are successfully registered");  
  */

      out.write("  \n");
      out.write("\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
