package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import crypto.RSAEncryptionDescription;
import java.io.File;
import java.security.spec.RSAPublicKeySpec;
import java.security.PublicKey;
import java.security.KeyFactory;
import org.json.simple.JSONObject;

public final class keycheck_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
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
    String hash = request.getParameter("hash").toString();
    String platform = request.getParameter("platform").toString();

      out.write(" \n");
      out.write("\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.handleSetProperty(_jspx_page_context.findAttribute("obj"), "email",
 email );
      out.write("  \n");
      out.write("\n");
      out.write("  \n");
      out.write("    \n");
  
    try{
        
            File d = new File(application.getRealPath("/"));
         
         String filepath1=d.getAbsolutePath() + "/server_keys/ServerPublic.key";
    System.out.println("filepath : " + filepath1);
    RSAEncryptionDescription robj = new RSAEncryptionDescription();
    KeyFactory keyFactory = KeyFactory.getInstance("RSA");
    PublicKey publicKey=robj.readPublicKeyFromFile(filepath1);
    RSAPublicKeySpec rsaPubKeySpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
    JSONObject jo=new JSONObject();
    jo=obj.check_key(hash);
    jo.put("Modulus", rsaPubKeySpec.getModulus().toString());
    jo.put("Exponent",rsaPubKeySpec.getPublicExponent().toString());
    
         response.setContentType("application/json");
        out.print(jo);
             
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
