/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import org.apache.commons.codec.digest.DigestUtils;
import bean.Website;
/**
 *
 * @author Jithu R Jacob
 */
public class api {

    public String state, requestcode, accesscode, clientid, time;

    public String getAccesscode(String requestcode,String clientid,String clientsecret) {
        try{
         Connection con = ConnectionProvider.getCon();
         PreparedStatement ps=con.prepareStatement("select accesscode from apirequest_details where requestcode='"+requestcode+"' and clientid='"+clientid+"'");
            System.out.println("query : "+ps.toString());
         ResultSet rs=ps.executeQuery();
        rs.next();
        Website we=new Website();
        we.setClient_id(clientid);
        we.setClient_secretkey(clientsecret);
        if(we.isValidWebsite())
        return rs.getString("accesscode");
        
        
        }catch(Exception ex){
            System.out.println("Excn : "+ex.toString());
        }
        return "Error";
    }
    
    public String getRequestcode(String state) {
        try{
         Connection con = ConnectionProvider.getCon();
         PreparedStatement ps=con.prepareStatement("select requestcode from apirequest_details where state='"+state+"'");
            System.out.println("query : "+ps.toString());
         ResultSet rs=ps.executeQuery();
        rs.next();
        return rs.getString("requestcode");
        
        }catch(Exception ex){
            System.out.println("Excn : "+ex.toString());
        }
        return "Error";
    }
     public String getAccesscode(String state) {
        try{
         Connection con = ConnectionProvider.getCon();
         PreparedStatement ps=con.prepareStatement("select accesscode from apirequest_details where state='"+state+"'");
            System.out.println("query : "+ps.toString());
         ResultSet rs=ps.executeQuery();
        rs.next();
        return rs.getString("accesscode");
        
        }catch(Exception ex){
            System.out.println("Excn : "+ex.toString());
        }
        return "Error";
    }
    
    public String initialize() {
        try {
            Connection con = ConnectionProvider.getCon();
            setState(DigestUtils.shaHex("" + Math.random() * 100000000 + new Timestamp(new Date().getTime())));
            setRequestcode(DigestUtils.shaHex("" + Math.random() * 100000000 + new Timestamp(new Date().getTime())));
            setAccesscode(DigestUtils.shaHex("" + Math.random() * 100000000 + new Timestamp(new Date().getTime())));
            PreparedStatement ps = con.prepareStatement("insert into apirequest_details (state,requestcode,accesscode,clientid) values('" + this.getState() + "','" + this.getRequestcode() + "','" + this.getAccesscode() + "','" + this.getClientid() + "');");
            System.out.println("quey: " + ps.toString());
            if (ps.executeUpdate() == 1) {
                return this.getState();
            }

        } catch (Exception ex) {
            System.out.println("excn in initalize" + ex.toString());
        }
        return "error";
    }

    public boolean isValidState(String state){
    
        try{
        Connection con=ConnectionProvider.getCon();
        
        PreparedStatement ps1 = con.prepareStatement("select * from apirequest_details where clientid='" + this.getClientid() + "' and state='"+state+"' ");
        
        System.out.println("qry : "+ps1.toString());
           
        ResultSet rs = ps1.executeQuery();
        rs.next();
            System.out.println("result : "+rs.getInt("used")+" res : "+(0 == rs.getInt("used")));
        
        
        PreparedStatement ps2=con.prepareStatement("update apirequest_details set used=1 where state='"+state+"'");
         System.out.println("qry : "+ps2.toString());
        ps2.executeUpdate();
        return true;
        //return 0 == rs.getInt("used");
            
        }catch(Exception ex){
            System.out.println("excn : "+ex.toString());
        }
        return false;
    }
    
    /**
     * @return the state
     */
    public String getState() {
        return state;
    }

    /**
     * @param state the state to set
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * @return the clientid
     */
    public String getClientid() {
        return clientid;
    }

    /**
     * @param clientid the clientid to set
     */
    public void setClientid(String clientid) {
        this.clientid = clientid;
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
     * @return the requestcode
     */
    public String getRequestcode() {
        return requestcode;
    }

    /**
     * @param requestcode the requestcode to set
     */
    public void setRequestcode(String requestcode) {
        this.requestcode = requestcode;
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
    }

}
