package com.example.imple.game.snake.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.imple.game.snake.model.Record2;
import com.github.pagehelper.Page;

//DB의 Record2 테이블(Snake Game 랭킹 기록 테이블)과 상호작용하기 위한 Mapper
@Mapper
public interface Record2Mapper {
	
	@Select("""
				select count(*)
				  from record2
				 where game_level = #{gameLevel}
			""")
	int countAllOfxLevel(@Param("gameLevel") int gameLevel);
	
	@Select("""
				select *
				  from record2
				 where game_level = #{gameLevel}
				 order by score desc
			""")
	List<Record2> selectAllOfxLevel(@Param("gameLevel") int gameLevel);
	
	@Select("""
				select *
				  from record2
				 where game_level = #{gameLevel}
				 order by score desc
			""")
	Page<Record2> selectPageByGameLevel(@Param("gameLevel") int gameLevel);
	
	@Select("""
				select *
				  from (
				    select *
				      from record2
				     where game_level = #{gameLevel}
				     order by score
				    )
				  where rownum = 1
			""")
	Record2 selectLastRowOfxLevel(@Param("gameLevel") int gameLevel);
	
	@Select("select * from record2 desc")
	List<Record2> selectAll();
	
	@Insert("""
			insert into record2
			(user_name, score, game_level)
			values
			(#{record.userName}, #{record.score}, #{record.gameLevel})
			""")
	int insertRecord(@Param("record") Record2 record);
	
	@Delete("""
			delete from record2
			 where (score, game_level) = (
				select score, game_level
				  from (
					select score, game_level
					  from record2
				     where game_level = #{gameLevel}
					 order by score 
				  )
				 where rownum = 1
			)
			""")
	int deleteMinRecordOfxLevel(@Param("gameLevel") int gameLevel);
}
