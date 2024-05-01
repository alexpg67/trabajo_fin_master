package com.tfm.myapplication;

import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputFilter;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.fxn.stash.Stash;
import com.tfm.myapplication.Model.AccessTokenResponse;
import com.tfm.myapplication.Model.InsertedData;
import com.tfm.myapplication.Model.KycApiInputDto;
import com.tfm.myapplication.Model.KycApiResponseDto;
import com.tfm.myapplication.Model.SimSwapCheckDto;
import com.tfm.myapplication.Model.SimSwapCheckResponseDto;
import com.tfm.myapplication.Model.UserData;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class TransferWindowActivity extends AppCompatActivity {
    DatabaseHelper databaseHelper;
    EditText editTextIbanDestino, edittext_telephone, edittext_cantidad_transferir, edittext_amount_transferir;
    private static final String IBAN_REGEX = "^[Ee][Ss]\\d{2} [A-Za-z\\d]{4} [A-Za-z\\d]{4} [A-Za-z\\d]{2} [A-Za-z\\d]{4} [A-Za-z\\d]{4} [A-Za-z\\d]{4}$";
    private static final int IBAN_LENGTH = 29;

    private double currentBalance;
    UserData userData;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_transfer_window);
        editTextIbanDestino = findViewById(R.id.edittext_iban_destino);
        edittext_telephone = findViewById(R.id.edittext_telephone);
        edittext_cantidad_transferir = findViewById(R.id.edittext_cantidad_transferir);
        edittext_amount_transferir = findViewById(R.id.edittext_amount_transferir);
        databaseHelper = new DatabaseHelper(this);
        editTextIbanDestino.setFilters(new InputFilter[]{new InputFilter.LengthFilter(IBAN_LENGTH)});
        editTextIbanDestino.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                // No implementation needed
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                // No implementation needed
            }

            @Override
            public void afterTextChanged(Editable s) {
                // Remove any non-alphanumeric characters


                Log.d("s", s.length()+"");
                String cleanedText = s.toString().replaceAll("[^A-Za-z0-9]", "");

                // Insert spaces after every four characters
                StringBuilder formattedIban = new StringBuilder();
                for (int i = 0; i < cleanedText.length(); i++) {
                    if (i > 0 && i % 4 == 0) {
                        formattedIban.append(" ");
                    }
                    formattedIban.append(cleanedText.charAt(i));
                }

                editTextIbanDestino.removeTextChangedListener(this);
                editTextIbanDestino.setText(formattedIban.toString());
                editTextIbanDestino.setSelection(formattedIban.length());
                editTextIbanDestino.addTextChangedListener(this);
            }
        });
        userData = databaseHelper.getUserData(Stash.getString(Config.DNI));

        currentBalance = Double.parseDouble(userData.getAmount());

    }

    public void next(View view) {
        if (editTextIbanDestino.getText().toString().length() == 29) {
            String destinationIBAN = editTextIbanDestino.getText().toString().trim();
            String recipientPhoneNumber = edittext_telephone.getText().toString().trim();
            String purposeOfTransfer = edittext_cantidad_transferir.getText().toString().trim();
            String amountToTransfer = edittext_amount_transferir.getText().toString().trim();
            if (destinationIBAN.isEmpty()) {
                editTextIbanDestino.setError("Required");
                editTextIbanDestino.requestFocus();

                return;
            }
            if (recipientPhoneNumber.isEmpty()) {
                edittext_telephone.setError("Required");
                edittext_telephone.requestFocus();

                return;
            }
            if (!recipientPhoneNumber.matches("^\\+[0-9]{5,15}$")) {
                edittext_telephone.setError("Please enter a valid phone number starting with '+'");
                edittext_telephone.requestFocus();
                return;
            }
            if (purposeOfTransfer.isEmpty()) {
                edittext_cantidad_transferir.setError("Required");
                return;
            }
            if (amountToTransfer.isEmpty()) {
                edittext_amount_transferir.setError("Required");
                edittext_amount_transferir.requestFocus();
                return;
            }

            SimSwapCheckDto input = new SimSwapCheckDto(userData.getPhoneNumber(), 240);
            // Si hay cambio de SIM Solo se va a permitir como máximo una transferencia del 90% del disponible
            double swappedTransferLimit = currentBalance * 0.9;
            Boolean scamFlag = false;
            if (Double.parseDouble(String.valueOf(amountToTransfer)) >= swappedTransferLimit){
                scamFlag = true;
            }

            requestToken(input, scamFlag, amountToTransfer, destinationIBAN, recipientPhoneNumber, purposeOfTransfer);

//            if (Double.parseDouble(String.valueOf(amountToTransfer)) > currentBalance) {
//                startActivity(new Intent(this, TransferErrorActivity.class));
//
//            } else {
//                String currentDate = getCurrentDate("dd/MM/yyyy");
//                boolean isInserted = databaseHelper.addUserTransferData(Stash.getString(Config.DNI), currentDate, destinationIBAN, recipientPhoneNumber, purposeOfTransfer, amountToTransfer);
//                    if (isInserted) {
//                        currentBalance -= Double.parseDouble(amountToTransfer);
//                        databaseHelper.updateAmountByDNI(userData.getDni(), String.valueOf(currentBalance));
//                        startActivity(new Intent(this, MainActivity.class));
//                        finish();
//
//                } else {
//                    startActivity(new Intent(this, TransferErrorActivity.class));
//                }
//            }
        }
        else
        {
            editTextIbanDestino.setError("Inavlid Format");
        }
    }
    private String getCurrentDate(String format) {
        SimpleDateFormat sdf = new SimpleDateFormat(format, Locale.getDefault());
        return sdf.format(new Date());
    }


    private void requestToken(SimSwapCheckDto input, Boolean scamFlag, String amountToTransfer, String destinationIBAN, String recipientPhoneNumber, String purposeOfTransfer) {
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
                    checkSwap(accessToken, input, scamFlag, amountToTransfer, destinationIBAN, recipientPhoneNumber, purposeOfTransfer); // Pasar el token a tu método que realiza la siguiente petición
                } else {
                    // Manejar el error, no se pudo obtener el token
                    Toast.makeText(TransferWindowActivity.this, "Error al obtener el access token", Toast.LENGTH_SHORT).show();
                }
            }

            @Override
            public void onFailure(Call<AccessTokenResponse> call, Throwable t) {
                // Manejar el fallo en la solicitud
                Toast.makeText(TransferWindowActivity.this, "La conexión para obtener el token falla: " + t.getMessage(), Toast.LENGTH_SHORT).show();
            }
        });
    }

    private void checkSwap (String accessToken, SimSwapCheckDto input, Boolean scamFlag, String amountToTransfer, String destinationIBAN, String recipientPhoneNumber, String purposeOfTransfer){
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("http://192.168.56.101:8100/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();

        ApiInterface apiInterface = retrofit.create(ApiInterface.class);
        Call<SimSwapCheckResponseDto> call = apiInterface.checkSimSwap("Bearer " + accessToken, input);


        call.enqueue(new Callback<SimSwapCheckResponseDto>() {
            @Override
            public void onResponse(Call<SimSwapCheckResponseDto> call, Response<SimSwapCheckResponseDto> response) {
                if (response.code() == 200 && response.body() != null) {
                    SimSwapCheckResponseDto apiResponse = response.body();

//                    if(apiResponse.getSwapped() && scamFlag){
//                        startActivity(new Intent(TransferWindowActivity.this, TransferErrorActivity.class));
//                    }
//                    else{
//                        Toast.makeText(TransferWindowActivity.this, "Error en la verificación de estafa", Toast.LENGTH_SHORT).show();
//                        startActivity(new Intent(TransferWindowActivity.this, TransferErrorActivity.class));
//                    }
//
//                }
//                else{
//                    Toast.makeText(TransferWindowActivity.this, "Error: " + response.code(), Toast.LENGTH_SHORT).show();
//                    startActivity(new Intent(TransferWindowActivity.this, TransferErrorActivity.class));
//
//
//                }

                    if (Double.parseDouble(String.valueOf(amountToTransfer)) > currentBalance || (apiResponse.getSwapped() && scamFlag)) {
                        startActivity(new Intent(TransferWindowActivity.this, TransferErrorActivity.class));

                    } else {
                        String currentDate = getCurrentDate("dd/MM/yyyy");
                        boolean isInserted = databaseHelper.addUserTransferData(Stash.getString(Config.DNI), currentDate, destinationIBAN, recipientPhoneNumber, purposeOfTransfer, amountToTransfer);
                        if (isInserted) {
                            currentBalance -= Double.parseDouble(amountToTransfer);
                            databaseHelper.updateAmountByDNI(userData.getDni(), String.valueOf(currentBalance));
                            startActivity(new Intent(TransferWindowActivity.this, MainActivity.class));
                            finish();

                        } else {
                            startActivity(new Intent(TransferWindowActivity.this, TransferErrorActivity.class));
                        }
                    }

                }
            }

            @Override
            public void onFailure(Call<SimSwapCheckResponseDto> call, Throwable t) {
                Toast.makeText(TransferWindowActivity.this, "La llamada al API falla: " + t.getMessage(), Toast.LENGTH_SHORT).show();
                startActivity(new Intent(TransferWindowActivity.this, TransferErrorActivity.class));
            }
        });
    }


}