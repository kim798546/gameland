package com.example.imple.game.avoid.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

//Avoid Game 플레이 화면 Controller
@Controller
@RequestMapping("/game/avoid")
public class AvoidGameController {
	
	@GetMapping("/setting")
	void setting() {
		
	}
	
	@GetMapping("/setting/{level}")
	String startGame(@PathVariable("level") int level, Model model) {
		//level에 따른 block들의 수 설정
		int numOfBlocks = 0;
		if(level==1)
			numOfBlocks = 10;
		else if(level==2)
			numOfBlocks = 15;
		else
			numOfBlocks = 20;
		model.addAttribute("numOfBlocks", numOfBlocks);
		model.addAttribute("level", level);
		return "game/avoid/game";
	}
	
}
