package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import org.apache.commons.codec.binary.Base64;
import java.security.spec.RSAPublicKeySpec;
import java.security.PublicKey;
import java.security.KeyFactory;
import org.json.simple.parser.JSONParser;
import crypto.*;
import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;
import java.security.MessageDigest;
import java.io.BufferedOutputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.io.IOException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Enumeration;
import java.io.File;
import org.json.simple.*;

public final class randomtest_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

String enc=null;
String data=null;
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
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
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
      out.write(' ');
      out.write('\n');
      out.write('\n');
      out.write('\n');

  String key=null,hash=null;
    String email= request.getParameter("email").toString(),fileName=null;// = request.getParameter("email").toString();

      out.write(' ');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.handleSetProperty(_jspx_page_context.findAttribute("obj"), "email",
 email );
      out.write("  \n");
      out.write("\n");


 File d = new File(application.getRealPath("/"));
     data = ""+(int)(Math.random()*10000);
    try {
        fileName = d.getAbsolutePath() + "/server_keys/ServerPrivate.key";
       RSAEncryptionDescription rsa_obj = new RSAEncryptionDescription();
       JSONObject js=new JSONObject();
     enc=rsa_obj.encryptData(data, obj.getKeydetails());
    js.put("data",enc );
    enc=new String(Base64.encodeBase64(js.toJSONString().getBytes("UTF8")));
    //   out.print(js.toJSONString());
      
    } catch (Exception ex) {
        out.println("excn : " + ex.toString());
    }

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Test</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <img src=\"http://qrickit.com/api/qr?d=");
      out.print(enc);
      out.write("&addtext=");
      out.print(data);
      out.write("&qrsize=250\">\n");
      out.write("    </body>\n");
      out.write("</html>\n");
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
