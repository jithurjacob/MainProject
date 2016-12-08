package com.jithurjacob.sequoro;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.annotation.TargetApi;
import android.app.Activity;
import android.app.LoaderManager.LoaderCallbacks;
import android.content.ContentResolver;
import android.content.Context;
import android.content.CursorLoader;
import android.content.Intent;
import android.content.Loader;
import android.database.Cursor;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Build.VERSION;
import android.os.Bundle;
import android.provider.ContactsContract;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.inputmethod.EditorInfo;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.squareup.okhttp.FormEncodingBuilder;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.RequestBody;
import com.squareup.okhttp.Response;

import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * A login screen that offers login via email/password.
 */
public class LoginActivity extends Activity implements LoaderCallbacks<Cursor> {


    /**
     * Keep track of the login task to ensure we can cancel it if requested.
     */
    private UserLoginTask mAuthTask = null;

    // UI references.
    private AutoCompleteTextView mEmailView;
    private EditText mPasswordView;
    private View mProgressView;
    private View mLoginFormView;
    private Button mEmailSignInButton;
    private View mProgrscrollview;
    private CheckBox mRememberMeChk;
    private TextView mText;
    // User Session Manager Class
    UserSessionManager session;
    public JSONObject obj;
    private String mailid, sessionid;
    public String login_output;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        // If the user is already logged in open activity key sync

        Thread th = new Thread() {
            public void run() {
                session = new UserSessionManager(getApplicationContext());
                if (session.isUserLoggedIn()) {
                    show_keysync();
                }
            }
        };
        th.run();
        login_output = null;
        // Set up the login form.
        mEmailView = (AutoCompleteTextView) findViewById(R.id.email);
        populateAutoComplete();

        mPasswordView = (EditText) findViewById(R.id.password);
        mPasswordView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int id, KeyEvent keyEvent) {
                if (id == R.id.login || id == EditorInfo.IME_NULL) {
                    attemptLogin();
                    return true;
                }
                return false;
            }
        });

        mEmailSignInButton = (Button) findViewById(R.id.email_sign_in_button);
        mEmailSignInButton.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                attemptLogin();
            }
        });

        mLoginFormView = findViewById(R.id.login_form);
        mProgressView = findViewById(R.id.login_progress);
        mProgrscrollview = findViewById(R.id.login_progress_view);
        // mText=(TextView) findViewById(R.id.textView2);
        // User Session Manager
