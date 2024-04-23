package com.gyub.omok;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@ServletComponentScan
@SpringBootApplication
public class OmokApplication {

	public static void main(String[] args) {
		SpringApplication.run(OmokApplication.class, args);
	}

}
