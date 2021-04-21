package emp;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.db;

public class EmpDAO {
	public List<EmpDTO> listEmp() {
		List<EmpDTO> items = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = db.getConn();
			String sql = " select * from emp order by ename ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				EmpDTO dto = new EmpDTO();
				dto.setEmpno(rs.getInt("empno"));
				dto.setEname(rs.getString("ename"));
				dto.setJob(rs.getString("job"));
				dto.setHiredate(rs.getDate("hiredate"));
				dto.setSal(rs.getInt("sal"));
				items.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return items;

	}

	public void updateSal(int empno) {
		Connection conn = null;
		CallableStatement cstmt = null;
		try {
			conn = db.getConn();
			// { call 프로시저이름 (전달할값)}
			String sql = "{call update_sal(?)}";
			cstmt = conn.prepareCall(sql);
			cstmt.setInt(1, empno);
			cstmt.execute();// 저장 프로시저 호출
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			try {
				if (cstmt != null)
					cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
	}
}
