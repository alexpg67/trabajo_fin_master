package com.tfm.simswap.model;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;

public class CheckDTO {


    @Pattern(regexp = "^\\+?[0-9]{5,15}$")
    @NotEmpty
    private String phoneNumber;
   @Min(value = 1)
   @Max(value = 2400)
   private int maxAge;

    public CheckDTO() {
    }

    public CheckDTO(String phoneNumber, int maxAge){
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
