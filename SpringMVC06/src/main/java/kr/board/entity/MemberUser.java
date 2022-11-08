package kr.board.entity;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;

// 인증 후 사용자 정보를 저장하기 -- 3 (UserDetails)
@Data
public class MemberUser extends User{ // MemberUserDetailsService의 UserDetails메서드

	private Member member;
	
	public MemberUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public MemberUser(Member mvo) {
		super
		(mvo.getMemID(), mvo.getMemPASSWORD(),
				// List<AuthVO> -> 스프링에서 제공하는 Collection<SimpleGrantedAuthority>로 바꿔야 한다
				mvo.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()));
		
		this.member = mvo;
	}

	// 일단 만들어 놓고 안되면 이거 주석 풀자... @Data 어노테이션 롬북이 안되는거니까 ...
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
}
