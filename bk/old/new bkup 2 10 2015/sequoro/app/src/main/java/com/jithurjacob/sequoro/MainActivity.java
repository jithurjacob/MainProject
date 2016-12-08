package com.jithurjacob.sequoro;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.util.Base64;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.google.zxing.integration.android.IntentIntegrator;
import com.google.zxing.integration.android.IntentResult;

import org.json.JSONObject;

public class MainActivity extends ActionBarActivity implements View.OnClickListener {

    UserSessionManager session;
    //UI instance variables
    private Button scanBtn;
    private TextView otpTxt,excnTxt;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //instantiate UI items
        scanBtn = (Button)findViewById(R.id.scan_button);
        otpTxt = (TextView)findViewById(R.id.otp);
        excnTxt = (TextView)findViewById(R.id.scan_content);

        session = new UserSessionManager(getApplicationContext());

        //listen for clicks
        scanBtn.setOnClickListener(this);

        session.checkLogin();
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
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
            // Starting MainActivity
            Intent i = new Intent(getApplicationContext(),SettingsActivity.class);
            i.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(i);
            return true;
        }else  if (id == R.id.action_about) {
            // Starting MainActivity
            Intent i = new Intent(getApplicationContext(),AboutUsActivity.class);
            i.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(i);
            return true;
        }else  if (id == R.id.action_logout) {
            // Starting MainActivity
            session.logoutUser();
            finish();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void onClick(View v){
        //check for scan button
        if(v.getId()==R.id.scan_button){
            //instantiate ZXing integration class
            IntentIntegrator scanIntegrator = new IntentIntegrator(this);
            //start scanning
            scanIntegrator.initiateScan();
        }
    }

    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
        try {
        //retrieve result of scanning - instantiate ZXing object
        IntentResult scanningResult = IntentIntegrator.parseActivityResult(requestCode, resultCode, intent);
        //check we have a valid result
        if (scanningResult != null) {
            //get content from Intent Result
            String scanContent = scanningResult.getContents();
            //get format name of data scanned
            //String scanFormat = scanningResult.getFormatName();
            //output to UI
            // formatTxt.setText("FORMAT: "+scanFormat);
            //contentTxt.setText("CONTENT: "+scanContent);
            if(scanContent.compareTo("null")!=0){
                String fileName12 =getFilesDir()+"/"+session.getEmail()+ "Private.key";
                RSAEncryptionDecryption rsaobj = new RSAEncryptionDecryption(getApplicationContext(),session.getEmail());
                JSONObject js= null;

                    js = new JSONObject(new String(Base64.decode(scanContent,Base64.DEFAULT)));

                String decrd=rsaobj.decryptData(js.getString("data"), fileName12);
                otpTxt.setText(decrd);
            }else{
                excnTxt.setText("Scan failed ");
            }
        }
        else{
            //invalid scan data or scan canceled
            Toast toast = Toast.makeText(getApplicationContext(),
                    "No scan data received!", Toast.LENGTH_SHORT);
            toast.show();
        }
        } catch (Exception e) {
            System.out.println("excn in scanning"+e.toString());
            if(e.toString().compareTo("java.lang.NullPointerException")==0)
                excnTxt.setText("Scan failed");
            else
            excnTxt.setText("Scan failed....Exception : "+e.getMessage());
            //e.printStackTrace();
        }
    }
}
