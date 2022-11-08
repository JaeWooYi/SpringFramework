package kr.board.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import kr.board.security.MemberUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	@Bean
	public UserDetailsService memberUserDetailsService() {
		return new MemberUserDetailsService();
	}
	
	// 위 빈을 등록
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(memberUserDetailsService()).passwordEncoder(passwordEncoder());
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		// ~요청에 대한 보안 설정
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter,CsrfFilter.class);
		
		// 요청에따른 권한을 확인하여 서비스하는 부분 -- 1
		http
			.authorizeRequests()				// 요청에대한권한을 설정해 주겟다.
				.antMatchers("/")				// 어떤 url은 이렇게, 어떤 url은 이렇게 매치해주기 -> 일단은 "/"(루트로)로해서 모든 사용자가 사용가능
				.permitAll()					// 특별한 권한없이 모두 permit
				.and()							// 다음 또 권한 걸고싶을때 사용
			.formLogin()						// 어떤 url이 왔을때 로그인페이지로 갈건지
				.loginPage("/memLoginForm.do")
				.loginProcessingUrl("/memLogin.do")	// 스프링 인증 api를 거치겠다 -> /memLogin.do url을 통해서
				.permitAll()
				.and()
			.logout()
				.invalidateHttpSession(true) 						// 로그아웃하려면 세션을 끊어 줘야겠지?
				.logoutSuccessUrl("/")								// 로그아웃 되면 메인으로 다시 가게 해주자
				.and()
			.exceptionHandling().accessDeniedPage("/access-denied");// 혹시라도 오류가 날 수도 있기때문에 예외처리를 해주자
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

}