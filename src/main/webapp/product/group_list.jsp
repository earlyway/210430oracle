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
>상품명 <input type="text" name="product_name">
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
String sql=
" select p.product_code,product_name,sum(price*amount)" 
+" from product p, product_sales s"
+" where p.product_code=s.product_code and product_name like ?" 
	+" group by p.product_code, product_name";


pstmt=conn.prepareStatement(sql);
String name="";
if(request.getParameter("product_name")!=null){
	name=request.getParameter("product_name");
}
pstmt.setString(1, name+"%");
rs=pstmt.executeQuery();
%>
<!-- <a href="이동할 주소">하이퍼 링크텍스트</a> -->
<table border="1">
	<tr> 	<!-- table row테이블의 행 -->
		<td>상품코드</td><!-- table divsion 테이블의 열 -->
		<td>상품명</td>
		<td>금액 합계</td>
		</tr>
<%
while(rs.next()) {//1개의 레코드를 읽음, 내용이 있으면 true, 없으면 false
String product_code=rs.getString("product_code");//get자료형(필드명)or get자료형(인덱스)
String product_name=rs.getString("product_name");
int sum=rs.getInt(3);


%>
	<tr>
		<td><%=product_code%></td>
		<td><%=product_name%></td>
		<td><%=sum%></td>
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