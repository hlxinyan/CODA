package com.coda.erp;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * The Spring Boot application for the ERPApplication
 */
@SpringBootApplication
@EnableScheduling
@Slf4j
public class ERPApplication {
    public static void main(String... args) {
        SpringApplication.run(ERPApplication.class, args);
    }
}
