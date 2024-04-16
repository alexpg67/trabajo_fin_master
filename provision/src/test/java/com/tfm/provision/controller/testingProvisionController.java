package com.tfm.provision.controller;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.tfm.provision.exception.CustomException;
import com.tfm.provision.model.Address;
import com.tfm.provision.model.Client;
import com.tfm.provision.model.TitularData;
//import com.tfm.provision.security.SecurityConfiguration;
//import com.tfm.provision.security.SecurityConfiguration;
//import com.tfm.provision.security.TestSecurityConfiguration;
import com.tfm.provision.service.ProvisionService;
import jakarta.validation.constraints.*;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.PropertySource;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
//import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

//
@WebMvcTest(ProvisionController.class)

//@TestPropertySource(locations = "classpath:application-test.properties")
//
//@Import(TestSecurityConfiguration.class)
//@ActiveProfiles("test")
//@SpringBootTest
class ProvisionControllerTest {


    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ProvisionService service;

    @Autowired
    private ObjectMapper objectMapper;

    //----------------------------------------GETALL-----------------------------------------------------------------------------
    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testGetAllEmptyResponse() throws Exception {


        List<Client> listaVacia = List.of();
        String requestURI = "http://localhost:8082/provision/v0/getall";

        Mockito.when(service.getAllClients()).thenReturn(listaVacia);

        mockMvc.perform(get(requestURI))
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testGetAllTwoSizeResponse() throws Exception {

        String msisdn1 = "+1234";
        String msisdn2 = "+4321";
        TitularData titularData = new TitularData();
        Client cliente1 = new Client(msisdn1, "00000000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        Client cliente2 = new Client(msisdn2, "10101010", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        List<Client> response = List.of(cliente1, cliente2);
        String requestURI = "http://localhost:8082/provision/v0/getall";

        Mockito.when(service.getAllClients()).thenReturn(response);

        mockMvc.perform(get(requestURI))
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(response)))
                .andDo(print());
    }

    //----------------------------------------GETALL-----------------------------------------------------------------------------
    //----------------------------------------GET/MSISDN-----------------------------------------------------------------------------
    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testGetMsisdnEmptyResponse() throws Exception {

        String msisdn = "+1234";
        Optional<Client> emptyOptional = Optional.empty();
        String requestURI = "http://localhost:8082/provision/v0/get/msisdn/" + msisdn;

        Mockito.when(service.getMsisdnClient(msisdn)).thenReturn(emptyOptional);

        mockMvc.perform(get(requestURI))
                .andExpect(status().isNotFound())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":404,\"message\":\"Can't be checked because the msisdn is unknown\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testGetMsisdnEmptyRequest() throws Exception {

        String msisdn = "";
        Optional<Client> emptyOptional = Optional.empty();
        String requestURI = "http://localhost:8082/provision/v0/get/msisdn/" + msisdn;

        Mockito.when(service.getMsisdnClient(msisdn)).thenReturn(emptyOptional);

        mockMvc.perform(get(requestURI))
                .andExpect(status().isInternalServerError())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":500,\"message\":\"Server error\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testGetMsisdnSuccessResponse() throws Exception {

        String msisdn = "+1234";
        TitularData titularData = new TitularData();
        Client cliente = new Client(msisdn, "00000000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        Optional<Client> response = Optional.of(cliente);
        String requestURI = "http://localhost:8082/provision/v0/get/msisdn/" + msisdn;

        Mockito.when(service.getMsisdnClient(msisdn)).thenReturn(response);

        mockMvc.perform(get(requestURI))
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());

    }

    //----------------------------------------GET/MSISDN-----------------------------------------------------------------------------

