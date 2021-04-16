
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberList {
	public static void main(String[] args) {
		String driver="oracle.jdbc.driver.OracleDriver";//오라클 드라이버 클래스
		               //jdbc:dbms이름@호스트:포트/데이터베이스
		String url="jdbc:oracle:thin:@localhost:1521:xe";//연결문자열
		String id="hr";
		String pwd="hr";
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			//Class.forName(driver);//드라이버 로딩(생략가능)
			conn=DriverManager.getConnection(url,id,pwd);//오라클 서버에 접속
			String sql="select *from emp";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			System.out.println("사번\t이름\t직급\t급여");
			while(rs.next()) {//1개의 레코드를 읽음, 내용이 있으면 true, 없으면 false
				String empno=rs.getString("empno");//get자료형(필드명)
				String ename=rs.getString("ename");
				String job=rs.getString("job");
				int sal=rs.getInt("sal");
				System.out.println(empno+"\t"+ename+"\t"+job+"\t"+sal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();//참조변수가 'rs가 가리키는 내용'이 null이 아니면 close()
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if(pstmt!=null) pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if(conn!=null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
