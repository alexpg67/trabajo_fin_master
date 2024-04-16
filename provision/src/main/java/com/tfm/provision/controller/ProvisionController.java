package com.tfm.provision.controller;

import com.tfm.provision.model.Client;
import com.tfm.provision.exception.CustomException;
import com.tfm.provision.service.ProvisionService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(path = "/provision/v0")
@CrossOrigin(origins = "*")
public class ProvisionController {

    private static final Logger log = LoggerFactory.getLogger(ProvisionController.class);
    @Autowired
    private ProvisionService provisionService;
    @GetMapping(path = "/getall")
    public List<Client> getClients(){

        log.info("Se devuelven todos los clientes");
        return provisionService.getAllClients();

    }

    @GetMapping(path = "/get/msisdn/{msisdn}")
    public Optional<Client> getMsisdnClient(@PathVariable String msisdn) throws CustomException {
        Optional<Client> cliente = provisionService.getMsisdnClient(msisdn);

        if (cliente.isEmpty()){
            log.info("No se ha encontrado el cliente con MSISDN: {}", msisdn); // Log informativo cuando no se encuentra el MSISDN
            throw new CustomException(HttpStatus.NOT_FOUND, "UNKNOWN_MSISDN", "Can't be checked because the msisdn is unknown");
        }else{
            log.info("Se devuelve el cliente con MSISDN: {}", msisdn); // Log informativo cuando no se encuentra el MSISDN
            return cliente;

        }
//        return provisionService.getMsisdnClient(msisdn);

    }

    @GetMapping(path = "/get/email/{email}")
    public List<Client> getCorreoClient(@PathVariable String email) throws CustomException {

//        return provisionService.getEmailClient(email);

        List<Client> cliente = provisionService.getEmailClient(email);

        if (cliente.isEmpty()){
            log.info("No se ha encontrado el cliente con email: {}", email);
            throw new CustomException(HttpStatus.NOT_FOUND, "UNKNOWN_EMAIL", "Can't be checked because the email is unknown");
        }else{
            log.info("Se devuelve el cliente con email: {}", email);
            return cliente;

        }

    }

    @GetMapping(path = "/get/dni/{dni}")
    public List<Client> getDniClient(@PathVariable String dni) throws CustomException {
        List<Client> cliente = provisionService.getDniClient(dni);

        if (cliente.isEmpty()){
            log.info("No se ha encontrado el cliente con DNI: {}", dni);
            throw new CustomException(HttpStatus.NOT_FOUND, "UNKNOWN_DNI", "Can't be checked because the dni is unknown");
        }else{
            log.info("Se devuelve el cliente con DNI: {}", dni);
            return cliente;

        }



//        return provisionService.getDniClient(dni);

    }


//    @PostMapping(path = "/newclient")
//    public ResponseEntity<Client> setData(@RequestBody @Valid Client cliente) throws CustomException {
//        String imsi = cliente.getImsi();
//        int mcc = cliente.getMcc();
//        String mnc = cliente.getMnc();
//
//        String mccStr = String.valueOf(mcc);
//        String mncStr = String.valueOf(mnc);
//
//        String imsiMcc = imsi.substring(0, 3); // Obtener los primeros 3 dígitos del IMSI
//        String imsiMnc = imsi.substring(3);    // Obtener los siguientes dígitos del IMSI
//
//        boolean titular = cliente.isTitular();
//
//        if(titular){
//            List<Client> document = provisionService.getDniClient(cliente.getTitularData().getIdDocument());
//            if (!document.isEmpty()){
//                System.out.println("No esta vacio");
//                //return ResponseEntity.badRequest().build();
//               // CustomException excepcion = new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
//
////                try {
//                    System.out.println("Salta la excepcion");
//                  throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
////                } catch (CustomException ex) {
////                    System.out.println("No puede haber dos titulares con los mismos datos");
////                }
//
//            }
//        }
////        Client savedClient = provisionService.saveClient(cliente);
////        return ResponseEntity.ok(savedClient);
//        if (imsiMcc.equals(mccStr) && imsiMnc.startsWith(mncStr)) {
//            ZonedDateTime now = ZonedDateTime.now();
//            String formattedDate = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX"));
//
//            System.out.println(now);
//            System.out.println(formattedDate);
//
//
//            cliente.setLatestSimChange(formattedDate);
//            System.out.println(cliente);
//            Client savedClient = provisionService.saveClient(cliente);
//            System.out.println(savedClient);
//
//            return ResponseEntity.ok(savedClient);
//        } else {
//            // No hay coincidencia
//            //return new ResponseEntity<>("Los primeros 3 dígitos del IMSI no coinciden con MCC o los siguientes no coinciden con MNC.", HttpStatus.BAD_REQUEST);
//            throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT", "Client specified an invalid argument, request body or query param");
//        }
//
//       // return provisionService.saveClient(cliente);
////Añadir formato de codigos HTTP y la variable timestamp. El de la unicidad es 409. Si la entrada esta mal es un 400. Hay que darle forma. falta el PUT.
//        //A partir de ahí, hacer las pruebas.
//
//    }

