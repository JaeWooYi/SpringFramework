package kr.board.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.board.entity.Member;
import kr.board.entity.MemberUser;
import kr.board.mapper.MemberMapper;

public class MemberUserDetailsService implements org.springframework.security.core.userdetails.UserDetailsService{	// 스프링에서 기본적으로 만들어져있는 인터페이스를 사용하자

	@Autowired
	private MemberMapper memberMapper;
	
	// UserDetailsService -- 2
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		// 로그인 처리하기
		Member mvo = memberMapper.memberLogin(username);
		// 위 정보를(mvo) -> UserDetails(spring에서 있는 인터페이스클래스)에 있는 User객체에 담아야 한다 -> User을 구현하는 클래스를 또만들어야해...(MeberUser라고 만들자)
		if(mvo != null) {
			return new MemberUser(mvo);	// 그냥 return mvo; 는 안돼니 new MemberUser(mvo)로 해야해 -> Member, Auth정보를 Meberuser에 넣어 주는거야 
		}else {		// ID가 없으면 null처리해야지
			throw new UsernameNotFoundException("user with username " + username +" dose not exist.");
		}
	}

}
