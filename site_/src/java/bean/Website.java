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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.*;

public class Website {

    public String owner_email;
    public String site_name;
    public String site_url;
    public String site_redirecturl;
    public String site_logo;
    public String site_desc;
    public String client_secretkey;
    public String client_id;

    public Map getClient_id(String email) {
        
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select * from website_details where owner_email='" + email + "' ");
            //System.out.println("query : "+ps1.toString());
            ResultSet rs = ps1.executeQuery();
            Map<String, String> res = new HashMap<String, String>();
            while (rs.next()) {
                res.put("site_name", rs.getString("site_name"));
                res.put("site_url", rs.getString("site_url"));
                res.put("owner_email", rs.getString("owner_email"));
                res.put("site_redirecturl", rs.getString("site_redirecturl"));
                res.put("site_logo", rs.getString("site_logo"));
                res.put("site_desc", rs.getString("site_desc"));
                res.put("client_secretkey", rs.getString("client_secretkey"));
                res.put("client_id", rs.getString("client_id"));
            }
            // System.out.println(""+res.toString());
            return res;
        } catch (Exception ex) {
            System.out.println("Excn in get site name: " + ex.toString());
        }

        return null;
    }
    
    public boolean isValidWebsite() throws SQLException {

        Connection con = ConnectionProvider.getCon();
        PreparedStatement ps1 = con.prepareStatement("select count(*) as count from website_details where client_id='" + this.getClient_id() + "' and client_secretkey='" + this.getClient_secretkey() + "'");
        System.out.println("query : "+ps1.toString());
        ResultSet rs = ps1.executeQuery();

        rs.next();
        return 1 == rs.getInt("count");
    }

    public Map getSite_details(String client_id) {
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select * from website_details where client_id='" + this.getClient_id() + "' and site_redirecturl='" + this.getSite_redirecturl() + "'");
            System.out.println("query getsitedetails : "+ps1.toString());
            ResultSet rs = ps1.executeQuery();
            Map<String, String> res = new HashMap<String, String>();
            while (rs.next()) {
                res.put("site_name", rs.getString("site_name"));
                res.put("site_url", rs.getString("site_url"));
                res.put("owner_email", rs.getString("owner_email"));
                res.put("site_redirecturl", rs.getString("site_redirecturl"));
                res.put("site_logo", rs.getString("site_logo"));
                res.put("site_desc", rs.getString("site_desc"));
                res.put("client_secretkey", rs.getString("client_secretkey"));
                res.put("client_id", rs.getString("client_id"));
            }
            // System.out.println(""+res.toString());
            return res;
        } catch (Exception ex) {
            System.out.println("Excn in get site name: " + ex.toString());
        }

        return null;
    }
