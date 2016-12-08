/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
  import org.apache.commons.codec.binary.Base64;
import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;
/**
 *
 * @author Jithu R Jacob
 */
public class QrGen {
    public void generate_qrcode(String data,String path){
        
        
        
    try{
    // to generate qr code 
     ByteArrayOutputStream out = QRCode.from(data).to(ImageType.PNG).withSize(300, 300).stream();
 
        try {
            FileOutputStream fout = new FileOutputStream(new File(path));
 
            fout.write(out.toByteArray());
 
            fout.flush();
            fout.close();
 
        } catch (FileNotFoundException e) {
            // Do Logging
        	e.printStackTrace();
        } catch (IOException e) {
            // Do Logging
        	e.printStackTrace();
        }
    }catch(Exception exn){
        System.out.println("excn in creating qr code : "+exn.toString());
    }
    
    }
    
    
}
