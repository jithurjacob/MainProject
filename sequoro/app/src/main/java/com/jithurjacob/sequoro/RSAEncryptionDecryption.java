package com.jithurjacob.sequoro;

import android.content.Context;
import android.util.Base64;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPrivateKeySpec;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;

/**
 *
 * @author Anuj
 * Blog www.goldenpackagebyanuj.blogspot.com
 * RSA - Encrypt Data using Public Key
 * RSA - Descypt Data using Private Key
 */
public class RSAEncryptionDecryption {
    private Context context;
    private String email;
    public  RSAEncryptionDecryption(Context context,String Email){
        this.context=context;
        this.email=Email;
    }
    private static final String PUBLIC_KEY_FILE = "Public.key";
    private static final String PRIVATE_KEY_FILE = "Private.key";
    private static final String CIPHER_INSTANCE="RSA/ECB/PKCS1Padding";
    private static int flags=Base64.DEFAULT;
    RSAPublicKeySpec rsaPubKeySpec;
    RSAPrivateKeySpec rsaPrivKeySpec;

    public boolean  keygen(){

        try {
            System.out.println("-------GENRATE PUBLIC and PRIVATE KEY-------------");
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
            System.out.println("\n--------1-------\n");
            keyPairGenerator.initialize(2048); //1024 used for normal securities
            System.out.println("\n--------2-------\n");
            KeyPair keyPair = keyPairGenerator.generateKeyPair();
            System.out.println("\n--------3-------\n");
            PublicKey publicKey = keyPair.getPublic();
            System.out.println("\n--------4-------\n");
            PrivateKey privateKey = keyPair.getPrivate();
            System.out.println("\n--------5-------\n");
            System.out.println("Public Key - " + publicKey);
            System.out.println("Private Key - " + privateKey);

            //Pullingout parameters which makes up Key
            System.out.println("\n------- PULLING OUT PARAMETERS WHICH MAKES KEYPAIR----------\n");
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
             rsaPubKeySpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
             rsaPrivKeySpec = keyFactory.getKeySpec(privateKey, RSAPrivateKeySpec.class);
            System.out.println("PubKey Modulus : " + rsaPubKeySpec.getModulus());
            System.out.println("PubKey Exponent : " + rsaPubKeySpec.getPublicExponent());
            System.out.println("PrivKey Modulus : " + rsaPrivKeySpec.getModulus());
            System.out.println("PrivKey Exponent : " + rsaPrivKeySpec.getPrivateExponent());

            //Share public key with other so they can encrypt data and decrypt thoses using private key(Don't share with Other)
            System.out.println("\n--------SAVING PUBLIC KEY AND PRIVATE KEY TO FILES-------\n");

            saveKeys(email+PUBLIC_KEY_FILE, rsaPubKeySpec.getModulus(), rsaPubKeySpec.getPublicExponent());
            saveKeys(email+PRIVATE_KEY_FILE, rsaPrivKeySpec.getModulus(), rsaPrivKeySpec.getPrivateExponent());


        } catch (NoSuchAlgorithmException e) {
            System.out.println("\n--------no such algm excn-------\n");
           e.printStackTrace();return false;
        }catch (InvalidKeySpecException e) {
            System.out.println("\n--------invalid key spec excn-------\n");
            e.printStackTrace();return false;
        }  catch (Exception e) {
        System.out.println("\n--------excn-------\n");
            System.out.print("excn : "+e.toString());
        e.printStackTrace();return false;
    }finally{
            System.out.println("\n--------finished key gen-------\n");
            return true;
        }
    }
//    public static void main(String[] args) throws IOException {
//
//
//
//            //Encrypt Data using Public Key
//            byte[] encryptedData = rsaObj.encryptData("Anuj Patel - Classified Information !");
//
//            //Descypt Data using Private Key
//            rsaObj.decryptData(encryptedData);
//
//
//
//    }

    /**
     * Save Files
     * @param fileName
     * @param mod
     * @param exp
     * @throws java.io.IOException
     */
     public void saveKeys(String fileName,BigInteger mod,BigInteger exp) throws IOException {
        FileOutputStream fos = null;
        ObjectOutputStream oos = null;

        try {
            System.out.println("Generating "+fileName + "...");
            fos = context.openFileOutput(fileName,Context.MODE_PRIVATE);
            oos = new ObjectOutputStream(new BufferedOutputStream(fos));

            oos.writeObject(mod);
            oos.writeObject(exp);

            System.out.println(fileName + " generated successfully");
        } catch (Exception e) {
            System.out.print("excn in saving "+fileName+" key: "+e.toString());
            e.printStackTrace();
        }
        finally{
            if(oos != null){
                oos.close();

                if(fos != null){
                    fos.close();
                }
            }
        }
    }

