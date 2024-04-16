package com.tfm.provision.service;

import com.tfm.provision.controller.ProvisionController;
import com.tfm.provision.exception.CustomException;
import com.tfm.provision.model.Address;
import com.tfm.provision.model.Client;
import com.tfm.provision.model.TitularData;
import com.tfm.provision.repository.ProvisionRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.regex.Pattern;

@Service
public class ProvisionService {

    private static final Logger log = LoggerFactory.getLogger(ProvisionService.class);
    @Autowired
    private ProvisionRepository provisionRepository;

    public List<Client> getAllClients(){
        //return provisionRepository.findClientByEmail("example@gmail.com");
        return provisionRepository.findAll();
    }

    public Optional<Client> getMsisdnClient(String msisdn){
        //return provisionRepository.findClientByEmail("example@gmail.com");
        return provisionRepository.findClientByMsisdn(msisdn);
    }

    public List<Client> getEmailClient(String email){
        //return provisionRepository.findClientByEmail("example@gmail.com");
        return provisionRepository.findClientByEmail(email);
    }

    public List<Client> getDniClient(String dni){
        //return provisionRepository.findClientByEmail("example@gmail.com");
        return provisionRepository.findClientByDni(dni);
    }



    public Client saveClient(Client cliente) throws CustomException{

//        String imsi = cliente.getImsi();
//        int mcc = cliente.getMcc();
//        String mnc = cliente.getMnc();
//
//        String mccStr = String.valueOf(mcc);
//        String mncStr = String.valueOf(mnc);
//
//        String imsiMcc = imsi.substring(0, 3); // Obtener los primeros 3 dígitos del IMSI
//        String imsiMnc = imsi.substring(3);    // Obtener los siguientes dígitos del IMSI

        boolean titular = cliente.isTitular();

        if(titular){
            List<Client> document = getDniClient(cliente.getTitularData().getIdDocument());
            if (!document.isEmpty()){
//                System.out.println("No esta vacio");
                log.info("Ya existe un cliente titular con los mismos datos");
                //return ResponseEntity.badRequest().build();
                // CustomException excepcion = new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");

//                try {
//                System.out.println("Salta la excepcion");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
//                } catch (CustomException ex) {
//                    System.out.println("No puede haber dos titulares con los mismos datos");
//                }

            }
        }
//        Client savedClient = provisionService.saveClient(cliente);
//        return ResponseEntity.ok(savedClient);
//        if (imsiMcc.equals(mccStr) && imsiMnc.startsWith(mncStr)) {
            ZonedDateTime now = ZonedDateTime.now();
            String formattedDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX"));

//            System.out.println(now);
//            System.out.println(formattedDate);


            cliente.setLatestSimChange(formattedDate);
//            System.out.println(cliente);


//            Client savedClient = saveClient(cliente);
//            System.out.println(savedClient);

//            return ResponseEntity.ok(savedClient);
            return provisionRepository.save(cliente);
//        } else {
//            // No hay coincidencia
//            //return new ResponseEntity<>("Los primeros 3 dígitos del IMSI no coinciden con MCC o los siguientes no coinciden con MNC.", HttpStatus.BAD_REQUEST);
//            throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
//        }

    }

