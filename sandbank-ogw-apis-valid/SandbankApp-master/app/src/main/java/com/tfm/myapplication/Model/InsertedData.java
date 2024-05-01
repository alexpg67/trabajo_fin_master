package com.tfm.myapplication.Model;

public class InsertedData {

    private String dni;
    private String name;
    private String lastName;
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

    public InsertedData(String dni, String name, String lastName, String email, String phoneNumber, String dob, String password, String street, String streetNumber, String floor, String postalCode, String city, String region, String country) {
        this.dni = dni;
        this.name = name;
        this.lastName = lastName;
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
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public void setStreetNumber(String streetNumber) {
        this.streetNumber = streetNumber;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getDni() {
        return dni;
    }

    public String getName() {
        return name;
    }

    public String getLastName() {
        return lastName;
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
}
