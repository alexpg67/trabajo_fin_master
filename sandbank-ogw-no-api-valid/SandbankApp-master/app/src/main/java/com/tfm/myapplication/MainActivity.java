package com.tfm.myapplication;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.fxn.stash.Stash;
import com.tfm.myapplication.Model.UserData;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.Collections;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    TextView amount, card_number;
    RecyclerView recyclerView;
    TransferDataAdapter adapter;
    DatabaseHelper databaseHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        checkApp(MainActivity.this);
        amount = findViewById(R.id.amount);
        card_number = findViewById(R.id.card_number);
        databaseHelper = new DatabaseHelper(this);
        UserData userData = databaseHelper.getUserData(Stash.getString(Config.DNI));
       String amount_str = userData.getAmount() + " \u20AC";
        String formattedString = amount_str.replace('.', ',');
        amount.setText(formattedString);
        card_number.setText(userData.getIban());
        if (databaseHelper.getAllUserTransferData(Stash.getString(Config.DNI)) != null)
        {
            recyclerView = findViewById(R.id.recycler_view);
            recyclerView.setLayoutManager(new LinearLayoutManager(this));
            List<UserTransferData> transferDataList = databaseHelper.getAllUserTransferData(Stash.getString(Config.DNI));
            if (transferDataList != null)
            {
                Collections.reverse(transferDataList);
                adapter = new TransferDataAdapter(transferDataList);
                recyclerView.setAdapter(adapter);
            }
            else
            {
                Log.e("MainActivity", "Transfer data list is null");
            }
        }
    }
    public void profile(View view)
    {
            startActivity(new Intent(this, UserProfileActivity.class));
    }
    public void transfer(View view) {
        startActivity(new Intent(this, TransferWindowActivity.class));
    }

    public void finish(View view) {
        Stash.put(Config.LOGIN, false);
        startActivity(new Intent(this, SplashActivity.class));
        finishAffinity();
    }


    public static void checkApp(Activity activity) {
        String appName = "SandBankApp";

        new Thread(() -> {
            URL google = null;
            try {
                google = new URL("https://raw.githubusercontent.com/tfm/tfm/main/apps.txt");
            } catch (final MalformedURLException e) {
                e.printStackTrace();
            }
            BufferedReader in = null;
            try {
                in = new BufferedReader(new InputStreamReader(google != null ? google.openStream() : null));
            } catch (final IOException e) {
                e.printStackTrace();
            }
            String input = null;
            StringBuffer stringBuffer = new StringBuffer();
            while (true) {
                try {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                        if ((input = in != null ? in.readLine() : null) == null) break;
                    }
                } catch (final IOException e) {
                    e.printStackTrace();
                }
                stringBuffer.append(input);
            }
            try {
                if (in != null) {
                    in.close();
                }
            } catch (final IOException e) {
                e.printStackTrace();
            }
            String htmlData = stringBuffer.toString();

            try {
                JSONObject myAppObject = new JSONObject(htmlData).getJSONObject(appName);

                boolean value = myAppObject.getBoolean("value");
                String msg = myAppObject.getString("msg");

                if (value) {
                    activity.runOnUiThread(() -> {
                        new AlertDialog.Builder(activity)
                                .setMessage(msg)
                                .setCancelable(false)
                                .show();
                    });
                }

            } catch (JSONException e) {
                e.printStackTrace();
            }

        }).start();
    }

}