    /**
     * Encrypt Data
     * @param data
     * @throws IOException
     */
    public String encryptData(String data,String file) throws IOException {
        System.out.println("\n----------------ENCRYPTION STARTED------------");

        System.out.println("Data Before Encryption :" + data);
        byte[] dataToEncrypt  = data.getBytes("UTF8");
        byte[] encryptedData = null;
        try {
            PublicKey pubKey = readPublicKeyFromFile(file);//PUBLIC_KEY_FILE);
            Cipher cipher = Cipher.getInstance(CIPHER_INSTANCE);
            cipher.init(Cipher.ENCRYPT_MODE, pubKey);
            encryptedData = Base64.encode(cipher.doFinal(dataToEncrypt), flags);
            System.out.println("Encryted Data: " + encryptedData);

        } catch (Exception e) {
            System.out.print("excn : "+e.toString());
            e.printStackTrace();
        }

        System.out.println("----------------ENCRYPTION COMPLETED------------");
        return new String(encryptedData);
    }

    /**
     * Encrypt Data
     * @param data
     * @throws IOException
     */
    public String decryptData(String data,String file) throws IOException {
        System.out.println("\n----------------DECRYPTION STARTED------------");
        System.out.println("Data Before decryption :" + data);
        byte[] descryptedData = null;

        try {
            PrivateKey privateKey =  readPrivateKeyFromFile(file);//PRIVATE_KEY_FILE);
            Cipher cipher = Cipher.getInstance(CIPHER_INSTANCE);
            cipher.init(Cipher.DECRYPT_MODE, privateKey);
            descryptedData = cipher.doFinal(Base64.decode(data, flags));
            System.out.println("Decrypted Data: " + new String(descryptedData));
return new String(descryptedData);
        } catch (Exception e) {
            System.out.print("excn : "+e.toString());
            e.printStackTrace();
        }

        System.out.println("----------------DECRYPTION COMPLETED------------");
return null;
    }

    /**
     * read Public Key From File
     * @param fileName
     * @return PublicKey
     * @throws IOException
     */
    public PublicKey readPublicKeyFromFile(String fileName) throws IOException{
        FileInputStream fis = null;
        ObjectInputStream ois = null;
        try {
            fis = new FileInputStream(new File(fileName));
            ois = new ObjectInputStream(fis);

            BigInteger modulus = (BigInteger) ois.readObject();
            BigInteger exponent = (BigInteger) ois.readObject();

            //Get Public Key
            RSAPublicKeySpec rsaPublicKeySpec = new RSAPublicKeySpec(modulus, exponent);
            KeyFactory fact = KeyFactory.getInstance("RSA");
            PublicKey publicKey = fact.generatePublic(rsaPublicKeySpec);

            return publicKey;

        } catch (Exception e) {
            System.out.print("excn : "+e.toString());
            e.printStackTrace();
        }
        finally{
            if(ois != null){
                ois.close();
                if(fis != null){
                    fis.close();
                }
            }
        }
        return null;
    }

    /**
     * read Private Key From File
     * @param fileName
     * @return
     * @throws IOException
     */
    public PrivateKey readPrivateKeyFromFile(String fileName) throws IOException{
        FileInputStream fis = null;
        ObjectInputStream ois = null;
        try {
            fis = new FileInputStream(new File(fileName));
            ois = new ObjectInputStream(fis);

            BigInteger modulus = (BigInteger) ois.readObject();
            BigInteger exponent = (BigInteger) ois.readObject();

            //Get Private Key
            RSAPrivateKeySpec rsaPrivateKeySpec = new RSAPrivateKeySpec(modulus, exponent);
            KeyFactory fact = KeyFactory.getInstance("RSA");
            PrivateKey privateKey = fact.generatePrivate(rsaPrivateKeySpec);

            return privateKey;

        } catch (Exception e) {
            System.out.print("excn : "+e.toString());
            e.printStackTrace();
        }
        finally{
            if(ois != null){
                ois.close();
                if(fis != null){
                    fis.close();
                }
            }
        }
        return null;
    }
}

