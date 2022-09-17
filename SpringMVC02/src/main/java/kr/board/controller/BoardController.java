package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {
	
	@Autowired
	BoardMapper boardMapper;
	
	@RequestMapping("/")
	public String main() {
		return "main";
	}
	
	// @ResponseBody --> jackson-databind(객체를 -> json 데이터 포맷으로 변환)
	@RequestMapping("/boardList.do")
	public @ResponseBody List<Board> boardList(){		// 객체를 리턴??? --> json 데이터 형식으로 변환을 해서 리턴하겠다.	--> @ResponseBody어노테이션 필요
		List<Board> list = boardMapper.getLists();
		return list;  // 객체를 리턴??? --> json 데이터 형식으로 변환을 해서 리턴하겠다.  --> api필요 : jakson-databind
	}
}

