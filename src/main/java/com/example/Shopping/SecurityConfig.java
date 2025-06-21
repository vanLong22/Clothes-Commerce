package com.example.Shopping;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.http.HttpMethod;



@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                //.requestMatchers(HttpMethod.POST, "/users/login").permitAll() // Cho phép POST /users/login
            	//.anyRequest().authenticated() // Các request khác yêu cầu xác thực
            		.anyRequest().permitAll()
            )
            .csrf(csrf -> csrf.disable()); // Tắt CSRF
        return http.build();
    }
    /*
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(HttpMethod.DELETE, "/api/resource/**").permitAll()
                .anyRequest().authenticated());
        return http.build();
    }
    */
}
 
 