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
<title>Game Land 아이디 찾기</title>
<script type="text/javascript">
window.onload = function() {
	let main = document.querySelector("form");
	main.style.width = "500px";
}
</script>
</head>
<body>
<a class="btn btn-secondary" href="/user/login">뒤로 가기</a>
<a class="btn btn-secondary" href="/">메인 화면으로</a>
<h1 class="nanum">아이디 찾기</h1>
<form action="/user/find/id" method="post" class="container border p-5">
	<input type="text" name="name" class="form-control" placeholder="이름을 입력해주세요.">
	<input type="text" name="phoneNumber" class="form-control" placeholder="휴대전화 번호를 입력해주세요.">
	<div>*예시:000-0000-0000</div>
	<input type="submit" class="form-control btn btn-success" value="아이디 찾기">
	<c:if test="${binding.hasErrors()}">
		<hr>
		<h4>*알림</h4>
	</c:if>
	<c:forEach var="g" items="${binding.globalErrors}">
		<div>${g.defaultMessage}</div>
	</c:forEach>
	<c:forEach var="f" items="${binding.fieldErrors}">
		<div>${f.defaultMessage}</div>	
	</c:forEach>
</form>
</body>
</html>