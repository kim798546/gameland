package com.example.imple.game.avoid.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//DB의 Record 테이블(Avoid Game 랭킹 기록 테이블)과 상호작용하기 위한 Model
@Data
@AllArgsConstructor(staticName = "of")
@NoArgsConstructor
@Builder
public class Record{
	String userName;
	int    score;
	int    elapseTime;
	int	   gameLevel;
}
