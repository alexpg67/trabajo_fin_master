package com.tfm.kyc.service;


import com.tfm.kyc.exception.CustomException;
import com.tfm.kyc.model.ApiInputDTO;
import com.tfm.kyc.model.Client;
import com.tfm.kyc.model.ResponseDTO;
import com.tfm.kyc.repository.KycRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class KycService {

    private static final Logger log = LoggerFactory.getLogger(KycService.class);

    @Autowired
    private KycRepository kycRepository;

    public ResponseDTO matchData(ApiInputDTO apiInputDTO) throws CustomException {

        String msisdn = apiInputDTO.getPhoneNumber();
        Optional<Client> cliente = kycRepository.findClientByMsisdn(msisdn);


        if (cliente.isEmpty()) {
            log.info("No se ha encontrado el cliente con MSISDN, no se puede devolver el match de: {}", msisdn); // Log informativo cuando no se encuentra el MSISDN
            throw new CustomException(HttpStatus.NOT_FOUND, "NOT_FOUND", "not_found_contractor/not_found");
        }

        if (apiInputDTO.getIdDocument().isEmpty() || !(matchIdDocument(apiInputDTO.getIdDocument(),cliente.get().getTitularData().getIdDocument()))){
            log.info("El cliente no tiene acceso porque no ha introducido el DNI o el DNI no hace match con el que tenemos guardado para ese número: " + apiInputDTO.getIdDocument());

            throw new CustomException(HttpStatus.UNAUTHORIZED, "PERMISSION_DENIED", "Client does not have sufficient permissions to perform this action");


        }

        String name = apiInputDTO.getName();
        String givenName = apiInputDTO.getGivenName();
        String familyName = apiInputDTO.getFamilyName();
        String address = apiInputDTO.getAddress();
        String streetName = apiInputDTO.getStreetName();
        String streetNumber = apiInputDTO.getStreetNumber();

        if (!matchName(name, givenName + familyName) || !(matchStreetName(address, streetName + streetNumber))){
            log.info("El nombre completo no coincide con el nombre + apellido o la dirección completa no coincide con la calle + el número");
            throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");

        }


        String idDocumentMatchedAsString = Boolean.toString(matchIdDocument(apiInputDTO.getIdDocument(), cliente.get().getTitularData().getIdDocument()));


        boolean givenNameMatched = matchName(apiInputDTO.getGivenName(), cliente.get().getTitularData().getGivenName());
        String givenNameMatchedAsString = Boolean.toString(givenNameMatched);

        boolean familyNameMatched = matchName(apiInputDTO.getFamilyName(), cliente.get().getTitularData().getFamilyName());
        String familyNameMatchedAsString = Boolean.toString(familyNameMatched);


        boolean nameMatched = givenNameMatched && familyNameMatched;
        String nameMatchAsString = Boolean.toString(nameMatched);

        String nameKanaHankakuMatch = "not_available";
        String nameKanaZenkakuMatch = "not_available";
        String middleNamesMatch = "not_available";
        String familyNameAtBirthMatch = "not_available";
//        String addressMatch = "not_available";

        Boolean streetNameMatchBool = matchStreetName(apiInputDTO.getStreetName(), cliente.get().getTitularData().getAddress().getStreetName());
        String streetNameMatch = Boolean.toString(matchStreetName(apiInputDTO.getStreetName(), cliente.get().getTitularData().getAddress().getStreetName()));

        Boolean streetNumberMatchBool = apiInputDTO.getStreetNumber().equals(cliente.get().getTitularData().getAddress().getStreetNumber());

        String addressMatch = Boolean.toString( streetNameMatchBool && streetNumberMatchBool);
        String streetNumberMatch = Boolean.toString(apiInputDTO.getStreetNumber().equals(cliente.get().getTitularData().getAddress().getStreetNumber()));
        String postalCodeMatch = Boolean.toString(apiInputDTO.getPostalCode().equals(cliente.get().getTitularData().getAddress().getPostalCode()));

        String regionMatch = Boolean.toString(matchName(apiInputDTO.getRegion(),cliente.get().getTitularData().getAddress().getRegion()));

        String localityMatch = Boolean.toString(matchName(apiInputDTO.getLocality(),cliente.get().getTitularData().getAddress().getLocality()));
        String countryMatch = Boolean.toString(matchName(apiInputDTO.getCountry(),cliente.get().getTitularData().getAddress().getCountry()));

        String houseNumberExtensionMatch = Boolean.toString(apiInputDTO.getHouseNumberExtension().equals(cliente.get().getTitularData().getAddress().getHouseNumberExtension()));

        String birthdateMatch = Boolean.toString(apiInputDTO.getBirthdate().equals(cliente.get().getTitularData().getBirthdate()));

        String emailMatch = Boolean.toString(apiInputDTO.getEmail().equals(cliente.get().getTitularData().getEmail()));

        String genderMatch = Boolean.toString(matchGender(apiInputDTO.getGender(),cliente.get().getTitularData().getGender()));


        ResponseDTO response = new ResponseDTO(idDocumentMatchedAsString,nameMatchAsString, givenNameMatchedAsString,familyNameMatchedAsString,nameKanaHankakuMatch, nameKanaZenkakuMatch,middleNamesMatch,familyNameAtBirthMatch,addressMatch,streetNameMatch,streetNumberMatch,postalCodeMatch,regionMatch,localityMatch,countryMatch,houseNumberExtensionMatch,birthdateMatch,emailMatch,genderMatch);
        log.info("Se devuelve correctamente el match");
        return response;
    }

    public boolean matchIdDocument(String inputIdDocument, String storedIdDocument) throws CustomException {

        inputIdDocument = inputIdDocument.replaceAll("\\s+", "");
        storedIdDocument = storedIdDocument.replaceAll("\\s+", "");

        String truncatedInputId = inputIdDocument.length() > 20 ? inputIdDocument.substring(0, 20) : inputIdDocument;
        String truncatedStoredId = storedIdDocument.length() > 20 ? storedIdDocument.substring(0, 20) : storedIdDocument;

        String normalizedInputId = truncatedInputId.toLowerCase();
        String normalizedStoredId = truncatedStoredId.toLowerCase();


//        String[][] specialCharacters = {
//                {"à", "a"}, {"è", "e"}, {"ì", "i"}, {"ò", "o"}, {"ù", "u"},
//                {"ä", "a"}, {"ë", "e"}, {"ï", "i"}, {"ö", "o"}, {"ü", "u"},
//                {"â", "a"}, {"ê", "e"}, {"î", "i"}, {"ô", "o"}, {"û", "u"},
//                {"á", "a"}, {"é", "e"}, {"í", "i"}, {"ó", "o"}, {"ú", "u"},
//                {"ð", "d"}, {"ý", "y"}, {"ã", "a"}, {"ñ", "n"}, {"õ", "o"},
//                {"š", "s"}, {"ž", "z"}, {"ç", "c"}, {"å", "a"}, {"ø", "o"},
//                {"ß", "ss"}
//        };
//
//        // Se reemplazan caracteres especiales
//        for (String[] pair : specialCharacters) {
//            normalizedInputId = normalizedInputId.replace(pair[0], pair[1]);
//            normalizedStoredId = normalizedStoredId.replace(pair[0], pair[1]);
//        }
//
//        // Se elimina cualquier carácter que no sea alfanumerico
//        normalizedInputId = normalizedInputId.replaceAll("[^a-z0-9]", "");
//        normalizedStoredId = normalizedStoredId.replaceAll("[^a-z0-9]", "");


        return normalizedInputId.equals(normalizedStoredId);
    }

    public boolean matchName(String inputName, String storedName) throws CustomException {

        //OJO, el especaio cuenta como elemento. Es posible que si hay diferentes espcacios entre los String se cojan subsecuencias distintas. Me parece
        //más correcto añadir al principio eliminar espacios antes que truncar. Posible mejora.

        //Mejora incorporada

        inputName = inputName.replaceAll("\\s+", "");
        storedName = storedName.replaceAll("\\s+", "");


        String truncatedInputId = inputName.length() > 40 ? inputName.substring(0, 40) : inputName;
        String truncatedStoredId = storedName.length() > 40 ? storedName.substring(0, 40) : storedName;

        String normalizedInputId = truncatedInputId.toLowerCase();
        String normalizedStoredId = truncatedStoredId.toLowerCase();


        String[][] specialCharacters = {
                {"à", "a"}, {"è", "e"}, {"ì", "i"}, {"ò", "o"}, {"ù", "u"},
                {"ä", "a"}, {"ë", "e"}, {"ï", "i"}, {"ö", "o"}, {"ü", "u"},
                {"â", "a"}, {"ê", "e"}, {"î", "i"}, {"ô", "o"}, {"û", "u"},
                {"á", "a"}, {"é", "e"}, {"í", "i"}, {"ó", "o"}, {"ú", "u"},
                {"ð", "d"}, {"ý", "y"}, {"ã", "a"}, {"ñ", "n"}, {"õ", "o"},
                {"š", "s"}, {"ž", "z"}, {"ç", "c"}, {"å", "a"}, {"ø", "o"},
                {"ß", "ss"}
        };

        // Se reemplazan caracteres especiales
        for (String[] pair : specialCharacters) {
            normalizedInputId = normalizedInputId.replace(pair[0], pair[1]);
            normalizedStoredId = normalizedStoredId.replace(pair[0], pair[1]);
        }

//        // Se elimina cualquier carácter que no sea alfanumerico
        normalizedInputId = normalizedInputId.replaceAll("[^a-z0-9]", "");
        normalizedStoredId = normalizedStoredId.replaceAll("[^a-z0-9]", "");


        return normalizedInputId.equals(normalizedStoredId);
    }

    public boolean matchStreetName(String inputStreetName, String storedStreetName) throws CustomException {

        //Aqui no puede ser porque se tienen que eliminar las palabras que hemos especificado y si quitas los espacios no lo detecta
//        inputStreetName = inputStreetName.replaceAll("\\s+", "");
//        storedStreetName = storedStreetName.replaceAll("\\s+", "");

        String truncatedInputId = inputStreetName.length() > 40 ? inputStreetName.substring(0, 40) : inputStreetName;
        String truncatedStoredId = storedStreetName.length() > 40 ? storedStreetName.substring(0, 40) : storedStreetName;

        String normalizedInputId = truncatedInputId.toLowerCase();
        String normalizedStoredId = truncatedStoredId.toLowerCase();

        String[][] specialCharacters = {
                {"à", "a"}, {"è", "e"}, {"ì", "i"}, {"ò", "o"}, {"ù", "u"},
                {"ä", "a"}, {"ë", "e"}, {"ï", "i"}, {"ö", "o"}, {"ü", "u"},
                {"â", "a"}, {"ê", "e"}, {"î", "i"}, {"ô", "o"}, {"û", "u"},
                {"á", "a"}, {"é", "e"}, {"í", "i"}, {"ó", "o"}, {"ú", "u"},
                {"ð", "d"}, {"ý", "y"}, {"ã", "a"}, {"ñ", "n"}, {"õ", "o"},
                {"š", "s"}, {"ž", "z"}, {"ç", "c"}, {"å", "a"}, {"ø", "o"},
                {"ß", "ss"}
        };

        for (String[] pair : specialCharacters) {
            normalizedInputId = normalizedInputId.replace(pair[0], pair[1]);
            normalizedStoredId = normalizedStoredId.replace(pair[0], pair[1]);
        }

        // Se eliminan palabras relacionadas con tipos de calles
        String[] streetTypeKeywords = {"calle", "avenida", "plaza", "crta", "carretera", "alameda", "camino", "glorieta", "paseo", "ronda", "avda", "via", "parque", "poligono"};
        for (String keyword : streetTypeKeywords) {
            normalizedInputId = normalizedInputId.replaceAll("\\b" + keyword + "\\b", "");
            normalizedStoredId = normalizedStoredId.replaceAll("\\b" + keyword + "\\b", "");
        }


        normalizedInputId = normalizedInputId.replaceAll("[^a-z0-9\\s]", "").replaceAll("\\s+", "");
        normalizedStoredId = normalizedStoredId.replaceAll("[^a-z0-9\\s]", "").replaceAll("\\s+", "");

        return normalizedInputId.equals(normalizedStoredId);
    }

    public boolean matchGender(String inputGender, String storedGender) throws CustomException {
        inputGender= inputGender.replaceAll("[^a-zA-Z0-9]", "").replaceAll("\\s+", "");
        storedGender = storedGender.replaceAll("[^a-zA-Z0-9]", "").replaceAll("\\s+", "");

        if ("Masculino".equalsIgnoreCase(storedGender)) {
            storedGender = "Male";
        } else if ("Femenino".equalsIgnoreCase(storedGender)) {
            storedGender = "Female";
        }

        inputGender = inputGender.toLowerCase();
        storedGender = storedGender.toLowerCase();




        return inputGender.equals(storedGender);


    }




}
