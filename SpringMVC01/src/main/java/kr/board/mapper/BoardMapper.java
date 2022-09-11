package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.board.entity.Board;

// mybatis-api를 쓰면 아래 어노 테이션을 쓸 수 있다.
@Mapper
public interface BoardMapper {
	
	public List<Board> getLists();	// 게시판 전체 리스트
	
	public void boardInsert(Board vo);
	
	public Board boardContent(int idx);
	
	public void boardDelete(int idx);
	
}
