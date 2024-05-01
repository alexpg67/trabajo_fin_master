package com.tfm.myapplication.Model;



public class SimSwapCheckDto {


    private String phoneNumber;

    private int maxAge;

    public SimSwapCheckDto() {
    }

    public SimSwapCheckDto(String phoneNumber, int maxAge){
        this.phoneNumber = phoneNumber;
        this.maxAge = maxAge;
    }
    // Getter y Setter

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public int getMaxAge() {
        return maxAge;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setMaxAge(int maxAge) {
        this.maxAge = maxAge;
    }
}

