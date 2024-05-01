package com.tfm.myapplication.Model;

public class UserData {
    private String name;
    private String lastName;
    private String dni;
    private String email;
    private String phoneNumber;
    private String dob;
    private String password;
    private String street;
    private String streetNumber;
    private String floor;
    private String postalCode;
    private String city;
    private String region;
    private String country;
    private String amount;
    private String iban;

    public UserData(String name, String lastName, String dni, String email, String phoneNumber, String dob, String password, String street, String streetNumber, String floor, String postalCode, String city, String region, String country, String amount, String iban) {
        this.name = name;
        this.lastName = lastName;
        this.dni = dni;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.dob = dob;
        this.password = password;
        this.street = street;
        this.streetNumber = streetNumber;
        this.floor = floor;
        this.postalCode = postalCode;
        this.city = city;
        this.region = region;
        this.country = country;
        this.amount = amount;
        this.iban = iban;
    }

    public String getName() {
        return name;
    }

    public String getLastName() {
        return lastName;
    }

    public String getDni() {
        return dni;
    }

    public String getEmail() {
        return email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public String getDob() {
        return dob;
    }

    public String getPassword() {
        return password;
    }

    public String getStreet() {
        return street;
    }

    public String getStreetNumber() {
        return streetNumber;
    }

    public String getFloor() {
        return floor;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public String getCity() {
        return city;
    }

    public String getRegion() {
        return region;
    }

    public String getCountry() {
        return country;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getIban() {
        return iban;
    }

    public void setIban(String iban) {
        this.iban = iban;
    }
}
