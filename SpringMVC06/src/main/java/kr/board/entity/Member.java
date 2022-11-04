package kr.board.entity;

import java.util.List;

public class Member {

	private int memIDX;
	private String memID;
	private String memPASSWORD;
	private String memNAME;
	private int memAGE;
	private String memGENDER;
	private String memEMAIL;
	private String memPROFILE;
	private List<AuthVO> authList;	// authList[0], authList[1], authList[2] 이런식으로 넘어오겠지? authList[2].auth 이렇게 부여할꺼야 join.jsp봐봐
	
	public int getMemIDX() {
		return memIDX;
	}
	public void setMemIDX(int memIDX) {
		this.memIDX = memIDX;
	}
	public String getMemID() {
		return memID;
	}
	public void setMemID(String memID) {
		this.memID = memID;
	}
	public String getMemPASSWORD() {
		return memPASSWORD;
	}
	public void setMemPASSWORD(String memPASSWORD) {
		this.memPASSWORD = memPASSWORD;
	}
	public String getMemNAME() {
		return memNAME;
	}
	public void setMemNAME(String memNAME) {
		this.memNAME = memNAME;
	}
	public int getMemAGE() {
		return memAGE;
	}
	public void setMemAGE(int memAGE) {
		this.memAGE = memAGE;
	}
	public String getMemGENDER() {
		return memGENDER;
	}
	public void setMemGENDER(String memGENDER) {
		this.memGENDER = memGENDER;
	}
	public String getMemEMAIL() {
		return memEMAIL;
	}
	public void setMemEMAIL(String memEMAIL) {
		this.memEMAIL = memEMAIL;
	}
	public String getMemPROFILE() {
		return memPROFILE;
	}
	public void setMemPROFILE(String memPROFILE) {
		this.memPROFILE = memPROFILE;
	}
	public List<AuthVO> getAuthList() {
		return authList;
	}
	public void setAuthList(List<AuthVO> authList) {
		this.authList = authList;
	}
}
