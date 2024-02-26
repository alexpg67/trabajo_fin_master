package com.tfm.simswap.dev;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
@Data
@Document
public class Client {
    @Id
    private String id;
    private String msisdn;
    private String name;
    private String lastName;
    private String email;


    public Client(String msisdn, String name, String lastName, String email) {
        this.msisdn = msisdn;
        this.name = name;
        this.lastName = lastName;
        this.email = email;
    }
}