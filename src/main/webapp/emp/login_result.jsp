<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%
String driver="oracle.jdbc.driver.OracleDriver";//오라클 드라이버 클래스
String url="jdbc:oracle:thin:@localhost:1521:xe";//연결문자열
String id="hr";
String pwd="hr";

Connection conn=null;
PreparedStatement pstmt=null;
ResultSet rs=null;

try {
	//Class.forName(driver);//드라이버 로딩(생략가능)
	conn=DriverManager.getConnection(url,id,pwd);//오라클 서버에 접속
	String userid=request.getParameter("userid");
	String pass=request.getParameter("pwd");
	String sql=	" select * from members where userid=? and pwd=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, userid);
	pstmt.setString(2, pass);
	rs=pstmt.executeQuery();
	if(rs.next()){
		out.println(rs.getString("username")+"님 환영합니다");
	}else{
		out.println("fail...");
	}
}catch(Exception e){
	e.printStackTrace();
}finally{

}
%>
</body>
</html>