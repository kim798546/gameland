package com.example.imple.game.snake.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

//Snake Game 플레이 화면 Controller
@Controller
@RequestMapping("/game/snake")
public class SnakeGameController {
	
	@GetMapping("/setting")
	void setting() {
		
	}
	
	@GetMapping("/setting/{level}")
	String startGame(@PathVariable("level") int level, Model model) {
		model.addAttribute("level", level);
		return "game/snake/game";
	}	
}
