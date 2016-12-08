package bean;

import static bean.ConnectionProvider.debug;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.*;
import org.json.simple.parser.*;
import bean.User.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class Otp {  //id`, `usernmae`, `c_username`, `website`, `otp_hash`, `time`, `used`, `accesscode`

    private String email, client_id, otp_hash, accesscode, time, secure_otp_hash_id;
    private int id, used;

    public void hello() {
        System.out.print("hello world");
    }

    
    
    public Map getLogin_detaills(String email, Map client_id) {
        System.out.println("REceived params : email : "+email+" clientid : "+client_id.toString());
        try {
            Connection con = ConnectionProvider.getCon();
            Map<String, JSONObject> ma = new HashMap<>();

            Iterator ir = client_id.values().iterator();
            if(client_id.values().size()==0){
             PreparedStatement ps1 = con.prepareStatement("select * from otp_details where  email='" + email + "' order by time desc");
                System.out.println("query usr : "+ps1.toString());
                ResultSet rs = ps1.executeQuery();

                JSONArray resu = new JSONArray();
                int i = 0;
                while (rs.next()) {
                    JSONObject res = new JSONObject();
                    res.put("email", rs.getString("email"));
                    res.put("client_id", rs.getString("client_id"));
                    res.put("time", rs.getString("time"));
                    res.put("used", rs.getString("used"));
                    res.put("protocol", rs.getString("protocol"));
                    ma.put("" + (i++), res);
                }
            }else while (ir.hasNext()) {
                PreparedStatement ps1 = con.prepareStatement("select * from otp_details where client_id='" + ir.next() + "' or email='" + email + "' order by time desc");
                System.out.println("query : "+ps1.toString());
                ResultSet rs = ps1.executeQuery();

                JSONArray resu = new JSONArray();
                int i = 0;
                while (rs.next()) {
                    JSONObject res = new JSONObject();
                    res.put("email", rs.getString("email"));
                    res.put("client_id", rs.getString("client_id"));
                    res.put("time", rs.getString("time"));
                    res.put("used", rs.getString("used"));
                    res.put("protocol", rs.getString("protocol"));

                    ma.put("" + (i++), res);
                }
                // System.out.println(""+res.toString());
            }
           // System.out.println("" + ma.toString());
            return ma;
        } catch (Exception ex) {
            System.out.println("Excn in get login list: " + ex.toString());
        }

        return null;
    }

    public void otp_invalidate(String secureid) {

        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("update otp_details set used=1 where secure_otp_hash_id='" + secureid + "'");
            String status = null;
            if (ps1.executeUpdate() == 1) {
                status = "Changed Successfully";
            } else {
                status = "error";
            }
        } catch (Exception ex) {
            System.out.println("excn invalidating otp");
        }
    }

    public JSONObject check_login() {
        JSONObject replyObj = new JSONObject();
        User obj = new User();
        int stat = 0;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select count(*) as count,protocol,otp_hash,keyboard_layout from otp_details where email='" + this.getEmail() + "'  and secure_otp_hash_id = '" + this.getSecure_otp_hash_id() + "' and used=0");
            System.out.println(ps1.toString());
            ResultSet rs = ps1.executeQuery();
            int count = 0, protocol = -1;
            String key = null, otp_hash = null, keyboard_layout = null, second_pwd = "", secondary_password = obj.getSecondary_password(this.getEmail());
            while (rs.next()) {
                count = rs.getInt("count");
                protocol = rs.getInt("protocol");
                otp_hash = rs.getString("otp_hash");
                keyboard_layout = rs.getString("keyboard_layout");
            }
            if (count == 1) {

                if (protocol == 0) {
                    if (this.getOtp_hash().compareTo(otp_hash) == 0) {
                        replyObj.put("status", "ok");
                    } else {
                        replyObj.put("status", "Invalid OTP");
                    }
                } else {
                    JSONObject matrix = (JSONObject) new JSONParser().parse(keyboard_layout);
                    System.out.println("Original Keyboard layout : " + keyboard_layout);
                    int[] keys = new int[25];
                    String[] str_arr = this.otp_hash.split(";");
                    System.out.println("keys pressed : " + this.otp_hash);
                    int[] keyarray = new int[str_arr.length];
                    for (int i = 0; i < str_arr.length; i++) {
                        keyarray[i] = Integer.parseInt(str_arr[i]);
                    }
                    for (int i = 0; i < 25; i++) {
                        keys[i] = Integer.parseInt(matrix.get("" + (i)).toString());
                    }
                    System.out.print("keys : ");
                    for (int i = 0; i < 25; i++) {
                        System.out.println(" i : " + i + " : " + keys[i]);
                    }
                    for (int i = 0; i < keyarray.length; i++) {
                        System.out.println("Current second pwd : " + second_pwd + " keyarray[i] : " + keyarray[i] + " key : " + keys[keyarray[i]]);
                        second_pwd = second_pwd + ("" + keys[keyarray[i]]);
                    }
                    System.out.println("Secondary pass computed : " + second_pwd + secondary_password);
                    if (second_pwd.compareTo(secondary_password) == 0) {
                        replyObj.put("status", "ok");
                    } else {
                        replyObj.put("status", "Invalid OTP");
                    }
                }

            } else {
                replyObj.put("status", "Invalid OTP");

            }
            otp_invalidate(this.getSecure_otp_hash_id());
            //  replyObj.put("stmt", ps1.toString());

        } catch (Exception e) {
            if (debug == 1) {
                System.out.print("excn in login jsp : " + e.toString());
                replyObj.put("status", "Invalid OTP");
            }
        }

        return replyObj;
    }

    public Boolean insert(int protocol) {
        Boolean status = false;
        int stat = 0;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps;
            if (protocol == 0) {
                ps = con.prepareStatement("insert into otp_details (email,client_id, otp_hash, time, accesscode,secure_otp_hash_id) "
                        + "values('" + this.getEmail() + "','" + this.getClient_id() + "','"
                        + this.getOtp_hash() + "','" + this.getTime() + "','" + this.getAccesscode() + "','" + this.getSecure_otp_hash_id() + "');");
            } else {
                ps = con.prepareStatement("insert into otp_details (email,client_id, keyboard_layout, time, accesscode,secure_otp_hash_id,protocol) "
                        + "values('" + this.getEmail() + "','" + this.getClient_id() + "','"
                        + this.getOtp_hash() + "','" + this.getTime() + "','" + this.getAccesscode() + "','" + this.getSecure_otp_hash_id() + "',1);");
            }

            System.out.println(ps.toString());
            stat = ps.executeUpdate();
            if (stat == 1) {
                status = true;
            } else {
                status = false;
            }

        } catch (Exception e) {
            if (debug == 1) {
                System.out.println("Excn entering otp details : " + e.toString());
                return false;
            }
        }

        return status;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail(String accesscode) {

        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select email from  otp_details where accesscode='" + accesscode + "' ");
            System.out.println("query: " + ps1.toString());
            ResultSet rs = ps1.executeQuery();
            rs.next();
            return rs.getString("email");

        } catch (Exception ex) {
            System.out.println("excn : " + ex.toString());
        }
        return "Error";
    }

    /**
     * @return the otp_hash
     */
    public String getOtp_hash() {
        return otp_hash;
    }

    /**
     * @param otp_hash the otp_hash to set
     */
    public void setOtp_hash(String otp_hash) {
        this.otp_hash = otp_hash;
    }

    /**
     * @return the accesscode
     */
    public String getAccesscode() {
        return accesscode;
    }

    /**
     * @param accesscode the accesscode to set
     */
    public void setAccesscode(String accesscode) {
        this.accesscode = accesscode;

        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("update otp_details set accesscode='" + accesscode + "' where secure_otp_hash_id='" + this.secure_otp_hash_id + "'");
            String status = null;
            if (ps1.executeUpdate() == 1) {
                status = "Changed Successfully";
            } else {
                status = "error";
            }
            System.out.println("status : " + status);
        } catch (Exception ex) {
            System.out.println("excn invalidating otp");
        }

    }

    /**
     * @return the time
     */
    public String getTime() {
        return time;
    }

    /**
     * @param time the time to set
     */
    public void setTime(String time) {
        this.time = time;
    }

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the id
     */
    public String getClient_id() {
        return client_id;
    }

    /**
     * @param id the id to set
     */
    public void setClient_id(String id) {
        this.client_id = id;
    }

    /**
     * @return the used
     */
    public int getUsed() {
        return used;
    }

    /**
     * @param used the used to set
     */
    public void setUsed(int used) {
        this.used = used;
    }

    /**
     * @return the secure_otp_hash_id
     */
    public String getSecure_otp_hash_id() {
        return secure_otp_hash_id;
    }

    /**
     * @param secure_otp_hash_id the secure_otp_hash_id to set
     */
    public void setSecure_otp_hash_id(String secure_otp_hash_id) {
        this.secure_otp_hash_id = secure_otp_hash_id;
    }

}
