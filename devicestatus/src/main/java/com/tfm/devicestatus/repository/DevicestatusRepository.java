package com.tfm.devicestatus.repository;

import com.tfm.devicestatus.model.Client;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;


public interface DevicestatusRepository extends MongoRepository<Client, String> {


    Optional<Client> findClientByMsisdn(String msisdn);



}
