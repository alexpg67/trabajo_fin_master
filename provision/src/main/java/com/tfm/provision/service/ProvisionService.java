package com.tfm.provision.service;

import com.tfm.provision.exception.CustomException;
import com.tfm.provision.model.Client;
import com.tfm.provision.repository.ProvisionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Service
public class ProvisionService {

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

        String imsi = cliente.getImsi();
        int mcc = cliente.getMcc();
        String mnc = cliente.getMnc();

        String mccStr = String.valueOf(mcc);
        String mncStr = String.valueOf(mnc);

        String imsiMcc = imsi.substring(0, 3); // Obtener los primeros 3 dígitos del IMSI
        String imsiMnc = imsi.substring(3);    // Obtener los siguientes dígitos del IMSI

        boolean titular = cliente.isTitular();

        if(titular){
            List<Client> document = getDniClient(cliente.getTitularData().getIdDocument());
            if (!document.isEmpty()){
                System.out.println("No esta vacio");
                //return ResponseEntity.badRequest().build();
                // CustomException excepcion = new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");

//                try {
                System.out.println("Salta la excepcion");
                throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
//                } catch (CustomException ex) {
//                    System.out.println("No puede haber dos titulares con los mismos datos");
//                }

            }
        }
//        Client savedClient = provisionService.saveClient(cliente);
//        return ResponseEntity.ok(savedClient);
        if (imsiMcc.equals(mccStr) && imsiMnc.startsWith(mncStr)) {
            ZonedDateTime now = ZonedDateTime.now();
            String formattedDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX"));

            System.out.println(now);
            System.out.println(formattedDate);


            cliente.setLatestSimChange(formattedDate);
            System.out.println(cliente);
//            Client savedClient = saveClient(cliente);
//            System.out.println(savedClient);

//            return ResponseEntity.ok(savedClient);
            return provisionRepository.save(cliente);
        } else {
            // No hay coincidencia
            //return new ResponseEntity<>("Los primeros 3 dígitos del IMSI no coinciden con MCC o los siguientes no coinciden con MNC.", HttpStatus.BAD_REQUEST);
            throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
        }

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
