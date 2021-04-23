package memo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import common.db;
import oracle.jdbc.OracleTypes;

public class MemoDAO {
	public List<MemoDTO> listMemo(){
		List<MemoDTO>items=new ArrayList<>();	
		Connection conn=null;
		CallableStatement cstmt=null;
		ResultSet rs=null;
		try {
			conn=db.getConn();
				//{call 프로시저 이름(매개변수)}
			String sql="{call memo_list(?)}";
			cstmt=conn.prepareCall(sql);
			//출력매개변수(outParameter)를 리턴받을 변수 지정
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.execute();
			//1번 출력매개변수가 가리키는 데이터를 받아서 rs에 연결시킴
			rs=(ResultSet)cstmt.getObject(1);
			while(rs.next()) {
				int idx=rs.getInt("idx");
				String writer=rs.getString("writer");
				String memo=rs.getString("memo");
				Date post_date=rs.getDate("post_date");
				String ip=rs.getString("ip");
				MemoDTO dto=new MemoDTO(idx,writer,memo,post_date,ip);
				items.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(cstmt!=null) cstmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
				// TODO: handle exception
			}
			try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
				// TODO: handle exception
			}
		}
		return items;
	}
	
	public void insertMemo(MemoDTO dto) {
		Connection conn=null;
		CallableStatement cstmt=null;
		try {
			conn=db.getConn();
			String sql="{call memo_insert(?,?,?)}";
			cstmt=conn.prepareCall(sql);
			cstmt.setString(1, dto.getWriter());
			cstmt.setString(2, dto.getMemo());
			cstmt.setString(3, dto.getIp());
			cstmt.execute();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(cstmt!=null) cstmt.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			try {
				if(conn!=null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
}
