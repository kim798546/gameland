<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="/img/favicon.png">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<script src=/webjars/bootstrap/js/bootstrap.min.js></script>
<script src=/webjars/jquery/jquery.min.js></script>
<title>Game Land 찾기 결과</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Dancing+Script:wght@500;700&family=Kalam:wght@700&family=Nanum+Pen+Script&family=Hahmlet:wght@600&display=swap');
.hahmlet {
	font-family: 'Hahmlet', serif;
}
</style>
</head>
<body>
<main class="container text-center">
<article class="hahmlet">
	<c:choose>
		<c:when test="${id ne null}">
			<h1 class="bg-success text-light p-3">아이디 찾기</h1>
			<h3>id 조회 결과입니다.</h3>
			<hr>
			<h4>당신의 id는 ${id}입니다.</h4>
		</c:when>
		<c:when test="${pw ne null}">
			<h1 class="bg-success text-light p-3">비밀번호 찾기</h1>
			<h3>임시 비밀번호를 발급해드렸습니다.</h3>
			<hr>
			<h4>임시 비밀번호는 ${pw} 입니다.</h4>
			<h4>로그인 하신 후 꼭 비밀번호를 변경해주시기 바랍니다.</h4>		
		</c:when>
	</c:choose>
</article>
<div>
	<a href="/user/login" class="btn btn-success">로그인 페이지로 이동</a>
</div>
</main>
</body>
</html>