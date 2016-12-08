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
   
public static final String CONNECTION_URL="jdbc:mysql://localhost/demo?autoReconnect=true";  
public static final String PASSWORD="";  
 
//public static final String CONNECTION_URL="jdbc:mysql://mysql44124-sequoro2.jelasticlw.com.br/demo"; 
//public static final String PASSWORD="f85VDcnKe0"; 
public static final String DRIVER="com.mysql.jdbc.Driver";  
 public static final String USERNAME="root";  

 
private static Connection con=null;  
public static final int debug=1;
public static final String baseurl="http://localhost:8080/site/";//"http://sequoro1.jelasticlw.com.br/";
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