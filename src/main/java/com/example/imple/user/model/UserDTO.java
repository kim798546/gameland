package com.example.imple.user.model;

import org.hibernate.validator.constraints.Length;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.example.standard.model.Modelable;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//회원가입 시 사용자가 입력한 정보를 담는 DTO
@Data
@AllArgsConstructor(staticName = "of")
@NoArgsConstructor
@Builder
public class UserDTO implements Modelable<User>{
	@NotBlank(message = "공백은 입력할 수 없습니다.")
	@Length(min = 4, max = 20, message = "아이디는 4자리에서 20자리 사이의 값을 입력해주세요.") 
	String id;
	
	@NotBlank(message = "공백은 입력할 수 없습니다.")
	@Length(min = 4, max = 12, message = "비밀번호는 4자리에서 20자리 사이의 값을 입력해주세요.")
	String password;
	
	String password2;
	
	@Length(min = 2, max = 20, message = "이름은 2자에서 20자 사이의 값을 입력해주세요.")
	String name;
	
	@Length(min = 13, max = 13, message = "전화번호를 올바른 형식으로 작성해주세요.")
	String phoneNumber;
	
	String role;

	@Override
	public User getModel() {
		var encoder = new BCryptPasswordEncoder();
		var encodedPassword = encoder.encode(password);
		
		return User.builder()
				   .id(id)
				   .password(encodedPassword)
				   .role("USER")
				   .name(name)
				   .phoneNumber(phoneNumber)
				   .build();
	}
	
	
}
