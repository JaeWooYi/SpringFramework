package kr.board.mapper;

import java.util.List;

import kr.board.entity.Board;

// mybatis-api를 쓰면 아래 어노 테이션을 쓸 수 있다.
//@Mapper
public interface BoardMapper {
	
	public List<Board> getList();	// 게시판 전체 리스트
	
}
