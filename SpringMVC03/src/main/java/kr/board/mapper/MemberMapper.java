package kr.board.mapper;

import org.apache.ibatis.annotations.Mapper;
import kr.board.entity.Member;

// mybatis-api를 쓰면 아래 어노테이션을 쓸 수 있다.
@Mapper
public interface MemberMapper {
	
	public Member registerCheck(String memID);
	
	public int register(Member m);	// 회원 등록( 성공 : 1, 실패 : 0)
	
}
