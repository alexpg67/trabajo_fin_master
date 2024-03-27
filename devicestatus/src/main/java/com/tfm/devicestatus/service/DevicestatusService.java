package com.tfm.devicestatus.service;

import com.tfm.devicestatus.exception.CustomException;
import com.tfm.devicestatus.model.Client;
import com.tfm.devicestatus.model.RoamingResponse;
import com.tfm.devicestatus.repository.DevicestatusRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.sql.Array;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Service
public class DevicestatusService {

    private static final Logger log = LoggerFactory.getLogger(DevicestatusService.class);

    @Autowired
    private DevicestatusRepository devicestatusRepository;

    @Autowired
    private StringRedisTemplate redisTemplate;


    public RoamingResponse getRoaming(String msisdn) throws CustomException {

        Boolean roaming = false;
       Optional<Client> cliente = devicestatusRepository.findClientByMsisdn(msisdn);

        if (cliente.isEmpty()) {
            log.info("No se ha encontrado el cliente con MSISDN, no se puede devolver el estado de roaming: {}", msisdn); // Log informativo cuando no se encuentra el MSISDN
            throw new CustomException(HttpStatus.NOT_FOUND, "NOT_FOUND", "The specified resource is not found");
        }

       int countryCode = cliente.get().getMcc();

        // Hay que hacer el mapeo en redis
        List<String> countryName = new ArrayList<>();
//        countryName.add("Spain");



        String imsi = cliente.get().getImsi();


        String mccStr = String.valueOf(countryCode);


        String imsiMcc = imsi.substring(0, 3); //Los 3 primeros digitos del IMSI son los del MCC de la red local.

        if (!imsiMcc.equals(mccStr)){

            log.info("Voy a consultar a redis");
            // Consulta en Redis
            String country = redisTemplate.opsForValue().get(String.valueOf(countryCode));
            log.info("El usuario está en roaming en " + country);
            countryName.add(country);
            roaming = true;
            RoamingResponse isRoaming =  new RoamingResponse(roaming, countryCode, countryName);
            return isRoaming;

        }

        RoamingResponse isNotRoaming =  new RoamingResponse(roaming, countryCode, new ArrayList<>());
        return isNotRoaming;







    }
}
