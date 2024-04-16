package com.tfm.simswap.service;

import com.tfm.simswap.exception.CustomException;
import com.tfm.simswap.model.CheckDTO;
import com.tfm.simswap.model.Client;
import com.tfm.simswap.repository.SimswapRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

@Service
public class SimswapService {

    private static final Logger log = LoggerFactory.getLogger(SimswapService.class);

    @Autowired
    private SimswapRepository simswapRepository;

    // Ahora este método no es estático
    public Optional<Client> getClient(String msisdn) throws CustomException {
        return simswapRepository.findClientByMsisdn(msisdn);

    }

    public Boolean checkSwap(CheckDTO check) throws CustomException {

        String msisdn = check.getPhoneNumber();
        int maxAge = check.getMaxAge();

        Optional<Client> cliente = simswapRepository.findClientByMsisdn(msisdn);

        if (cliente.isEmpty()) {
            log.info("No se ha encontrado el cliente con MSISDN, no se puede devolver el swapped: {}", msisdn); // Log informativo cuando no se encuentra el MSISDN
            throw new CustomException(HttpStatus.NOT_FOUND, "SIM_SWAP.UNKNOWN_PHONE_NUMBER", "SIM Swap can't be checked because the phone number is unknown");
        }

        String swaptimestamp = cliente.get().getLatestSimChange();


        Instant swaptimestampInstant = Instant.parse(swaptimestamp);


        Instant now = Instant.now();


        Instant thresholdDate = now.minus(maxAge, ChronoUnit.DAYS);


        boolean isSwappedRecently = swaptimestampInstant.isAfter(thresholdDate);

        return isSwappedRecently;




    }
}















