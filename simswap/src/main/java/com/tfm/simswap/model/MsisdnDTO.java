package com.tfm.simswap.model;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;

public class MsisdnDTO {

    @Pattern(regexp = "^\\+?[0-9]{5,15}$")
    @NotEmpty
    private String phoneNumber;

    public MsisdnDTO() {
    }

    public MsisdnDTO(String phoneNumber){
        this.phoneNumber = phoneNumber;
    }
    // Getter y Setter
    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
}