package com.tfm.kyc.service;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.tfm.kyc.controller.KycController;
import com.tfm.kyc.exception.CustomException;
import com.tfm.kyc.model.*;
import com.tfm.kyc.repository.KycRepository;
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

import static com.mongodb.internal.connection.tlschannel.util.Util.assertTrue;
import static org.junit.jupiter.api.Assertions.*;

@WebMvcTest(KycController.class)
@Import({ KycService.class })
public class KycServiceTest {


    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private KycRepository kycRepository;

    //    @InjectMocks
    @Autowired
    private KycService kycService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    public void testMatchIdDocument() throws Exception {

    String id1 = "02387645193917D";
    String id2 = "02387645193917d";

    Boolean result = kycService.matchIdDocument(id1, id2);

    assertTrue(result);

    }

    @Test
    public void testMatchIdDocumentLength() throws Exception {

            //Da True porque se trunca a 20
        String id1 = "02387645193917D345798111";
        String id2 = "02387645193917d34579800000";

        Boolean result = kycService.matchIdDocument(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatcIdDocumentLength() throws Exception {

        //Da True porque se trunca a 20
        String id1 = "02387645193917D345798111";
        String id2 = "02387645193917d34579800000";

        Boolean result = kycService.matchIdDocument(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatchIdDocumentBlankSpace() throws Exception {

        //Da True porque se trunca a 20
        String id1 = "0238764519391 7D345798111*";
        String id2 = "02387645193917d34579800000";

        Boolean result = kycService.matchIdDocument(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatchNameValid() throws Exception {

        //Da True porque se trunca a 20
        String id1 = "Alex ";
        String id2 = " aLEx  ";

        Boolean result = kycService.matchName(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatchNameInvalidLength() throws Exception {

        //Da False porque se trunca a 40 y los espacios entre palabras son diferentes
        String id1 = "Alex pqeiqwpr papij ihwehfwheifhweifhwjk";
        String id2 = " aLEx pqeiqwpr papij ihwehfwheifhweifhwjk";

        Boolean result = kycService.matchName(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatchNameValidSpecialCh() throws Exception {


        String id1 = "Ramón";
        String id2 = " rAmon  ";

        Boolean result = kycService.matchName(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatchStreetNameValid() throws Exception {

        //Da False porque se trunca a 40 y los espacios entre palabras son diferentes
        String id1 = "calle Gran vía";
        String id2 = " Gran via  ";

        Boolean result = kycService.matchStreetName(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatchStreetNameValidSpecCh() throws Exception {


        String id1 = "glorieta melocotón";
        String id2 = " Melocoton  ";

        Boolean result = kycService.matchStreetName(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatchGenderValid() throws Exception {

        //Da False porque se trunca a 40 y los espacios entre palabras son diferentes
        String id1 = "MALE";
        String id2 = " Masculino";

        Boolean result = kycService.matchGender(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatchGenderValidEnglish() throws Exception {

        //Da False porque se trunca a 40 y los espacios entre palabras son diferentes
        String id1 = "MALE";
        String id2 = " MALE";

        Boolean result = kycService.matchGender(id1, id2);

        assertTrue(result);

    }

    @Test
    public void testMatchDataNoClient() throws Exception {

        ApiInputDTO input = new ApiInputDTO("+34678901234",
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
        titularData.setIdDocument("87654321I");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);
        String msisdn = input.getPhoneNumber();

        Client cliente = new Client("+34678901234", "124070000", 214, "0", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

        Mockito.when(kycRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.empty());

        CustomException thrown = assertThrows(CustomException.class, () -> {
            kycService.matchData(input);
        }, "not_found_contractor/not_found");

        assertEquals(HttpStatus.NOT_FOUND, thrown.getStatus());
        assertEquals("NOT_FOUND", thrown.getCode());
        assertEquals("not_found_contractor/not_found", thrown.getMessage());

    }

    @Test
    public void testMatchDataIdDocumentEmpty() throws Exception {

        ApiInputDTO input = new ApiInputDTO("+34678901234",
                "",
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
        titularData.setIdDocument("87654321I");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);
        String msisdn = input.getPhoneNumber();

        Client cliente = new Client("+34678901234", "124070000", 214, "0", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

        Mockito.when(kycRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.of(cliente));

        CustomException thrown = assertThrows(CustomException.class, () -> {
            kycService.matchData(input);
        }, "Client does not have sufficient permissions to perform this action");

        assertEquals(HttpStatus.UNAUTHORIZED, thrown.getStatus());
        assertEquals("PERMISSION_DENIED", thrown.getCode());
        assertEquals("Client does not have sufficient permissions to perform this action", thrown.getMessage());

    }

    @Test
    public void testMatchDataIdDocumentNotMatch() throws Exception {

        ApiInputDTO input = new ApiInputDTO("+34678901234",
                "12224",
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
        titularData.setIdDocument("87654321I");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);
        String msisdn = input.getPhoneNumber();

        Client cliente = new Client("+34678901234", "124070000", 214, "0", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

        Mockito.when(kycRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.of(cliente));

        CustomException thrown = assertThrows(CustomException.class, () -> {
            kycService.matchData(input);
        }, "Client does not have sufficient permissions to perform this action");

        assertEquals(HttpStatus.UNAUTHORIZED, thrown.getStatus());
        assertEquals("PERMISSION_DENIED", thrown.getCode());
        assertEquals("Client does not have sufficient permissions to perform this action", thrown.getMessage());

    }

    @Test
    public void testMatchDataNameNotMatch() throws Exception {

        ApiInputDTO input = new ApiInputDTO("+34678901234",
                "87654321I",
                "Sofía Hernández",
                "Sofía",
                "Hernández Fernandez",
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
        titularData.setIdDocument("87654321I");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);
        String msisdn = input.getPhoneNumber();

        Client cliente = new Client("+34678901234", "124070000", 214, "0", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

        Mockito.when(kycRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.of(cliente));

        CustomException thrown = assertThrows(CustomException.class, () -> {
            kycService.matchData(input);
        }, "Client specified an invalid argument, request body or query param");

        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());

    }

    @Test
    public void testMatchAddressNotMatch() throws Exception {

        ApiInputDTO input = new ApiInputDTO("+34678901234",
                "87654321I",
                "Sofía Hernández",
                "Sofía",
                "Hernández Fernandez",
                "",
                "Ｆｅｄｅ",
                "Sanchez",
                "YYYY",
                "Carrer De MALlorca 10",
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
        titularData.setIdDocument("87654321I");
        titularData.setEmail("email@example.com");
        titularData.setGender("Masculino");
        titularData.setBirthdate("2000-01-01");
        titularData.setAddress(address);
        String msisdn = input.getPhoneNumber();

        Client cliente = new Client("+34678901234", "124070000", 214, "0", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

        Mockito.when(kycRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.of(cliente));

        CustomException thrown = assertThrows(CustomException.class, () -> {
            kycService.matchData(input);
        }, "Client specified an invalid argument, request body or query param");

        assertEquals(HttpStatus.BAD_REQUEST, thrown.getStatus());
        assertEquals("INVALID_ARGUMENT", thrown.getCode());
        assertEquals("Client specified an invalid argument, request body or query param", thrown.getMessage());

    }


    @Test
    public void testMatchValid() throws Exception {

        ApiInputDTO input = new ApiInputDTO("+34678901234",
                "87654321I",
                "Sofía Hernández",
                "Sofía",
                "Hernández ",
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


        Address address = new Address();
        address.setStreetName("Carrer de Mallorca");
        address.setStreetNumber("100");
        address.setPostalCode("08029");
        address.setRegion("barcelona");
        address.setLocality("barcelona");
        address.setCountry("españa");
        address.setHouseNumberExtension("I");

        TitularData titularData = new TitularData();
        titularData.setName("Sofía Hernández");
        titularData.setGivenName("sofia");
        titularData.setFamilyName("hernandez");
        titularData.setIdDocument("87654321I");
        titularData.setEmail("sofia@example.com");
        titularData.setGender("femenino");
        titularData.setBirthdate("1984-07-25");
        titularData.setAddress(address);
        String msisdn = input.getPhoneNumber();

        Client cliente = new Client("+34678901234", "124070000", 214, "0", 120, true, titularData, "2024-02-11T12:30:10.360+01:00");

        Mockito.when(kycRepository.findClientByMsisdn(msisdn)).thenReturn(Optional.of(cliente));

        ResponseDTO response = new ResponseDTO("true","true","true","true","not_available","not_available","not_available","not_available","true",
                "true","true","true","true","true","true","true","true","true","true");

        ResponseDTO serviceResponse = kycService.matchData(input);

        //Con assertEquals directamente no funciona porque compara los objeto enteros y no son el mismo exactamente Expected :com.tfm.kyc.model.ResponseDTO@6a4af081
        //Actual   :com.tfm.kyc.model.ResponseDTO@36b53f08


        assertEquals(response.getIdDocumentMatch(), serviceResponse.getIdDocumentMatch());
        assertEquals(response.getNameMatch(), serviceResponse.getNameMatch());
        assertEquals(response.getGivenNameMatch(), serviceResponse.getGivenNameMatch());
        assertEquals(response.getFamilyNameMatch(), serviceResponse.getNameMatch());
        assertEquals(response.getNameKanaHankakuMatch(), serviceResponse.getNameKanaHankakuMatch());
        assertEquals(response.getNameKanaZenkakuMatch(), serviceResponse.getNameKanaZenkakuMatch());
        assertEquals(response.getMiddleNamesMatch(), serviceResponse.getMiddleNamesMatch());
        assertEquals(response.getFamilyNameAtBirthMatch(), serviceResponse.getFamilyNameAtBirthMatch());
        assertEquals(response.getAddressMatch(), serviceResponse.getAddressMatch());
        assertEquals(response.getStreetNameMatch(), serviceResponse.getStreetNameMatch());
        assertEquals(response.getStreetNumberMatch(), serviceResponse.getStreetNumberMatch());
        assertEquals(response.getPostalCodeMatch(), serviceResponse.getPostalCodeMatch());
        assertEquals(response.getRegionMatch(), serviceResponse.getRegionMatch());
        assertEquals(response.getLocalityMatch(), serviceResponse.getLocalityMatch());
        assertEquals(response.getCountryMatch(), serviceResponse.getCountryMatch());
        assertEquals(response.getHouseNumberExtensionMatch(), serviceResponse.getHouseNumberExtensionMatch());
        assertEquals(response.getBirthdateMatch(), serviceResponse.getBirthdateMatch());
        assertEquals(response.getEmailMatch(), serviceResponse.getEmailMatch());
        assertEquals(response.getGenderMatch(), serviceResponse.getGenderMatch());


    }




}


