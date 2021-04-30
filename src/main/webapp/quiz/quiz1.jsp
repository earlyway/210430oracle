<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post"
>부서이름 <input type="text" name="username">
<input type="submit" value="확인">
</form>

<%@ page import="java.sql.*" %> <!-- page 지시어 -->
<%
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
String sql=
 "select username, useraddress, userphone, useremail from addre";
pstmt=conn.prepareStatement(sql);
String name="";
if(request.getParameter("username")!=null){
	name=request.getParameter("username");
}
pstmt.setString(1, name);
rs=pstmt.executeQuery();
%>
<!-- <a href="이동할 주소">하이퍼 링크텍스트</a> -->
<table border="1">
	<tr> 	<!-- table row테이블의 행 -->
		<td>이름</td><!-- table division 테이블의 열 -->
		<td>주소</td>
		<td>폰번호</td>
		<td>이메일</td>
		</tr>
<%
while(rs.next()) {//1개의 레코드를 읽음, 내용이 있으면 true, 없으면 false
String username=rs.getString("username");//get자료형(필드명)or get자료형(인덱스)
String useraddress=rs.getString("useraddress");
String userphone=rs.getString("userphone");
String useremail=rs.getString("useremail");
%>
	<tr>
		<td><%=username%></td>
		<td><%=useraddress%></td>
		<td><%=userphone%></td>
		<td><%=useremail%></td>
	</tr>
<%
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
%>
</table>
</body>
</html>