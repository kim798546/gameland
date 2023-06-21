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
<link rel="stylesheet" href="/css/h-tag-font.css">
<script src=/webjars/bootstrap/js/bootstrap.min.js></script>
<script src=/webjars/jquery/jquery.min.js></script>
<title>Game Land Login</title>
<script type="text/javascript">
window.onload = function() {
	let main = document.querySelector("main");
	main.style.width = "500px";
}
</script>
</head>
<body>
<a class="btn btn-secondary" href="/">메인 화면으로</a>
<main class="container">
	<div class="border p-5">
		<h3 class="text-center">Game Land Login</h3>
		<form action="/user/login" method="post">
			<label for="username">ID</label>
			<input class="form-control" id="username" name="username" placeholder="아이디를 입력하세요." value="${param.username}"/>
			<label for="password">Password</label>
			<input class="form-control" id="password" name="password" type="password" placeholder="비밀번호를 입력하세요." value="${param.password}"/>
			<input name="remember-me" type="checkbox" checked="checked"><span> 자동 로그인</span>
			<input class="btn btn-success form-control" type="submit" value="로그인"/>	
		</form>
	</div>
	<div class="row mt-3">
		<a class="col-4 border text-secondary text-decoration-none text-center" href="/user/create">회원가입</a>
		<a class="col-4 border text-secondary text-decoration-none text-center" href="/user/find/id">아이디 찾기</a>
		<a class="col-4 border text-secondary text-decoration-none text-center" href="/user/find/pw">비밀번호 찾기</a>
	</div>
	<c:if test="${exception ne null}">
		<span>*회원정보가 일치하지 않습니다.</span>
	</c:if>
</main>
</body>
</html>