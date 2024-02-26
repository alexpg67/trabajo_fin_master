package com.tfm.provision.exception;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ControllerAdvice;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
@Component
public class CustomAuthorizationFailureHandler implements AccessDeniedHandler {

    private final ObjectMapper objectMapper = new ObjectMapper();



//    @Override
//    public void handle(HttpServletRequest request, HttpServletResponse response,
//                         AuthenticationException authException) throws IOException {
//        response.setStatus(HttpStatus.UNAUTHORIZED.value());
//        response.setContentType("application/json");
//
//        Map<String, Object> responseBody = new HashMap<>();
//        responseBody.put("status", HttpStatus.UNAUTHORIZED.value());
//        responseBody.put("code", "UNAUTHENTICATED");
//        responseBody.put("message", "Request not authenticated due to missing, invalid, or expired credentials");
//
//        PrintWriter writer = response.getWriter();
//        objectMapper.writeValue(writer, responseBody);
//        writer.flush();;
//
//    }

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response,
                       AccessDeniedException exc) throws IOException {
        response.setStatus(HttpStatus.FORBIDDEN.value());
        response.setContentType("application/json");

        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("status", HttpStatus.FORBIDDEN.value());
        responseBody.put("code", "PERMISSION_DENIED");
        responseBody.put("message", "Client does not have sufficient permissions to perform this action");

        PrintWriter writer = response.getWriter();
        objectMapper.writeValue(writer, responseBody);
        writer.flush();;
    }
}
