package com.tfm.provision;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.PropertySource;

@SpringBootApplication
//@PropertySource("classpath:application-security.properties")
public class ProvisionApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProvisionApplication.class, args);
	}

}
