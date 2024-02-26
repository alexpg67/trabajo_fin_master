package com.tfm.provision.service;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.tfm.provision.controller.ProvisionController;
import com.tfm.provision.exception.CustomException;
import com.tfm.provision.model.Address;
import com.tfm.provision.model.Client;
import com.tfm.provision.model.TitularData;
import com.tfm.provision.repository.ProvisionRepository;
import com.tfm.provision.security.SecurityConfiguration;
import com.tfm.provision.security.TestSecurityConfiguration;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

//@SpringBootTest
//@AutoConfigureMockMvc
@TestPropertySource(locations = "classpath:application-test.properties")
@WebMvcTest(ProvisionController.class)
@Import({TestSecurityConfiguration.class, ProvisionService.class })
@ActiveProfiles("test")
public class ProvisionServiceTest {


    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ProvisionRepository provisionRepository;

//    @InjectMocks
    @Autowired
    private ProvisionService provisionService;

    @Autowired
    private ObjectMapper objectMapper;


    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testProvisionServiceValidClient() throws Exception {
//        @Pattern(regexp = "^[0-9]{2,3}$")
//        @NotNull

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre");
        titularData.setGivenName("NombreCompleto");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "124070000", 124, "0", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());
        Mockito.when(provisionRepository.save(Mockito.any())).thenReturn(cliente);

        Client savedClient = provisionService.saveClient(cliente);

        assertNotNull(savedClient);
        assertEquals(cliente, savedClient);
        verify(provisionRepository, times(1)).save(cliente);


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testProvisionServiceInvalidTitularClientDuplicatedDni() throws Exception {


        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre");
        titularData.setGivenName("NombreCompleto");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "124070000", 124, "0", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        Client duplicadoCliente = new Client("+34668", "124070000", 124, "0", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of(duplicadoCliente));
        Mockito.when(provisionRepository.save(Mockito.any())).thenReturn(cliente);

//        Client savedClient = provisionService.saveClient(cliente);

        Assertions.assertThrows(CustomException.class, () -> provisionService.saveClient(cliente));


    }

//    @Test
//    @WithMockUser(username = "testuser", roles = {"USER"})
//    public void testProvisionServiceInvalidImsiFormat() throws Exception {
//
//
//        Address address = new Address();
//        address.setStreetName("Calle Ejemplo");
//        address.setStreetNumber("123");
//        address.setPostalCode("12345");
//        address.setRegion("Región Ejemplo");
//        address.setLocality("Localidad Ejemplo");
//        address.setCountry("País Ejemplo");
//        address.setHouseNumberExtension("A");
//
//        TitularData titularData = new TitularData();
//        titularData.setName("Nombre");
//        titularData.setGivenName("NombreCompleto");
//        titularData.setFamilyName("Apellido");
//        titularData.setIdDocument("12345678Z");
//        titularData.setEmail("email@example.com");
//        titularData.setGender("Masculino");
//        titularData.setBirthdate("2000-01-01");
//        titularData.setAddress(address);
//
//        Client cliente = new Client("+34668", "124070000", 125, "0", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
//
//
//        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());
//        Mockito.when(provisionRepository.save(Mockito.any())).thenReturn(cliente);
//
////        Client savedClient = provisionService.saveClient(cliente);
//
//        Assertions.assertThrows(CustomException.class, () -> provisionService.saveClient(cliente));
//
//
//    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testProvisionServiceLatestSimChangeFormat() throws Exception {


        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre");
        titularData.setGivenName("NombreCompleto");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "124070000", 124, "0", 120, true, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());
        Mockito.when(provisionRepository.save(Mockito.any())).thenReturn(cliente);

        Client savedClient = provisionService.saveClient(cliente);



        String latestSimChange = savedClient.getLatestSimChange();
        assertEquals(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX").format(ZonedDateTime.parse(latestSimChange)), latestSimChange);


    }

}
