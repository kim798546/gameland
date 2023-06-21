package com.example.standard.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;

//성공 페이지 처리 관련 interface
public interface SuccessController {
	
	@GetMapping("/success")
	void success(Model model, HttpServletRequest request);
}
