<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> <!--  html문서의 버전, HTML5 형식 -->
<html> <!-- 태그 -->
<head> <!-- 문서의 정보 현재페이지의 정보 -->
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> <!-- 문서의 내용 -->
hello
<%
String a="안녕하세요";
out.println(a);
%>
String a="안녕하세요";
out.println(a);<br>


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
//String sql=" select empno, ename, job, sal, hiredate, comm, (sal*12+nvl(comm,0)) money, dname from emp e, dept d where e.deptno=d.deptno ";
String sql=" select*from emp_v ";
pstmt=conn.prepareStatement(sql);
rs=pstmt.executeQuery();
%>
<!-- <a href="이동할 주소">하이퍼 링크텍스트</a> -->
<a href="emp_form.jsp">사원등록</a>
<table border="1">
	<tr> 	<!-- table row테이블의 행 -->
		<td>사번</td><!-- table divsion 테이블의 열 -->
		<td>이름</td>
		<td>직급</td>
		<td>급여</td>
		<td>입사일자</td>
		<td>커미션</td>
		<td>연봉</td>
		<td>부서명</td>
		</tr>
<%
while(rs.next()) {//1개의 레코드를 읽음, 내용이 있으면 true, 없으면 false
String empno=rs.getString("empno");//get자료형(필드명)
String ename=rs.getString("ename");
String job=rs.getString("job");
int sal=rs.getInt("sal");
String hiredate=rs.getString("hiredate").substring(0,10);
int comm=rs.getInt("comm");
int money=rs.getInt("money");
String dname=rs.getString("dname");
%>
	<tr>
		<td><%=empno%></td>
		<td><%=ename%></td>
		<td><%=job%></td>
		<td><%=sal%></td>
		<td><%=hiredate%></td>
		<td><%=comm%></td>
		<td><%=money%></td>
		<td><%=dname%></td>
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