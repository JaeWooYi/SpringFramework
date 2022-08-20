package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {

	// /boardList.do라는 요청이 오면?
	
	@Autowired
	private BoardMapper mapper;
	
	// HandlerMapping
	@RequestMapping("/boardList.do")
	public String boardList(Model model) {
		// retrun타입이 view페이지의 경로니까 String
		
		List<Board> list = mapper.getLists();
		model.addAttribute("list", list);
		
		return "boardList";	// WEB_INF/views/boardList.jsp
	}
	
	
}

