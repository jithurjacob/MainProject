/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import static bean.ConnectionProvider.debug;
import java.sql.ResultSet;

/**
 *
 * @author Jithu R Jacob
 */
public class user {
    
    public String name;
    public String email;
    public String pwd;
    public String age;
public String proovider;
    public boolean register(){
    try{
        Connection con = ConnectionProvider.getCon();
     PreparedStatement ps = con.prepareStatement("insert into user(name,pwd,email,age,provider) values('" + this.getName() + "','" + this.getPwd() + "','" + this.getEmail() + "'," + this.getAge()+ ",'"+this.getProovider()+"');");

               return ps.executeUpdate()==1;
               
    }catch(Exception ex){
    
    }
    return false;
    }
    public boolean login(){
    
        Connection con = ConnectionProvider.getCon();
        try {
            PreparedStatement ps1 = con.prepareStatement("select count(*) as count from user where email='" + this.getEmail() + "' and  pwd='" + this.getPwd() + "'");
            System.out.println("qry : "+ps1.toString()  ); 
            ResultSet rs2 = ps1.executeQuery();
            rs2.next();
            if(rs2.getInt("count")==1)
                return true;
            else return false;
        
        } catch (SQLException ex) {
            Logger.getLogger(user.class.getName()).log(Level.SEVERE, null, ex);
        }
           
        return false;
    }
     public String getName_email(){
    
        Connection con = ConnectionProvider.getCon();
        try {
            PreparedStatement ps1 = con.prepareStatement("select name from user where email='" + this.getEmail() + "' and  pwd='" + this.getPwd() + "'");
            System.out.println("qry : "+ps1.toString()  ); 
            ResultSet rs2 = ps1.executeQuery();
            rs2.next();
            return rs2.getString("name");
        
        } catch (SQLException ex) {
            Logger.getLogger(user.class.getName()).log(Level.SEVERE, null, ex);
        }
           
        return null;
    }
    public boolean email_exists(){
    
        Connection con = ConnectionProvider.getCon();
        try {
            PreparedStatement ps1 = con.prepareStatement("select count(*) as count from user where email='" + this.getEmail() + "'");
             ResultSet rs2 = ps1.executeQuery();
            rs2.next();
            if(rs2.getInt("count")==1)
                return true;
            else return false;
        
        } catch (SQLException ex) {
            Logger.getLogger(user.class.getName()).log(Level.SEVERE, null, ex);
        }
           
        return false;
    }
    
    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
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
     * @return the pwd
     */
    public String getPwd() {
        return pwd;
    }

    /**
     * @param pwd the pwd to set
     */
    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    /**
     * @return the age
     */
    public String getAge() {
        return age;
    }

    /**
     * @param age the age to set
     */
    public void setAge(String age) {
        this.age = age;
    }

    /**
     * @return the proovider
     */
    public String getProovider() {
        return proovider;
    }

    /**
     * @param proovider the proovider to set
     */
    public void setProovider(String proovider) {
        this.proovider = proovider;
    }
    
    
}
