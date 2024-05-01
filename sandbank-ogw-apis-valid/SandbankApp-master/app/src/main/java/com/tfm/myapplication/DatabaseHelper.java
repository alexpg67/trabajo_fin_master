package com.tfm.myapplication;

import android.annotation.SuppressLint;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.text.TextUtils;
import android.util.Log;

import com.fxn.stash.Stash;
import com.tfm.myapplication.Model.UserData;
import com.tfm.myapplication.UserTransferData;

import java.util.ArrayList;
import java.util.List;

public class DatabaseHelper extends SQLiteOpenHelper {
    private static final String DATABASE_NAME = "sandbank.db";
    private static final String TABLE_USERS = "users";
    private static final String TABLE_TRANSACTIONS = "transactions";

    // Columns for the users table
    private static final String COL_ID = "ID";
    private static final String COL_USER_ID = "USER_ID";
    private static final String COL_NAME = "NAME";
    private static final String COL_LAST_NAME = "LAST_NAME";
    private static final String COL_DNI = "DNI";
    private static final String COL_EMAIL = "EMAIL";
    private static final String COL_PHONE_NUMBER = "PHONE_NUMBER";
    private static final String COL_DOB = "DOB";
    private static final String COL_PASSWORD = "PASSWORD";
    private static final String COL_STREET = "STREET";
    private static final String COL_STREET_NUMBER = "STREET_NUMBER";
    private static final String COL_FLOOR = "FLOOR";
    private static final String COL_POSTAL_CODE = "POSTAL_CODE";
    private static final String COL_CITY = "CITY";
    private static final String COL_REGION = "REGION";
    private static final String COL_COUNTRY = "COUNTRY";
    private static final String COL_TOTAL_AMOUNT = "TOTAL_AMOUNT";
    private static final String COL_IBAN = "MY_IBAM";

    // Columns for the transactions table
    private static final String COL_TRANSACTION_ID = "TRANSACTION_ID";
    private static final String COL_DESTINATION_IBAN = "DESTINATION_IBAN";
    private static final String COL_RECIPIENT_PHONE_NUMBER = "RECIPIENT_PHONE_NUMBER";
    private static final String COL_PURPOSE_TRANSFER = "PURPOSE_TRANSFER";
    private static final String COL_AMOUNT_TRANSFER = "AMOUNT_TRANSFER";
    private static final String COL_DATE = "DATE";

    private static final String IBAN_PREFIX = "ES21 1234 0000 0000";
    private static final String IBAN_COUNTER_KEY = "ibanCounter";

    private int ibanCounter;

