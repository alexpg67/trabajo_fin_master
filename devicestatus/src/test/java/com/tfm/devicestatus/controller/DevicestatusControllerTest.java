package com.tfm.devicestatus.controller;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.tfm.devicestatus.exception.CustomException;
import com.tfm.devicestatus.model.ApiInputDTO;
import com.tfm.devicestatus.model.RoamingResponse;
import com.tfm.devicestatus.model.UeIdDTO;
import com.tfm.devicestatus.service.DevicestatusService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Optional;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(DevicestatusController.class)
public class DevicestatusControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private DevicestatusService service;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    public void testValidCase() throws Exception {
        String requestURI = "http://localhost:8084/device-status/v0/roaming";

        UeIdDTO ueIdDTOinput = new UeIdDTO("","+34623456701","","");
        ApiInputDTO input = new ApiInputDTO(ueIdDTOinput,5000);

        RoamingResponse response = new RoamingResponse(true, 748, new ArrayList<>(Arrays.asList("Uruguay")));
        // Envuelve el cliente en un Optional para el mock
        Mockito.when(service.getRoaming(Mockito.anyString())).thenReturn(response);

        String jsonCliente = objectMapper.writeValueAsString(input);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())
                .andExpect(content().json(objectMapper.writeValueAsString(response)))
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andDo(print());
    }

    @Test
    public void testServiceLaunchException() throws Exception {
        String requestURI = "http://localhost:8084/device-status/v0/roaming";

        UeIdDTO ueIdDTOinput = new UeIdDTO("","+34623456701","","");
        ApiInputDTO input = new ApiInputDTO(ueIdDTOinput,5000);

        RoamingResponse response = new RoamingResponse(true, 748, new ArrayList<>(Arrays.asList("Uruguay")));
        // Envuelve el cliente en un Optional para el mock
        Mockito.when(service.getRoaming(Mockito.anyString())).thenThrow(new CustomException(HttpStatus.NOT_FOUND, "NOT_FOUND", "The specified resource is not found"));

        String jsonCliente = objectMapper.writeValueAsString(input);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isNotFound())
//                .andExpect(content().json(objectMapper.writeValueAsString(response)))
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andDo(print());
    }

    @Test
    public void testInvalidMsisdn() throws Exception {
        String requestURI = "http://localhost:8084/device-status/v0/roaming";

        UeIdDTO ueIdDTOinput = new UeIdDTO("","+3462345670h","","");
        ApiInputDTO input = new ApiInputDTO(ueIdDTOinput,5000);

        RoamingResponse response = new RoamingResponse(true, 748, new ArrayList<>(Arrays.asList("Uruguay")));
        // Envuelve el cliente en un Optional para el mock
        Mockito.when(service.getRoaming(Mockito.anyString())).thenThrow(new CustomException(HttpStatus.NOT_FOUND, "NOT_FOUND", "The specified resource is not found"));

        String jsonCliente = objectMapper.writeValueAsString(input);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())
//                .andExpect(content().json(objectMapper.writeValueAsString(response)))
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andDo(print());
    }

}
