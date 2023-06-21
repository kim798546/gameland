package com.example.standard.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import jakarta.servlet.http.HttpServletRequest;

//페이지 처리 관련 interface
public interface PageableController {
	
	@GetMapping("/page/{pageNum}/{pageSize}")
	String page(HttpServletRequest request, @PathVariable("pageNum") int pageNum, @PathVariable("pageSize") int pageSize, Model model);
}
