/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedList;
import org.apache.commons.codec.binary.Base64;
import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;
import org.json.simple.JSONObject;
import bean.Otp;
import bean.User;
import crypto.RSAEncryptionDescription;
import java.sql.Timestamp;
import java.util.Date;

import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author Jithu R Jacob
 */
public class QrGen {

    public String generate_qrcode(String platform, int protocol, Otp otp_obj, User obj, File d, int step,String cleintid) {
        JSONObject replyObj = new JSONObject();
        JSONObject matrixObj = new JSONObject();
        JSONObject js = new JSONObject();
        Timestamp ts_now = new Timestamp(new Date().getTime());
        String now = ts_now.toString();
        String secure_otp_id = DigestUtils.shaHex(now + "$#@#$%^salt");
        String data = null;

        // out.println("prptocol : "+obj.getProtocol());
        if (protocol == 0) {
            replyObj.put("protocol", "0");
            js.put("protocol", "0");
            int num = 0;
            while (num < 1000 || num > 10000) {
                num = (int) (Math.random() * 10000);
            }
            data = "" + num;
        } else {//protocol 2
            replyObj.put("protocol", "1");
            js.put("protocol", "1");
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
            int i = 0;
            Iterator li = ll.iterator();
            while (li.hasNext()) {
                matrixObj.put(i++, li.next());
            }

            data = matrixObj.toJSONString();//new String(Base64.encodeBase64(matrixObj.toJSONString().getBytes("UTF8")));

        }
        try {
            otp_obj.setOtp_hash(data);
            otp_obj.setSecure_otp_hash_id(secure_otp_id);

            if (platform.compareTo("3") == 0) {
                   otp_obj.setClient_id(cleintid);
            }

            otp_obj.insert(protocol);

        } catch (Exception ex) {
            System.out.println("Excn in entering otp :" + ex.toString());
        }
        String enc = null;
        try {
            String fileName = d.getAbsolutePath() + "/server_keys/ServerPrivate.key";
            RSAEncryptionDescription rsa_obj = new RSAEncryptionDescription();

            enc = rsa_obj.encryptData(data, obj.getKeydetails());
            js.put("data", enc);
            enc = new String(Base64.encodeBase64(js.toJSONString().getBytes("UTF8")));
            if (step == 2) {
                replyObj.put("status", "notok");
            } else {
                replyObj.put("status", "ok");
            }
            //  replyObj.put("qrcode", "http://qrickit.com/api/qr?d=" + enc + "&addtext=" + data + "&qrsize=250");
            String path = "/img/keys/" + (int) (Math.random() * 100000) + ".PNG";
            if(ConnectionProvider.baseurl.compareTo("http://localhost:8080/site/")==0)
             path = "./img/keys/" + (int) (Math.random() * 100000) + ".PNG";
            this.generate_qrcode(enc, d.getAbsolutePath() + path);
            replyObj.put("name", obj.getName(obj.getEmail()));
            replyObj.put("qrcode", path);
            replyObj.put("secureid", secure_otp_id);
            return replyObj.toJSONString().trim();

        } catch (Exception ex) {
            replyObj.put("status", "exception :" + ex.toString());

            return (replyObj.toJSONString().trim());
        }

    }

    public void generate_qrcode(String data, String path) {

        try {
            // to generate qr code 
            ByteArrayOutputStream out = QRCode.from(data).to(ImageType.PNG).withSize(300, 300).stream();

            try {
                FileOutputStream fout = new FileOutputStream(new File(path));

                fout.write(out.toByteArray());

                fout.flush();
                fout.close();

            } catch (FileNotFoundException e) {
                // Do Logging
                e.printStackTrace();
            } catch (IOException e) {
                // Do Logging
                e.printStackTrace();
            }
        } catch (Exception exn) {
            System.out.println("excn in creating qr code : " + exn.toString());
        }

    }
}
