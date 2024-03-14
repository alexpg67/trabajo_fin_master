package com.tfm.simswap.controller;

import com.tfm.simswap.exception.CustomException;
import com.tfm.simswap.model.CheckDTO;
import com.tfm.simswap.model.Client;
import com.tfm.simswap.model.MsisdnDTO;
import com.tfm.simswap.service.SimswapService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Pattern;

@RestController
@RequestMapping(path = "/sim-swap/v0")
public class SimswapController {

    private static final Logger log = LoggerFactory.getLogger(SimswapController.class);

    @Autowired
    private SimswapService simswapService;


    @PostMapping(path = "/retrieve-data")
    public ResponseEntity<?> retrieveData(@RequestBody @Valid MsisdnDTO msisdnDTO) throws CustomException {
        String msisdn = msisdnDTO.getPhoneNumber();
//        System.out.println(msisdn);
        Optional <Client> cliente = simswapService.getClient(msisdn);
//        System.out.println(cliente);
        if (cliente.isEmpty()) {
            log.info("No se ha encontrado el cliente con MSISDN, no se puede devolver timestamp: {}", msisdn); // Log informativo cuando no se encuentra el MSISDN
            throw new CustomException(HttpStatus.NOT_FOUND, "SIM_SWAP.UNKNOWN_PHONE_NUMBER", "SIM Swap can't be checked because the phone number is unknown");
        } else {
            log.info("Se devuelve el timestamp del cliente con MSISDN: {}", msisdn); // Log informativo cuando no se encuentra el MSISDN
            String timestamp = cliente.get().getLatestSimChange();
            Map<String, Object> response = Collections.singletonMap("latestSimChange", timestamp);
            return ResponseEntity.ok(response);

        }
    }

    @PostMapping(path = "/check")
    public ResponseEntity<?> checkData(@RequestBody CheckDTO checkDTO) throws CustomException {


        String msisdn = checkDTO.getPhoneNumber();

        int maxAge = checkDTO.getMaxAge();

        if (!Pattern.matches("^\\+?[0-9]{5,15}$", msisdn)) {
            log.info("El msisdn " + msisdn + " no cumple con las reglas definidas");
            throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT","Client specified an invalid argument, request body or query param");
        }

        if (maxAge == 0) {
            maxAge = 240; // Valor por defecto
        } else if (maxAge < 1 || maxAge > 2400) {
            log.info("El parametro" + maxAge + " no está entre 1 y 2400");
            throw new CustomException(HttpStatus.BAD_REQUEST, "INVALID_ARGUMENT","Client specified an invalid argument, request body or query param");
        }

        CheckDTO check = new CheckDTO(msisdn, maxAge);


        Boolean result = simswapService.checkSwap(check);

        Map<String, Object> response = Collections.singletonMap("swapped", result);

            return ResponseEntity.ok(response);

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
