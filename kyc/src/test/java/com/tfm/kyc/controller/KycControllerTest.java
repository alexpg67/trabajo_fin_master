package com.tfm.kyc.controller;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.tfm.kyc.exception.CustomException;
import com.tfm.kyc.model.*;
import com.tfm.kyc.service.KycService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Collections;
import java.util.Optional;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(KycController.class)
public class KycControllerTest {


    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private KycService service;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    public void testValidResponse() throws Exception {
        String requestURI = "http://localhost:8085/kyc-match/v0/match";


        ApiInputDTO input = new ApiInputDTO( "+34678901234",
                 "87654321I",
               "Sofía Hernández",
                "Sofía",
               "Hernández",
                "",
                 "Ｆｅｄｅ",
                 "Sanchez",
                "YYYY",
                 "Carrer De MALlorca 100",
                 "Carrer de Mallorca",
                 "100",
               "08029",
               "Barcelona",
               "Barcelona",
                "España",
                "I",
                 "1984-07-25",
                "sofia@example.com",
                 "FEMale");

        ResponseDTO responseDTO = new ResponseDTO();
        responseDTO.setIdDocumentMatch("true");
        responseDTO.setNameMatch("true");
        responseDTO.setGivenNameMatch("true");
        responseDTO.setFamilyNameMatch("true");
        responseDTO.setNameKanaHankakuMatch("not_available");
        responseDTO.setNameKanaZenkakuMatch("not_available");
        responseDTO.setMiddleNamesMatch("not_available");
        responseDTO.setFamilyNameAtBirthMatch("not_available");
        responseDTO.setAddressMatch("true");
        responseDTO.setStreetNameMatch("true");
        responseDTO.setStreetNumberMatch("true");
        responseDTO.setPostalCodeMatch("true");
        responseDTO.setRegionMatch("true");
        responseDTO.setLocalityMatch("true");
        responseDTO.setCountryMatch("true");
        responseDTO.setHouseNumberExtensionMatch("true");
        responseDTO.setBirthdateMatch("true");
        responseDTO.setEmailMatch("true");
        responseDTO.setGenderMatch("true");

        Mockito.when(service.matchData(Mockito.any())).thenReturn(responseDTO);

        String jsonCliente = objectMapper.writeValueAsString(input);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())
                .andExpect(content().json(objectMapper.writeValueAsString(responseDTO)))
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andDo(print());
    }

    @Test
    public void testExceptionResponse() throws Exception {
        String requestURI = "http://localhost:8085/kyc-match/v0/match";


        ApiInputDTO input = new ApiInputDTO( "+34678901234",
                "87654321I",
                "Sofía Hernández",
                "Sofía",
                "Hernández",
                "",
                "Ｆｅｄｅ",
                "Sanchez",
                "YYYY",
                "Carrer De MALlorca 100",
                "Carrer de Mallorca",
                "100",
                "08029",
                "Barcelona",
                "Barcelona",
                "España",
                "I",
                "1984-07-25",
                "sofia@example.com",
                "FEMale");

        ResponseDTO responseDTO = new ResponseDTO();
        responseDTO.setIdDocumentMatch("true");
        responseDTO.setNameMatch("true");
        responseDTO.setGivenNameMatch("true");
        responseDTO.setFamilyNameMatch("true");
        responseDTO.setNameKanaHankakuMatch("not_available");
        responseDTO.setNameKanaZenkakuMatch("not_available");
        responseDTO.setMiddleNamesMatch("not_available");
        responseDTO.setFamilyNameAtBirthMatch("not_available");
        responseDTO.setAddressMatch("true");
        responseDTO.setStreetNameMatch("true");
        responseDTO.setStreetNumberMatch("true");
        responseDTO.setPostalCodeMatch("true");
        responseDTO.setRegionMatch("true");
        responseDTO.setLocalityMatch("true");
        responseDTO.setCountryMatch("true");
        responseDTO.setHouseNumberExtensionMatch("true");
        responseDTO.setBirthdateMatch("true");
        responseDTO.setEmailMatch("true");
        responseDTO.setGenderMatch("true");

        Mockito.when(service.matchData(Mockito.any())).thenThrow(new CustomException(HttpStatus.NOT_FOUND, "NOT_FOUND", "not_found_contractor/not_found"));



        String jsonCliente = objectMapper.writeValueAsString(input);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isNotFound())
//                .andExpect(content().json(objectMapper.writeValueAsString(responseDTO)))
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andDo(print());
    }

}
