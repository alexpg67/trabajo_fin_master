package com.tfm.myapplication;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.fxn.stash.Stash;
import com.tfm.myapplication.Model.UserData;

import org.w3c.dom.Text;

public class UserProfileActivity extends AppCompatActivity {
    TextView current_user_IBAN, current_dni, password;
    DatabaseHelper databaseHelper;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_user_profile);
        current_user_IBAN = findViewById(R.id.current_user_IBAN);
        current_dni = findViewById(R.id.current_dni);
        password = findViewById(R.id.password);
        databaseHelper = new DatabaseHelper(this);
        UserData userData = databaseHelper.getUserData(Stash.getString(Config.DNI));
        current_user_IBAN.setText(userData.getIban());
        current_dni.setText(userData.getDni());
        password.setText(userData.getPassword());

    }

    public void home(View view) {


            startActivity(new Intent(this, UpdateProfileActivity.class));


    }

    public  void  home_(View view)
    {
        startActivity(new Intent(this, MainActivity.class));
        finishAffinity();
    }

}