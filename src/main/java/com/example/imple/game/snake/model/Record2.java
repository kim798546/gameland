package com.example.imple.game.snake.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//DB의 Record2 테이블(Snake Game 랭킹 기록 테이블)과 상호작용하기 위한 Model
@Data
@AllArgsConstructor(staticName = "of")
@NoArgsConstructor
@Builder
public class Record2{
	String userName;
	int    score;
	int	   gameLevel;
}
