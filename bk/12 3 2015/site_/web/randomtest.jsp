<%-- 
    Document   : randomtest
    Created on : Dec 26, 2014, 9:37:31 PM
    Author     : Jithu R Jacob
--%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>

<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.security.spec.RSAPublicKeySpec"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.KeyFactory"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="crypto.*"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.File"%>

<%@page import="org.json.simple.*" %>
<jsp:useBean id="obj"  class="bean.User" scope="session"/> 
 
<jsp:useBean id="qr_obj"  class="bean.QrGen" scope="session"/>  
<%!String enc=null;%>
<%!String data=null;%>
<%!String path=null;%>
<%! JSONObject matrixObj = new JSONObject();%>
<%
  String key=null,hash=null;
    String email= request.getParameter("email").toString(),fileName=null;// = request.getParameter("email").toString();
%> 
<jsp:setProperty name="obj" property="email" value="<%= email %>" />  

<%

 File d = new File(application.getRealPath("/"));
     data = ""+(int)(Math.random()*10000);
     //test
     int rand=0;
     int[] matrix=new int[16];
     
     LinkedList ll = new LinkedList();
ll.add(new Integer(0));
ll.add(new Integer(1));
ll.add(new Integer(2));
ll.add(new Integer(3));
ll.add(new Integer(4));
ll.add(new Integer(5));
ll.add(new Integer(6));
ll.add(new Integer(7));
ll.add(new Integer(8));
ll.add(new Integer(9));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));
ll.add(new Integer(-1));


Collections.shuffle(ll);
 int i=0;
   Iterator li = ll.iterator();
while(li.hasNext())
    matrixObj.put(i++, li.next());

     data=matrixObj.toJSONString();

     //trst
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
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Test</title>
    </head>
    <style>
        body{
            word-break: break-all;
        }
    </style>
    <body>
        <%
    
         path="./img/keys/"+(int)(Math.random()*100000)+".PNG";
        qr_obj.generate_qrcode(enc,d.getAbsolutePath() +path);
        
        
       
        %>
        <%!
         String display(int n){
        return Integer.parseInt(matrixObj.get(n).toString()) >=0 ? matrixObj.get(n).toString():"&nbsp;";
        }
        %>
        <img src="<%=path%>" >
        <br><br><br><br>
        <table border="1">
            <tr> <td><%=display(0)%></td> <td><%=display(1)%></td> <td><%=display(2)%></td> <td><%=display(3)%></td><td><%=display(4)%></td> </tr>
            <tr> <td><%=display(5)%></td> <td><%=display(6)%></td> <td><%=display(7)%></td> <td><%=display(8)%></td><td><%=display(9)%></td> </tr>
            <tr> <td><%=display(10)%></td> <td><%=display(11)%></td> <td><%=display(12)%></td> <td><%=display(13)%></td><td><%=display(14)%></td> </tr>
            <tr> <td><%=display(15)%></td> <td><%=display(16)%></td> <td><%=display(17)%></td> <td><%=display(18)%></td><td><%=display(19)%></td> </tr> 
            <tr> <td><%=display(20)%></td> <td><%=display(21)%></td> <td><%=display(22)%></td> <td><%=display(23)%></td><td><%=display(24)%></td> </tr>
         
        </table>
        <br><br><br><br>
        data=<%=data%>
        <br><br><br><br>
        <p><%=enc%></p>
        
    </body>
</html>
