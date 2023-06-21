package com.example.imple.user.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

//DB의 Users 테이블(계정 목록 관리 테이블)과 상호작용하기 위한 Model
@Data
@AllArgsConstructor(staticName = "of")
@NoArgsConstructor
@Builder
public class User {
	@NonNull String id;
	@NonNull String password;
			 String role;
			 String name;
			 String phoneNumber;
			 
}
