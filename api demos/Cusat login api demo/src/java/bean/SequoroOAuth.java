/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import com.sun.xml.ws.runtime.dev.Session;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.Timestamp;
import org.apache.commons.codec.binary.Base64;
import java.util.Date;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.json.JsonObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sun.net.util.URLUtil;
import org.json.simple.*;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
/**
 *
 * @author Jithu R Jacob
 */
public class SequoroOAuth {

    public String clientId, clientSecretKey, redirectUrl, initializeUrl, loginUrl, authUrl, requestUrl, nonce, state, time, email, authcode, requestcode;

    public SequoroOAuth() throws UnsupportedEncodingException, IOException {
String baseurl="http://localhost:8080/site/";//"http://sequoro1.jelasticlw.com.br/";
        clientId = "K9VU/lMey/CCbACxgdf775sGltA=";
        clientSecretKey = "MjEyNTQzOTFqaXRodUBnbWFpbC5jb21TSUIgaHR0cDo=";
        redirectUrl = "http://localhost:8080/cusat/login_check.jsp";
         authUrl = baseurl+"api/accesscode_api.jsp?clientid=" + this.clientId + "&clientsecretkey=" + this.clientSecretKey + "&requestcode=";
        initializeUrl = baseurl+"api/request_intialize.jsp?clientid=" + this.clientId + "&clientsecretkey=" + this.clientSecretKey;
        state = initialize_request().trim();
        time = new Timestamp(new Date().getTime()).toString();
        requestUrl =baseurl+ "api/login_api.jsp?clientid=" + clientId + "&redirecturl=" + redirectUrl + "&time=" + time + "&state=" + state;

        this.nonce = HMACSHA256(this.requestUrl, this.clientSecretKey);
        this.requestUrl = this.requestUrl + "&nonce=" + nonce;
    }

    ////////////////// nonce is used to check integrity of the request
    public String getEmail() {

        return this.email;
    }

    public String getRedirectUrl() {
        return this.redirectUrl;
    }

    public String getRequestUrl() {

        //System.out.println("req url : "+requestUrl);
        return this.requestUrl;
    }

    private String HMACSHA256(String message, String secret) throws UnsupportedEncodingException {
        String hash = null;
        try {

            Mac sha256_HMAC = Mac.getInstance("HmacSHA256");
            SecretKeySpec secret_key = new SecretKeySpec(secret.getBytes(), "HmacSHA256");
            sha256_HMAC.init(secret_key);

            hash = new String(Base64.encodeBase64(sha256_HMAC.doFinal(message.getBytes())));

        } catch (Exception e) {
            System.out.println("Excn hmac :" + e.toString());
        }
        return URLEncoder.encode(hash, "UTF-8");
    }

    public boolean authenticate(String requestcode,HttpServletRequest request) throws ServletException, IOException, ParseException {
        this.requestcode = requestcode;
        URL urldemo = new URL(this.authUrl+requestcode);
        URLConnection yc = urldemo.openConnection();
        BufferedReader in = new BufferedReader(new InputStreamReader(
                yc.getInputStream()));
        String inputLine;
        String response = "";
        while ((inputLine = in.readLine()) != null) {
            response += inputLine;

        }
        in.close();
        System.out.println(response);
        JSONParser parser=new JSONParser();
        JSONObject replyObj=(JSONObject)parser.parse(response);
        if(replyObj.get("accesscode").toString().compareTo("Error")!=0){
            this.authcode=response;
            request.getSession().setAttribute("accesscode", replyObj.get("accesscode").toString());
            request.getSession().setAttribute("name", replyObj.get("name").toString());
            request.getSession().setAttribute("email", replyObj.get("email").toString());
            return true;
        }
        return false;
    }

    private String initialize_request() throws IOException {
        this.requestcode = requestcode;
        URL urldemo = new URL(this.initializeUrl);
        URLConnection yc = urldemo.openConnection();
        BufferedReader in = new BufferedReader(new InputStreamReader(
                yc.getInputStream()));
        String inputLine;
        String response = "";
        while ((inputLine = in.readLine()) != null) {
            response += inputLine;

        }
        in.close();
        System.out.println(response);

        return response;

    }
}
