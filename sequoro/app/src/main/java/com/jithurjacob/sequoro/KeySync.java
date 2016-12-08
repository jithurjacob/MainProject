package com.jithurjacob.sequoro;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.app.ActionBarActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.okhttp.FormEncodingBuilder;
import com.squareup.okhttp.Headers;
import com.squareup.okhttp.MediaType;
import com.squareup.okhttp.MultipartBuilder;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.RequestBody;
import com.squareup.okhttp.Response;

import org.json.JSONObject;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;

public class KeySync extends ActionBarActivity {
    private TextView mStatus;
    public String output;
    public static final MediaType MEDIA_TYPE_MARKDOWN = MediaType.parse("text/x-markdown; charset=utf-8");
    private static final MediaType MEDIA_TYPE_TEXT = MediaType.parse("text/plain; charset=utf-8");
    private OkHttpClient client = new OkHttpClient();
    private static final String PRIVATE_KEY_FILE = "Private.key";
    UserSessionManager session;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_key_sync);
        mStatus = (TextView) findViewById(R.id.status);
        //Phase 1: check if private key exists else create new pri-pub and save pri upld pub
        //Phase 2: check if enc pri on server sync it
//        session = new UserSessionManager(getApplicationContext());
        session = new UserSessionManager(getApplicationContext());
        session.checkLogin();
        System.out.println("\n--------finish-------\n");
    }