//        session = new UserSessionManager(getApplicationContext());
//        if (session.isUserLoggedIn()) {
//            show_keysync();
//        }

        mailid = null;
        sessionid = null;

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

    public void show_keysync() {
        // Starting KeySyncActivity
        System.out.print("starting key sync");
        Intent i = new Intent(getApplicationContext(), KeySync.class);
        i.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

        // Add new Flag to start new Activity
        i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(i);
        finish();
    }

    private void populateAutoComplete() {
        if (VERSION.SDK_INT >= 14) {
            // Use ContactsContract.Profile (API 14+)
            getLoaderManager().initLoader(0, null, this);
        } else if (VERSION.SDK_INT >= 8) {
            // Use AccountManager (API 8+)
            new SetupEmailAutoCompleteTask().execute(null, null);
        }
    }


    /**
     * Attempts to sign in or register the account specified by the login form.
     * If there are form errors (invalid email, missing fields, etc.), the
     * errors are presented and no actual login attempt is made.
     */
    public void attemptLogin() {
     //   showtoast("attempt login");
        if (mAuthTask != null) {
            return;

        }

        // Reset errors.
        mEmailView.setError(null);
        mPasswordView.setError(null);

        // Store values at the time of the login attempt.
        String email = mEmailView.getText().toString();
        String password = mPasswordView.getText().toString();

        boolean cancel = false;
        View focusView = null;


        // Check for a valid password, if the user entered one.
        if (!TextUtils.isEmpty(password) && !isPasswordValid(password)) {
            mPasswordView.setError(getString(R.string.error_invalid_password));
            focusView = mPasswordView;
            cancel = true;
        }

        // Check for a valid email address.
        if (TextUtils.isEmpty(email)) {
            mEmailView.setError(getString(R.string.error_field_required));
            focusView = mEmailView;
            cancel = true;
        } else if (!isEmailValid(email)) {
            mEmailView.setError(getString(R.string.error_invalid_email));
            focusView = mEmailView;
            cancel = true;
        }

        if (cancel) {
            // There was an error; don't attempt login and focus the first
            // form field with an error.
            focusView.requestFocus();
        } else {
            // Show a progress spinner, and kick off a background task to
            // perform the user login attempt.
            showProgress(true);
          //  System.out.print("creating login task");
          //  showtoast("creating login task");
            mAuthTask = new UserLoginTask(email, password);
            mAuthTask.execute((Void) null);
        //    showtoast("created login task");
        }
    }

    private boolean isEmailValid(String email) {
        //TODO: Replace this with your own logic
        return email.contains("@");
    }

    private boolean isPasswordValid(String password) {
        //TODO: Replace this with your own logic
        return password.length() > 4;
    }

    public void showtoast(String cont) {
        //  if(mProgressView.getVisibility()==View.VISIBLE)
        Toast.makeText(getApplicationContext(), cont, Toast.LENGTH_LONG).show();
        //  else
        //     Toast.makeText(getApplicationContext(), "invis",Toast.LENGTH_LONG).show();
    }

    /**
     * Shows the progress UI and hides the login form.
     */
    @TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
    public void showProgress(final boolean show) {
        // On Honeycomb MR2 we have the ViewPropertyAnimator APIs, which allow
        // for very easy animations. If available, use these APIs to fade-in
        // the progress spinner.
//        if(show)
//        Toast.makeText(getApplicationContext(), "showing prog",
//                Toast.LENGTH_SHORT).show();
//        else
//            Toast.makeText(getApplicationContext(), "hiding prog",
//                    Toast.LENGTH_SHORT).show();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB_MR2) {
            // Toast.makeText(getApplicationContext(), "here1",Toast.LENGTH_SHORT).show();
            int shortAnimTime = getResources().getInteger(android.R.integer.config_shortAnimTime);

            // mLoginFormView.setVisibility(show ? View.GONE : View.VISIBLE);
            mEmailView.setVisibility(show ? View.GONE : View.VISIBLE);
            mPasswordView.setVisibility(show ? View.GONE : View.VISIBLE);
            mEmailSignInButton.setVisibility(show ? View.GONE : View.VISIBLE);
            mLoginFormView.animate().setDuration(shortAnimTime).alpha(
                    show ? 0 : 1).setListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    //  mLoginFormView.setVisibility(show ? View.GONE : View.VISIBLE);
                    mEmailView.setVisibility(show ? View.GONE : View.VISIBLE);
                    mPasswordView.setVisibility(show ? View.GONE : View.VISIBLE);
                    mEmailSignInButton.setVisibility(show ? View.GONE : View.VISIBLE);
                }
            });
            mProgrscrollview.setVisibility(show ? View.VISIBLE : View.GONE);
            mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
            mProgressView.animate().setDuration(shortAnimTime).alpha(
                    show ? 1 : 0).setListener(new AnimatorListenerAdapter() {
                @Override
                public void onAnimationEnd(Animator animation) {
                    mProgrscrollview.setVisibility(show ? View.VISIBLE : View.GONE);
                    mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);

                }
            });
        } else {

            // The ViewPropertyAnimator APIs are not available, so simply show
            // and hide the relevant UI components.
            mProgrscrollview.setVisibility(show ? View.VISIBLE : View.GONE);
            mProgressView.setVisibility(show ? View.VISIBLE : View.GONE);
            //   mLoginFormView.setVisibility(show ? View.GONE : View.VISIBLE);

            mEmailView.setVisibility(show ? View.GONE : View.VISIBLE);
            mPasswordView.setVisibility(show ? View.GONE : View.VISIBLE);
            mEmailSignInButton.setVisibility(show ? View.GONE : View.VISIBLE);
        }
    }

    @Override
    public Loader<Cursor> onCreateLoader(int i, Bundle bundle) {
        return new CursorLoader(this,
                // Retrieve data rows for the device user's 'profile' contact.
                Uri.withAppendedPath(ContactsContract.Profile.CONTENT_URI,
                        ContactsContract.Contacts.Data.CONTENT_DIRECTORY), ProfileQuery.PROJECTION,

                // Select only email addresses.
                ContactsContract.Contacts.Data.MIMETYPE +
                        " = ?", new String[]{ContactsContract.CommonDataKinds.Email
                .CONTENT_ITEM_TYPE},

                // Show primary email addresses first. Note that there won't be
                // a primary email address if the user hasn't specified one.
                ContactsContract.Contacts.Data.IS_PRIMARY + " DESC");
    }

    @Override
    public void onLoadFinished(Loader<Cursor> cursorLoader, Cursor cursor) {
        List<String> emails = new ArrayList<String>();
        cursor.moveToFirst();
        while (!cursor.isAfterLast()) {
            emails.add(cursor.getString(ProfileQuery.ADDRESS));
            cursor.moveToNext();
        }

        addEmailsToAutoComplete(emails);
    }

    @Override
    public void onLoaderReset(Loader<Cursor> cursorLoader) {

    }

    private interface ProfileQuery {
        String[] PROJECTION = {
                ContactsContract.CommonDataKinds.Email.ADDRESS,
                ContactsContract.CommonDataKinds.Email.IS_PRIMARY,
        };

        int ADDRESS = 0;
        int IS_PRIMARY = 1;
    }

    /**
     * Use an AsyncTask to fetch the user's email addresses on a background thread, and update
     * the email text field with results on the main UI thread.
     */
    class SetupEmailAutoCompleteTask extends AsyncTask<Void, Void, List<String>> {

        @Override
        protected List<String> doInBackground(Void... voids) {
            ArrayList<String> emailAddressCollection = new ArrayList<String>();

            // Get all emails from the user's contacts and copy them to a list.
            ContentResolver cr = getContentResolver();
            Cursor emailCur = cr.query(ContactsContract.CommonDataKinds.Email.CONTENT_URI, null,
                    null, null, null);
            while (emailCur.moveToNext()) {
                String email = emailCur.getString(emailCur.getColumnIndex(ContactsContract
                        .CommonDataKinds.Email.DATA));
                emailAddressCollection.add(email);
            }
            emailCur.close();

            return emailAddressCollection;
        }

        @Override
        protected void onPostExecute(List<String> emailAddressCollection) {
            addEmailsToAutoComplete(emailAddressCollection);
        }
    }

    private void addEmailsToAutoComplete(List<String> emailAddressCollection) {
        //Create adapter to tell the AutoCompleteTextView what to show in its dropdown list.
        ArrayAdapter<String> adapter =
                new ArrayAdapter<String>(LoginActivity.this,
                        android.R.layout.simple_dropdown_item_1line, emailAddressCollection);

        mEmailView.setAdapter(adapter);
    }

    /**
     * Represents an asynchronous login/registration task used to authenticate
     * the user.
     */
    public class UserLoginTask extends AsyncTask<Void, Void, Boolean> {

        private final String mEmail;
        private final String mPassword;
        private String mStatus;

        UserLoginTask(String email, String password) {
            mEmail = email;
            mPassword = password;
            mStatus = null;
        }

        private boolean checkNetworkConnection() {
            boolean haveConnectedWifi = false;
            boolean haveConnectedMobile = false;
            try {
                System.out.print("checking cncn");
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
            }catch (Exception ex){
                System.out.print("Exception in N/W check : "+ex.toString());
                return false;
            }
            return haveConnectedWifi || haveConnectedMobile;
        }


        // Given a URL, establishes an HttpUrlConnection and retrieves
// the web page content as a InputStream, which it returns as
// a string.
        private String downloadUrl(String myurl) throws IOException {
            System.out.println("starting to access " + myurl);
            String a = null;
          /*  HttpClient client=new DefaultHttpClient();
            HttpPost httpPost=new HttpPost(myurl);
            List<NameValuePair> nameValuePair=new ArrayList<NameValuePair>(2);
            nameValuePair.add(new BasicNameValuePair("email",mEmail));
            nameValuePair.add(new BasicNameValuePair("pasw",mPassword));
            nameValuePair.add(new BasicNameValuePair("platform","2"));
            try{
                httpPost.setEntity(new UrlEncodedFormEntity(nameValuePair));
            }catch(Exception ex){
                ex.printStackTrace();
            }
            try{
                HttpResponse resp= client.execute(httpPost);
                response= EntityUtils.toString( resp.getEntity());
            }catch(Exception ex){
                System.out.print("excn in downurl "+ex.toString());
                ex.printStackTrace();
            }*/
            try {
                OkHttpClient client = new OkHttpClient();
                RequestBody formBody = new FormEncodingBuilder()
                        .add("email", mEmail) //session.getEmail())
                        .add("pasw", mPassword)
                        .add("platform", "2")
                        .build();
                System.out.println("\n\n\n2\n\n\n"+formBody.toString()+mEmail+mPassword);
                Request request = new Request.Builder()
                        .url(myurl)
                        .post(formBody)
                        .build();
                System.out.println("\n\n\nlogin 3\n\n\n");
                Response response = client.newCall(request).execute();
                if (!response.isSuccessful()) //throw new IOException("Unexpected code " + response);
                    System.out.println("\n\n\nresponse failed\n\n\n");
                a = response.body().string().trim();
                System.out.println("returning" + a);

            } catch (Exception ex) {
                System.out.println("excn in downurl " + ex.toString());
            }
            return a;

        }

        @Override
        protected Boolean doInBackground(Void... params) {
            // TODO: attempt authentication against a network service.

            try {
                System.out.print("in do bknd");
                if (checkNetworkConnection()) {//TODO check auth here
                    //  Thread.sleep(5000);// Simulate network access.
                    // AsyncTask<String, Void, String> a= new DownloadWebpageTask().execute("www.google.com");
                    String a = downloadUrl(getString(R.string.baseurl) + "login.jsp");
                    if(a!=null){
                    obj = new JSONObject(a);
                    login_output = obj.getString("status");

                    mStatus = obj.getString("status");
                    // Toast.makeText(getApplicationContext(), a.get(),Toast.LENGTH_LONG).show();
                    }else{
                        login_output = "An exception occured";
                        return false;
                    }
                } else
                    login_output = "no net";


            } catch (Exception e) {
                System.out.print("excn in login bkg : " + e.toString());
                login_output = "An exception occured";
                return false;
            }



            return mStatus.compareTo("ok") == 0;


        }

        // Uses AsyncTask to create a task away from the main UI thread. This task takes a
        // URL string and uses it to create an HttpUrlConnection. Once the connection
        // has been established, the AsyncTask downloads the contents of the webpage as
        // an InputStream. Finally, the InputStream is converted into a string, which is
        // displayed in the UI by the AsyncTask's onPostExecute method.

        @Override
        protected void onPostExecute(final Boolean success) {
            try {
                mAuthTask = null;
                //  mText.setText(login_output);
                if (success) {
                    // Creating user login session
                    session.createUserLoginSession(mEmail, sessionid);
//                    if (obj.getString("keystatus").compareTo("ok") == 0)
//                        show_main();
//                    else
                    show_keysync();
                    finish();

                } else {
                    showProgress(false);
                    if (login_output.compareTo("no net") == 0)
                        Toast.makeText(getApplicationContext(), "Check your connectivity", Toast.LENGTH_SHORT).show();
                    else {
                         Toast.makeText(getApplicationContext(), login_output,Toast.LENGTH_SHORT).show();
                      //  mPasswordView.setError(getString(R.string.error_incorrect_password));
                      //  mPasswordView.requestFocus();
                    }
                }
                //  showme();
            } catch (Exception ex) {
                System.out.print("Exception in post exec : " + ex.toString());
            }
        }



        @Override
        protected void onCancelled() {
            mAuthTask = null;
            showProgress(false);
        }
    }
}



