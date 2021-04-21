<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="emp.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//버튼을 눌러서 넘어온 empno값을 숫자로 바꾸어 저장
int empno
=Integer.parseInt(request.getParameter("empno"));
EmpDAO dao=new EmpDAO();//dao 인스턴스를 만들고
dao.updateSal(empno);//급여인상 처리
%>
<!-- 처리되었습니다.<br>
<a href="list.jsp">사원목록으로 이동</a> -->
<script>
	alert("처리완료");
	location.href="list.jsp";
	</script>
</body>
</html>