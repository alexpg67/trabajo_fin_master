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
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
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

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientNotFound() throws Exception {


        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "124070000", 124, "0", 120, true, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.empty());


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.NOT_FOUND, thrown.getStatus());
        assertEquals("UNKNOWN_MSISDN", thrown.getCode());
        assertEquals("Can't be updated because the msisdn is unknown", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientImsiWrongFormat() throws Exception {


        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "1240700000867867556756", 126, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientMccWrongFormat() throws Exception {


        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "124070001", 999999, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientMncWrongFormat() throws Exception {


        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "124070001", 125, "1577", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientCellIdWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo Con Mas de 4 strings ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientNameWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo Con Mas de 4 strings ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientGivenNameWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre y Tres");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientFamilyNameWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido1 Apellido2 Apellido3?");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }
    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientIdDocumentWrong() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z*");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientEmailWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("emailexample.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientGenderWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Comp ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Helicoptero Apache");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientBirthdayWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("200001-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientStreetNameWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejepl9");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo  ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientStreetNumberWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123Hola");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientPostalCodeWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345A");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientRegionWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo 9");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientLocalityWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo9");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo  ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientCountryWrongFormat() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo akdgsa ajkldh lashj askjf");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));


        // Ejecución y verificación
        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientValidInput() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, false, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());
        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of());
        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));
        Mockito.when(provisionRepository.save(Mockito.any())).thenReturn(cliente);


        // Ejecución y verificación
