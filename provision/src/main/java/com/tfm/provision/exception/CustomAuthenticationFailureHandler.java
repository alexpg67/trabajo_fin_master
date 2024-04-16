//package com.tfm.provision.exception;
//
//import com.fasterxml.jackson.databind.ObjectMapper;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.security.core.AuthenticationException;
//import org.springframework.security.web.AuthenticationEntryPoint;
//import org.springframework.security.web.authentication.AuthenticationFailureHandler;
//import org.springframework.stereotype.Component;
//import org.springframework.web.bind.annotation.ControllerAdvice;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.util.HashMap;
//import java.util.LinkedHashMap;
//import java.util.Map;
//
//@ControllerAdvice
//@Component
//public class CustomAuthenticationFailureHandler implements AuthenticationEntryPoint {
//
//    private final ObjectMapper objectMapper = new ObjectMapper();
//
//
//
//    @Override
//    public void commence(HttpServletRequest request, HttpServletResponse response,
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
//}
