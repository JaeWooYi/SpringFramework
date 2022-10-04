package kr.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.board.entity.Member;
import kr.board.mapper.MemberMapper;

@Controller
public class MemberController {

	@Autowired
	MemberMapper memberMapper;
	
	@RequestMapping("/memJoin.do")
	public String memJoin() {
		return "member/join";
	}
	
	@RequestMapping("/memRegisterCheck.do")
	public @ResponseBody int memRegisterCheck(String memID) {
		Member m = memberMapper.registerCheck(memID);
		if(m != null || memID.equals("")) {
			return 0;	// 이미 존재하는 회원 or 공백일경우
		}
		return 1;	// 사용가능할 경우
	}
	
	// 회원가입 처리
	@RequestMapping("/memberRegister.do")
	public String memberRegister(String memPASSWORD1, String memPASSWORD2
								, Member mvo, RedirectAttributes rttr, HttpSession session) {
		if(mvo.getMemID()==null || mvo.getMemID().equals("") ||
		   memPASSWORD1==null || memPASSWORD1.equals("") ||
		   memPASSWORD2==null || memPASSWORD2.equals("") ||
//		   mvo.getMemPASSWORD()==null || mvo.getMemPASSWORD().equals("") ||
		   mvo.getMemNAME()==null || mvo.getMemNAME().equals("") ||
		   mvo.getMemAGE()==0 ||
		   mvo.getMemGENDER()==null || mvo.getMemGENDER().equals("") ||
		   mvo.getMemEMAIL()==null || mvo.getMemEMAIL().equals("")) {
			
			// 누락메시지와 함께 가기 --> rttr을 통해(객체바인딩 못하니까)
			rttr.addFlashAttribute("msgType", "Fail Message");
			rttr.addFlashAttribute("msg", "Input everything Plz!");
			return "redirect:/memJoin.do";
		}
		if(!memPASSWORD1.equals(memPASSWORD2)) {
			rttr.addFlashAttribute("msgType", "Fail Message");
			rttr.addFlashAttribute("msg", "Check Your Password!");
			return "redirect:/memJoin.do";
		}
		mvo.setMemPROFILE("");	// 사진 이미지는 일단 보류
		
		// 회원을 테이블에 저장하기!
		int result = memberMapper.register(mvo);
		if(result ==1) {	// 회원가입 성공 메시지
			rttr.addFlashAttribute("msg", "Success!");
			rttr.addFlashAttribute("msg", "Signed Up!!");
			
			// 회원가입이 성공하면 로그인처리하게 할까??
			session.setAttribute("mvo", mvo); // ${empty m}인지 체크해보기 or ${!empty m}	// header.jsp 가봐 있어
			
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msg", "Fail..");
			rttr.addFlashAttribute("msg", "Already member..");
			return "redirect:/memJoin.do";
		}
	}
	
	// 로그아웃
	@RequestMapping("/memLogout.do")
	public String memLogout(HttpSession session) {
		session.invalidate();	// 세션 끊기
		return "redirect:/";
	}
	
	// 로그인화면
	@RequestMapping("/memLoginForm.do")
	public String memLoginForm() {
		return "member/memLoginForm";
	}
	
	// 로그인 기능
	@RequestMapping("/memberLogin.do")
	public String memberLogin(Member m, RedirectAttributes rttr, HttpSession session) {
		if(m.getMemID()==null || m.getMemID().equals("") ||
		   m.getMemPASSWORD()==null || m.getMemPASSWORD().equals("")) {
			rttr.addFlashAttribute("msgType", "Fail Message..");
			rttr.addFlashAttribute("msg", "Re Input");
			return "redirect:/memLoginForm.do";
		}
		
		Member mvo = memberMapper.memberLogin(m);
		if(mvo != null) {	//	login success
			rttr.addFlashAttribute("msgType", "Success Message");
			rttr.addFlashAttribute("msg", "Login Success");
			session.setAttribute("mvo", mvo);
			return "redirect:/";
		}else {				// 	login fail
			rttr.addFlashAttribute("msgType", "Fail Message");
			rttr.addFlashAttribute("msg", "Retry");
			return "redirect:/memLoginForm.do";
		}
	}
	
}
