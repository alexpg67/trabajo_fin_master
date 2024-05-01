package com.tfm.myapplication;

import android.content.Intent;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.style.UnderlineSpan;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.fxn.stash.Stash;

public class SplashActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);
        TextView textView = findViewById(R.id.textView1);
        SpannableString spannableString = new SpannableString(textView.getText());
        int startIndex = textView.getText().toString().indexOf("Regístrate");
        int endIndex = startIndex + "Regístrate".length();
        spannableString.setSpan(new UnderlineSpan(), startIndex, endIndex, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        textView.setText(spannableString);
        if (Stash.getBoolean(Config.LOGIN, false))
        {
            Intent intent = new Intent(SplashActivity.this, MainActivity.class);
            startActivity(intent);
            finish();
        }
    }

    public void create_account(View view) {
        startActivity(new Intent(this, CreateAccountActivity.class));
    }

    public void login(View view) {
        startActivity(new Intent(this, LoginScreenActivity.class));
    }

}