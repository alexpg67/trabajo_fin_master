package com.tfm.provision.repository;

import com.tfm.provision.model.Client;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.List;
import java.util.Optional;

public interface ProvisionRepository extends MongoRepository<Client, String> {

    Optional<Client> findClientByMsisdn(String msisdn);

    @Query("{ 'titular_data.email' : ?0 }")
    List<Client> findClientByEmail(String email);

    @Query("{ 'titular_data.idDocument' : ?0 }")
//    Optional<Client> findClientByDni(String dni);
    List<Client> findClientByDni(String dni);

    Optional<Client> deleteClientByMsisdn(String msisdn);
    List<Client> deleteManyClientByTitularDataEmail(String email);

    List<Client> deleteManyClientByTitularDataIdDocument(String dni);


}
