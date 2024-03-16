package com.tfm.devicestatus.model;

import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Data
@Document(collection = "client_muestra")
public class Client {
    @Id
    private String id;
   @Indexed(unique = true)
   @Pattern(regexp = "^\\+?[0-9]{5,15}$")
   @NotEmpty
    private String msisdn;
   @NotEmpty
   @Indexed(unique = true)
   @Pattern(regexp = "^[0-9]{3}[0-9]{2,3}[0-9]{1,10}$")
    private String imsi;
    @Min(value = 0)
    @Max(value = 999)
    @NotNull
    private int mcc;
//    @Min(value = 0)
//    @Max(value = 999)
//    @NotNull
//    private int mnc;
    @Pattern(regexp = "^[0-9]{2,3}$")
    @NotNull
    private String mnc;
    @Field("cell_id")
    @Min(value = 0)
    @Max(value = 9999)
    @NotNull
    private int cellId;
    @NotNull
    private boolean titular;
    @Field("titular_data")
    @NotNull
    @Valid
    private TitularData titularData;
//Añadir en codigo esta variable
    private String latestSimChange;

    public Client(String msisdn, String imsi, int mcc, String mnc, int cellId, boolean titular, TitularData titularData, String latestSimChange) {
        this.msisdn = msisdn;
        this.imsi = imsi;
        this.mcc = mcc;
        this.mnc = mnc;
        this.cellId = cellId;
        this.titular = titular;
        this.titularData = titularData;
        this.latestSimChange=latestSimChange;
    }
}


