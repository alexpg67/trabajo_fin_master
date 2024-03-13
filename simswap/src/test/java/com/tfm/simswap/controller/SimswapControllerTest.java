package com.tfm.simswap.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tfm.simswap.model.Address;
import com.tfm.simswap.model.Client;
import com.tfm.simswap.model.MsisdnDTO;
import com.tfm.simswap.model.TitularData;
import com.tfm.simswap.service.SimswapService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(SimswapController.class)

public class SimswapControllerTest {


    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private SimswapService service;

    @Autowired
    private ObjectMapper objectMapper;



    @Test
    public void testMsisdnFound() throws Exception {
        String requestURI = "http://localhost:8083/sim-swap/v0/retrieve-data";

        MsisdnDTO input = new MsisdnDTO("+34623456789");

        Address address = new Address();
        // Configuraciones de address

        TitularData titularData = new TitularData();
        // Configuraciones de titularData

        Client cliente = new Client("+34668", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

        // Envuelve el cliente en un Optional para el mock
        Mockito.when(service.getClient(Mockito.anyString())).thenReturn(Optional.of(cliente));

        String jsonCliente = objectMapper.writeValueAsString(input);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())
                .andExpect(content().json(objectMapper.writeValueAsString(Collections.singletonMap("latestSimChange", cliente.getLatestSimChange()))))
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andDo(print());
    }


    @Test
    public void testMsisdnNotFound() throws Exception {
        String requestURI = "http://localhost:8083/sim-swap/v0/retrieve-data";

        MsisdnDTO input = new MsisdnDTO("+34623456789");

        Address address = new Address();
        // Configuraciones de address

        TitularData titularData = new TitularData();
        // Configuraciones de titularData

        Client cliente = new Client("+34668", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

        // Envuelve el cliente en un Optional para el mock
        Mockito.when(service.getClient(Mockito.anyString())).thenReturn(Optional.empty());

        String jsonCliente = objectMapper.writeValueAsString(input);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isNotFound())
//                .andExpect(content().json(objectMapper.writeValueAsString(Collections.singletonMap("latestSimChange", cliente.getLatestSimChange()))))
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(content().json("{\"status\":404,\"message\":\"SIM Swap can't be checked because the phone number is unknown\"}"))
                .andDo(print());
    }

    @Test
    public void testMsisdnNotValid() throws Exception {
        String requestURI = "http://localhost:8083/sim-swap/v0/retrieve-data";

        MsisdnDTO input = new MsisdnDTO("+3462345678h");

        Address address = new Address();
        // Configuraciones de address

        TitularData titularData = new TitularData();
        // Configuraciones de titularData

        Client cliente = new Client("+34668", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

        // Envuelve el cliente en un Optional para el mock
        Mockito.when(service.getClient(Mockito.anyString())).thenReturn(Optional.empty());

        String jsonCliente = objectMapper.writeValueAsString(input);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())
//                .andExpect(content().json(objectMapper.writeValueAsString(Collections.singletonMap("latestSimChange", cliente.getLatestSimChange()))))
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
//                .andExpect(content().json("{\"status\":404,\"message\":\"SIM Swap can't be checked because the phone number is unknown\"}"))
                .andDo(print());
    }

    @Test
    public void testMsisdnNotProvided() throws Exception {
        String requestURI = "http://localhost:8083/sim-swap/v0/retrieve-data";

        MsisdnDTO input = new MsisdnDTO("");

        Address address = new Address();
        // Configuraciones de address

        TitularData titularData = new TitularData();
        // Configuraciones de titularData

        Client cliente = new Client("+34668", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

        // Envuelve el cliente en un Optional para el mock
        Mockito.when(service.getClient(Mockito.anyString())).thenReturn(Optional.empty());

        String jsonCliente = objectMapper.writeValueAsString(input);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())
//                .andExpect(content().json(objectMapper.writeValueAsString(Collections.singletonMap("latestSimChange", cliente.getLatestSimChange()))))
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
//                .andExpect(content().json("{\"status\":404,\"message\":\"SIM Swap can't be checked because the phone number is unknown\"}"))
                .andDo(print());
    }
}
