package com.tfm.devicestatus.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class CustomException extends Exception {

    private final HttpStatus status;
    private final String code;
    private final String message;


    public CustomException(HttpStatus status, String code, String message) {
        this.status = status;
        this.code = code;
        this.message = message;

    }



}