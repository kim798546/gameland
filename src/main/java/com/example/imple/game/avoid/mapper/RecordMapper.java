package com.example.imple.game.avoid.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.imple.game.avoid.model.Record;
import com.github.pagehelper.Page;

//DB의 Record 테이블(Avoid Game 랭킹 기록 테이블)과 상호작용하기 위한 Mapper
@Mapper
public interface RecordMapper {
	
	@Select("""
				select count(*)
				  from record
				 where game_level = #{gameLevel}
			""")
	int countAllOfxLevel(@Param("gameLevel") int gameLevel);
	
	@Select("""
				select *
				  from record
				 where game_level = #{gameLevel}
				 order by score desc,
				 		  elapse_time desc
			""")
	List<Record> selectAllOfxLevel(@Param("gameLevel") int gameLevel);
	
	@Select("""
				select *
				  from record
				 where game_level = #{gameLevel}
				 order by score desc,
				 		  elapse_time desc
			""")
	Page<Record> selectPageByGameLevel(@Param("gameLevel") int gameLevel);
	
	@Select("""
				select *
				  from (
				    select *
				      from record
				     where game_level = #{gameLevel}
				     order by score, elapse_time
				    )
				  where rownum = 1
			""")
	Record selectLastRowOfxLevel(@Param("gameLevel") int gameLevel);
	
	@Select("select * from record desc")
	List<Record> selectAll();
	
	@Insert("""
			insert into record
			(user_name, score, elapse_time, game_level)
			values
			(#{record.userName}, #{record.score}, #{record.elapseTime}, #{record.gameLevel})
			""")
	int insertRecord(@Param("record") Record record);
	
	@Delete("""
			delete from record
			 where (score, elapse_time, game_level) = (
				select score, elapse_time, game_level
				  from (
					select score, elapse_time, game_level
					  from record
				     where game_level = #{gameLevel}
					 order by score, elapse_time 
				  )
				 where rownum = 1
			)
			""")
	int deleteMinRecordOfxLevel(@Param("gameLevel") int gameLevel);
}
