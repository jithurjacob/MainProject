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
   
public static final String CONNECTION_URL="jdbc:mysql://localhost/db?autoReconnect=true";  
public static final String PASSWORD="";  
 
/*public static final String CONNECTION_URL="jdbc:mysql://mysql38989-env-4506756.jelasticlw.com.br/db"; 
public static final String PASSWORD="IWaDp8SBtI"; */
public static final String DRIVER="com.mysql.jdbc.Driver";  
 public static final String USERNAME="root";  

 
private static Connection con=null;  
public static final int debug=1;
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