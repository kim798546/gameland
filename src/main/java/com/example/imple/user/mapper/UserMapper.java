package com.example.imple.user.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.imple.user.model.User;

//DB의 Users 테이블(계정 목록 관리 테이블)과 상호작용하기 위한 Mapper
@Mapper
public interface UserMapper {
	
	@Select("""
			select *
			  from users
			 where id = #{id}
			""")
	User selectById(String id);
	
	@Select("""
			select *
			  from users
			 where phone_number = #{phoneNumber}
			""")
	User selectByPhoneNumber(String phoneNumber);

	
	@Insert("""
			insert into users
			values
			(#{user.id}, #{user.password}, #{user.role}, #{user.name}, #{user.phoneNumber}) 
			""")
	int insertUser(@Param("user") User user);
	
	@Update("""
			update users
			   set password = #{user.password}
			 where id		= #{user.id}
			""")
	int updatePassword(@Param("user") User user);
	
	@Update("""
			update users
			   set password     = #{user.password},
			   	   role         = #{user.role},
			   	   name         = #{user.name},
			   	   phone_number = #{user.phoneNumber}
			 where id		    = #{user.id}
			""")
	int updateUser(@Param("user") User user);
}
