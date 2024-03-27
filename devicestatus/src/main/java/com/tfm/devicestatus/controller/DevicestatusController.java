package com.tfm.devicestatus.controller;


import com.tfm.devicestatus.exception.CustomException;
import com.tfm.devicestatus.model.ApiInputDTO;
import com.tfm.devicestatus.model.RoamingResponse;
import com.tfm.devicestatus.service.DevicestatusService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "/device-status/v0")
//@CrossOrigin(origins = "http://localhost:8082")
@CrossOrigin(origins = "*")
public class DevicestatusController {

    private static final Logger log = LoggerFactory.getLogger(DevicestatusController.class);




    @Autowired
    private DevicestatusService devicestatusService;

    @PostMapping(path = "/roaming")
    public ResponseEntity<?> roaming(@RequestBody @Valid ApiInputDTO apiInputDTO) throws CustomException {

        String msisdn = apiInputDTO.getUeId().getMsisdn();

        RoamingResponse response = devicestatusService.getRoaming(msisdn);
            return ResponseEntity.ok(response);


    }

//    @PostMapping(path = "/roamingprueba")
//    public ResponseEntity<?> roaming(@RequestBody @Valid MsisdnDTO msisdnDTO) throws CustomException {
//        String msisdn = msisdnDTO.getPhoneNumber();
//
//        System.out.println("msisdn");
//
//
//
////            Map<String, Object> response = Collections.singletonMap("latestSimChange", timestamp);
//
//        RoamingResponse response = devicestatusService.getRoaming(msisdn);
//        return ResponseEntity.ok(response);
//
//
//    }
}
