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
	String sql=	" select * from userlist where userid=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, userid);
	rs=pstmt.executeQuery();
	if(rs.next()){
		out.println(request.getParameter("userid")+"는 사용할 수 없는 아이디입니다.");
	}else {
		out.println(request.getParameter("userid")+"입력하신 id는 사용 가능합니다.");
	}
	
}catch(Exception e){
	e.printStackTrace();
}finally{

}
%>
</body>
</html>
