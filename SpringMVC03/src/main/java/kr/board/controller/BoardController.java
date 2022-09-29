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
	
	@RequestMapping("/")
	public String main() {
		return "main";
	}
	
//	// @ResponseBody --> jackson-databind(객체를 -> json 데이터 포맷으로 변환)
//	@RequestMapping("/boardList.do")
//	public @ResponseBody List<Board> boardList(){		// 객체를 리턴??? --> json 데이터 형식으로 변환을 해서 리턴하겠다.	--> @ResponseBody어노테이션 필요
//		List<Board> list = boardMapper.getLists();
//		return list;  // 객체를 리턴??? --> json 데이터 형식으로 변환을 해서 리턴하겠다.  --> api필요 : jakson-databind
//	}
//	
//	@RequestMapping("/boardInsert.do")
//	public @ResponseBody void boardInsert(Board vo) {
//		boardMapper.boardInsert(vo);		// 등록 성공!
//	}
//	
//	@RequestMapping("/boardDelete.do")
////	public @ResponseBody void boardDelete(int idx) {
//	public @ResponseBody void boardDelete(@RequestParam("idx") int idx) {	// @RequestParam("idx") 붙이나 안붙이나 실행에 영향 없네 히히
//		boardMapper.boardDelete(idx);
//	}
//	
//	@RequestMapping("/boardUpdate.do")
//	public @ResponseBody void boardUpdate(Board vo) {
//		boardMapper.boardUpdate(vo);
//	}
//	
//	@RequestMapping("/boardContent.do")
//	public @ResponseBody Board boardContent(int idx) {
//		Board vo = boardMapper.boardContent(idx);
//		return vo;
//	}
//	
//	@RequestMapping("/boardCount.do")
//	public @ResponseBody Board boardCount(int idx) {	// @ResponseBody좀 제발 까먹지 말자
//		boardMapper.boardCount(idx);
//		Board vo = boardMapper.boardContent(idx);
//		return vo;
//	}
	
}

