<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.Date" %>
    <%@ page import="java.util.*" %>
    <%@ page import="emp.*" %><!-- emp 패키지에 dto, dao있음. -->
<!DOCTYPE html> <!--  html문서의 버전, HTML5 형식 -->
<html> <!-- 태그 -->
<head> <!-- 문서의 정보 현재페이지의 정보 -->
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> <!-- 문서의 내용 -->
<h2>사원목록</h2>
<table border="1">
	<tr>
		<th>사번</th>
		<th>이름</th>
		<th>직급</th>
		<th>입사일자</th>
		<th>급여</th>
		<th></th>
	</tr>
	
	
<%
EmpDAO dao=new EmpDAO();
List<EmpDTO> items=dao.listEmp();
for(EmpDTO dto : items){
%>
	<tr>
		<td><%out.println(dto.getEmpno()); %></td>
		<td><%=dto.getEname() %></td>
		<td><%=dto.getJob() %></td>
		<td><%=dto.getHiredate() %></td>
		<td><%=dto.getSal()%></td>
		<td><input type="button"
		onclick=
		"location.href='update_sal.jsp?empno=<%=dto.getEmpno() %>'"
		value="급여인상"></td>
	</tr>
	<%
	}
	%>
</table>
</body>
</html>