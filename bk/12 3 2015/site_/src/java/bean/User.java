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
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.*;

public class User {

    private String name, pasw, email, public_key, secondary_password, keyhash;
    private int protocol, verified, isSiteOwner;

    public void hello() {
        System.out.print("hello world");
    }

    public JSONObject check_key(String hash) {
        JSONObject replyObj = new JSONObject();
        int stat = 0;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps2 = con.prepareStatement("select * from user_details where email='" + this.getEmail() + "'");
            // System.out.println(ps2.toString());
            ResultSet rs2 = ps2.executeQuery();
            rs2.next();
            String key = rs2.getString("public_key");
            String keyhash = rs2.getString("keyhash");
            if ((null == key || key.compareTo("") == 0 || keyhash.compareTo(hash) != 0)) {
                replyObj.put("keystatus", "no key");
            } else {

                replyObj.put("keystatus", "ok");
            }

  //  replyObj.put("stmt", ps1.toString());
        } catch (Exception e) {
            if (debug == 1) {
                System.out.print("excn in keycheck : " + e.toString());
            }
        }

        return replyObj;
    }

    public JSONObject check_login() {
        JSONObject replyObj = new JSONObject();

        int stat = 0;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select count(*) as count , verified,protocol from user_details where email='" + this.getEmail() + "' and  pasw='" + this.getPasw() + "'");
            System.out.println("login query : "+ps1.toString());
            //replyObj.put( "query",ps1.toString());
            ResultSet rs = ps1.executeQuery();
            int count = 0, verified = -1,protocol=0;
            String key = null;
            while (rs.next()) {
                count = rs.getInt("count");
                verified = rs.getInt("verified");
                 protocol = rs.getInt("protocol");
            }
            this.setVerified(verified);
            if (count == 1) {
                if (verified == 0) {
                    replyObj.put("status", "Please verify your email");
                } else {
                    this.setProtocol(protocol);
                    replyObj.put("status", "ok");
                    replyObj.put("qrcode", generate_qrcode());
                }
            } else {
                replyObj.put("status", "Invalid Username/password");

            }
  //  replyObj.put("stmt", ps1.toString());

        } catch (Exception e) {
            if (debug == 1) {
                System.out.print("excn in login jsp : " + e.toString());
                replyObj.put("status", "Invalid OTP");
            }
        }

        return replyObj;
    }

    public String generate_qrcode() {

        String response = null;

        return response;
    }

    public boolean allok() {
        try {
            String key = getKeydetails();
            System.out.println("Key deta"+key);
            if (key.compareTo("") == 0 || key.equals(null) == true  ) {
                return false;
            }
            // check file exists
            
            FileInputStream fis = null;
            fis = new FileInputStream(new File(key));
            
            //  System.out.println("ok");
        } catch (Exception ex) {
            System.out.println("excn in allok : " + ex.toString());
            return false;

        }
        return true;
    }

    public String registration() {
        String status = null;
        int stat = 0;
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select count(*) as count from user_details where email='" + this.getEmail() + "'");
            ResultSet rs = ps1.executeQuery();
            int count = 0;
            while (rs.next()) {
                count = rs.getInt("count");
            }
            if (count <= 0) {
                if (this.getName() == null) {
                    this.setName("demo");
                }
                PreparedStatement ps = con.prepareStatement("insert into user_details (name,pasw,email,isSiteOwner) values('" + this.getName() + "','" + this.getPasw() + "','" + this.getEmail() + "'," + this.getIsSiteOwner() + ");");

                stat = ps.executeUpdate();
                if (stat == 1) {
                    status = "Registerd successfully";
                } else {
                    status = "Registrsation failed";
                }
            } else {
                status = "Email aready exists";
            }

        } catch (Exception e) {
           
                System.out.print(e);
             status = "Email aready exists";
        }

        return status;
    }

    public String check_password(String oldpasw) {
        String status = null;
        Connection con = ConnectionProvider.getCon();
        PreparedStatement ps1;
        try {
            ps1 = con.prepareStatement("select pasw from user_details where email='" + this.getEmail() + "'");
            // status+=ps1.toString();
            ResultSet rs = ps1.executeQuery();
            rs.next();
            if (oldpasw.compareTo(rs.getString("pasw")) == 0) {
                status = "ok";
            } else {
                status = "not ok";
            }

        } catch (SQLException ex) {
            Logger.getLogger(User.class.getName()).
                    log(Level.SEVERE, null, ex);
        }
        return status;
    }

    public String change_password(String newpasw) throws SQLException {
        Connection con = ConnectionProvider.getCon();
        PreparedStatement ps1 = con.prepareStatement("update user_details set pasw='" + newpasw + "' where email='" + this.getEmail() + "'");
        String status = null;
        if (ps1.executeUpdate() == 1) {
            status = "Changed Successfully";
        } else {
            status = "error";
        }
        return status;
    }

    public String setKeydetails() {
        String status = "error";
        try{
        Connection con = ConnectionProvider.getCon();
        PreparedStatement ps1 = con.prepareStatement("update user_details set public_key='" + this.getPublic_key() + "' ,  keyhash='" + this.getKeyhash() + "'   where email='" + this.getEmail() + "'");
        
        if (ps1.executeUpdate() == 1) {
            status = "ok";
        } else {
            status = "error";
        }
        }catch(Exception ex){
            System.out.println("Excn in set key : "+ex.toString());
        }
        return status;
    }

    public String getKeydetails() throws SQLException {
        try {
            //System.out.println("email : "+this.getEmail());
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select public_key from user_details    where email='" + this.getEmail() + "'");

            ResultSet rs = ps1.executeQuery();
            rs.next();
            String resp = rs.getString("public_key");
            //   System.out.println("resp : "+resp);
            return resp;
        } catch (Exception ex) {
            System.out.println("excn in getkeydetails : " + ex.toString());
            return null;
        }

    }

    public String getSecondary_password(String email){
    String pwd="";
    try {
            //System.out.println("email : "+this.getEmail());
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select secondary_password from user_details    where email='" + email + "'");

            ResultSet rs = ps1.executeQuery();
            rs.next();
            pwd=rs.getString("secondary_password");
            //   System.out.println("resp : "+resp);
            
        } catch (Exception ex) {
            System.out.println("excn in getsecondarypwd : " + ex.toString());
            return pwd;
        }
    
    return pwd;
    }
    public String getName(String email){
    String name="";
    try {
            //System.out.println("email : "+this.getEmail());
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select name from user_details    where email='" + email + "'");

            ResultSet rs = ps1.executeQuery();
            rs.next();
            name=rs.getString("name");
               System.out.println("name : "+ps1.toString());
            
        } catch (Exception ex) {
            System.out.println("excn in getname : " + ex.toString());
            return name;
        }
    
    return name;
    }
    public boolean setSecondary_password(String email,String pwd){
    boolean res=false;
    try {
            //System.out.println("email : "+this.getEmail());
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("update  user_details set secondary_password = "+pwd+"   where email='" + email + "'");

        if (ps1.executeUpdate() == 1) {
           res=true;
        } else {
            res=false;
        }
            //   System.out.println("resp : "+resp);
            
        } catch (Exception ex) {
            System.out.println("excn in setaecondapass : " + ex.toString());
            return false;
        }
    
    return res;
    }
  
    public int getProtocol(String email){
    int protocol=0;
    try {
            //System.out.println("email : "+this.getEmail());
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select protocol from user_details    where email='" + email + "'");

            ResultSet rs = ps1.executeQuery();
            rs.next();
            protocol=rs.getInt("protocol");
            //   System.out.println("resp : "+resp);
            
        } catch (Exception ex) {
            System.out.println("excn in getprotocol : " + ex.toString());
            return 0;
        }
    
    return protocol;
    }
     public int getIsSiteOwner(String email){
    int own=0;
    try {
            //System.out.println("email : "+this.getEmail());
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select isSiteOwner from user_details    where email='" + email + "'");

            ResultSet rs = ps1.executeQuery();
            rs.next();
           own=rs.getInt("isSiteOwner");
            //   System.out.println("resp : "+resp);
            
        } catch (Exception ex) {
            System.out.println("excn in getowner : " + ex.toString());
            return own;
        }
    
    return own;
    }
    public boolean setProtocol(String email,int protocol,int pwd){
    boolean res=false;
    try {
            //System.out.println("email : "+this.getEmail());
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("update  user_details set protocol = "+protocol+" , secondary_password= "+pwd+"  where email='" + email + "'");

        if (ps1.executeUpdate() == 1) {
           res=true;
        } else {
            res=false;
        }
            //   System.out.println("resp : "+resp);
            
        } catch (Exception ex) {
            System.out.println("excn in setprotocol : " + ex.toString());
            return false;
        }
    
    return res;
    }
  
    
    public String getPasw() {
        return this.pasw;
    }

    public void setPasw(String pasw) {
        this.pasw = pasw;
    }

    public int getVerified() {
        return this.verified;
    }

    public void setVerified(int ver) {
        this.verified = ver;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getKeyhash() {
        return this.keyhash;
    }

    public void setKeyhash(String KeyHash) {
        this.keyhash = KeyHash;
    }

    public String getPublic_key() {
        return this.public_key;
    }

    public void setPublic_key(String public_key) {
        public_key = public_key.replace("\\", "\\\\");
        this.public_key = public_key;
    }

    public int getProtocol() {
        return this.protocol;
    }

    public void setProtocol(int protocol) {
        this.protocol = protocol;
    }

    public String getSecondary_password() {
        return this.secondary_password;
    }

    public void setSecondary_password(String secondary_password) {
        this.secondary_password = secondary_password;
    }

    /**
     * @return the isSiteOwner
     */
    public int getIsSiteOwner() {
        return isSiteOwner;
    }

    /**
     * @param isSiteOwner the isSiteOwner to set
     */
    public void setIsSiteOwner(int isSiteOwner) {
        this.isSiteOwner = isSiteOwner;
    }

}
