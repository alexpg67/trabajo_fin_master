package com.tfm.simswap.controller;

import com.tfm.simswap.exception.CustomException;
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
