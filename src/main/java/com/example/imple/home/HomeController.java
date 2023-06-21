package com.example.imple.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

//home화면 Controller
@Controller
public class HomeController {
	
	@GetMapping("/")
	String home() {
		return "home";
	}
}