Thread th;
    @Override
    protected void onStart() {
        super.onStart();
         th = new Thread() {
            public void run() {
                try {

                    Thread.sleep(5000);
                    System.out.println("on start");
                    File file1 = new File(getFilesDir() +"/"+session.getEmail()+ "Private.key");
                    File file2 = new File(getFilesDir() +"/"+session.getEmail()+ "Public.key");
                    File file3 = new File(getFilesDir() + "/serverpublic.key");

                    if ((file1.exists() && file2.exists() && file3.exists())) {
                        myHandler.sendEmptyMessage(4)  ;
                        show_main();

                        //  new sendPublicKey(getApplicationContext(),getMD5EncryptedString(getFilesDir()+"/Public.key"),getFilesDir()+"/Public.key").execute().get() ;
                        myHandler.sendEmptyMessage(5)  ;

                    } else {
                        myHandler.sendEmptyMessage(6)  ;


                        startMyTask(new RSA(getApplicationContext()));

                        //  new RSA(getApplicationContext()).execute().get();

                        //    mStatus.setText("Key generated");
                        // new sendPublicKey(getApplicationContext(),getMD5EncryptedString(getFilesDir()+"/Public.key"),getFilesDir()+"/Public.key").execute().get() ;
                        //  new sendPublicKey(getApplicationContext(),getMD5EncryptedString(getFilesDir()+"/Public.key"),getFilesDir()+"/Public.key").execute() ;
                        //  mStatus.setText("Syncing with server sending keys after gen");

                    }
                    System.out.println("\n--------finish thread-------\n");
                    return;
                } catch (Exception ex) {
                    System.out.println("\n--------excn1 in create------- " + ex.toString());
                    //   showtoast("An exception occured");
                }
            }
        };
        try {

            th.start();
        } catch (Exception ex) {
            System.out.println("\n--------excn1 in invk thread------- " + ex.toString());
        }
    }

    public void showtoast(String cont) {

        Toast.makeText(getApplicationContext(), cont, Toast.LENGTH_LONG).show();

    }

    @TargetApi(Build.VERSION_CODES.HONEYCOMB)
    static public <T> void startMyTask(AsyncTask<T, ?, ?> task, T... params) {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
                task.executeOnExecutor(AsyncTask.THREAD_POOL_EXECUTOR, params).get();
            } else {
                task.execute(params).get();
            }
        } catch (Exception e) {
            System.out.print(" excn in start task : " + e.toString());
        }
    }


    public static String getMD5EncryptedString(String encTarget) {
        MessageDigest mdEnc = null;
        try {
            mdEnc = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Exception while encrypting to md5");
            e.printStackTrace();
        } // Encryption algorithm
        mdEnc.update(encTarget.getBytes(), 0, encTarget.length());
        String md5 = new BigInteger(1, mdEnc.digest()).toString(16);
        while (md5.length() < 32) {
            md5 = "0" + md5;
        }
        return md5;
    }

    public void show_main() {
        // Starting MainActivity
        Intent i = new Intent(getApplicationContext(), MainActivity.class);
        i.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

        // Add new Flag to start new Activity
        i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(i);
        finish();
    }

    public class sendPublicKey extends AsyncTask<Void, String, Boolean> {
        private Context context;
        private String hash;
        private String filepath;

        public sendPublicKey(Context context, String hash, String filepath) {
            this.hash = hash;
            this.filepath = filepath;
            this.context = context;
        }

        private boolean checkNetworkConnection() {
            boolean haveConnectedWifi = false;
            boolean haveConnectedMobile = false;

            ConnectivityManager cm = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
            NetworkInfo[] netInfo = cm.getAllNetworkInfo();
            for (NetworkInfo ni : netInfo) {
                if (ni.getTypeName().equalsIgnoreCase("WIFI"))
                    if (ni.isConnected())
                        haveConnectedWifi = true;
                if (ni.getTypeName().equalsIgnoreCase("MOBILE"))
                    if (ni.isConnected())
                        haveConnectedMobile = true;
            }
            return haveConnectedWifi || haveConnectedMobile;
        }

        public String check_key(String myurl, String hash) throws IOException {
            System.out.println("\n\n\ninside key check\n\n\n");
            String a = null;
            try {
                Response response;
                 System.out.println("\n\n\n1\n\n\n"+ session.getEmail());
                RequestBody formBody = new FormEncodingBuilder()
                        .add("email", session.getEmail())
                        .add("hash", hash)
                        .add("platform", "2")
                        .build();
                System.out.println("\n\n\nchck key 2\n\n\n");
                Request request = new Request.Builder()
                        .url(myurl)
                        .post(formBody)
                        .build();
                System.out.println("\n\n\n3\n\n\n");
                response = client.newCall(request).execute();
                if (!response.isSuccessful()) //throw new IOException("Unexpected code " + response);
                    System.out.println("\n\n\nresponse failed\n\n\n");
                a = response.body().string().trim();
                System.out.println("\nREsponse ::" + a);
                System.out.println("\n\n\nchk key 4\n\n\n");

                System.out.println("\n\n\nchk key returning " + a);
                return a;

            } catch (Exception ex) {
                System.out.println("\n--------excn------- in check_key : " + ex.toString());

            } finally {
                return a;
            }
        }

        private String keyupload(String myurl, String hash, String filepath) throws IOException {
            System.out.print("\n\n\ninside key upload\n\n\n");

            String a = "ok";
            try {
                Response response;
                // System.out.print("\n\n\n11\n\n\n");
                //       File file = new File(getFilesDir()+"/Public.key");
//            RequestBody formBody = new FormEncodingBuilder()
//                    .add("email","jithu@gmail.com")
//                    .add("hash",hash)
//                    .add("platform","2")
//                    .build();
                String filepath1 = getFilesDir() +"/"+session.getEmail()+ "Public.key";
                System.out.println("filepath : " + filepath1);
                RSAEncryptionDecryption obj = new RSAEncryptionDecryption(this.context,session.getEmail());
                KeyFactory keyFactory = KeyFactory.getInstance("RSA");
                PublicKey publicKey = obj.readPublicKeyFromFile(filepath1);
                RSAPublicKeySpec rsaPubKeySpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
                JSONObject js = new JSONObject();
                js.put("Modulus", rsaPubKeySpec.getModulus().toString());
                js.put("Exponent", rsaPubKeySpec.getPublicExponent().toString());
                System.out.println("-----5-----");
                RequestBody requestBody = new MultipartBuilder()
                        .type(MultipartBuilder.FORM)
                        .addPart(
                                Headers.of("Content-Disposition", "form-data; name=\"email\""),
                                RequestBody.create(null, session.getEmail()))
                        .addPart(
                                Headers.of("Content-Disposition", "form-data; name=\"hash\""),
                                RequestBody.create(null, hash))
                        .addPart(
                                Headers.of("Content-Disposition", "form-data; name=\"platform\""),
                                RequestBody.create(null, "2"))
                        .addPart(
                                Headers.of("Content-Disposition", "form-data; name=\"key\""),
                                RequestBody.create(null, js.toString()))
                        .build();
                Request request = new Request.Builder()
                        .url(myurl)
                        .post(requestBody)
                        .build();


                System.out.println("-----6-----");

                Response response1 = client.newCall(request).execute();
                System.out.println("-----7-----");
                if (!response1.isSuccessful()) //throw new IOException("Unexpected code " + response);
                    System.out.print("\n\n\nresponse failed\n\n\n");
                System.out.println("-----8-----");
                a = response1.body().string().trim();
                System.out.println("-----9-----");
                System.out.print("REsponse returned a : " + a);
                return a;
            } catch (Exception ex) {
                System.out.println("\n--------excn------- in key upload " + ex.toString());
                ex.printStackTrace();
            }
            return a;
        }

        public void save_serverkeys(String res) {
            try {
                System.out.print("trying to save  server keys   ");
                RSAEncryptionDecryption rsa_obj = new RSAEncryptionDecryption(context,session.getEmail());
                String fileName = "serverpublic.key";
                JSONObject array = new JSONObject(res);

                BigInteger mod = new BigInteger(array.get("Modulus").toString());
                BigInteger exp = new BigInteger(array.get("Exponent").toString());
                rsa_obj.saveKeys(fileName, mod, exp);
                System.out.print(" server keys saved  ");
            } catch (Exception e) {
                System.out.print("Excn in saving server keys : " + e.toString());
            }
        }

        @Override
        protected Boolean doInBackground(Void... params) {

            try {

                if (checkNetworkConnection()) {
                    System.out.println("sending req key check");
                    String a = check_key(getString(R.string.baseurl) + "keycheck.jsp", this.hash);

                    System.out.println("a:" + a);
                    if(a!=null) {
                        JSONObject obj = new JSONObject(a);
                        //System.out.println("cmp : " + obj.getString("keystatus").compareTo("ok"));
                        if (obj.getString("keystatus").compareTo("ok") == 0) {
                            // System.out.println("\n return true 251 ");
                            save_serverkeys(a);
                            return true;
                        } else {
                            System.out.println("\n else 270 ");
                            a = keyupload(getString(R.string.baseurl) + "keyupload.jsp", this.hash, this.filepath);
                            obj = new JSONObject(a);
                            mStatus.setText(a);
                            System.out.println("\n a: " + a);
                            if (obj.getString("status").compareTo("ok") == 0) {

                                save_serverkeys(a);
                                output = "Key uploaded successfully";
                                System.out.print(output);
                                return true;
                            } else {
                                output = "Key upload failed";
                                System.out.print(output);
                                return false;
                            }
                        }

                    }else{
                        output = "Execption in sending";
                        return false;
                    }
                } else {
                    output = "no net";
                    return false;
                }
            } catch (Exception e) {
                System.out.println("excn in async do backgrd : " + e.toString());

                return false;
            }


        }

        @Override
        protected void onProgressUpdate(String... values) {
            mStatus.setText(values[0]);
            if (values[0].compareTo("true") == 0)
                mStatus.setText("key sent");
            else
                mStatus.setText("key sending failed");
        }

        @Override
        protected void onPostExecute(Boolean result) {
            //mStatus.setText("Finished Sending Keys");
            // The results of the above method
            // Processing the results here
            if (result)
                myHandler.sendEmptyMessage(2);
            else
                myHandler.sendEmptyMessage(3);
        }

    }

    public class RSA extends AsyncTask<Void, String, Boolean> {
        private Context context;

        public RSA(Context context) {
            try {
                this.context = context;
                System.out.println("Completed RSA constructor");
            } catch (Exception ex) {
                System.out.print("Excn in costr : " + ex.toString());
            }
        }

        @Override
        protected Boolean doInBackground(Void... params) {
            try {
                System.out.println("Starting RSA key creation");
                RSAEncryptionDecryption obj = new RSAEncryptionDecryption(this.context,session.getEmail());
                if (!obj.keygen()) return false;
                //      publishProgress( "true");
                //  else
                //    publishProgress(  "false");
                System.out.println("Completed RSA key creation");
            } catch (Exception ex) {
                System.out.print("Excn in costr : " + ex.toString());
            }
            return true;
        }

        @Override
        protected void onProgressUpdate(String... values) {
            mStatus.setText(values[0]);
            if (values[0].compareTo("true") == 0)
                mStatus.setText("key generated");
            else
                mStatus.setText("keygen fail");
        }

        @Override
        protected void onPostExecute(Boolean result) {
            mStatus.setText("Finished generating Key... Uploading Keys");
            // The results of the above method
            // Processing the results here
            if (result)
                myHandler.sendEmptyMessage(0);
            else
                myHandler.sendEmptyMessage(1);
        }

    }

    Handler myHandler = new Handler() {

        @Override
        public void handleMessage(Message msg) {
            //mStatus.setText("in handle");
            switch (msg.what) {
                case 0://send pub key to db
                    mStatus.setText("key generated successfully");
                    startMyTask(new sendPublicKey(getApplicationContext(), getMD5EncryptedString(getFilesDir() +"/"+session.getEmail()+ "Public.key"), getFilesDir() +"/"+session.getEmail()+"Public.key"));
                    break;
                case 1://send pub key to db
                    mStatus.setText("generating keys failed");

                    break;
                case 2://send ok
                    mStatus.setText("sending key was successful");
                    show_main();
                    break;
                case 3://send failed
                    //    mStatus.setText(output);
                    mStatus.setText("sending failed");

                    break;
                case 4:
                    mStatus.setText("Key already generated");
                    break;
                case 5:
                    mStatus.setText("Syncing with server");
                    break;
                case 6:
                    mStatus.setText("Generating keys");
                    break;
                default:
                    break;
            }
        }
    };

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        // getMenuInflater().inflate(R.menu.menu_key_sync, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
//
//        //noinspection SimplifiableIfStatement
//        if (id == R.id.action_settings) {
//            return true;
//        }
//
        return super.onOptionsItemSelected(item);
    }
}
