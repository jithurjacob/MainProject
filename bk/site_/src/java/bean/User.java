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


public class User{  
private String pasw,email,public_key,secondary_password,keyhash;  
  private int protocol;
  
 public void hello(){
 System.out.print("hello world");
 }
 public JSONObject check_key(String hash){
     JSONObject replyObj=new JSONObject();
int stat=0;
try{  
Connection con=ConnectionProvider.getCon();
PreparedStatement ps2=con.prepareStatement("select * from user_details where email='"+this.getEmail()+"'");
   // System.out.println(ps2.toString());
    ResultSet rs2=ps2.executeQuery();
    rs2.next();
  String key=rs2.getString("public_key");
  String keyhash=rs2.getString("keyhash");
if((null==key || key.compareTo("")==0 || keyhash.compareTo(hash)!=0) ) {
    replyObj.put( "keystatus","no key");
    } else {
    
    replyObj.put( "keystatus","ok");
    }


  //  replyObj.put("stmt", ps1.toString());
  
}catch(Exception e){
if(debug==1)System.out.print(e);
}  
      
 
return replyObj;
}

 
 public JSONObject check_login(){
     JSONObject replyObj=new JSONObject();

int stat=0;
try{  
Connection con=ConnectionProvider.getCon();
PreparedStatement ps1=con.prepareStatement("select count(*) as count from user_details where email='"+this.getEmail()+"' and  pasw='"+this.getPasw()+"'");
ResultSet rs=ps1.executeQuery();
int count=0;
String key=null;
while(rs.next()){
count=rs.getInt("count");
}
if(count==1){
   
  replyObj.put( "status","ok");

}else{
    replyObj.put( "status","Invalid Username/password");

}
  //  replyObj.put("stmt", ps1.toString());
  
}catch(Exception e){
if(debug==1)System.out.print(e);
}  
      
 
return replyObj;
}

 
public String registration(){
String status=null;
int stat=0;
try{  
Connection con=ConnectionProvider.getCon();
PreparedStatement ps1=con.prepareStatement("select count(*) as count from user_details where email='"+this.getEmail()+"'");
ResultSet rs=ps1.executeQuery();
int count=0;
while(rs.next()){
count=rs.getInt("count");
}
if(count<=0){
PreparedStatement ps=con.prepareStatement("insert into user_details (pasw,email) values('"+this.getPasw()+"','"+this.getEmail()+"');");  

stat=ps.executeUpdate();
if(stat==1){
status="Registerd successfully";
}else{
status="Registrsation failed";
}
}else{
status="Email aready exists";
}
              
  
}catch(Exception e){
if(debug==1)System.out.print(e);
}  
      
 
return status;
}

 public String check_password(String oldpasw)
 {
     String status=null;
     Connection con=ConnectionProvider.getCon();
     PreparedStatement ps1;
    try {
        ps1 = con.prepareStatement("select pasw from user_details where email='"+this.getEmail()+"'");
       // status+=ps1.toString();
      ResultSet rs=ps1.executeQuery();
      rs.next();
     if(oldpasw.compareTo(rs.getString("pasw"))==0)
     {
         status="ok";
     }
     else
     {
         status="not ok";
     }
     
   } catch (SQLException ex) {
        Logger.getLogger(User.class.getName()).
                log(Level.SEVERE, null, ex);
    }
    return status;
 }
 public String change_password(String newpasw) throws SQLException
 {
    Connection con=ConnectionProvider.getCon();
     PreparedStatement ps1=con.prepareStatement("update user_details set pasw='"+newpasw+"' where email='"+this.getEmail()+"'");
     String status=null;
     if(ps1.executeUpdate()==1)
         status= "Changed Successfully";
     else
         status="error";
     return status;
 }
public String setKeydetails() throws SQLException
 {
    Connection con=ConnectionProvider.getCon();
     PreparedStatement ps1=con.prepareStatement("update user_details set public_key='"+this.getPublic_key()+"' ,  keyhash='"+this.getKeyhash()+"'   where email='"+this.getEmail()+"'");
     String status=null;
     if(ps1.executeUpdate()==1)
         status= "ok";
     else
         status="error";
     return status;
 }
public String getKeydetails() throws SQLException
 {
    Connection con=ConnectionProvider.getCon();
     PreparedStatement ps1=con.prepareStatement("select public_key from user_details    where email='"+this.getEmail()+"'");
     String status=null;
     ResultSet rs=ps1.executeQuery();
     rs.next();
     return rs.getString("public_key");
 }
public String getPasw() {  
    return this.pasw;  
}  
  
public void setPasw(String pasw) {  
    this.pasw = pasw;  
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
    this.keyhash= KeyHash;  
} 
public String getPublic_key() {  
    return this.public_key;  
}  
  
public void setPublic_key(String public_key) {  
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

}  
