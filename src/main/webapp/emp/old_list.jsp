<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> <!--  html문서의 버전, HTML5 형식 -->
<html> <!-- 태그 -->
<head> <!-- 문서의 정보 현재페이지의 정보 -->
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> <!-- 문서의 내용 -->
<form method="post"
>부서이름 <input type="text" name="dname">
<input type="submit" value="확인">
</form>


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
String sql=
"select e.deptno, dname, count(*), sum(sal),round(avg(sal)),max(sal),min(sal) from emp e, dept d where e.deptno=d.deptno and dname=? group by e. deptno, dname";

pstmt=conn.prepareStatement(sql);
String name="";
if(request.getParameter("dname")!=null){
	name=request.getParameter("dname");
}
pstmt.setString(1, name);
rs=pstmt.executeQuery();
%>
<!-- <a href="이동할 주소">하이퍼 링크텍스트</a> -->
<table border="1">
	<tr> 	<!-- table row테이블의 행 -->
		<td>부서코드</td><!-- table division 테이블의 열 -->
		<td>부서이름</td>
		<td>직원수</td>
		<td>합</td>
		<td>평균</td>
		<td>최대</td>
		<td>최소</td>
		</tr>
<%
while(rs.next()) {//1개의 레코드를 읽음, 내용이 있으면 true, 없으면 false
int deptno=rs.getInt("deptno");//get자료형(필드명)or get자료형(인덱스)
String dname=rs.getString("dname");
int count=rs.getInt(3);
int sum=rs.getInt(4);
double avg=rs.getDouble(5);
int max=rs.getInt(6);
int min=rs.getInt(7);


%>
	<tr>
		<td><%=deptno%></td>
		<td><%=dname%></td>
		<td><%=count%></td>
		<td><%=sum%></td>
		<td><%=avg%></td>
		<td><%=max%></td>
		<td><%=min%></td>
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