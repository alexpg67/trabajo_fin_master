package com.tfm.myapplication;

import android.content.Intent;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.style.UnderlineSpan;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.fxn.stash.Stash;

public class LoginScreenActivity extends AppCompatActivity {
    private EditText etIdentifier, etPassword;
    private DatabaseHelper dbHelper;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login_screen);
        dbHelper = new DatabaseHelper(this);
        etIdentifier = findViewById(R.id.et_identifier);
        etPassword = findViewById(R.id.et_password);
        TextView textView = findViewById(R.id.textView1);
        SpannableString spannableString = new SpannableString(textView.getText());
        int startIndex = textView.getText().toString().indexOf("Ha olvidado la contraseña?");
        int endIndex = startIndex + "Ha olvidado la contraseña?".length();
        spannableString.setSpan(new UnderlineSpan(), startIndex, endIndex, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        textView.setText(spannableString);
    }
    public void main_page(View view) {
        String identifier = etIdentifier.getText().toString().trim();
        String password = etPassword.getText().toString().trim();

        if (identifier.isEmpty()) {
            Toast.makeText(this, "Please enter your identifier", Toast.LENGTH_SHORT).show();
            return;
        }
        if (password.isEmpty()) {
            Toast.makeText(this, "Please enter your password", Toast.LENGTH_SHORT).show();
            return;
        }
        if (dbHelper.checkLogin(identifier, password)) {
            Stash.put(Config.LOGIN, true);
            Stash.put(Config.DNI,identifier);
            Toast.makeText(this, "Login successful", Toast.LENGTH_SHORT).show();
            startActivity(new Intent(this, MainActivity.class));
            finish(); // Finish the current activity
        } else {
            Toast.makeText(this, "Invalid identifier or password", Toast.LENGTH_SHORT).show();
        }
    }
}