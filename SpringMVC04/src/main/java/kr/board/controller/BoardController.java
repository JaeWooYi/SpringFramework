package kr.board.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.board.mapper.BoardMapper;

// Rest전 기존 방식..
@Controller
public class BoardController {
	
	@Autowired
	BoardMapper boardMapper;
	
	@RequestMapping("/boardMain.do")
	public String main() {
		return "board/main";
	}
	
}

