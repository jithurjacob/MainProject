package com.jithurjacob.sequoro;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.util.Base64;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.google.zxing.integration.android.IntentIntegrator;
import com.google.zxing.integration.android.IntentResult;

import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity extends ActionBarActivity implements View.OnClickListener {

    UserSessionManager session;
    //UI instance variables
    private Button scanBtn;
    private TextView otpTxt,excnTxt,key0,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13,key14,key15,key16,key17,key18,key19,key20,key21,key22,key23,key24;
private TableLayout matrix_table;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //instantiate UI items
        scanBtn = (Button)findViewById(R.id.scan_button);
        otpTxt = (TextView)findViewById(R.id.otp);
        excnTxt = (TextView)findViewById(R.id.scan_content);
matrix_table=(TableLayout)findViewById(R.id.matrix_table);

        key0 = (TextView)findViewById(R.id.key0);
        key1 = (TextView)findViewById(R.id.key1);
        key2 = (TextView)findViewById(R.id.key2);
        key3 = (TextView)findViewById(R.id.key3);
        key4 = (TextView)findViewById(R.id.key4);
        key5 = (TextView)findViewById(R.id.key5);
        key6 = (TextView)findViewById(R.id.key6);
        key7 = (TextView)findViewById(R.id.key7);
        key8 = (TextView)findViewById(R.id.key8);
        key9 = (TextView)findViewById(R.id.key9);
        key10 = (TextView)findViewById(R.id.key10);
        key11 = (TextView)findViewById(R.id.key11);
        key12 = (TextView)findViewById(R.id.key12);
        key13 = (TextView)findViewById(R.id.key13);
        key14 = (TextView)findViewById(R.id.key14);
        key15 = (TextView)findViewById(R.id.key15);
        key16 = (TextView)findViewById(R.id.key16);
        key17= (TextView)findViewById(R.id.key17);
        key18 = (TextView)findViewById(R.id.key18);
        key19= (TextView)findViewById(R.id.key19);
        key20 = (TextView)findViewById(R.id.key20);
        key21 = (TextView)findViewById(R.id.key21);
        key22 = (TextView)findViewById(R.id.key22);
        key23 = (TextView)findViewById(R.id.key23);
        key24 = (TextView)findViewById(R.id.key24);






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
                String fileName12 =getFilesDir()+"/"+ session.getEmail()+ "Private.key";
                RSAEncryptionDecryption rsaobj = new RSAEncryptionDecryption(getApplicationContext(),session.getEmail());
                JSONObject js= null;

                    js = new JSONObject(new String(Base64.decode(scanContent,Base64.DEFAULT)));

                String decrd=rsaobj.decryptData(js.getString("data"), fileName12);

                if(js.getString("protocol").compareTo("0")==0) {
                    otpTxt.setVisibility(View.VISIBLE);
                    matrix_table.setVisibility(View.GONE);
                    otpTxt.setText(decrd);
                } else{
                    otpTxt.setVisibility(View.GONE);
                    matrix_table.setVisibility(View.VISIBLE);
                    JSONObject matrix= new JSONObject(decrd);// new String(Base64.decode(decrd,Base64.DEFAULT))
                    key0.setText(display(matrix,"0"));
                    key1.setText(display(matrix,"1"));
                    key2.setText(display(matrix,"2"));
                    key3.setText(display(matrix,"3"));
                    key4.setText(display(matrix,"4"));
                    key5.setText(display(matrix,"5"));
                    key6.setText(display(matrix,"6"));
                    key7.setText(display(matrix,"7"));
                    key8.setText(display(matrix,"8"));
                    key9.setText(display(matrix,"9"));
                    key10.setText(display(matrix,"10"));
                    key11.setText(display(matrix,"11"));
                    key12.setText(display(matrix,"12"));
                    key13.setText(display(matrix,"13"));
                    key14.setText(display(matrix,"14"));
                    key15.setText(display(matrix,"15"));
                    key16.setText(display(matrix,"16"));
                    key17.setText(display(matrix,"17"));
                    key18.setText(display(matrix,"18"));
                    key19.setText(display(matrix,"19"));
                    key20.setText(display(matrix,"20"));
                    key21.setText(display(matrix,"21"));
                    key22.setText(display(matrix,"22"));
                    key23.setText(display(matrix,"23"));
                    key24.setText(display(matrix,"24"));


                }
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
    public String display(JSONObject matrix,String n) throws JSONException{
        return Integer.parseInt(matrix.getString(n)) >=0 ? matrix.getString(n):" ";
    }
}
