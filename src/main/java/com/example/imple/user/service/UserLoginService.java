package com.example.imple.user.service;

import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.imple.user.mapper.UserMapper;

//사용자 로그인 결과를 처리하는 Service
@Service
public class UserLoginService implements UserDetailsService {

	@Autowired
	UserMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		var user = mapper.selectById(username);
		
		if (Objects.isNull(user))
			throw new UsernameNotFoundException("없는 유저입니다.");
			
		return User.builder()
				   .username(user.getId())
				   .password(user.getPassword())
				   .roles(user.getRole())
				   .build();
	}

}
