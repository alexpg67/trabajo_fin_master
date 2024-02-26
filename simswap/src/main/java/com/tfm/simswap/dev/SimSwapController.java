package com.tfm.simswap.dev;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(path = "/sim-swap/v0")
public class SimSwapController {

    @Autowired
    private ClientService clientService;
    @GetMapping
    public Optional<Client> retrieveDate(){
//    return List.of(
//         new Client(
//                 "+34659852762",
//                 "Fulano",
//                 "Perez",
//                 "example@gmail.com"
//         )
//    );


        return clientService.getAllClients();


    }

    @PostMapping
    public Client setData(@RequestBody Client cliente){
//    return List.of(
//         new Client(
//                 "+34659852762",
//                 "Fulano",
//                 "Perez",
//                 "example@gmail.com"
//         )
//    );


        return clientService.saveClient(cliente);


    }

}