    //----------------------------------------GET/EMAIL-----------------------------------------------------------------------------

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testGetEmailEmptyResponse() throws Exception {

        String email = "prueba@gmail.com";
        List<Client> emptyOptional = List.of();
        String requestURI = "http://localhost:8082/provision/v0/get/email/" + email;

        Mockito.when(service.getEmailClient(email)).thenReturn(emptyOptional);

        mockMvc.perform(get(requestURI))
                .andExpect(status().isNotFound())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":404,\"message\":\"Can't be checked because the email is unknown\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testGetEmailEmptyRequest() throws Exception {

        String email = "";
        List<Client> emptyOptional = List.of();
        String requestURI = "http://localhost:8082/provision/v0/get/email/" + email;

        Mockito.when(service.getEmailClient(email)).thenReturn(emptyOptional);

        mockMvc.perform(get(requestURI))
                .andExpect(status().isInternalServerError())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":500,\"message\":\"Server error\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testGetEmailSuccessResponse() throws Exception {

        String email = "prueba@gmail.com";
        TitularData titularData = new TitularData();
        Client cliente = new Client("+1234", "00000000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        List<Client> response = List.of(cliente);
        String requestURI = "http://localhost:8082/provision/v0/get/email/" + email;

        Mockito.when(service.getEmailClient(email)).thenReturn(response);

        mockMvc.perform(get(requestURI))
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(response)))
                .andDo(print());

    }


    //----------------------------------------GET/EMAIL-----------------------------------------------------------------------------

