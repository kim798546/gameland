package com.example.imple.game.snake.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.imple.game.snake.mapper.Record2Mapper;
import com.example.standard.controller.PageableController;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import jakarta.servlet.http.HttpServletRequest;

//Avoid Game 랭킹 페이지 처리 Controller
@Controller
@RequestMapping("/game/snake/record")
public class Record2PageController implements PageableController{

	@Autowired
	Record2Mapper mapper;
	
	@Autowired
	ObjectMapper json;
	
	@Override
	public String page(HttpServletRequest request, int pageNum, int pageSize, Model model) {
		var level = Integer.parseInt(request.getParameter("level"));
		model.addAttribute("level", level);
		
		PageHelper.startPage(pageNum, pageSize);
		var list = mapper.selectPageByGameLevel(level);
		var paging = PageInfo.of(list, 10);
		model.addAttribute("list", list);
		model.addAttribute("paging", paging);
		
		return "game/snake/record/page";
		
	}

}
