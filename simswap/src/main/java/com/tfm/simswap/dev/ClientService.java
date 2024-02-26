package com.tfm.simswap.dev;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ClientService {

   @Autowired
    private ClientRepository clientRepository;

    public Optional<Client> getAllClients(){
        return clientRepository.findClientByEmail("example@gmail.com");
    }

    public Client saveClient(Client cliente){
        return clientRepository.save(cliente);
    }
}