//----------------------------------------GET/DNI-----------------------------------------------------------------------------

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testGetDniEmptyResponse() throws Exception {

        String dni = "1111111A";
        List<Client> emptyOptional = List.of();
        String requestURI = "http://localhost:8082/provision/v0/get/dni/" + dni;

        Mockito.when(service.getDniClient(dni)).thenReturn(emptyOptional);

        mockMvc.perform(get(requestURI))
                .andExpect(status().isNotFound())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":404,\"message\":\"Can't be checked because the dni is unknown\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testGetDniEmptyRequest() throws Exception {

        String dni = "";
        List<Client> emptyOptional = List.of();
        String requestURI = "http://localhost:8082/provision/v0/get/dni/" + dni;

        Mockito.when(service.getDniClient(dni)).thenReturn(emptyOptional);

        mockMvc.perform(get(requestURI))
                .andExpect(status().isInternalServerError())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":500,\"message\":\"Server error\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testGetDniSuccessResponse() throws Exception {

        String dni = "11111111A";
        TitularData titularData = new TitularData();
        Client cliente = new Client("+1234", "00000000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        List<Client> response = List.of(cliente);
        String requestURI = "http://localhost:8082/provision/v0/get/dni/" + dni;

        Mockito.when(service.getDniClient(dni)).thenReturn(response);

        mockMvc.perform(get(requestURI))
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(response)))
                .andDo(print());

    }


    //----------------------------------------GET/DNI-----------------------------------------------------------------------------

    //----------------------------------------DELETE/MSISDN-----------------------------------------------------------------------------
    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testDeleteMsisdnEmptyResponse() throws Exception {

        String msisdn = "+1234";
        Optional<Client> emptyOptional = Optional.empty();
        String requestURI = "http://localhost:8082/provision/v0/delete/msisdn/" + msisdn;

        Mockito.when(service.deleteMsisdnClient(msisdn)).thenReturn(emptyOptional);

        mockMvc.perform(delete(requestURI))
                .andExpect(status().isNotFound())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":404,\"message\":\"Can't be deleted because the msisdn is unknown\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testDeleteMsisdnEmptyRequest() throws Exception {

        String msisdn = "";
        Optional<Client> emptyOptional = Optional.empty();
        String requestURI = "http://localhost:8082/provision/v0/delete/msisdn/" + msisdn;

        Mockito.when(service.deleteMsisdnClient(msisdn)).thenReturn(emptyOptional);

        mockMvc.perform(delete(requestURI))
                .andExpect(status().isInternalServerError())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":500,\"message\":\"Server error\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testDeleteMsisdnSuccessResponse() throws Exception {

        String msisdn = "+1234";
        TitularData titularData = new TitularData();
        Client cliente = new Client(msisdn, "00000000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        Optional<Client> response = Optional.of(cliente);
        String requestURI = "http://localhost:8082/provision/v0/delete/msisdn/" + msisdn;

        Mockito.when(service.deleteMsisdnClient(msisdn)).thenReturn(response);

        mockMvc.perform(delete(requestURI))
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());

    }

    //----------------------------------------DELETE/MSISDN-----------------------------------------------------------------------------

    //----------------------------------------DELETE/EMAIL-----------------------------------------------------------------------------

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testDeleteEmailEmptyResponse() throws Exception {

        String email = "prueba@gmail.com";
        List<Client> emptyOptional = List.of();
        String requestURI = "http://localhost:8082/provision/v0/delete/email/" + email;

        Mockito.when(service.deleteEmailClient(email)).thenReturn(emptyOptional);

        mockMvc.perform(delete(requestURI))
                .andExpect(status().isNotFound())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":404,\"message\":\"Can't be deleted because the email is unknown\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testDeleteEmailEmptyRequest() throws Exception {

        String email = "";
        List<Client> emptyOptional = List.of();
        String requestURI = "http://localhost:8082/provision/v0/delete/email/" + email;

        Mockito.when(service.deleteEmailClient(email)).thenReturn(emptyOptional);

        mockMvc.perform(delete(requestURI))
                .andExpect(status().isInternalServerError())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":500,\"message\":\"Server error\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testDeleteEmailSuccessResponse() throws Exception {

        String email = "prueba@gmail.com";
        TitularData titularData = new TitularData();
        Client cliente = new Client("+1234", "00000000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        List<Client> response = List.of(cliente);
        String requestURI = "http://localhost:8082/provision/v0/delete/email/" + email;

        Mockito.when(service.deleteEmailClient(email)).thenReturn(response);

        mockMvc.perform(delete(requestURI))
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(response)))
                .andDo(print());

    }


    //----------------------------------------DELETE/EMAIL-----------------------------------------------------------------------------

    //----------------------------------------DELETE/DNI-----------------------------------------------------------------------------

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testDeleteDniEmptyResponse() throws Exception {

        String dni = "1111111A";
        List<Client> emptyOptional = List.of();
        String requestURI = "http://localhost:8082/provision/v0/delete/dni/" + dni;

        Mockito.when(service.deleteDniClient(dni)).thenReturn(emptyOptional);

        mockMvc.perform(delete(requestURI))
                .andExpect(status().isNotFound())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":404,\"message\":\"Can't be deleted because the dni is unknown\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testDeleteDniEmptyRequest() throws Exception {

        String dni = "";
        List<Client> emptyOptional = List.of();
        String requestURI = "http://localhost:8082/provision/v0/delete/dni/" + dni;

        Mockito.when(service.deleteDniClient(dni)).thenReturn(emptyOptional);

        mockMvc.perform(delete(requestURI))
                .andExpect(status().isInternalServerError())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":500,\"message\":\"Server error\"}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testDeleteDniSuccessResponse() throws Exception {

        String dni = "11111111A";
        TitularData titularData = new TitularData();
        Client cliente = new Client("+1234", "00000000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        List<Client> response = List.of(cliente);
        String requestURI = "http://localhost:8082/provision/v0/delete/dni/" + dni;

        Mockito.when(service.deleteDniClient(dni)).thenReturn(response);

        mockMvc.perform(delete(requestURI))
                .andExpect(status().isOk())
                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(response)))
                .andDo(print());

    }

    //----------------------------------------DELETE/DNI-----------------------------------------------------------------------------

    //----------------------------------------POST-----------------------------------------------------------------------------

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidMsisdnMinLength() throws Exception {


        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+3444", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        Mockito.when(service.saveClient(cliente)).thenReturn(cliente);

        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":\"BAD_REQUEST\",\"code\":\"INVALID_ARGUMENT\",\"message\":\"Client specified an invalid argument, request body or query param\",\"errors\":[\"must match \\\"^\\\\+?[0-9]{5,15}$\\\"\"]}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidMsisdnMaxLength() throws Exception {


        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34444444444444444444", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        Mockito.when(service.saveClient(cliente)).thenReturn(cliente);

        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":\"BAD_REQUEST\",\"code\":\"INVALID_ARGUMENT\",\"message\":\"Client specified an invalid argument, request body or query param\",\"errors\":[\"must match \\\"^\\\\+?[0-9]{5,15}$\\\"\"]}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidMsisdnCharacterError() throws Exception {


        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34ABC", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
        Mockito.when(service.saveClient(cliente)).thenReturn(cliente);

        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json("{\"status\":\"BAD_REQUEST\",\"code\":\"INVALID_ARGUMENT\",\"message\":\"Client specified an invalid argument, request body or query param\",\"errors\":[\"must match \\\"^\\\\+?[0-9]{5,15}$\\\"\"]}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidMsisdnOptionalPlus() throws Exception {


        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("34668", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

//        Client cliente2 = new Client("+34668", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
//
//        ZonedDateTime now = ZonedDateTime.now();
//        String formattedDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX"));


//        cliente2.setLatestSimChange(formattedDate);
        // cliente.setId(null);

        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);
        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andExpect(content().contentType("application/json"))

                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidMsisdnWithPlus() throws Exception {


        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

//        Client cliente2 = new Client("+34668", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
//
//        ZonedDateTime now = ZonedDateTime.now();
//        String formattedDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX"));


//        cliente2.setLatestSimChange(formattedDate);
        // cliente.setId(null);

        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);
        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andExpect(content().contentType("application/json"))

                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidMsisdnNull() throws Exception {


        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

//        Client cliente2 = new Client("+34668", "124070000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
//
//        ZonedDateTime now = ZonedDateTime.now();
//        String formattedDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX"));


//        cliente2.setLatestSimChange(formattedDate);
        // cliente.setId(null);

        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);

        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
//                .andExpect(content().json("{\"status\":\"BAD_REQUEST\",\"code\":\"INVALID_ARGUMENT\",\"message\":\"Client specified an invalid argument, request body or query param\",\"errors\":[\" +\n" +
//                        "        \"\\\"must not be empty\\\",\" +  // Aquí está la corrección\n" +
//                        "        \"\\\"must match ^\\\\+?[0-9]{5,15}$\\\"\"]}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidImsiMinLength() throws Exception {
//        @NotNull
//        @Pattern(regexp = "^[0-9]{3}[0-9]{2,3}[0-9]{1,10}$")
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "12407", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
//                .andExpect(content().json("{\"status\":\"BAD_REQUEST\",\"code\":\"INVALID_ARGUMENT\",\"message\":\"Client specified an invalid argument, request body or query param\",\"errors\":[\" +\n" +
//                        "        \"\\\"must not be empty\\\",\" +  // Aquí está la corrección\n" +
//                        "        \"\\\"must match ^\\\\+?[0-9]{5,15}$\\\"\"]}"))
                .andDo(print());
    }


    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidImsiMaxLength() throws Exception {
//        @NotNull
//        @Pattern(regexp = "^[0-9]{3}[0-9]{2,3}[0-9]{1,10}$")
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "12407777777777777", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
//                .andExpect(content().json("{\"status\":\"BAD_REQUEST\",\"code\":\"INVALID_ARGUMENT\",\"message\":\"Client specified an invalid argument, request body or query param\",\"errors\":[\" +\n" +
//                        "        \"\\\"must not be empty\\\",\" +  // Aquí está la corrección\n" +
//                        "        \"\\\"must match ^\\\\+?[0-9]{5,15}$\\\"\"]}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidImsiCharacterError() throws Exception {
//        @NotNull
//        @Pattern(regexp = "^[0-9]{3}[0-9]{2,3}[0-9]{1,10}$")
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "12407777a", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
//                .andExpect(content().json("{\"status\":\"BAD_REQUEST\",\"code\":\"INVALID_ARGUMENT\",\"message\":\"Client specified an invalid argument, request body or query param\",\"errors\":[\" +\n" +
//                        "        \"\\\"must not be empty\\\",\" +  // Aquí está la corrección\n" +
//                        "        \"\\\"must match ^\\\\+?[0-9]{5,15}$\\\"\"]}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidImsiNull() throws Exception {
//        @NotNull
//        @Pattern(regexp = "^[0-9]{3}[0-9]{2,3}[0-9]{1,10}$")
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+34668", "", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
//                .andExpect(content().json("{\"status\":\"BAD_REQUEST\",\"code\":\"INVALID_ARGUMENT\",\"message\":\"Client specified an invalid argument, request body or query param\",\"errors\":[\" +\n" +
//                        "        \"\\\"must not be empty\\\",\" +  // Aquí está la corrección\n" +
//                        "        \"\\\"must match ^\\\\+?[0-9]{5,15}$\\\"\"]}"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidImsi() throws Exception {
//        @NotNull
//        @Pattern(regexp = "^[0-9]{3}[0-9]{2,3}[0-9]{1,10}$")
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());
    }


    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidMccMinLength() throws Exception {
//        @Min(value = 0)
//        @Max(value = 999)
//        @NotNull
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", -1, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidMccMaxLength() throws Exception {
//        @Min(value = 0)
//        @Max(value = 999)
//        @NotNull
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 1000, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }


    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidMccNull() throws Exception {
//        @Min(value = 0)
//        @Max(value = 999)
//        @NotNull
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);


        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidMncMinLength() throws Exception {
//        @Pattern(regexp = "^[0-9]{2,3}$")
//        @NotNull
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "0", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidMncMaxLength() throws Exception {
//        @Pattern(regexp = "^[0-9]{2,3}$")
//        @NotNull
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "0333", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidMncCharacterError() throws Exception {
//        @Pattern(regexp = "^[0-9]{2,3}$")
//        @NotNull
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "03A3", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidMncNull() throws Exception {
//        @Pattern(regexp = "^[0-9]{2,3}$")
//        @NotNull
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidMnc() throws Exception {
//        @Pattern(regexp = "^[0-9]{2,3}$")
//        @NotNull
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);


        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidCellIdMinLength() throws Exception {
//        @Min(value = 0)
//        @Max(value = 9999)
//        @NotNull
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", -2, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidCellIdMaxLength() throws Exception {
//        @Min(value = 0)
//        @Max(value = 9999)
//        @NotNull
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 10000, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidCellId() throws Exception {
//        @Min(value = 0)
//        @Max(value = 9999)
//        @NotNull
        String requestURI = "http://localhost:8082/provision/v0/newclient";

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
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);


        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidName() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^[a-zA-ZñÑáéíóúÁÉÍÓÚüÜ]+$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón15");
        titularData.setGivenName("NombreCompleto");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidName() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^[a-zA-ZñÑáéíóúÁÉÍÓÚüÜ]+$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("NombreCompleto");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);


        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidGivenName() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,2}$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo2");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidGivenNameLength() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,2}$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo terminato");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidGivenName() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,2}$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678Z");
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);


        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidIdDocumentCharacterError() throws Exception {
//        @Indexed
//        //No son unicos ya que en un pack familiar, solo tenemos los datos del titular (Multiples MSISDN con mismos datos)
//        @NotEmpty
//        @Pattern(regexp = "^[0-9]{8}[A-Za-z]$") //OJO!! para KYC puede ser DNI no solo de España.


        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12A45678Z");
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidIdDocumentLetraCharacterError() throws Exception {
//        @Indexed
//        //No son unicos ya que en un pack familiar, solo tenemos los datos del titular (Multiples MSISDN con mismos datos)
//        @NotEmpty
//        @Pattern(regexp = "^[0-9]{8}[A-Za-z]$") //OJO!! para KYC puede ser DNI no solo de España.


        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("123456788");
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidIdDocument() throws Exception {
//        @Indexed
//        //No son unicos ya que en un pack familiar, solo tenemos los datos del titular (Multiples MSISDN con mismos datos)
//        @NotEmpty
//        @Pattern(regexp = "^[0-9]{8}[A-Za-z]$") //OJO!! para KYC puede ser DNI no solo de España.


        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);

        String jsonCliente = objectMapper.writeValueAsString(cliente);


        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());
    }


    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidIdEmail() throws Exception {
//@Email


        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("emailexample");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidEmail() throws Exception {
//@Email


        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);


        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidGender() throws Exception {
//   @Pattern(regexp = "^(Masculino|Femenino)$")


        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculinoo");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidGender() throws Exception {
//   @Pattern(regexp = "^(Masculino|Femenino)$")


        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);


        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidBirthdate() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^\\d{4}-\\d{2}-\\d{2}$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("200A-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidBirthdateTwo() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^\\d{4}-\\d{2}-\\d{2}$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("200001-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidBirthdayThree() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^\\d{4}-\\d{2}-\\d{2}$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-001-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidBirthdate() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^\\d{4}-\\d{2}-\\d{2}$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);

        String jsonCliente = objectMapper.writeValueAsString(cliente);


        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidStreetNameNumberError() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,5}$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo1");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostInvalidStreetNameMaxLength() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,5}$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Ejemplo Hola Gran Vía Pepe Hola Buu Hola Que tal");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);

        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isBadRequest())

                .andExpect(content().contentType("application/json"))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPostValidStreetName() throws Exception {
//        @NotEmpty
//        @Pattern(regexp = "^([a-zA-ZñÑáéíóúÁÉÍÓÚüÜ\\s]+\\s?){1,5}$")

        String requestURI = "http://localhost:8082/provision/v0/newclient";

        Address address = new Address();
        address.setStreetName("Calle Puerta del Sol");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);

        Client cliente = new Client("+346687", "7777777", 100, "07", 100, true, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.saveClient(Mockito.any())).thenReturn(cliente);


        String jsonCliente = objectMapper.writeValueAsString(cliente);


        mockMvc.perform(post(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente)))
                .andDo(print());
    }

    @Test
 //   @WithMockUser(username = "testuser", roles = {"USER"})
    public void testPutValidResponse() throws Exception {

        String msisdn = "+346687";
        String requestURI = "http://localhost:8082/provision/v0/updateclient/" + msisdn;

        Address address = new Address();
        address.setStreetName("Calle Puerta del Sol");
        address.setStreetNumber("123");
        address.setPostalCode("12345");
        address.setRegion("Región Ejemplo");
        address.setLocality("Localidad Ejemplo");
        address.setCountry("País Ejemplo");
        address.setHouseNumberExtension("A");

        TitularData titularData = new TitularData();
        titularData.setName("Ramón");
        titularData.setGivenName("Ignacio Álvaroo");
        titularData.setFamilyName("Apellido");
        titularData.setIdDocument("12345678D");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);


        Client cliente2 = new Client("+346687", "1111111", 200, "17", 150, false, titularData, "2024-02-11T12:30:10.360+01:00");


        Mockito.when(service.updateClient(Mockito.any())).thenReturn(cliente2);

        String jsonCliente = objectMapper.writeValueAsString(cliente2);


        mockMvc.perform(put(requestURI)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonCliente))
                .andExpect(status().isOk())

                .andExpect(content().contentType("application/json"))
                .andExpect(content().json(objectMapper.writeValueAsString(cliente2)))
                .andDo(print());

