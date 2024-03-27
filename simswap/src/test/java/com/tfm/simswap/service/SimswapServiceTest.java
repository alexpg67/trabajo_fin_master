package com.tfm.simswap.service;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.tfm.simswap.controller.SimswapController;
import com.tfm.simswap.exception.CustomException;
import com.tfm.simswap.model.CheckDTO;
import com.tfm.simswap.model.Client;
import com.tfm.simswap.repository.SimswapRepository;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpStatus;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@WebMvcTest(SimswapController.class)
@Import({ SimswapService.class })
public class SimswapServiceTest {
    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private SimswapRepository simswapRepository;

    //    @InjectMocks
    @Autowired
    private SimswapService simswapService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    public void testSimswapServiceValid() throws Exception {

        CheckDTO input = new CheckDTO("+34658763452",300);
        String msisdn = input.getPhoneNumber();
        Client cliente = new Client(msisdn, "214070000", 214, "0", 120, true, null, "2024-03-15T12:30:10.360+01:00");


        Mockito.when(simswapRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.of(cliente));
//        Mockito.when(valueOperations.get("214")).thenReturn(expectedCountry);


       Boolean response = simswapService.checkSwap(input);

        assertTrue(response);





    }

    @Test
    public void testSimswapServiceFalse() throws Exception {

        CheckDTO input = new CheckDTO("+34658763452",10);
        String msisdn = input.getPhoneNumber();
        Client cliente = new Client(msisdn, "214070000", 214, "0", 120, true, null, "2024-03-05T12:30:10.360+01:00");


        Mockito.when(simswapRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.of(cliente));
//        Mockito.when(valueOperations.get("214")).thenReturn(expectedCountry);


        Boolean response = simswapService.checkSwap(input);

        assertFalse(response);





    }


    @Test
    public void testSimswapServiceMsisdnNotFound() throws Exception {

        CheckDTO input = new CheckDTO("+34658763452",10);
        String msisdn = input.getPhoneNumber();
        Client cliente = new Client(msisdn, "214070000", 214, "0", 120, true, null, "2024-03-05T12:30:10.360+01:00");

        Mockito.when(simswapRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.empty());

        CustomException thrown = assertThrows(CustomException.class, () -> {
            simswapService.checkSwap(input);
        }, "Expected getRoaming() to throw, but it didn't");

        assertEquals(HttpStatus.NOT_FOUND, thrown.getStatus());
        assertEquals("SIM_SWAP.UNKNOWN_PHONE_NUMBER", thrown.getCode());
        assertEquals("SIM Swap can't be checked because the phone number is unknown", thrown.getMessage());




    }


}
