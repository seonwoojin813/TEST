<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 회원관리</title>
</head>
<body>
	<header>
		<h2>쇼핑몰 회원 관리 ver 1.0</h2>
	</header>
	<nav>
		<a href="register.jsp" target="content">회원등록</a>&nbsp;&nbsp;
		 <a href="list.jsp" target="content">회원목록조회/수정</a>&nbsp;&nbsp; 
		 <a href="summary.jsp" target="content">회원매출조회</a>&nbsp;&nbsp; 
		 <a href="main.jsp"target="content">홈으로</a>
	</nav>
	<section>
		<iframe width="100%" height="400px" src="main.jsp" name="content" id="content" frameborder=0>
		</iframe>

	</section>
	<footer>HRDKOREACopyright@2016 All right reserved Human
		Resource Development Service of Korea</footer>

</body>
</html>