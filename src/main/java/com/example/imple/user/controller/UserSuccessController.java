package com.example.imple.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.standard.controller.SuccessController;

import jakarta.servlet.http.HttpServletRequest;

//계정 수정, 생성 완료 페이지 처리 Controller
@Controller
@RequestMapping("/user")
public class UserSuccessController implements SuccessController {

	@Override
	public void success(Model model, HttpServletRequest request) {
		
	}

}
