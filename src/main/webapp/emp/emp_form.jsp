<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>사원등록</h2><!-- heading 태그, 제목 h1~h6 -->
<!-- 데이터를 서버에 보내기 위해서는 form 태그를 사용
post 방식- 많은 양의 데이터를 서버에 보낼 때 사용
action 데이터를 받을 서버측 주소
데이터입력은 input 태그사용, name="변수명" 서버에서 확인하는 변수명
br : 줄바꿈 태그
type="submit" 제출 버튼, 
제출 버튼을 누르면 action에 지정한 주소로 데이터가 넘어감 -->
<form method="post" action="insert.jsp">
사번 : <input type="text" name="empno"><br>
이름 : <input type="text" name="ename"><br>
직급 : <input type="text" name="job"><br>
급여 : <input type="text" name="sal"><br>
입사일자 : <input type="text" name="hiredate"><br>
커미션 : <input type="text" name="comm"><br>
<input type="submit" value="확인">
</form>

</body>
</html>