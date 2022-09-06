package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	@GetMapping("/boardForm.do")		// RequestMappgin으로 해도 된다.
	public String boardForm() {	
		return "boardForm";
	}
	
	@PostMapping("/boardInsert.do")		// post방식으로 오니까 PostMapping로 하자.
	public String boardInsert(Board vo) {
		
		mapper.boardInsert(vo);		// 파라미터 수집, 등록
		
		return "redirect:/boardList.do";
	}
	
}

