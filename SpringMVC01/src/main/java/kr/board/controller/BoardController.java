package kr.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {

	// /boardList.do라는 요청이 오면?
	// HandlerMapping
	@RequestMapping("/boardList.do")
	public String boardList() {
		// retrun타입이 view페이지의 경로니까 String
		
		return "boardList";
	}
	
	
}
