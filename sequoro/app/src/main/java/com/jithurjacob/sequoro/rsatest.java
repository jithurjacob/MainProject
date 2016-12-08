package com.jithurjacob.sequoro;

import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectOutputStream;


public class rsatest extends ActionBarActivity {

    private TextView mResp;
    private Button mButton;

    public void LoadText(int resourceId,String fileName) throws Exception{
        // The InputStream opens the resourceId and sends it to the buffer
        InputStream is = this.getResources().openRawResource(resourceId);
        BufferedReader br = new BufferedReader(new InputStreamReader(is));
        String readLine = null;

        try {
            // While the BufferedReader readLine is not null
            while ((readLine = br.readLine()) != null) {
                Log.d("TEXT", readLine);
            }

            // Close the InputStream and BufferedReader
            is.close();
            br.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        FileOutputStream fos = null;
        ObjectOutputStream oos = null;

        try {
            System.out.println("Generating "+fileName + "...");
            fos = getApplicationContext().openFileOutput(fileName, Context.MODE_PRIVATE);
            oos = new ObjectOutputStream(new BufferedOutputStream(fos));

            oos.writeBytes(readLine);


            System.out.println(fileName + " generated successfully");
        } catch (Exception e) {
            System.out.print("excn : "+e.toString());
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

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_rsatest);
        mResp= (TextView) findViewById(R.id.response_text);

        mButton = (Button) findViewById(R.id.button);
        mButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                new testing(getApplicationContext()).execute();
            }
        });

    }



    public class testing extends AsyncTask<Void, String,Boolean> {
        Context context;
        public  testing(Context con){
            this.context=con;
        }
        public void test(){/*
          ///  mResp.setText("stsrting");
            String fileName12 =getFilesDir()+ "/Private.key";
            String fileName13 =getFilesDir()+ "/Public.key";
            try {
                String filepath1 =getFilesDir()+ "/serverpublic.key";//Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.serverpublic).toString();

                System.out.println("filepath : " + filepath1);
                RSAEncryptionDecryption rsaobj = new RSAEncryptionDecryption(context);
                KeyFactory keyFactory = KeyFactory.getInstance("RSA");
                System.out.print("\n\n\n-1\n\n\n ");
                File f=new File(filepath1);
                if(!f.exists()) {
                    System.out.print("\n\n\nfile not exists\n\n\n ");

                }
//
//                System.out.print("\n\n\n0\n\n\n key data");
                String data = rsaobj.encryptData("hi", filepath1);
                String serverdata = rsaobj.encryptData("hello", fileName13);
                System.out.print("\n\n\n0.1\n\n\n");
                OkHttpClient client = new OkHttpClient();

                System.out.print("\n\n\n1\n\n\n");
                RequestBody formBody = new FormEncodingBuilder()
                        .add("data", data)
                        .add("serverdata", serverdata)
                        .add("email", "jithu@gmail.com")
                        .build();
                System.out.print("\n\n\n2\n\n\n");
                Request request = new Request.Builder()
                        .url("http://env-4506756.jelasticlw.com.br/check_enc.jsp")
                        .post(formBody)
                        .build();
                System.out.print("\n\n\n3\n\n\n");
                Response response = client.newCall(request).execute();
                if (!response.isSuccessful()) //throw new IOException("Unexpected code " + response);
                    System.out.print("\n\n\nresponse failed\n\n\n");
                String resp=response.body().string().trim();
               // mResp.setText( response.body().string().trim());
                System.out.print("\n\n\nresp : " +resp+"\n\n\n");
                JSONObject js=new JSONObject(resp);
                 String decrd=rsaobj.decryptData(js.getString("server"), fileName12);

                System.out.print("Client says : "+js.getString("client")+" Server says : "+decrd);

            }catch(Exception ex){
                System.out.print("Excn : "+ex.toString());
            }
*/
        }
        @Override
        protected Boolean doInBackground(Void... params) {

            test();
            return true;
        }
        @Override
        protected void onProgressUpdate(String... values) {
//            mStatus.setText(values[0]);
//            if(values[0]=="true")
//                mStatus.setText("key generated");
//            else
//                mStatus.setText("keygen fail");
        }
        @Override
        protected void onPostExecute(Boolean result) {
           // re.setText("Finished generating Key");

        }

    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
      //  getMenuInflater().inflate(R.menu.menu_rsatest, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
