package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
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

public final class check_005fenc_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

      File d = new File(application.getRealPath("/"));
   // MultipartRequest a = new MultipartRequest(request, d.getAbsolutePath() + "/");
    String data = request.getParameter("data").toString();
   //   String key = request.getParameter("key").toString();
    try {
        String fileName = d.getAbsolutePath() + "/server_keys/ServerPrivate.key";
       

        RSAEncryptionDescription rsa_obj = new RSAEncryptionDescription();
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
    PublicKey publicKey=rsa_obj.readPublicKeyFromFile(fileName);
    RSAPublicKeySpec rsaPubKeySpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
    JSONObject js=new JSONObject();
    js.put("Modulus", rsaPubKeySpec.getModulus().toString());
    js.put("Exponent",rsaPubKeySpec.getPublicExponent().toString());
       out.print("data : "+rsa_obj.decryptData(data.getBytes(), fileName)+"\n key used : "+js.toJSONString()+"\nrecvd key : " );
      
    } catch (Exception ex) {
        out.println("excn : " + ex.toString());
    }
    

      out.write(' ');
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
