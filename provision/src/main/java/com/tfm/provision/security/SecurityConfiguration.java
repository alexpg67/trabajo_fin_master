package com.tfm.provision.security;
import com.tfm.provision.exception.CustomAuthenticationFailureHandler;
import com.tfm.provision.exception.CustomAuthorizationFailureHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.oauth2.jwt.JwtDecoders;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.context.annotation.Profile;

@Configuration
@PropertySource("classpath:application-security.properties")
@EnableWebSecurity
@Profile("!test")
public class SecurityConfiguration {

    @Autowired
    private CustomAuthenticationFailureHandler authenticationFailureHandler;

    @Autowired
    private CustomAuthorizationFailureHandler authorizationFailureHandler;

    @Bean
    public SecurityFilterChain configure(HttpSecurity http) throws Exception {

        http
                .csrf(csrf -> csrf.disable()) // Deshabilitar CSRF Sin esto, error 401 para metodos POST, PUT, DELETE
                .authorizeHttpRequests((authorize) -> authorize

                        .requestMatchers("/actuator/**").permitAll()
//                                  .requestMatchers(HttpMethod.GET, "/provision/v0/get/msisdn/**").permitAll()
//                        .requestMatchers(HttpMethod.POST, "/provision/v0/newclient").permitAll()
                                .requestMatchers( "/provision/v0/**").permitAll()
                                .requestMatchers( HttpMethod.DELETE,"/provision/v0/**").permitAll()
                                .requestMatchers( HttpMethod.POST,"/provision/v0/**").permitAll()
                                .requestMatchers( HttpMethod.PUT,"/provision/v0/**").permitAll()
//                        .requestMatchers("/provision/v0/newclient").permitAll()
//                        .requestMatchers("/provision/v0/updateclient/**").permitAll()
//                        .requestMatchers("/provision/v0/delete/**").permitAll()

                        .anyRequest().authenticated()


                )




//                .exceptionHandling(exceptionHandling -> exceptionHandling
//                        .authenticationEntryPoint(authenticationFailureHandler)
//                        .accessDeniedHandler(authorizationFailureHandler)
//                )
                .oauth2Login(Customizer.withDefaults())
//                .oauth2ResourceServer((oauth2) -> oauth2
//                        .jwt(jwt -> jwt
//////                        .decoder(JwtDecoders.fromIssuerLocation("http//:localhost:8080/realms/Test"))
//                        .decoder(JwtDecoders.fromIssuerLocation("http://localhost:8080/realms/Test"))
////                        .jwtAuthenticationConverter(jwtAuthenticationConverter())
//
//               )

//        );
        ;

        return http.build();
    }

//    @Bean
//    public JwtAuthenticationConverter jwtAuthenticationConverter() {
//        JwtAuthenticationConverter converter = new JwtAuthenticationConverter();
//        // Configura el convertidor para manejar las autoridades
//        converter.setJwtGrantedAuthoritiesConverter(new JwtGrantedAuthoritiesConverter());
//        return converter;
//    }

    }
