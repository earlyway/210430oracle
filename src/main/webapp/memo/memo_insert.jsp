<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="memo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String writer=request.getParameter("writer");
String memo=request.getParameter("memo");
MemoDTO dto=new MemoDTO();
dto.setWriter(writer);
dto.setMemo(memo);
dto.setIp(request.getRemoteAddr());//클라이언트의 ip주소
MemoDAO dao=new MemoDAO();
dao.insertMemo(dto);
response.sendRedirect("memo_list.jsp");//페이지 이동
%>
</body>
</html>