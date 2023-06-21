package com.example.standard.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import jakarta.servlet.http.HttpServletRequest;

//Ajax로 받은 데이터 처리 관련 interface
public interface AjaxCreateController<T,K,V> {
	
	@GetMapping("/create")
	void create(Model model, HttpServletRequest request);
	
	@PostMapping("/create")
	ResponseEntity<T> create(@RequestBody Map<K, V> requestBody);
	
}
