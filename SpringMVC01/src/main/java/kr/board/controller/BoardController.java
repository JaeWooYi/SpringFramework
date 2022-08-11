package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.board.entity.Board;

@Controller
public class BoardController {

	// /boardList.do라는 요청이 오면?
	// HandlerMapping
	@RequestMapping("/boardList.do")
	public String boardList(Model model) {
		// retrun타입이 view페이지의 경로니까 String
		
		Board vo = new Board();
		vo.setIdx(1);
		vo.setTitle("first board");
		vo.setContent("Test good?");
		vo.setWriter("KKK");
		vo.setIndate("2022-01-01");
		vo.setCount(0);
		
		List<Board> list = new ArrayList<Board>();
		list.add(vo);
		list.add(vo);
		list.add(vo);
		model.addAttribute("list", list);
		
		return "boardList";	// WEB_INF/views/boardList.jsp
	}
	
	
}
