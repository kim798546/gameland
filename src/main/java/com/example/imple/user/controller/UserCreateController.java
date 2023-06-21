package com.example.imple.user.controller;

import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.imple.user.mapper.UserMapper;
import com.example.imple.user.model.UserDTO;
import com.example.standard.controller.CreateController;

import jakarta.servlet.http.HttpServletRequest;

//회원가입 처리 관련 Controller
@Controller
@RequestMapping("/user")
public class UserCreateController implements CreateController<UserDTO>{
	
	@Autowired
	UserMapper mapper;
	
	@Override
	public void create(Model model, HttpServletRequest request) {
		var error = request.getParameter("error");
		if(Objects.isNull(error)) {
			var session = request.getSession();
			session.removeAttribute("user");
			session.removeAttribute("binding");			
		}
	}
	
	@Override
	public String create(UserDTO dto, BindingResult binding, Model model, HttpServletRequest request, RedirectAttributes attr) {
		var session = request.getSession();
		session.setAttribute("user", dto);
		session.setAttribute("binding", binding);
		
		//공백여부 체크
		var id = dto.getId();
		if(!id.equals(id.replace(" ", "")))
			binding.rejectValue("id", "9999", "공백은 입력할 수 없습니다.");
		
		//비밀번호 일치 체크
		var password = dto.getPassword();
		var password2 = dto.getPassword2();
		if(!password.equals(password2)) {
			System.out.println(password);
			System.out.println(password2);
			binding.rejectValue("password", "9998", "비밀번호가 일치하지 않습니다.");			
		}
		
		//전화번호 형식 체크
		var phoneNumber = dto.getPhoneNumber();
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
			if(hasErrors) {
				binding.rejectValue("phoneNumber", "9997", "전화번호를 올바른 형식으로 작성해주세요.");
			}
		}
		
		//전화번호 중복 체크
		if(Objects.nonNull(mapper.selectByPhoneNumber(phoneNumber))) {
			binding.rejectValue("phoneNumber", "9996", "이미 존재하는 전화번호 입니다.");
			return "redirect:/user/create?error";
		}
			
		if(binding.hasErrors())
			return "redirect:/user/create?error";
		
		var user = dto.getModel();
		try {
			mapper.insertUser(user);
		} catch (DuplicateKeyException e) {
			binding.reject("id", "중복된 id입니다.");
			return "redirect:/user/create?error";
		}
		
		return "redirect:/user/success?create";
	}



	
}