//        CustomException thrown = assertThrows(CustomException.class, () -> {
//            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
//        }, "Se esperaba CustomException");
//

        Client response = provisionService.updateClient(cliente);

        assertEquals(cliente.getMsisdn(), response.getMsisdn());
        assertEquals(cliente.getImsi(), response.getImsi());
        assertEquals(cliente.getMcc(), response.getMcc());
        assertEquals(cliente.getMnc(), response.getMnc());
        assertEquals(cliente.getCellId(), response.getCellId());
        assertEquals(cliente.isTitular(), response.isTitular());
        // Verificar atributos de TitularData
        assertEquals(cliente.getTitularData().getName(), response.getTitularData().getName());
        assertEquals(cliente.getTitularData().getGivenName(), response.getTitularData().getGivenName());
        assertEquals(cliente.getTitularData().getFamilyName(), response.getTitularData().getFamilyName());
        assertEquals(cliente.getTitularData().getIdDocument(), response.getTitularData().getIdDocument());
        assertEquals(cliente.getTitularData().getEmail(), response.getTitularData().getEmail());
        assertEquals(cliente.getTitularData().getGender(), response.getTitularData().getGender());
        assertEquals(cliente.getTitularData().getBirthdate(), response.getTitularData().getBirthdate());
        // Verificar atributos de Address
        assertEquals(cliente.getTitularData().getAddress().getStreetName(), response.getTitularData().getAddress().getStreetName());
        assertEquals(cliente.getTitularData().getAddress().getStreetNumber(), response.getTitularData().getAddress().getStreetNumber());
        assertEquals(cliente.getTitularData().getAddress().getPostalCode(), response.getTitularData().getAddress().getPostalCode());
        assertEquals(cliente.getTitularData().getAddress().getRegion(), response.getTitularData().getAddress().getRegion());
        assertEquals(cliente.getTitularData().getAddress().getLocality(), response.getTitularData().getAddress().getLocality());
        assertEquals(cliente.getTitularData().getAddress().getCountry(), response.getTitularData().getAddress().getCountry());
        assertEquals(cliente.getTitularData().getAddress().getHouseNumberExtension(), response.getTitularData().getAddress().getHouseNumberExtension());


    }


    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientValidInputTitular() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        //Hay ya uno en la BBDD que es el que quiero actualizar, pero solo hay 1. Si hay más da error.
        titularData.setIdDocument("");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, true, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");
        Client cliente2 = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");
        Client cliente3 = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of(cliente2));

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));
        Mockito.when(provisionRepository.save(Mockito.any())).thenReturn(cliente);



        Client response = provisionService.updateClient(cliente);

        assertEquals(cliente.getMsisdn(), response.getMsisdn());
        assertEquals(cliente.getImsi(), response.getImsi());
        assertEquals(cliente.getMcc(), response.getMcc());
        assertEquals(cliente.getMnc(), response.getMnc());
        assertEquals(cliente.getCellId(), response.getCellId());
        assertEquals(cliente.isTitular(), response.isTitular());
        // Verificar atributos de TitularData
        assertEquals(cliente.getTitularData().getName(), response.getTitularData().getName());
        assertEquals(cliente.getTitularData().getGivenName(), response.getTitularData().getGivenName());
        assertEquals(cliente.getTitularData().getFamilyName(), response.getTitularData().getFamilyName());
        assertEquals(cliente.getTitularData().getIdDocument(), response.getTitularData().getIdDocument());
        assertEquals(cliente.getTitularData().getEmail(), response.getTitularData().getEmail());
        assertEquals(cliente.getTitularData().getGender(), response.getTitularData().getGender());
        assertEquals(cliente.getTitularData().getBirthdate(), response.getTitularData().getBirthdate());
        // Verificar atributos de Address
        assertEquals(cliente.getTitularData().getAddress().getStreetName(), response.getTitularData().getAddress().getStreetName());
        assertEquals(cliente.getTitularData().getAddress().getStreetNumber(), response.getTitularData().getAddress().getStreetNumber());
        assertEquals(cliente.getTitularData().getAddress().getPostalCode(), response.getTitularData().getAddress().getPostalCode());
        assertEquals(cliente.getTitularData().getAddress().getRegion(), response.getTitularData().getAddress().getRegion());
        assertEquals(cliente.getTitularData().getAddress().getLocality(), response.getTitularData().getAddress().getLocality());
        assertEquals(cliente.getTitularData().getAddress().getCountry(), response.getTitularData().getAddress().getCountry());
        assertEquals(cliente.getTitularData().getAddress().getHouseNumberExtension(), response.getTitularData().getAddress().getHouseNumberExtension());


    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientInvalidInputTitular() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        //Hay ya uno en la BBDD que es el que quiero actualizar, pero solo hay 1. Si hay más da error.
        titularData.setIdDocument("");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, true, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");
        Client cliente2 = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");
        Client cliente3 = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of(cliente2,cliente3));

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));
        Mockito.when(provisionRepository.save(Mockito.any())).thenReturn(cliente);



        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());



    }

    @Test
    @WithMockUser(username = "testuser", roles = {"USER"})
    public void testUpdateClientInvalidInputTitularIdDocumentNotEmpty() throws Exception {




        Address existingAddress = new Address();
        existingAddress.setStreetName("Calle Ejemplo");
        existingAddress.setStreetNumber("123");
        existingAddress.setPostalCode("12345");
        existingAddress.setRegion("Región Ejemplo");
        existingAddress.setLocality("Localidad Ejemplo");
        existingAddress.setCountry("País Ejemplo");
        existingAddress.setHouseNumberExtension("A");

        TitularData existingTitularData = new TitularData();
        existingTitularData.setName("Nombre Completo ");
        existingTitularData.setGivenName("Nombre");
        existingTitularData.setFamilyName("Apellido");
        existingTitularData.setIdDocument("12345678Z");
        existingTitularData.setEmail("email@example.com");
        existingTitularData.setGender("Masculino");
        existingTitularData.setBirthdate("2000-01-01");
        existingTitularData.setAddress(existingAddress);

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Nombre Completo ");
        titularData.setGivenName("Nombre");
        titularData.setFamilyName("Apellido");
        //Hay ya uno en la BBDD que es el que quiero actualizar, pero solo hay 1. Si hay más da error.
        titularData.setIdDocument("1234589D");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente = new Client("+34668", "124070001", 125, "15", 122, true, titularData, "");
        Client existingClient = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");
        Client cliente2 = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");
        Client cliente3 = new Client("+34668", "124070000", 124, "12", 120, false, titularData, "");


        Mockito.when(provisionService.getDniClient(anyString())).thenReturn(List.of(cliente2));

        Mockito.when(provisionService.getMsisdnClient(anyString())).thenReturn(Optional.of(existingClient));
        Mockito.when(provisionRepository.save(Mockito.any())).thenReturn(cliente);



        CustomException thrown = assertThrows(CustomException.class, () -> {
            provisionService.updateClient(cliente); // Asegúrate de que updateClient realmente lanza CustomException cuando no encuentra el cliente
        }, "Se esperaba CustomException");




        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());



    }



}
