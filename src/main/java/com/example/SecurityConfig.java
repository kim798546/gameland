package com.example;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import jakarta.servlet.DispatcherType;

//Spring Security 설정
@Configuration
public class SecurityConfig {
	
	@Autowired
	UserDetailsService userDetailsService;
	
	//BCryptPasswordEncoder로 암호화
	@Bean
	PasswordEncoder encoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		//보안 관련 설정
		http.csrf(csrf ->{
			csrf.disable();
		});
		
		http.cors(cors -> {
			cors.disable();
		});
		
		//url의 허용여부 결정
		http.authorizeHttpRequests(request -> {
			request.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll();
			request.anyRequest().permitAll();
		});
		
		//로그인 방식 설정
		http.formLogin(login -> { 
			login.loginPage("/user/login"); //로그인 url 설정
			login.defaultSuccessUrl("/", true); //로그인 성공하면 항상 home으로 가도록
			login.failureHandler((request, response, e) -> { //로그인 실패 시 처리. e가 실패했을 때 에러정보
				request.setAttribute("exception", e);
				request.getRequestDispatcher("/user/login-fail").forward(request, response);
			});
			login.permitAll(); //로그인 관련 페이지는 모두 permit
		});
		
		http.logout(logout -> {
			logout.logoutUrl("/user/logout");
		});
		
		//Remember Me
		http.rememberMe(remember -> {
			remember.alwaysRemember(false);
			remember.tokenValiditySeconds(60*60*24); // 자동 로그인 얼마나 유지할지
			remember.userDetailsService(userDetailsService); 
		});
		
		return http.build();
	}
	
}
