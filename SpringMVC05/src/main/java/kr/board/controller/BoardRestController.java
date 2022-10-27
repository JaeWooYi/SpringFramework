package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@RequestMapping("/board")
@RestController		// 보통 Ajax쓸때 쓰는 컨트롤러 -> @ResponseBody(JSON응답) 생략가능
public class BoardRestController {
	
	@Autowired
	BoardMapper boardMapper;

	// @ResponseBody --> jackson-databind(객체를 -> json 데이터 포맷으로 변환)
	@GetMapping("/all")
	public List<Board> boardList(){		// 객체를 리턴??? --> json 데이터 형식으로 변환을 해서 리턴하겠다.	--> @ResponseBody어노테이션 필요
		List<Board> list = boardMapper.getLists();
		return list;  // 객체를 리턴??? --> json 데이터 형식으로 변환을 해서 리턴하겠다.  --> api필요 : jakson-databind
	}
	
	@PostMapping("/new")
	public void boardInsert(Board vo) {
		boardMapper.boardInsert(vo);		// 등록 성공!
	}
	
	@DeleteMapping("/{idx}")
	public void boardDelete(@PathVariable("idx") int idx) {	// @RequestParam("idx") 붙이나 안붙이나 실행에 영향 없네 히히
		boardMapper.boardDelete(idx);
	}
	
	@PutMapping("/update")
	public void boardUpdate(@RequestBody Board vo) {
		boardMapper.boardUpdate(vo);
	}
	
	@GetMapping("/{idx}")
	public Board boardContent(@PathVariable("idx") int idx) {
		Board vo = boardMapper.boardContent(idx);
		return vo;
	}
	
	@PutMapping("/count/{idx}")
	public Board boardCount(@PathVariable int idx) {	// @ResponseBody좀 제발 까먹지 말자
		boardMapper.boardCount(idx);
		Board vo = boardMapper.boardContent(idx);
		return vo;
	}
	
}
