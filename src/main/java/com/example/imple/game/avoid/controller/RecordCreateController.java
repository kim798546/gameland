package com.example.imple.game.avoid.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.imple.game.avoid.mapper.RecordMapper;
import com.example.imple.game.avoid.model.Record;
import com.example.standard.controller.AjaxCreateController;

import jakarta.servlet.http.HttpServletRequest;

//Avoid Game 랭킹에 반영할 사용자 record 처리 Controller
@Controller
@RequestMapping("/game/avoid/record")
public class RecordCreateController implements AjaxCreateController<String, String, String>{
	
	@Autowired
	RecordMapper mapper;
	
	@Override
	public void create(Model model, HttpServletRequest request) {
		
	}

	@Override
	public ResponseEntity<String> create(Map<String, String> requestBody) {
		var userName = requestBody.get("userName");
		var level = Integer.parseInt(requestBody.get("level"));
		var score = Integer.parseInt(requestBody.get("score"));
		var elapseTime = Integer.parseInt(requestBody.get("elapseTime"));
		var record = Record.builder()
						   .userName(userName)
						   .score(score)
						   .elapseTime(elapseTime)
						   .gameLevel(level)
						   .build();
		
		//조건처리: 각 레벨 당 데이터를 최대 100개로 유지(랭킹 순).
		var minRecord = mapper.selectLastRowOfxLevel(level);
		var cnt = mapper.countAllOfxLevel(level);
		if(cnt<100) 
			mapper.insertRecord(record);			
		else {
			if(minRecord.getScore()<score || minRecord.getScore()==score && minRecord.getElapseTime()<elapseTime) {
				mapper.deleteMinRecordOfxLevel(level);
				mapper.insertRecord(record);				
			}
		}
		return ResponseEntity.ok("Data created successfully");
	}
}
