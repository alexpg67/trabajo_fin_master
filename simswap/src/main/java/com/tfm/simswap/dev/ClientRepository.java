package com.tfm.simswap.dev;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ClientRepository extends MongoRepository <Client, String>{

    Optional<Client> findClientByEmail(String email);



}