public Map getSite_list() {
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select * from website_details");
            //System.out.println("query : "+ps1.toString());
            ResultSet rs = ps1.executeQuery();
            Map<String, JSONObject> ma = new HashMap<>();
             JSONArray resu=new JSONArray();
             int i=0;
            while (rs.next()) {
                JSONObject res=new JSONObject();
                res.put("site_name", rs.getString("site_name"));
                res.put("site_url", rs.getString("site_url"));
                res.put("owner_email", rs.getString("owner_email"));
                res.put("site_redirecturl", rs.getString("site_redirecturl"));
                res.put("site_logo", rs.getString("site_logo"));
                res.put("site_desc", rs.getString("site_desc"));
                res.put("client_secretkey", rs.getString("client_secretkey"));
                res.put("client_id", rs.getString("client_id"));
               // resu.add(res.toJSONString());
                ma.put(""+(i++), res);
            }
            // System.out.println(""+res.toString());
            return ma;
        } catch (Exception ex) {
            System.out.println("Excn in get site list: " + ex.toString());
        }

        return null;
    }

     
     public Map getSite_list(String email) {
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select * from website_details where owner_email='" + email + "'");
            //System.out.println("query : "+ps1.toString());
            ResultSet rs = ps1.executeQuery();
            Map<String, JSONObject> ma = new HashMap<>();
             JSONArray resu=new JSONArray();
             int i=0;
            while (rs.next()) {
                JSONObject res=new JSONObject();
                res.put("site_name", rs.getString("site_name"));
                res.put("site_url", rs.getString("site_url"));
                res.put("owner_email", rs.getString("owner_email"));
                res.put("site_redirecturl", rs.getString("site_redirecturl"));
                res.put("site_logo", rs.getString("site_logo"));
                res.put("site_desc", rs.getString("site_desc"));
                res.put("client_secretkey", rs.getString("client_secretkey"));
                res.put("client_id", rs.getString("client_id"));
               // resu.add(res.toJSONString());
                ma.put(""+(i++), res);
            }
            // System.out.println(""+res.toString());
            return ma;
        } catch (Exception ex) {
            System.out.println("Excn in get site list: " + ex.toString());
        }

        return null;
    }

     
    public boolean isValidRequest() {
        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select count(*) as count from website_details where client_id='" + this.getClient_id() + "' and site_redirecturl='" + this.getSite_redirecturl() + "'");
            // System.out.println("query : "+ps1.toString());
            ResultSet rs = ps1.executeQuery();
            int count = 0;
            while (rs.next()) {
                count = rs.getInt("count");
            }
            return count == 1;
        } catch (Exception ex) {
            System.out.println("Excn in isvalid req : " + ex.toString());
        }

        return false;
    }

    public boolean add_site() {

        try {
            Connection con = ConnectionProvider.getCon();
            PreparedStatement ps1 = con.prepareStatement("select count(*) as count from website_details where owner_email='" + this.getOwner_email() + "' and site_redirecturl='" + this.getSite_redirecturl() + "'");
            ResultSet rs = ps1.executeQuery();
            int count = 0;
            while (rs.next()) {
                count = rs.getInt("count");
            }
            
            if (count <= 0) {

                PreparedStatement ps = con.prepareStatement("insert into website_details (owner_email,site_name,site_url,site_redirecturl,site_logo,site_desc,client_secretkey,client_id) values('" + this.getOwner_email() + "','" + this.getSite_name() + "','" + this.getSite_url() + "','" + this.getSite_redirecturl() + "','" + this.getSite_logo() + "','" + this.getSite_desc() + "','" + this.getClient_secretkey() + "','" + this.getClient_id() + "');");
                System.out.println(ps.toString());
                return ps.executeUpdate() == 1;

            } else {
                return false;
            }

        } catch (Exception ex) {
            System.out.println("Excn in add site : " + ex.toString());
            return false;
        }

    }

    /**
     * @return the owner_name
     */
    public String getOwner_email() {
        return owner_email;
    }

    /**
     * @param owner_name the owner_name to set
     */
    public void setOwner_email(String owner_email) {
        this.owner_email = owner_email;
    }

    /**
     * @return the site_name
     */
    public String getSite_name() {
        return site_name;
    }

    /**
     * @param site_name the site_name to set
     */
    public void setSite_name(String site_name) {
        this.site_name = site_name;
    }

    /**
     * @return the site_url
     */
    public String getSite_url() {
        return site_url;
    }

    /**
     * @param site_url the site_url to set
     */
    public void setSite_url(String site_url) {
        this.site_url = site_url;
    }

    /**
     * @return the site_redirecturl
     */
    public String getSite_redirecturl() {
        return site_redirecturl;
    }

    /**
     * @param site_redirecturl the site_redirecturl to set
     */
    public void setSite_redirecturl(String site_redirecturl) {
        this.site_redirecturl = site_redirecturl;
    }

    /**
     * @return the site_logo
     */
    public String getSite_logo() {
        return site_logo;
    }

    /**
     * @param site_logo the site_logo to set
     */
    public void setSite_logo(String site_logo) {
        this.site_logo = site_logo;
    }

    /**
     * @return the site_desc
     */
    public String getSite_desc() {
        return site_desc;
    }

    /**
     * @param site_desc the site_desc to set
     */
    public void setSite_desc(String site_desc) {
        this.site_desc = site_desc;
    }

    /**
     * @return the client_secretkey
     */
    public String getClient_secretkey() {
        return client_secretkey;
    }

    /**
     * @param client_secretkey the client_secretkey to set
     */
    public void setClient_secretkey(String client_secretkey) {
        this.client_secretkey = client_secretkey;
    }

    /**
     * @return the client_id
     */
    public String getClient_id() {
        return client_id;
    }

    /**
     * @param client_id the client_id to set
     */
    public void setClient_id(String client_id) {
        this.client_id = client_id;
    }

}
