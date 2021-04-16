<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*"%>

<%
String driver="oracle.jdbc.driver.OracleDriver";//오라클 드라이버 클래스
//jdbc:dbms이름@호스트:포트/데이터베이스
String url="jdbc:oracle:thin:@localhost:1521:xe";//연결문자열
String id="hr";
String pwd="hr";

Connection conn=null;
PreparedStatement pstmt=null;
try{
	conn=DriverManager.getConnection(url,id,pwd);//오라클 서버에 접속
	String sql="insert into emp(empno, ename, job, sal, hiredate, comm) values(?,?,?,?,?,?)";//sql 명령어 작성
	pstmt=conn.prepareStatement(sql);
	//1번부터 6번까지 ?에 값을 입력.
			//request.getParameter("태그의 name")
	pstmt.setInt(1, Integer.parseInt(request.getParameter("empno")));
	pstmt.setString(2, request.getParameter("ename"));
	pstmt.setString(3, request.getParameter("job"));
	pstmt.setInt(4, Integer.parseInt(request.getParameter("sal")));
	pstmt.setString(5, request.getParameter("hiredate"));
	pstmt.setInt(6, Integer.parseInt(request.getParameter("comm")));
	pstmt.executeUpdate();//레코드가 저장됨
	response.sendRedirect("list.jsp");//list.jsp 페이지로 이동

}catch(Exception e){
e.printStackTrace();
}finally{
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
%>

</body>
</html>