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
import com.oreilly.servlet.MultipartRequest;
import org.json.simple.*;

public final class keyupload_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

RSAEncryptionDescription rsa_obj = new RSAEncryptionDescription();
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
      out.write("  \n");

  String key=null,hash=null;
    String email=null,fileName=null;// = request.getParameter("email").toString();

      out.write(" \n");
      out.write("\n");
      out.write('\n');


    File d = new File(application.getRealPath("/"));
    MultipartRequest a = new MultipartRequest(request, d.getAbsolutePath() + "/");
//out.println("mail : "+a.getParameter("email"));
  //  out.println("hash : " + a.getParameter("hash"));
//out.println("plat : "+a.getParameter("platform"));
//out.println("key : "+a.getParameter("key"));
    try {
        fileName = d.getAbsolutePath() + "/keys/" + a.getParameter("email").toString() + (Math.random() * 10000) + ".key";
        key = a.getParameter("key").toString();
         email = a.getParameter("email").toString();
        hash = a.getParameter("hash").toString();
//out.print(d.getAbsolutePath()+"/keys/1.key");
        //out.println(fileName);
        JSONParser parser = new JSONParser();
        //out.print("Received key : " + key);
        Object obj1 = parser.parse(key);
        JSONObject array = (JSONObject) obj1;

        
        BigInteger mod = new BigInteger(array.get("Modulus").toString());
        BigInteger exp = new BigInteger(array.get("Exponent").toString());
        rsa_obj.saveKeys(fileName, mod, exp);
        md5 mobj = new md5();
     //   out.print("hash : " + mobj.getMD5EncryptedString(fileName));
    } catch (Exception ex) {
        out.println("excn : " + ex.toString());
    }
    

      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.handleSetProperty(_jspx_page_context.findAttribute("obj"), "email",
 email );
      out.write("  \n");
      org.apache.jasper.runtime.JspRuntimeLibrary.handleSetProperty(_jspx_page_context.findAttribute("obj"), "public_key",
 fileName );
      out.write("  \n");
      org.apache.jasper.runtime.JspRuntimeLibrary.handleSetProperty(_jspx_page_context.findAttribute("obj"), "keyhash",
 hash );
      out.write("  \n");

try{
JSONObject jo=new JSONObject();
if(obj.setKeydetails().compareTo("ok")==0){
    
    String filepath1=d.getAbsolutePath() + "/server_keys/ServerPublic.key";
    System.out.println("filepath : " + filepath1);
    
    KeyFactory keyFactory = KeyFactory.getInstance("RSA");
    PublicKey publicKey=rsa_obj.readPublicKeyFromFile(filepath1);
    RSAPublicKeySpec rsaPubKeySpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
    JSONObject js=new JSONObject();
    jo.put("Modulus", rsaPubKeySpec.getModulus().toString());
    jo.put("Exponent",rsaPubKeySpec.getPublicExponent().toString());
    
    jo.put("status","ok");
}else{
    jo.put("status","error");
}

out.print(jo.toJSONString());
}catch(Exception ex){
out.print("sending serv key : "+ex.toString());
}

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
