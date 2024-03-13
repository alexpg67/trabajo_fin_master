package com.tfm.simswap.exception;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.context.request.async.AsyncRequestTimeoutException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@ControllerAdvice
public class RestExceptionHandler extends ResponseEntityExceptionHandler {

    @ExceptionHandler(CustomException.class)
    protected ResponseEntity<Object> handleCustomException(CustomException cs) {
        Map<String, Object> responseBody = new LinkedHashMap<>();
        responseBody.put("status",cs.getStatus().value());
        responseBody.put("code", cs.getCode());
        responseBody.put("message", cs.getMessage());
        return new ResponseEntity<>(responseBody, cs.getStatus());
    }



    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex,
                                                                  HttpHeaders headers, HttpStatusCode status, WebRequest request) {
//
//            ApiError apiError =
//                    new ApiError(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
//            return new ResponseEntity<>(apiError, HttpStatus.BAD_REQUEST);

        Map<String, Object> responseBody = new LinkedHashMap<>();
        responseBody.put("status", HttpStatus.BAD_REQUEST);
        responseBody.put("code", "INVALID_ARGUMENT");
       // responseBody.put("status", status.value());

        List<String> errors = ex.getBindingResult().getFieldErrors()
                .stream()
                .map(x -> x.getDefaultMessage())
                .collect(Collectors.toList());

        responseBody.put("message", "Client specified an invalid argument, request body or query param");
        responseBody.put("errors", errors); //No es CAMARA, borrar para el API OGW

        return new ResponseEntity<>(responseBody, headers, status);
    }

    @ExceptionHandler(DuplicateKeyException.class)
    public ResponseEntity<Object> handleDuplicateKeyException(DuplicateKeyException ex) {
//            String errorMessage = "El valor proporcionado para el campo ya existe en la base de datos.";
//            return new ResponseEntity<>(errorMessage, HttpStatus.BAD_REQUEST);

        Map<String, Object> responseBody = new LinkedHashMap<>();
        responseBody.put("status", HttpStatus.CONFLICT.value());
        responseBody.put("code", "CONFLICT");
        // responseBody.put("status", status.value());



        responseBody.put("message", "Another request is created for the same MSISDN");


        return new ResponseEntity<>(responseBody, HttpStatus.CONFLICT);
    }


    @ExceptionHandler(HttpClientErrorException.Unauthorized.class)
    public ResponseEntity<Object> handleUnauthorizedException(HttpClientErrorException.Unauthorized ex) {
//            String errorMessage = "El valor proporcionado para el campo ya existe en la base de datos.";
//            return new ResponseEntity<>(errorMessage, HttpStatus.BAD_REQUEST);

        Map<String, Object> responseBody = new LinkedHashMap<>();
        responseBody.put("status", HttpStatus.UNAUTHORIZED.value());
        responseBody.put("code", "UNAUTHENTICATED");
        // responseBody.put("status", status.value());



        responseBody.put("message", "Request not authenticated due to missing, invalid, or expired credentials");


        return new ResponseEntity<>(responseBody, HttpStatus.UNAUTHORIZED);
    }



    @Override
    protected ResponseEntity<Object> handleExceptionInternal(Exception ex, @Nullable Object body, HttpHeaders headers, HttpStatusCode statusCode, WebRequest request) {
        Map<String, Object> responseBody = new LinkedHashMap<>();
        responseBody.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
        responseBody.put("code", "INTERNAL");
        // responseBody.put("status", status.value());


        responseBody.put("message", "Server error");


        return new ResponseEntity<>(responseBody, headers, HttpStatus.INTERNAL_SERVER_ERROR);
    }
//        @ExceptionHandler(ServiceUnavailableException.class)
//        public ResponseEntity<Object> handleServiceUnavailableException(ServiceUnavailableException ex, WebRequest request) {
//            Map<String, Object> responseBody = new LinkedHashMap<>();
//            responseBody.put("status", HttpStatus.SERVICE_UNAVAILABLE.value());
//            responseBody.put("code", "UNAVAILABLE");
//            responseBody.put("message", "Service unavailable");
//
//            return new ResponseEntity<>(responseBody, HttpStatus.SERVICE_UNAVAILABLE);
//        }

    @Override
    protected ResponseEntity<Object> handleAsyncRequestTimeoutException(AsyncRequestTimeoutException ex, HttpHeaders headers, HttpStatusCode status, WebRequest request)  {
        Map<String, Object> responseBody = new LinkedHashMap<>();
        responseBody.put("status", HttpStatus.GATEWAY_TIMEOUT.value());
        responseBody.put("code", "TIMEOUT");
        responseBody.put("message", "Request timeout exceeded. Try later");

        return new ResponseEntity<>(responseBody, HttpStatus.GATEWAY_TIMEOUT);
    }


    @ExceptionHandler(Exception.class)
    public ResponseEntity<Object> handleGenericException(Exception ex, WebRequest request) {
        Map<String, Object> responseBody = new LinkedHashMap<>();
        responseBody.put("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
        responseBody.put("code", "INTERNAL");
        responseBody.put("message", "Server error");

        return new ResponseEntity<>(responseBody, HttpStatus.INTERNAL_SERVER_ERROR);
    }

}

