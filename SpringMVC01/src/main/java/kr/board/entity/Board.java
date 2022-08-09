package kr.board.entity;

public class Board {

	// Lombok사용법 : 아래 어노테이션 사용하면 된다.
	//@Data
	private int idx;	// 게시판 번호
	private String title;	// 게시판 제목
	private String content;	// 게시판 내용
	private String writer; 	// 게시판 작성자
	private String indate;	// 작성일
	private int count;		// 조회수
	
	
	/**
	 * 원래 같은 경우 getter, setter 이런식으로 만들어 준다.
	 * Lombok API를 통해 세터와 게터를 자동으로 만들수 있다.
	 */
//	public int getIdx() {
//		return idx;
//	}
//	public void setIdx(int idx) {
//		this.idx = idx;
//	}
//	public String getTitle() {
//		return title;
//	}
//	public void setTitle(String title) {
//		this.title = title;
//	}
//	public String getContent() {
//		return content;
//	}
//	public void setContent(String content) {
//		this.content = content;
//	}
//	public String getWriter() {
//		return writer;
//	}
//	public void setWriter(String writer) {
//		this.writer = writer;
//	}
//	public String getIndate() {
//		return indate;
//	}
//	public void setIndate(String indate) {
//		this.indate = indate;
//	}
//	public int getCount() {
//		return count;
//	}
//	public void setCount(int count) {
//		this.count = count;
//	}
	
}