    public Client updateClient(Client updateclient) throws CustomException{

        String msisdn = updateclient.getMsisdn();

        Optional<Client> cliente = getMsisdnClient(msisdn);

        if (!cliente.isPresent()) {
            log.info("No hay un cliente con ese número de teléfono");

            throw new CustomException(HttpStatus.NOT_FOUND, "UNKNOWN_MSISDN", "Can't be updated because the msisdn is unknown");
        }


        Client existingClient = cliente.get();


        if (updateclient.getImsi() != null && !updateclient.getImsi().isEmpty()) {
            if (!Pattern.matches("^[0-9]{3}[0-9]{2,3}[0-9]{1,10}$", updateclient.getImsi())) {
                log.info("no cumple con los criterios de imsi");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingClient.setImsi(updateclient.getImsi());
            log.info("Se actualiza el imsi y el timestamp");
            //Se cambia el timestamp cuando se cambia el imsi del msisdn
            ZonedDateTime now = ZonedDateTime.now();
            String formattedDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX"));


            existingClient.setLatestSimChange(formattedDate);
        }

        if (updateclient.getMcc() != 0) {
            if (updateclient.getMcc()< 0 || updateclient.getMcc() > 999) {
                log.info("no cumple con los criterios de mcc");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingClient.setMcc(updateclient.getMcc());
            log.info("Se actualiza el Mcc");


        }

        if (updateclient.getMnc() != null && !updateclient.getMnc().isEmpty()) {
            if (!Pattern.matches("^[0-9]{2,3}$", updateclient.getMnc())) {
                log.info("no cumple con los criterios de mnc");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingClient.setMnc(updateclient.getMnc());
            log.info("Se actualiza el Mnc");


        }

        if (updateclient.getCellId() != 0) {
            if (updateclient.getCellId()< 0 || updateclient.getCellId() > 9999) {
                log.info("no cumple con los criterios de cell id");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingClient.setMcc(updateclient.getCellId());
            log.info("Se actualiza el cell id");


        }



        TitularData updateTitularData = updateclient.getTitularData();
        TitularData existingTitularData = existingClient.getTitularData();
        Address updateAddress = updateTitularData.getAddress();
        Address existingAddress = existingTitularData.getAddress();

        if (updateTitularData.getName() != null && !updateTitularData.getName().isEmpty()) {
            if (!Pattern.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$", updateTitularData.getName())) {
                log.info("no cumple con los criterios de nombre completo");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingTitularData.setName(updateTitularData.getName());
            log.info("Se actualiza el Nombre completo");


        }

        if (updateTitularData.getGivenName() != null && !updateTitularData.getGivenName().isEmpty()) {
            if (!Pattern.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,2}$", updateTitularData.getGivenName())) {
                log.info("no cumple con los criterios de nombre ");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingTitularData.setGivenName(updateTitularData.getGivenName());
            log.info("Se actualiza el Nombre");


        }

        if (updateTitularData.getFamilyName() != null && !updateTitularData.getFamilyName().isEmpty()) {
            if (!Pattern.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,2}$", updateTitularData.getFamilyName())) {
                log.info("no cumple con los criterios de apellido ");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingTitularData.setFamilyName(updateTitularData.getFamilyName());
            log.info("Se actualiza el Apellido");


        }

        //Es en caso de errata, al escribirlo. El DNI no cambia de fecha
        if (updateTitularData.getIdDocument() != null && !updateTitularData.getIdDocument().isEmpty()) {
            if (!Pattern.matches("^[0-9]{8}[A-Za-z]$", updateTitularData.getIdDocument())) {
                log.info("no cumple con los criterios de dni ");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingTitularData.setIdDocument(updateTitularData.getIdDocument());
            log.info("Se actualiza el dni");


        }

        if (updateTitularData.getEmail() != null && !updateTitularData.getEmail().isEmpty()) {
            if (!Pattern.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$", updateTitularData.getEmail())) {
                log.info("no cumple con los criterios de email ");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingTitularData.setEmail(updateTitularData.getEmail());
            log.info("Se actualiza el email");


        }

        if (updateTitularData.getGender() != null && !updateTitularData.getGender().isEmpty()) {
            if (!Pattern.matches("^(Masculino|Femenino)$", updateTitularData.getGender())) {
                log.info("no cumple con los criterios de genero ");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingTitularData.setGender(updateTitularData.getGender());
            log.info("Se actualiza el genero");


        }
        //Es en caso de errata, al escribirlo. El cumpleaños no cambia de fecha
        if (updateTitularData.getBirthdate() != null && !updateTitularData.getBirthdate().isEmpty()) {
            if (!Pattern.matches("^\\d{4}-\\d{2}-\\d{2}$", updateTitularData.getBirthdate())) {
                log.info("no cumple con los criterios de cumpleaños ");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingTitularData.setBirthdate(updateTitularData.getBirthdate());
            log.info("Se actualiza el cumpleaños");


        }

        if (updateAddress.getStreetName() != null && !updateAddress.getStreetName().isEmpty()) {
            if (!Pattern.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,5}$", updateAddress.getStreetName())) {
                log.info("no cumple con los criterios del nombre de la calle");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingAddress.setStreetName(updateAddress.getStreetName());
            log.info("Se actualiza el nombre de la calle");


        }

        if (updateAddress.getStreetNumber() != null && !updateAddress.getStreetNumber().isEmpty()) {
            if (!Pattern.matches("^[0-9]{1,7}$", updateAddress.getStreetNumber())) {
                log.info("no cumple con los criterios del numero de direccion ");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingAddress.setStreetNumber(updateAddress.getStreetNumber());
            log.info("Se actualiza el numero de la calle");


        }

        if (updateAddress.getPostalCode() != null && !updateAddress.getPostalCode().isEmpty()) {
            if (!Pattern.matches("^[0-9]{1,7}$", updateAddress.getPostalCode())) {
                log.info("no cumple con los criterios del codigo postal ");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingAddress.setPostalCode(updateAddress.getPostalCode());
            log.info("Se actualiza el codigo postal");


        }

        if (updateAddress.getRegion() != null && !updateAddress.getRegion().isEmpty()) {
            if (!Pattern.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$", updateAddress.getRegion())) {
                log.info("no cumple con los criterios de la region ");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingAddress.setRegion(updateAddress.getRegion());
            log.info("Se actualiza la región del cliente");


        }

        if (updateAddress.getLocality() != null && !updateAddress.getLocality().isEmpty()) {
            if (!Pattern.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$", updateAddress.getLocality())) {
                log.info("no cumple con los criterios de la localidad ");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingAddress.setLocality(updateAddress.getLocality());
            log.info("Se actualiza la localidad del cliente");


        }

        //No debería ser distinto a España pero no lo vamos a limitar
        if (updateAddress.getCountry() != null && !updateAddress.getCountry().isEmpty()) {
            if (!Pattern.matches("^(?:[a-zA-ZáéíóúÁÉÍÓÚüÜñ]+\\s?){1,4}$", updateAddress.getCountry())) {
                log.info("no cumple con los criterios del país");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
            existingAddress.setCountry(updateAddress.getCountry());
            log.info("Se actualiza el país del cliente");


        }

        if (updateAddress.getHouseNumberExtension() != null && !updateAddress.getHouseNumberExtension().isEmpty()) {

            existingAddress.setHouseNumberExtension(updateAddress.getHouseNumberExtension());
            log.info("Se actualiza el piso del cliente");


        }





        boolean titular = updateclient.isTitular();
// La condicion cambia, si estoy modificando un cliente y dejo el DNI vacio, hay un documento con esa información que es el propio que quiero actualizar.
// Cuando haces el POST no puede haber ninguno

//        if(titular){
//            List<Client> document = getDniClient(updateclient.getTitularData().getIdDocument());
//            if (document.size() > 1 && (updateTitularData.getIdDocument() == null ||  updateTitularData.getIdDocument().isEmpty())){
//
//                log.info("Ya existe un cliente titular con los mismos datos");
//
//                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
//
//
//
//            } else if (document.size()>= 1 && (updateTitularData.getIdDocument() != null && !updateTitularData.getIdDocument().isEmpty())) {
//
//                log.info("Ya existe un cliente titular con los mismos datos");
//
//                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
//
//
//
//            }
//        }

        if (titular) {
            List<Client> existingClients = getDniClient(updateclient.getTitularData().getIdDocument());
            boolean idDocumentIsEmpty = updateTitularData.getIdDocument() == null || updateTitularData.getIdDocument().isEmpty();

            if (existingClients.size() > 1 && idDocumentIsEmpty) {
                // Caso en el que se encuentra al menos un cliente y se proporciona un DNI nulo o vacío.
                log.info("Ya existe un cliente titular con los mismos datos");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            } else if (!existingClients.isEmpty() && !idDocumentIsEmpty) {
                // Caso en el que se encuentra al menos un cliente y se proporciona un DNI no vacío.
                log.info("Ya existe un cliente titular con los mismos datos");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
            }
        }

        existingClient.setTitular(updateclient.isTitular());


        log.info("Se devuelve el cliente actualizado");

        return provisionRepository.save(existingClient);


    }
    public Optional<Client> deleteMsisdnClient(String msisdn){
        //return provisionRepository.findClientByEmail("example@gmail.com");
        return provisionRepository.deleteClientByMsisdn(msisdn);
    }

    public List<Client> deleteEmailClient(String email){
        //return provisionRepository.findClientByEmail("example@gmail.com");
        return provisionRepository.deleteManyClientByTitularDataEmail(email);
    }
    public List<Client> deleteDniClient(String dni){
        //return provisionRepository.findClientByEmail("example@gmail.com");
        return provisionRepository.deleteManyClientByTitularDataIdDocument(dni);
    }


}
