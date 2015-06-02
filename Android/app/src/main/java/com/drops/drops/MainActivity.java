package com.drops.drops;

import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.NotificationCompat;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

public class MainActivity extends Activity {

    Button raiseNotify;

    // ** Notifications ***********************
    private static final int NOTIFY_ME_ID = 1337;
    private int count = 0;
    private NotificationManager mgr = null;

    // ** Google Cloud Messaging **************
    private GCMClientManager pushClientManager;
    String PROJECT_NUMBER = "357897084697";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // ** Google Cloud Messaging ***********************************
        // *************************************************************
        pushClientManager = new GCMClientManager(this, PROJECT_NUMBER);
        pushClientManager.registerIfNeeded(new GCMClientManager.RegistrationCompletedHandler() {
            @Override
            public void onSuccess(String registrationId, boolean isNewRegistration) {
                Toast.makeText(MainActivity.this, registrationId, Toast.LENGTH_SHORT).show();
            }
        });

        // ** Notifications ********************************************
        mgr = (NotificationManager)getSystemService(NOTIFICATION_SERVICE);

        raiseNotify = (Button)findViewById(R.id.btn_Raise);
        raiseNotify.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Create Intent for when Notification is clicked
                //Intent resultIntent = new Intent(this, ACTIVITY_HERE);
                //int requestID = (int) System.currentTimeMillis();
                //int flags = PendingIntent.FLAG_CANCEL_CURRENT;
                //PendingIntent pIntent = PendingIntent.getActivity(this, requestID, resultIntent,flags);

                // CREATE A BASIC NOTIFICATION
                NotificationCompat.Builder mBuilder =
                        new NotificationCompat.Builder(getApplicationContext())
                        .setSmallIcon(R.drawable.notification_template_icon_bg)
                        .setContentTitle("My notification!@")
                        .setContentText("Hello m8!");
                        //.setContentIntent(pIntent);

                //Hide the notification after its selected.
                mBuilder.setAutoCancel(true);

                mgr.notify(NOTIFY_ME_ID, mBuilder.build());
            }
        });

        // ******* BASIC LISTVIEW *******
        //String[] items = {"item1", "item2", "item3"};
        //ArrayAdapter<String> itemsAdapter
        //        = new ArrayAdapter<String>(this, android.R.layout.simple_list_item_1, items);

        //ListView itemLv = (ListView)findViewById(R.id.activity_list);
        //itemLv.setAdapter(itemsAdapter);
        // ******* END OF BASIC LISTVIEW *******

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
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
