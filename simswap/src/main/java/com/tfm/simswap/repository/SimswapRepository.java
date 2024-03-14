package com.tfm.simswap.repository;

import com.tfm.simswap.model.Client;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface SimswapRepository extends MongoRepository<Client, String> {

    Optional<Client> findClientByMsisdn(String msisdn);

//    @Query("{ 'titular_data.email' : ?0 }")
//    List<Client> findClientByEmail(String email);
//
//    @Query("{ 'titular_data.idDocument' : ?0 }")
////    Optional<Client> findClientByDni(String dni);
//    List<Client> findClientByDni(String dni);




}