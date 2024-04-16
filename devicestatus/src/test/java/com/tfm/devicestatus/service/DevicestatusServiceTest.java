package com.tfm.devicestatus.service;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.tfm.devicestatus.controller.DevicestatusController;
import com.tfm.devicestatus.exception.CustomException;
import com.tfm.devicestatus.model.Address;
import com.tfm.devicestatus.model.Client;
import com.tfm.devicestatus.model.RoamingResponse;
import com.tfm.devicestatus.model.TitularData;
import com.tfm.devicestatus.repository.DevicestatusRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.http.HttpStatus;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;
import java.util.Optional;

import static com.mongodb.internal.connection.tlschannel.util.Util.assertTrue;
import static org.junit.jupiter.api.Assertions.*;

@WebMvcTest(DevicestatusController.class)
@Import({ DevicestatusService.class })
public class DevicestatusServiceTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private DevicestatusRepository devicestatusRepository;

    //    @InjectMocks
    @Autowired
    private DevicestatusService devicestatusService;
    @MockBean
    private StringRedisTemplate redisTemplate;
    @Autowired
    private ObjectMapper objectMapper;
    @Mock
    private ValueOperations<String, String> valueOperations;
    @BeforeEach
    void setUp() {
        Mockito.when(redisTemplate.opsForValue()).thenReturn(valueOperations);
    }
    @Test
    public void testDeviceStatusServiceValid() throws Exception {

        String msisdn = "+34623456701";
        Client cliente = new Client(msisdn, "214070000", 214, "0", 120, true, null, "2024-02-11T12:30:10.360+01:00");
        String expectedCountry = "Spain";

        Mockito.when(devicestatusRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.of(cliente));
//        Mockito.when(valueOperations.get("214")).thenReturn(expectedCountry);


        RoamingResponse response = devicestatusService.getRoaming(msisdn);

        assertEquals(214, response.getCountryCode());
        assertEquals(List.of(), response.getCountryName());
        assertFalse(response.isRoaming());





    }

    @Test
    public void testGetRoamingWhenRoaming() throws Exception {
        // Given
        String msisdn = "+34623456701";
        Client cliente = new Client(msisdn, "124070000", 214, "0", 120, true, null, "2024-02-11T12:30:10.360+01:00");
        String expectedCountry = "Spain";

        Mockito.when(devicestatusRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.of(cliente));
        Mockito.when(valueOperations.get("214")).thenReturn(expectedCountry);


        RoamingResponse response = devicestatusService.getRoaming(msisdn);
        assertTrue(response.isRoaming());
        assertEquals(214, response.getCountryCode());
        assertEquals(List.of(expectedCountry), response.getCountryName());
    }

    @Test
    public void testGetRoamingMsisdnNotFound() throws Exception {
        // Given
        String msisdn = "+34623456701";

        Mockito.when(devicestatusRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.empty());

        CustomException thrown = assertThrows(CustomException.class, () -> {
            devicestatusService.getRoaming(msisdn);
        }, "Expected getRoaming() to throw, but it didn't");

        assertEquals(HttpStatus.NOT_FOUND, thrown.getStatus());
        assertEquals("NOT_FOUND", thrown.getCode());
        assertEquals("The specified resource is not found", thrown.getMessage());

    }

}
