package com.example.imple.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

//id, pw찾기 결과 처리 Controller
@Controller
@RequestMapping("/user")
public class UserFindResultController {
	
	@GetMapping("/find/result")
	void result() {
		
	}
	
}