    @PostMapping(path = "/newclient")
    public ResponseEntity<Client> setData(@RequestBody @Valid Client cliente) throws CustomException {

        Client savedClient = provisionService.saveClient(cliente);
        log.info("Se añade el nuevo cliente con MSISDN : {}", cliente.getMsisdn());
        return ResponseEntity.ok(savedClient);


    }

    @PutMapping(path = "/updateclient/{msisdn}")
    public ResponseEntity<Client> updateData(@PathVariable String msisdn, @RequestBody Client updateclient) throws CustomException {


            Client savedClient = provisionService.updateClient(updateclient);
            log.info("Se ha modificado el cliente con MSISDN: {}", savedClient.getMsisdn());
            return ResponseEntity.ok(savedClient);

    }


    @DeleteMapping(path = "/delete/msisdn/{msisdn}")
    public Optional<Client> deleteMsisdnClient(@PathVariable String msisdn) throws CustomException {

        Optional<Client> clienteBorrado = provisionService.deleteMsisdnClient(msisdn);

        if (clienteBorrado.isEmpty()){
            log.info("No se ha encontrado el cliente con MSISDN: {}", msisdn);
            throw new CustomException(HttpStatus.NOT_FOUND, "UNKNOWN_MSISDN", "Can't be deleted because the msisdn is unknown");
        }else{
            log.info("Se ha eliminado el cliente con MSISDN: {}", msisdn);
            return clienteBorrado;

        }

//        return provisionService.deleteMsisdnClient(msisdn);

    }

    @DeleteMapping(path = "/delete/email/{email}")
    public List<Client> deleteEmailClient(@PathVariable String email) throws CustomException {
        List<Client> clientesBorrados = provisionService.deleteEmailClient(email);
        if (clientesBorrados.isEmpty()){
            log.info("No se ha encontrado el cliente con correo: {}", email);
            throw new CustomException(HttpStatus.NOT_FOUND, "UNKNOWN_EMAIL", "Can't be deleted because the email is unknown");
        }else{
            log.info("Se ha eliminado el cliente con correo: {}", email);
            return clientesBorrados;

        }

//        return provisionService.deleteEmailClient(email);

    }

    @DeleteMapping(path = "/delete/dni/{dni}")
    public List<Client> deleteDniClient(@PathVariable String dni) throws CustomException {


        List<Client> clientesBorrados = provisionService.deleteDniClient(dni);
        if (clientesBorrados.isEmpty()){
            log.info("No se ha encontrado el cliente con DNI: {}", dni);
            throw new CustomException(HttpStatus.NOT_FOUND, "UNKNOWN_DNI", "Can't be deleted because the dni is unknown");
        }else{
            log.info("Se ha eliminado el cliente con DNI: {}", dni);
            return clientesBorrados;

        }
//        return provisionService.deleteDniClient(dni);

    }

    @GetMapping("/error")
    public String generateInternalServerError() {
        // Simulamos un error interno lanzando una excepción
        log.info("Se ha simula error interno del servidor");
        throw new RuntimeException("Simulación de error interno");
    }

    @GetMapping("/timeout")
    public String testTimeout() throws InterruptedException {
        // Simula un tiempo de espera excesivo
        Thread.sleep(60000); // Espera 60 segundos (1 minuto)
        return "Response after timeout";
    }
}
