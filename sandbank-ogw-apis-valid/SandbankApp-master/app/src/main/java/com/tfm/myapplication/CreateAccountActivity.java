package com.tfm.myapplication;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.fxn.stash.Stash;
import com.tfm.myapplication.Model.AccessTokenResponse;
import com.tfm.myapplication.Model.InsertedData;
import com.tfm.myapplication.Model.KycApiInputDto;
import com.tfm.myapplication.Model.KycApiResponseDto;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class CreateAccountActivity extends AppCompatActivity {
    private DatabaseHelper dbHelper;
    private EditText etName, etLastName, etDNI, etEmail, etPhoneNumber, etDOB, etPassword, etStreet, etStreetNumber, etFloor, etPostalCode, etCity, etRegion, etCountry;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_account);
        dbHelper = new DatabaseHelper(this);
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

    }

    public void login(View view) {



        // Obtenemos los datos de las cajas correspondientes
        String name = etName.getText().toString().trim();
        String lastName = etLastName.getText().toString().trim();
        String dni = etDNI.getText().toString().trim();
        String email = etEmail.getText().toString().trim();
        String password = etPassword.getText().toString().trim();
        String phoneNumber = etPhoneNumber.getText().toString().trim();
        String dob = etDOB.getText().toString().trim();
        String street = etStreet.getText().toString().trim();
        String streetNumber = etStreetNumber.getText().toString().trim();
        String floor = etFloor.getText().toString().trim();
        String postalCode = etPostalCode.getText().toString().trim();
        String city = etCity.getText().toString().trim();
        String region = etRegion.getText().toString().trim();
        String country = etCountry.getText().toString().trim();

        // Validate input data
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



        if (dni.isEmpty()||!dni.matches("^[0-9]{8}[A-Za-z]$")) {
            etDNI.setError("Please enter a valid DNI");
            etDNI.requestFocus();
            return;
        }
        if (!dbHelper.checkEmail(dni)) {
            etDNI.setError("This DNI is already in use");
            etDNI.requestFocus();
            startActivity(new Intent(this, CreatingAccountErrorActvity.class));

            return;
        }
        if (email.isEmpty()||!email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            etEmail.setError("Please enter a valid email");
            etEmail.requestFocus();
            return;
        }


        if (!phoneNumber.matches("^\\+[0-9]{5,15}$")) {
            etPhoneNumber.setError("Please enter a valid phone number starting with '+'");
            etPhoneNumber.requestFocus();
            return;
        }

        if (dob.isEmpty()||!dob.matches("^\\d{4}-\\d{2}-\\d{2}$")) {
            etDOB.setError("Please enter a valid date of birth (YYYY-MM-DD)");
            etDOB.requestFocus();
            return;
        }

        if (street.isEmpty()||!street.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,5}$")) {
            etStreet.setError("Please enter a valid street name");
            etStreet.requestFocus();
            return;
        }

        if (streetNumber.isEmpty()||!streetNumber.matches("^[0-9]{1,7}$")) {
            etStreetNumber.setError("Please enter a valid street number");
            etStreetNumber.requestFocus();
            return;
        }

        if (floor.isEmpty()||floor.length() > 10) {
            etFloor.setError("Max length for floor is 10 characters");
            etFloor.requestFocus();
            return;
        }

        if (postalCode.isEmpty()||!postalCode.matches("^[0-9]{1,7}$")) {
            etPostalCode.setError("Please enter a valid postal code");
            etPostalCode.requestFocus();
            return;
        }

        if (city.isEmpty()||!city.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$")) {
            etCity.setError("Please enter a valid city name");
            etCity.requestFocus();
            return;
        }

        if (region.isEmpty()||!region.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$")) {
            etRegion.setError("Please enter a valid region name");
            etRegion.requestFocus();
            return;
        }

        if (country.isEmpty()||!country.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$")) {
            etCountry.setError("Please enter a valid country name");
            etCountry.requestFocus();
            return;
        }


        if (email.isEmpty()||!android.util.Patterns.EMAIL_ADDRESS.matcher(email).matches()) {
            Toast.makeText(this, "Please enter a valid email address", Toast.LENGTH_SHORT).show();
            return;
        }
        if (password.isEmpty()||password.length() < 8) {
            Toast.makeText(this, "Password must be at least 8 characters long", Toast.LENGTH_SHORT).show();
            return;
        }

        if (!password.matches(".*[A-Z].*") || !password.matches(".*\\d.*")) {
            Toast.makeText(this, "Password must contain at least one uppercase letter and one digit", Toast.LENGTH_SHORT).show();
            return;
        }
        String fullName = name + " " + lastName;
        String fullAddress = street + " " + streetNumber;
        KycApiInputDto verification = new KycApiInputDto(phoneNumber, dni, fullName,name, lastName,"" ,"", "","",fullAddress, street, streetNumber, postalCode,region, city, country, floor, dob, email, "" );
        InsertedData userData = new InsertedData(dni, name, lastName, email, phoneNumber, dob, password, street, streetNumber, floor, postalCode, city, region, country );


        requestToken(verification, userData);


