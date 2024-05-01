package com.tfm.myapplication;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.fxn.stash.Stash;
import com.tfm.myapplication.Model.UserData;

public class UpdateProfileActivity extends AppCompatActivity {
    private EditText etName, etLastName, etDNI, etEmail, etPhoneNumber, etDOB, etPassword,
            etStreet, etStreetNumber, etFloor, etPostalCode, etCity, etRegion, etCountry;
    private DatabaseHelper dbHelper;
    UserData userData;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_update_profile);
        dbHelper = new DatabaseHelper(this);

        // Initialize EditText fields
        etName = findViewById(R.id.et_name);
        etLastName = findViewById(R.id.et_last_name);
        etDNI = findViewById(R.id.et_dni);
        etEmail = findViewById(R.id.et_email);
        etPhoneNumber = findViewById(R.id.et_phone_number);
        etDOB = findViewById(R.id.et_dob);
        etPassword = findViewById(R.id.et_password);
        etStreet = findViewById(R.id.et_street);
        etStreetNumber = findViewById(R.id.et_street_number);
        etFloor = findViewById(R.id.et_floor);
        etPostalCode = findViewById(R.id.et_postal_code);
        etCity = findViewById(R.id.et_city);
        etRegion = findViewById(R.id.et_region);
        etCountry = findViewById(R.id.et_country);

        userData = dbHelper.getUserData(Stash.getString(Config.DNI));

        if (userData != null) {
            etName.setText(userData.getName());
            etLastName.setText(userData.getLastName());
            etDNI.setText(userData.getDni());
            etEmail.setText(userData.getEmail());
            etPhoneNumber.setText(userData.getPhoneNumber());
            etDOB.setText(userData.getDob());
            etPassword.setText(userData.getPassword());
            etStreet.setText(userData.getStreet());
            etStreetNumber.setText(userData.getStreetNumber());
            etFloor.setText(userData.getFloor());
            etPostalCode.setText(userData.getPostalCode());
            etCity.setText(userData.getCity());
            etRegion.setText(userData.getRegion());
            etCountry.setText(userData.getCountry());
        }
    }

    public void error(View view) {
        startActivity(new Intent(this, CreatingAccountErrorActvity.class));

    }

    public void home(View view) {
        startActivity(new Intent(this, MainActivity.class));

    }

    public void update(View view) {
        String name = etName.getText().toString().trim();
        String lastName = etLastName.getText().toString().trim();
        String dni = etDNI.getText().toString().trim();
        String email = etEmail.getText().toString().trim();
        String phoneNumber = etPhoneNumber.getText().toString().trim();
        String dob = etDOB.getText().toString().trim();
        String password = etPassword.getText().toString().trim();
        String street = etStreet.getText().toString().trim();
        String streetNumber = etStreetNumber.getText().toString().trim();
        String floor = etFloor.getText().toString().trim();
        String postalCode = etPostalCode.getText().toString().trim();
        String city = etCity.getText().toString().trim();
        String region = etRegion.getText().toString().trim();
        String country = etCountry.getText().toString().trim();
        if (name.isEmpty() || name.length() > 30) {
            etName.setError("Please enter a valid name (max 30 characters)");
            etName.requestFocus();
            return;
        }

        if (lastName.isEmpty() || lastName.length() > 30) {
            etLastName.setError("Please enter a valid last name (max 30 characters)");
            etLastName.requestFocus();
            return;
        }


        if (email.isEmpty() || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            etEmail.setError("Please enter a valid email");
            etEmail.requestFocus();
            return;
        }


        if (!phoneNumber.matches("^\\+[0-9]{5,15}$")) {
            etPhoneNumber.setError("Please enter a valid phone number starting with '+'");
            etPhoneNumber.requestFocus();
            return;
        }

        if (dob.isEmpty() || !dob.matches("^\\d{4}-\\d{2}-\\d{2}$")) {
            etDOB.setError("Please enter a valid date of birth (YYYY-MM-DD)");
            etDOB.requestFocus();
            return;
        }

        if (street.isEmpty() || !street.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,5}$")) {
            etStreet.setError("Please enter a valid street name");
            etStreet.requestFocus();
            return;
        }

        if (streetNumber.isEmpty() || !streetNumber.matches("^[0-9]{1,7}$")) {
            etStreetNumber.setError("Please enter a valid street number");
            etStreetNumber.requestFocus();
            return;
        }

        if (floor.isEmpty() || floor.length() > 10) {
            etFloor.setError("Max length for floor is 10 characters");
            etFloor.requestFocus();
            return;
        }

        if (postalCode.isEmpty() || !postalCode.matches("^[0-9]{1,7}$")) {
            etPostalCode.setError("Please enter a valid postal code");
            etPostalCode.requestFocus();
            return;
        }

        if (city.isEmpty() || !city.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$")) {
            etCity.setError("Please enter a valid city name");
            etCity.requestFocus();
            return;
        }

        if (region.isEmpty() || !region.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$")) {
            etRegion.setError("Please enter a valid region name");
            etRegion.requestFocus();
            return;
        }

        if (country.isEmpty() || !country.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$")) {
            etCountry.setError("Please enter a valid country name");
            etCountry.requestFocus();
            return;
        }


        if (email.isEmpty() || !android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches()) {
            Toast.makeText(this, "Please enter a valid email address", Toast.LENGTH_SHORT).show();
            return;
        }
        if (password.isEmpty() || password.length() < 8) {
            Toast.makeText(this, "Password must be at least 8 characters long", Toast.LENGTH_SHORT).show();
            return;
        }

        if (!password.matches(".*[A-Z].*") || !password.matches(".*\\d.*")) {
            Toast.makeText(this, "Password must contain at least one uppercase letter and one digit", Toast.LENGTH_SHORT).show();
            return;

        }

        dbHelper.updateUserData(
                etDNI.getText().toString(),
                etName.getText().toString(),
                etLastName.getText().toString(),
                etDNI.getText().toString(),
                etEmail.getText().toString(),
                etPhoneNumber.getText().toString(),
                etDOB.getText().toString(),
                etPassword.getText().toString(),
                etStreet.getText().toString(),
                etStreetNumber.getText().toString(),
                etFloor.getText().toString(),
                etPostalCode.getText().toString(),
                etCity.getText().toString(),
                etRegion.getText().toString(),
                etCountry.getText().toString(),
                userData.getAmount(),
                userData.getIban()
        );
        finish();
    }
}