    public DatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, 1);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // Create users table
        String createUserTableQuery = "CREATE TABLE " + TABLE_USERS + " (" +
                COL_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
                COL_USER_ID + " TEXT UNIQUE, " +
                COL_NAME + " TEXT, " +
                COL_LAST_NAME + " TEXT, " +
                COL_DNI + " TEXT, " +
                COL_EMAIL + " TEXT, " +
                COL_PHONE_NUMBER + " TEXT, " +
                COL_DOB + " TEXT, " +
                COL_PASSWORD + " TEXT, " +
                COL_STREET + " TEXT, " +
                COL_STREET_NUMBER + " TEXT, " +
                COL_FLOOR + " TEXT, " +
                COL_POSTAL_CODE + " TEXT, " +
                COL_CITY + " TEXT, " +
                COL_REGION + " TEXT, " +
                COL_COUNTRY + " TEXT, " +
                COL_TOTAL_AMOUNT + " TEXT, " +
                COL_IBAN + " TEXT)";
        db.execSQL(createUserTableQuery);

        // Create transactions table
        String createTransactionsTableQuery = "CREATE TABLE " + TABLE_TRANSACTIONS + " (" +
                COL_TRANSACTION_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, " +
                COL_USER_ID + " TEXT, " + // Foreign key referencing user_id in users table
                COL_DESTINATION_IBAN + " TEXT, " +
                COL_RECIPIENT_PHONE_NUMBER + " TEXT, " +
                COL_PURPOSE_TRANSFER + " TEXT, " +
                COL_DATE + " TEXT, " +
                COL_AMOUNT_TRANSFER + " TEXT)";
        db.execSQL(createTransactionsTableQuery);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_USERS);
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_TRANSACTIONS);
        onCreate(db);
    }

    public boolean addUser(String userId, String name, String lastName, String dni, String email, String phoneNumber, String dob, String password, String street, String streetNumber, String floor, String postalCode, String city, String region, String country) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        String iban = generateUniqueIBAN();
        contentValues.put(COL_USER_ID, userId);
        contentValues.put(COL_NAME, name);
        contentValues.put(COL_LAST_NAME, lastName);
        contentValues.put(COL_DNI, dni);
        contentValues.put(COL_EMAIL, email);
        contentValues.put(COL_PHONE_NUMBER, phoneNumber);
        contentValues.put(COL_DOB, dob);
        contentValues.put(COL_PASSWORD, password);
        contentValues.put(COL_STREET, street);
        contentValues.put(COL_STREET_NUMBER, streetNumber);
        contentValues.put(COL_FLOOR, floor);
        contentValues.put(COL_POSTAL_CODE, postalCode);
        contentValues.put(COL_CITY, city);
        contentValues.put(COL_REGION, region);
        contentValues.put(COL_COUNTRY, country);
        contentValues.put(COL_TOTAL_AMOUNT, 20000.0);
        contentValues.put(COL_IBAN, iban);
         Log.d("dataaa", contentValues+"  ");
        long result = db.insert(TABLE_USERS, null, contentValues);
        Log.d("dataaa", result+"  ");
        return result != -1;
    }

    public boolean checkEmail(String email) {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery("SELECT * FROM " + TABLE_USERS + " WHERE " + COL_DNI + "=?", new String[]{email});
        return cursor.getCount() <= 0;
    }

    public boolean checkLogin(String email, String password) {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery("SELECT * FROM " + TABLE_USERS + " WHERE " + COL_DNI + "=? AND " + COL_PASSWORD + "=?", new String[]{email, password});
        return cursor.getCount() > 0;
    }

    public UserData getUserData(String userId) {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery("SELECT * FROM " + TABLE_USERS + " WHERE " + COL_USER_ID + "=?", new String[]{userId});
        if (cursor.moveToFirst()) {
            @SuppressLint("Range") String name = cursor.getString(cursor.getColumnIndex(COL_NAME));
            @SuppressLint("Range") String lastName = cursor.getString(cursor.getColumnIndex(COL_LAST_NAME));
            @SuppressLint("Range") String dni = cursor.getString(cursor.getColumnIndex(COL_DNI));
            @SuppressLint("Range") String email = cursor.getString(cursor.getColumnIndex(COL_EMAIL));
            @SuppressLint("Range") String phoneNumber = cursor.getString(cursor.getColumnIndex(COL_PHONE_NUMBER));
            @SuppressLint("Range") String dob = cursor.getString(cursor.getColumnIndex(COL_DOB));
            @SuppressLint("Range") String password = cursor.getString(cursor.getColumnIndex(COL_PASSWORD));
            @SuppressLint("Range") String street = cursor.getString(cursor.getColumnIndex(COL_STREET));
            @SuppressLint("Range") String streetNumber = cursor.getString(cursor.getColumnIndex(COL_STREET_NUMBER));
            @SuppressLint("Range") String floor = cursor.getString(cursor.getColumnIndex(COL_FLOOR));
            @SuppressLint("Range") String postalCode = cursor.getString(cursor.getColumnIndex(COL_POSTAL_CODE));
            @SuppressLint("Range") String city = cursor.getString(cursor.getColumnIndex(COL_CITY));
            @SuppressLint("Range") String region = cursor.getString(cursor.getColumnIndex(COL_REGION));
            @SuppressLint("Range") String country = cursor.getString(cursor.getColumnIndex(COL_COUNTRY));
            @SuppressLint("Range") String total_amount = cursor.getString(cursor.getColumnIndex(COL_TOTAL_AMOUNT));
            @SuppressLint("Range") String iban = cursor.getString(cursor.getColumnIndex(COL_IBAN));

            return new UserData(name, lastName, dni, email, phoneNumber, dob, password, street, streetNumber, floor, postalCode, city, region, country, total_amount, iban);
        }
        cursor.close();
        return null;
    }

    public boolean updateUserData(String userId, String name, String lastName, String dni, String email, String phoneNumber, String dob, String password, String street, String streetNumber, String floor, String postalCode, String city, String region, String country, String total_amount, String iban) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_NAME, name);
        contentValues.put(COL_LAST_NAME, lastName);
        contentValues.put(COL_DNI, dni);
        contentValues.put(COL_EMAIL, email);
        contentValues.put(COL_PHONE_NUMBER, phoneNumber);
        contentValues.put(COL_DOB, dob);
        contentValues.put(COL_PASSWORD, password);
        contentValues.put(COL_STREET, street);
        contentValues.put(COL_STREET_NUMBER, streetNumber);
        contentValues.put(COL_FLOOR, floor);
        contentValues.put(COL_POSTAL_CODE, postalCode);
        contentValues.put(COL_CITY, city);
        contentValues.put(COL_REGION, region);
        contentValues.put(COL_COUNTRY, country);
        contentValues.put(COL_TOTAL_AMOUNT, total_amount);
        contentValues.put(COL_IBAN, iban);

        int result = db.update(TABLE_USERS, contentValues, COL_USER_ID + "=?", new String[]{userId});
        return result > 0;
    }

    public boolean addUserTransferData(String userId, String date, String destinationIBAN, String recipientPhoneNumber, String purposeOfTransfer, String amountToTransfer) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_USER_ID, userId); // Add user_id to associate transaction with user
        contentValues.put(COL_DESTINATION_IBAN, destinationIBAN);
        contentValues.put(COL_RECIPIENT_PHONE_NUMBER, recipientPhoneNumber);
        contentValues.put(COL_PURPOSE_TRANSFER, purposeOfTransfer);
        contentValues.put(COL_AMOUNT_TRANSFER, amountToTransfer);
        contentValues.put(COL_DATE, date);
        long result = db.insert(TABLE_TRANSACTIONS, null, contentValues);
        return result != -1;
    }

    public List<UserTransferData> getAllUserTransferData(String userId) {
        List<UserTransferData> transferDataList = new ArrayList<>();
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery("SELECT * FROM " + TABLE_TRANSACTIONS + " WHERE " + COL_USER_ID + "=?", new String[]{userId});
        try {
            if (cursor != null && cursor.moveToFirst()) {
                do {
                    @SuppressLint("Range") String destinationIBAN = cursor.getString(cursor.getColumnIndex(COL_DESTINATION_IBAN));
                    @SuppressLint("Range") String recipientPhoneNumber = cursor.getString(cursor.getColumnIndex(COL_RECIPIENT_PHONE_NUMBER));
                    @SuppressLint("Range") String purposeOfTransfer = cursor.getString(cursor.getColumnIndex(COL_PURPOSE_TRANSFER));
                    @SuppressLint("Range") String amountToTransfer = cursor.getString(cursor.getColumnIndex(COL_AMOUNT_TRANSFER));
                    @SuppressLint("Range") String date = cursor.getString(cursor.getColumnIndex(COL_DATE));
                    if (!TextUtils.isEmpty(amountToTransfer)) {
                        UserTransferData transferData = new UserTransferData(date, destinationIBAN, recipientPhoneNumber, purposeOfTransfer, amountToTransfer);
                        transferDataList.add(transferData);
                    }
                } while (cursor.moveToNext());
            }
        } catch (Exception e) {
            Log.e("DatabaseHelper", "Error reading data from cursor: " + e.getMessage());
        } finally {
            if (cursor != null) {
                cursor.close();
            }
        }
        return transferDataList;
    }

    private String generateUniqueIBAN() {
        ibanCounter = Stash.getInt(IBAN_COUNTER_KEY, 1);
        String ibanNumber = IBAN_PREFIX +" "+ String.format("%04d", ibanCounter);
        ibanCounter++;
        Stash.put(IBAN_COUNTER_KEY, ibanCounter);
        return ibanNumber;
    }

    public boolean updateAmountByDNI(String dni, String newAmount) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put(COL_TOTAL_AMOUNT, newAmount);

        // Update the transactions table where the user's DNI matches
        int result = db.update(TABLE_USERS, contentValues, COL_DNI + "=?", new String[]{dni});
        return result > 0;
    }

}
