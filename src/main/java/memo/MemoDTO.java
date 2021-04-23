package memo;

import java.sql.Date;

public class MemoDTO {
	private int idx;
	private String writer;
	private String memo;
	private Date post_date;
	private String ip;
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Date getPost_date() {
		return post_date;
	}
	public void setPost_date(Date post_date) {
		this.post_date = post_date;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	@Override
	public String toString() {
		return "MemoDTO [idx=" + idx + ", writer=" + writer + ", memo=" + memo + ", post_date=" + post_date + ", ip="
				+ ip + "]";
	}
	public MemoDTO() {}//기본 생성자
	public MemoDTO(int idx, String writer, String memo, Date post_date, String ip) {
		super();
		this.idx = idx;
		this.writer = writer;
		this.memo = memo;
		this.post_date = post_date;
		this.ip = ip;
	}
	

}