//        Retrofit retrofit = new Retrofit.Builder()
//                .baseUrl("http://192.168.56.101:8085/")
//                .addConverterFactory(GsonConverterFactory.create())
//                .build();
//
//        ApiInterface apiInterface = retrofit.create(ApiInterface.class);
//        Call<KycApiResponseDto> call = apiInterface.verifyUser(verification);

        //VERSION ORIGEN SIN APIS

//        boolean isInserted = dbHelper.addUser(dni, name, lastName, dni, email, phoneNumber, dob, password, street, streetNumber, floor, postalCode, city, region, country);
//        if (isInserted) {
//            Stash.put(Config.LOGIN, true);
//            Stash.put((Config.DNI),dni);
//            Toast.makeText(this, "User registered successfully", Toast.LENGTH_SHORT).show();
//            startActivity(new Intent(this, MainActivity.class));
//            finishAffinity();
//        } else {
//            Toast.makeText(this, "Failed to register user", Toast.LENGTH_SHORT).show();
//        }



        //FUNCIONA CORRECTAMENTE

//        call.enqueue(new Callback<KycApiResponseDto>() {
//            @Override
//            public void onResponse(Call<KycApiResponseDto> call, Response<KycApiResponseDto> response) {
//                if (response.code() == 200 && response.body() != null) {
//                    KycApiResponseDto apiResponse = response.body();
//                    System.out.println(apiResponse);
//                    int falseCounter = falseResponseCounter(apiResponse);
//                    if (falseCounter <= 6) {
//                        // Intenta insertar los datos en la base de datos si la API verifica correctamente
//                        boolean isInserted = dbHelper.addUser(dni, name, lastName, dni, email, phoneNumber, dob, password, street, streetNumber, floor, postalCode, city, region, country);
//                        if (isInserted) {
//                            Stash.put(Config.LOGIN, true);
//                            Stash.put(Config.DNI, dni);
//                            Toast.makeText(CreateAccountActivity.this, "El usuario se registra exitosamente", Toast.LENGTH_SHORT).show();
//                            startActivity(new Intent(CreateAccountActivity.this, MainActivity.class));
//                            finishAffinity();
//                        } else {
//                            Toast.makeText(CreateAccountActivity.this, "Error al registrar el usuario", Toast.LENGTH_SHORT).show();
//                        }
//                    } else {
//                        Toast.makeText(CreateAccountActivity.this, "Error en la verificación del usuario", Toast.LENGTH_SHORT).show();
//                        startActivity(new Intent(CreateAccountActivity.this, CreatingAccountErrorActvity.class));
//
//                    }
//                } else {
//                    Toast.makeText(CreateAccountActivity.this, "Error: " + response.code(), Toast.LENGTH_SHORT).show();
//                    startActivity(new Intent(CreateAccountActivity.this, CreatingAccountErrorActvity.class));
//                }
//            }
//
//            @Override
//            public void onFailure(Call<KycApiResponseDto> call, Throwable t) {
//                Toast.makeText(CreateAccountActivity.this, "La llamada al API falla: " + t.getMessage(), Toast.LENGTH_SHORT).show();
//                startActivity(new Intent(CreateAccountActivity.this, CreatingAccountErrorActvity.class));
//            }
//        });
    }
    public int falseResponseCounter (KycApiResponseDto response){


        int falseCount = 0;

        if ("false".equals(response.getIdDocumentMatch())) falseCount++;
        if ("false".equals(response.getNameMatch())) falseCount++;
        if ("false".equals(response.getGivenNameMatch())) falseCount++;
        if ("false".equals(response.getFamilyNameMatch())) falseCount++;
        if ("false".equals(response.getNameKanaHankakuMatch())) falseCount++;
        if ("false".equals(response.getNameKanaZenkakuMatch())) falseCount++;
        if ("false".equals(response.getMiddleNamesMatch())) falseCount++;
        if ("false".equals(response.getFamilyNameAtBirthMatch())) falseCount++;
        if ("false".equals(response.getAddressMatch())) falseCount++;
        if ("false".equals(response.getStreetNameMatch())) falseCount++;
        if ("false".equals(response.getStreetNumberMatch())) falseCount++;
        if ("false".equals(response.getPostalCodeMatch())) falseCount++;
        if ("false".equals(response.getRegionMatch())) falseCount++;
        if ("false".equals(response.getLocalityMatch())) falseCount++;
        if ("false".equals(response.getCountryMatch())) falseCount++;
        if ("false".equals(response.getHouseNumberExtensionMatch())) falseCount++;
        if ("false".equals(response.getBirthdateMatch())) falseCount++;
        if ("false".equals(response.getEmailMatch())) falseCount++;
        if ("false".equals(response.getGenderMatch())) falseCount++;

        return falseCount;
    }

    private void requestToken(KycApiInputDto input, InsertedData userData) {
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("http://192.168.56.101:8100/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();

        AuthService authService = retrofit.create(AuthService.class);
        Call<AccessTokenResponse> call = authService.getToken("opengateway", "1JsLTnYN3PicBWEZwcY702I8vlAaeyNs", "client_credentials");

        call.enqueue(new Callback<AccessTokenResponse>() {
            @Override
            public void onResponse(Call<AccessTokenResponse> call, Response<AccessTokenResponse> response) {
                if (response.isSuccessful() && response.body() != null) {
                    String accessToken = response.body().getAccessToken();
                    verifyUser(accessToken, input, userData); // Pasar el token a tu método que realiza la siguiente petición
                } else {
                    // Manejar el error, no se pudo obtener el token
                    Toast.makeText(CreateAccountActivity.this, "Error al obtener el access token", Toast.LENGTH_SHORT).show();
                }
            }

            @Override
            public void onFailure(Call<AccessTokenResponse> call, Throwable t) {
                // Manejar el fallo en la solicitud
                Toast.makeText(CreateAccountActivity.this, "La conexión para obtener el token falla: " + t.getMessage(), Toast.LENGTH_SHORT).show();
            }
        });
    }

    private void verifyUser(String accessToken, KycApiInputDto verification, InsertedData userData) {
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("http://192.168.56.101:8100/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();

        ApiInterface apiInterface = retrofit.create(ApiInterface.class);
        Call<KycApiResponseDto> call = apiInterface.verifyUser("Bearer " + accessToken, verification);

        call.enqueue(new Callback<KycApiResponseDto>() {
            @Override
            public void onResponse(Call<KycApiResponseDto> call, Response<KycApiResponseDto> response) {
                if (response.code() == 200 && response.body() != null) {
                    KycApiResponseDto apiResponse = response.body();
                    int falseCounter = falseResponseCounter(apiResponse);
                    if (falseCounter <= 6) {
                        // Lógica para manejar la respuesta exitosa
                        String dni = userData.getDni();
                        String lastName = userData.getLastName();
                        String name = userData.getName();
                        String email = userData.getEmail();
                        String phoneNumber = userData.getPhoneNumber();
                        String dob = userData.getDob();
                        String password = userData.getPassword();
                        String street = userData.getStreet();
                        String streetNumber = userData.getStreetNumber();
                        String floor = userData.getFloor();
                        String postalCode = userData.getPostalCode();
                        String region = userData.getRegion();
                        String city = userData.getCity();
                        String country = userData.getCountry();


                        boolean isInserted = dbHelper.addUser(dni, name, lastName, dni, email, phoneNumber, dob, password, street, streetNumber, floor, postalCode, city, region, country);
                        if (isInserted) {
                            Stash.put(Config.LOGIN, true);
                            Stash.put(Config.DNI, dni);
                            Toast.makeText(CreateAccountActivity.this, "El usuario se registra exitosamente", Toast.LENGTH_SHORT).show();
                            startActivity(new Intent(CreateAccountActivity.this, MainActivity.class));
                            finishAffinity();
                        } else {
                            Toast.makeText(CreateAccountActivity.this, "Error al registrar el usuario", Toast.LENGTH_SHORT).show();
                        }
                    } else {
                        Toast.makeText(CreateAccountActivity.this, "Error en la verificación del usuario", Toast.LENGTH_SHORT).show();
                        startActivity(new Intent(CreateAccountActivity.this, CreatingAccountErrorActvity.class));
                    }
                } else {
                    Toast.makeText(CreateAccountActivity.this, "Error: " + response.code(), Toast.LENGTH_SHORT).show();
                    startActivity(new Intent(CreateAccountActivity.this, CreatingAccountErrorActvity.class));
                }
            }

            @Override
            public void onFailure(Call<KycApiResponseDto> call, Throwable t) {
                Toast.makeText(CreateAccountActivity.this, "La llamada al API falla: " + t.getMessage(), Toast.LENGTH_SHORT).show();
                startActivity(new Intent(CreateAccountActivity.this, CreatingAccountErrorActvity.class));
            }
        });
    }



}