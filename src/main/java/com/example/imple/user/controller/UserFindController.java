package com.example.imple.user.controller;

import java.util.Objects;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.imple.user.mapper.UserMapper;
import com.example.imple.user.model.UserDTO;

import jakarta.servlet.http.HttpServletRequest;

//id, pw찾기 관련 처리 Controller
@Controller
@RequestMapping("/user")
public class UserFindController{
	
	@Autowired
	UserMapper mapper;
	
	@GetMapping("/find/id")
	void findId(Model model, HttpServletRequest request) {
		var session = request.getSession();
		var error = request.getParameter("error");
		if(Objects.isNull(error)){
			session.removeAttribute("user");
			session.removeAttribute("binding");
		}	
	}
	
	@PostMapping("/find/id")
	String findId(UserDTO dto, BindingResult binding, Model model, HttpServletRequest request, RedirectAttributes attr) {
		var session = request.getSession();
		session.setAttribute("user", dto);
		session.setAttribute("binding", binding);
		
		var phoneNumber = dto.getPhoneNumber();
		
		//이름과 전화번호 입력 여부 확인
		if(dto.getName().trim() == "" || dto.getPhoneNumber().trim() == "")
			binding.reject("not blank", "공백은 입력할 수 없습니다.");
		
		//전화번호 형식 체크
		String numbers = "0123456789";
		boolean hasErrors = false;
		if(phoneNumber.length()==13) {
			for(int i=0; i<13; i++) {
				if(i==3 || i==8)
					hasErrors = !("-".equals(phoneNumber.charAt(i)+"")); //"-"가 아니면 error
				else {
					String target = phoneNumber.charAt(i)+"";
					if(!numbers.contains(target))
						hasErrors = true;
				}
			}
			if(hasErrors)
				binding.rejectValue("phoneNumber", "9997", "전화번호를 올바른 형식으로 작성해주세요.");
		}
		
		
		if(binding.hasErrors())
			return "redirect:/user/find/id?error";
		
		var user = mapper.selectByPhoneNumber(phoneNumber);
		if(Objects.nonNull(user) && user.getName().equals(dto.getName())) {
			var id = user.getId();
			attr.addFlashAttribute("id", id);
			return "redirect:/user/find/result";			
		} else {
			binding.rejectValue("id", "9991", "해당 정보와 일치하는 아이디가 없습니다.");
			return "redirect:/user/find/id?error";			
		}
	}
	
	@GetMapping("/find/pw")
	void findPw(Model model, HttpServletRequest request) {
		var session = request.getSession();
		var error = request.getParameter("error");
		if(Objects.isNull(error)){
			session.removeAttribute("user");
			session.removeAttribute("binding");
		}	
	}
	
	@PostMapping("/find/pw")
	String findPw(UserDTO dto, BindingResult binding, Model model, HttpServletRequest request, RedirectAttributes attr) {
		var session = request.getSession();
		session.setAttribute("user", dto);
		session.setAttribute("binding", binding);
		
		var phoneNumber = dto.getPhoneNumber();
		var id = dto.getId();
		var name = dto.getName();
		var user = mapper.selectById(id);
		if(id == "" ||  name == "" || phoneNumber == "")
			binding.reject("notNull", "양식을 다 채워주세요.");
		else
			try {
				if(!(user.getId().equals(id) && user.getName().equals(name) && user.getPhoneNumber().equals(phoneNumber)))
					binding.reject("missMatch", "정보가 일치하지 않습니다.");
			} catch (NullPointerException e) {
				binding.reject("missMatch", "정보가 일치하지 않습니다.");
			}
						
		if(binding.hasErrors())
			return "redirect:/user/find/pw?error";
		
		var uuid = UUID.randomUUID();
		String password = uuid.toString().substring(0, 8); 
        var encoder = new BCryptPasswordEncoder();
        user.setPassword(encoder.encode(password));
        mapper.updatePassword(user);
        
        attr.addFlashAttribute("pw", password);
		return "redirect:/user/find/result";	
	}
}
