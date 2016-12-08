/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Radhika
 */
package bean;

import static bean.ConnectionProvider.debug;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.*;

public class Otp {  //id`, `usernmae`, `c_username`, `website`, `otp_hash`, `time`, `used`, `session_id`

    private String email, customer_username, website, otp_hash, session_id, time, secure_otp_hash_id;
    private int id, used;

    public void hello() {
        System.out.print("hello world");
    }

    public void otp_invalidate(String secureid){
    
        try{
        Connection con=ConnectionProvider.getCon();
     PreparedStatement ps1=con.prepareStatement("update otp_details set used=1 where secure_otp_hash_id='"+secureid+"'");
     String status=null;
     if(ps1.executeUpdate()==1)
         status= "Changed Successfully";
     else
         status="error";
        }catch(Exception ex){
            System.out.println("excn invalidating otp");
        }
    }
    public JSONObject check_login() {
        JSONObject replyObj = new JSONObject();

        int stat = 0;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select count(*) as count from otp_details where email='" + this.getEmail() + "' and  otp_hash='" + this.getOtp_hash() + "' and secure_otp_hash_id = '" + this.getSecure_otp_hash_id() + "' and used=0");
            System.out.println(ps1.toString());
            ResultSet rs = ps1.executeQuery();
            int count = 0;
            String key = null;
            while (rs.next()) {
                count = rs.getInt("count");
            }
            if (count == 1) {

                replyObj.put("status", "ok");

            } else {
                replyObj.put("status", "Invalid OTP");

            }
            otp_invalidate(this.getSecure_otp_hash_id());
  //  replyObj.put("stmt", ps1.toString());

        } catch (Exception e) {
            if (debug == 1) {
                System.out.print("excn in login jsp : " + e.toString());
            }
        }

        return replyObj;
    }

    public Boolean insert() {
        Boolean status = false;
        int stat = 0;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps = con.prepareStatement("insert into otp_details (email,customer_username,website, otp_hash, time, session_id,secure_otp_hash_id) "
                    + "values('" + this.getEmail() + "','" + this.getCustomer_username() + "','" + this.getWebsite() + "','"
                    + this.getOtp_hash() + "','" + this.getTime() + "','" + this.getSession_id() + "','" + this.getSecure_otp_hash_id() + "');");
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

    /**
     * @return the customer_username
     */
    public String getCustomer_username() {
        return customer_username;
    }

    /**
     * @param customer_username the customer_username to set
     */
    public void setCustomer_username(String customer_username) {
        this.customer_username = customer_username;
    }

    /**
     * @return the website
     */
    public String getWebsite() {
        return website;
    }

    /**
     * @param website the website to set
     */
    public void setWebsite(String website) {
        this.website = website;
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
     * @return the session_id
     */
    public String getSession_id() {
        return session_id;
    }

    /**
     * @param session_id the session_id to set
     */
    public void setSession_id(String session_id) {
        this.session_id = session_id;
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
