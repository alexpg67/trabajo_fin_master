package com.tfm.devicestatus.model;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class Address {
    @NotEmpty
//    @Pattern(regexp = "^[a-zA-Z]+$") //Si pones Calle Gran via se te lia
//    @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,5}$")
    @Pattern(regexp="^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,5}$")
    private String streetName;
    @NotEmpty
    @Pattern(regexp = "^[0-9]{1,7}$")
    private String streetNumber;
    @NotEmpty
    @Pattern(regexp = "^[0-9]{1,7}$")
    private String postalCode;
    @NotEmpty
//    @Pattern(regexp = "^[a-zA-Z]+$")
//    @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,4}$")
    @Pattern(regexp="^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$")
    private String region;
    @NotEmpty
//    @Pattern(regexp = "^[a-zA-Z]+$")
//    @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,4}$")
    @Pattern(regexp="^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$")
    private String locality;
    @NotEmpty
//    @Pattern(regexp = "^[a-zA-Z]+$")
//    @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,4}$")
    @Pattern(regexp="^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$")
    private String country;
    @NotEmpty
    private String houseNumberExtension;
}
