package kr.board.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.board.entity.AuthVO;
import kr.board.entity.Member;
import kr.board.mapper.MemberMapper;

@Controller
public class MemberController {

	@Autowired
	MemberMapper memberMapper;
	
	// MVC04에서 추가된 부분
	@Autowired
	PasswordEncoder pwEncoder;
	
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
		   mvo.getMemAGE()==0 || mvo.getAuthList().size()==0 ||
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
		
		// 회원을 테이블에 저장하기!	// 추가(MVC04	와 다른점) : 비밀번호를 암호화해야 한다.
		String encyptPw = pwEncoder.encode(mvo.getMemPASSWORD());	// password를 암호화 시켜서 encyptPw로 받자
		mvo.setMemPASSWORD(encyptPw);
		//	register() 수정 해줘야 함 -> MemberMapper.xml --- 추가(MVC04	와 다른점)
		int result = memberMapper.register(mvo);
		if(result ==1) {	// 회원가입 성공 메시지
			// 추가(MVC04	와 다른점) : 권한 테이블에 회원의 권환을 저장하기
			List<AuthVO> list =  mvo.getAuthList();
			for(AuthVO authVO : list) {
				if(authVO.getAuth() != null) {
					AuthVO saveVO = new AuthVO();
					saveVO.setMemID(mvo.getMemID());	// 회원 ID
					saveVO.setAuth(authVO.getAuth());	// 회원의 권한
					memberMapper.authInsert(saveVO);
				}
			}
			
			rttr.addFlashAttribute("msgType", "Success!");
			rttr.addFlashAttribute("msg", "Signed Up!!");
			
			// 회원가입이 성공하면 로그인처리하게 할까??
			Member mvo2 = memberMapper.getMember(mvo.getMemID());	// 추가(MVC04	와 다른점) // getMember() -> 역시 수정되어야함 : 회원정보 + 회원권한 정보 (xml파일)
			session.setAttribute("mvo", mvo2); // ${empty m}인지 체크해보기 or ${!empty m}	// header.jsp 가봐 있어
			System.out.println("회원가입 성공!! : " + mvo2);
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "Fail..");
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
		if(mvo != null && pwEncoder.matches(m.getMemPASSWORD(), mvo.getMemPASSWORD())) {	//	login success	// springMVC05에서 추가된 부분 : && pwEncoder.matches(m.getMemPASSWORD(), mvo.getMemPASSWORD())
			rttr.addFlashAttribute("msgType", "Success Message");
			rttr.addFlashAttribute("msg", "Login Success");
			session.setAttribute("mvo", mvo);	// ${!empty mvo}
			return "redirect:/";
		}else {				// 	login fail
			rttr.addFlashAttribute("msgType", "Fail Message");
			rttr.addFlashAttribute("msg", "Retry");
			return "redirect:/memLoginForm.do";
		}
	}
	
	// 회원정보 수정 페이지 가기
	@RequestMapping("/memUpdateForm.do")
	public String memUpdateForm() {
		return "member/memUpdateForm";
	}
	
	// 회원정보 수정하기
	@RequestMapping("/memUpdate.do")
	public String memUpdate(Member mvo, RedirectAttributes rttr, HttpSession session,
							String memPASSWORD1, String memPASSWORD2) {
		if(mvo.getMemID()==null || mvo.getMemID().equals("") ||
		   memPASSWORD1==null || memPASSWORD1.equals("") ||
		   memPASSWORD2==null || memPASSWORD2.equals("") ||
		   mvo.getMemNAME()==null || mvo.getMemNAME().equals("") ||
		   mvo.getMemAGE()==0 || mvo.getAuthList().size()==0 ||
		   mvo.getMemGENDER()==null || mvo.getMemGENDER().equals("") ||
		   mvo.getMemEMAIL()==null || mvo.getMemEMAIL().equals("")) {
			
			// 누락메시지와 함께 가기 --> rttr을 통해(객체바인딩 못하니까)
			rttr.addFlashAttribute("msgType", "Fail Message");
			rttr.addFlashAttribute("msg", "Input everything Plz!");
			return "redirect:/memUpdateForm.do";
		}
		if(!memPASSWORD1.equals(memPASSWORD2)) {
			rttr.addFlashAttribute("msgType", "Fail Message");
			rttr.addFlashAttribute("msg", "Check Your Password!");
			return "redirect:/memUpdateForm.do";
		}
		
		// 회원을 테이블에 저장하기!
		String encyptPW =pwEncoder.encode(mvo.getMemPASSWORD());
		mvo.setMemPASSWORD(encyptPW);
		int result = memberMapper.memUpdate(mvo);
		if(result ==1) {	// 수정 성공 메시지
			// 기존 권한을 삭제하고
			memberMapper.authDelete(mvo.getMemID());
			
			// 새로운 권한을 추가
			List<AuthVO>  list = mvo.getAuthList();
			for(AuthVO authVO : list) {
				if(authVO.getAuth() != null) {
					AuthVO saveVO = new AuthVO();
					saveVO.setMemID(mvo.getMemID());	// 회원 ID
					saveVO.setAuth(authVO.getAuth());	// 회원의 권한
					memberMapper.authInsert(saveVO);
				}
			}
			  
			rttr.addFlashAttribute("msgType", "Success!");
			rttr.addFlashAttribute("msg", "Update success!!");
			
			// 수정 성공하면 로그인처리
			Member mvo2 = memberMapper.getMember(mvo.getMemID());
			session.setAttribute("mvo", mvo2);
			
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "Fail..");
			rttr.addFlashAttribute("msg", "Update Fail..");
			return "redirect:/memUpdateForm.do";
		}
	}
	
	// 프로필 사진등록 화면!!
	@RequestMapping("/memImageForm.do")
	public String memImageForm() {
		return "member/memImageForm";
	}
	
	// 프로필 사진등록(upload -> DB에 이미지 경로 저장)
	@RequestMapping("/memImageUpdate.do")
	public String memImageUpdate(HttpServletRequest request, RedirectAttributes rttr, HttpSession session) {
		// 파일업로드 API(cos.jar(고전방식)쓸거임)
		MultipartRequest multi = null;
		int fileMaxSize = 10*1024*1024;	// 10MB를 의미
		
		// 실제 경로 -> /Users/EGOVEDU/eGovFrame-3.10.0/workspace.edu2/SpringFramework/SpringMVC03/src/main/webapp/resources/upload
		// 이클립스가 관리하는 경로 -> /Users/EGOVEDU/eGovFrame-3.10.0/workspace.edu2/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/SpringMVC03/resources/upload
		String savePath = request.getRealPath("resources/upload");
		
		// 업로드하려면 예외 처리가필요하데 ....
		try {
			// 이미지 업로드
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		}catch(Exception e){
			e.printStackTrace();
			rttr.addFlashAttribute("msgType", "Fail..");
			rttr.addFlashAttribute("msg", "Upload Fail(10MB 이하로 업로드 해주십시오)..");
			return "redirect:/memImageForm.do";
		}

		// DB에 업데이트 하기
		String memID =  multi.getParameter("memID");
		String newProfile = "";
		File file = multi.getFile("memPROFILE");
		if(file != null) {	// 업로드가 된 상태(png, jpg, gif만 해야해)
			// 이미지파일여부 체크 -> 이미지파일이 아니라면 삭제 해야함
			String ext = file.getName().substring(file.getName().lastIndexOf(".")+1);
			ext = ext.toUpperCase();
			if(ext.equals("PNG") || ext.equals("GIF") || ext.equals("JPG") || ext.equals("JPEG")) {		// 이미지 파일 일시
				// 새로 업로드된 이미지(new -> abcd.png), 현재 DB에 있는 이미지(old -> abcd1.png)
				String oldProfile = memberMapper.getMember(memID).getMemPROFILE();
				File oldFile = new File(savePath+ "/" + oldProfile);
				if(oldFile.exists()) {
					oldFile.delete();
				}
				newProfile = file.getName();
			}else {	// 이미지 파일이 아닐시
				if(file.exists()) {
					file.delete();	// 삭제
				}
				rttr.addFlashAttribute("msgType", "Fail..");
				rttr.addFlashAttribute("msg", "Upload Fail (이미지 파일만 업로드 해주세요.)");
				return "redirect:/memImageForm.do";
			}
		}
		
		// 새로운 이미지 디비에 업데이트
		Member mvo = new Member();
		mvo.setMemID(memID);
		mvo.setMemPROFILE(newProfile);
		memberMapper.memProfileUpdate(mvo);
		Member m = memberMapper.getMember(memID);	// 다시 회원정보를 가지고 와서 다시 업데이트된 멤버를 가지고 와야 한다
		// 세션생성(새롭게) : 이미지가 업데이트 된거로
		session.setAttribute("mvo", m);
		rttr.addFlashAttribute("msgType", "Success!!");
		rttr.addFlashAttribute("msg", "Upload Success (업로드 되었습니다.)");
		
		return "redirect:/";
	}
	
}
