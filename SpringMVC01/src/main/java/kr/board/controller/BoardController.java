package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {

	// /boardList.do라는 요청이 오면?
	
	@Autowired
	private BoardMapper mapper;
	
	// 보드 리스트 조회!!
	// HandlerMapping
	@RequestMapping("/boardList.do")
	public String boardList(Model model) {
		// retrun타입이 view페이지의 경로니까 String
		
		List<Board> list = mapper.getLists();
		model.addAttribute("list", list);
		
		return "boardList";	// WEB_INF/views/boardList.jsp
	}
	
	// 입력페이지 가기!!
	@GetMapping("/boardForm.do")		// RequestMappgin으로 해도 된다.
	public String boardForm() {	
		return "boardForm";
	}
	
	// 입력하기!
	@PostMapping("/boardInsert.do")		// post방식으로 오니까 PostMapping로 하자.
	public String boardInsert(Board vo) {
		
		mapper.boardInsert(vo);		// 파라미터 수집, 등록
		
		return "redirect:/boardList.do";
	}
	
	// 상세보기!!
	//@GetMapping("/boardContent.do")
	@RequestMapping("/boardContent.do")
	public String boardContent(@RequestParam("idx") int idx, Model model) {
		
		Board vo = mapper.boardContent(idx);
		model.addAttribute("vo", vo);
		
		return "boardContent";
	}
	
	// 삭제하기!!
	//@GetMapping("/boardDelete.do/{idx}")
	@RequestMapping("/boardDelete.do/{idx}")
	public String boardDelete(@PathVariable("idx") int idx) {
		
		mapper.boardDelete(idx);
		
		return "redirect:/boardList.do";
	}
	
}

