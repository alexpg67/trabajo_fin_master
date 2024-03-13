package com.tfm.simswap.service;

import com.tfm.simswap.exception.CustomException;
import com.tfm.simswap.model.Client;
import com.tfm.simswap.repository.SimswapRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
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
}