//        ArgumentCaptor<Client> clientCaptor = ArgumentCaptor.forClass(Client.class);
//        Mockito.verify(service).saveClient(clientCaptor.capture());
//
//        Client capturedClient = clientCaptor.getValue();

//        assertEquals(cliente2.getMsisdn(), capturedClient.getMsisdn());
//        assertEquals(cliente2.getImsi(), capturedClient.getImsi());
//        assertEquals(cliente2.getMcc(), capturedClient.getMcc());
//        assertEquals(cliente2.getMnc(), capturedClient.getMnc());
//        assertEquals(cliente2.getCellId(), capturedClient.getCellId());
//        assertEquals(cliente2.isTitular(), capturedClient.isTitular());
//        assertEquals(cliente2.getTitularData(), capturedClient.getTitularData());
    }


    //----------------------------------------POST-----------------------------------------------------------------------------

//--------------------------------------------------SEGURIDAD-----------------------------------------------------------------------------
//    @Test
//    public void testGetMsisdnNotAuthenticated() throws Exception {
//
//        String msisdn = "+1234";
//        TitularData titularData = new TitularData();
//        Client cliente = new Client(msisdn, "00000000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
//        Optional<Client> response = Optional.of(cliente);
//        String requestURI = "http://localhost:8082/provision/v0/get/msisdn/" + msisdn;
//
//        Mockito.when(service.getMsisdnClient(msisdn)).thenReturn(response);
//
//        mockMvc.perform(get(requestURI))
//                .andExpect(status().isUnauthorized())
//                //.andExpect(content().contentType("application/json"))
//                //.andExpect(content().json("{\"status\":401,\"message\":\"Request not authenticated due to missing, invalid, or expired credentials\"}"))
//                .andDo(print());
//
//    }
//
//    @Test
// //   @WithMockUser(username = "testuser", roles = {"USER"})
//    public void testGetMsisdnNotAuthorized() throws Exception {
//
//        String msisdn = "+1234";
//        TitularData titularData = new TitularData();
//        Client cliente = new Client(msisdn, "00000000", 124, "07", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");
//        Optional<Client> response = Optional.of(cliente);
//        String requestURI = "http://localhost:8082/provision/v0/get/msisdn/" + msisdn;
//
//        Mockito.when(service.getMsisdnClient(msisdn)).thenReturn(response);
//
//        mockMvc.perform(get(requestURI))
//                .andExpect(status().isUnauthorized())
//                //.andExpect(content().contentType("application/json"))
//                //.andExpect(content().json("{\"status\":401,\"message\":\"Request not authenticated due to missing, invalid, or expired credentials\"}"))
//                .andDo(print());
//
//    }

    //--------------------------------------------------SEGURIDAD-----------------------------------------------------------------------------


}
