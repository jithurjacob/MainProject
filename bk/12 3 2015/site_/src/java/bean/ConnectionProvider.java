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
import java.sql.*;  
  
public class ConnectionProvider { 
   
//public static final String CONNECTION_URL="jdbc:mysql://localhost/db?autoReconnect=true";  
//public static final String PASSWORD="";  
 
public static final String CONNECTION_URL="jdbc:mysql://mysql43871-sequoro1.jelasticlw.com.br/db"; 
public static final String PASSWORD="VrEwEkVKoL"; 
public static final String DRIVER="com.mysql.jdbc.Driver";  
 public static final String USERNAME="root";  

 
private static Connection con=null;  
public static final int debug=1;
public static final String baseurl="http://sequoro1.jelasticlw.com.br/";
static{  
try{  
Class.forName(DRIVER);  
con=DriverManager.getConnection(CONNECTION_URL,USERNAME,PASSWORD);

}catch(Exception e){
if(debug==1)System.out.print(e);
}  
}  
  
public static Connection getCon(){  
    return con;  
}  
  
}  