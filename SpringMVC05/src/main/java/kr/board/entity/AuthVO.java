package kr.board.entity;

import lombok.Data;

@Data	// getter setter 없어도 되려나
public class AuthVO {
	private int no;			// 일련번호 
	private String memID;	// 회원 아이디	
	private String auth;	// 회원권한(3가지 부여 : ROLE_USER, ROLE_MANAGER, ROLE_ADMIN)
	
//	public int getNo() {
//		return no;
//	}
//	public void setNo(int no) {
//		this.no = no;
//	}
//	public String getMemID() {
//		return memID;
//	}
//	public void setMemID(String memID) {
//		this.memID = memID;
//	}
//	public String getAuth() {
//		return auth;
//	}
//	public void setAuth(String auth) {
//		this.auth = auth;
//	}
	
}
