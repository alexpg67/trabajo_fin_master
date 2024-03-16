package com.tfm.kyc.model;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;
import org.springframework.data.mongodb.core.index.Indexed;

@Data
public class TitularData {
    @NotEmpty
    @Pattern(regexp = "^[a-zA-ZñÑáéíóúÁÉÍÓÚüÜñ]+$")
    private String name;
    @NotEmpty
//    @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,2}$")
//    @Pattern(regexp="^(?:\\w+\\W*){1,2}$")
    @Pattern(regexp="^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,2}$")
    private String givenName;
    @NotEmpty
//    @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,2}$")
    @Pattern(regexp="^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,2}$")
    private String familyName;
    @Indexed //No son unicos ya que en un pack familiar, solo tenemos los datos del titular (Multiples MSISDN con mismos datos)
    @NotEmpty
    @Pattern(regexp = "^[0-9]{8}[A-Za-z]$") //OJO!! para KYC puede ser DNI no solo de España.
    private String idDocument;
    @Indexed //No son unicos ya que en un pack familiar, solo tenemos los datos del titular (Multiples MSISDN con mismos datos)
    @NotEmpty
    @Email
    private String email;
    @NotEmpty
    @Pattern(regexp = "^(Masculino|Femenino)$")
    private String gender;
    @NotEmpty
    @Pattern(regexp = "^\\d{4}-\\d{2}-\\d{2}$") //La fecha de nacimiento debe estar en formato ISO 8601 (YYYY-MM-DD).
    private String birthdate;
    @NotNull
    @Valid
    private Address address;
}