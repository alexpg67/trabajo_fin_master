package com.tfm.kyc.controller;


import com.tfm.kyc.exception.CustomException;
import com.tfm.kyc.model.ApiInputDTO;
import com.tfm.kyc.model.ResponseDTO;
import com.tfm.kyc.service.KycService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/kyc-match/v0")
public class KycController {

    private static final Logger log = LoggerFactory.getLogger(KycController.class);

    @Autowired
    private KycService kycService;


    @PostMapping(path = "/match")
    public ResponseEntity<?> matchData(@RequestBody ApiInputDTO apiInputDTO) throws CustomException {



        ResponseDTO response = kycService.matchData(apiInputDTO);

        return ResponseEntity.ok(response);

    }



}
