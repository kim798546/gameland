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
<title>Game Land 회원정보 수정</title>
</head>
<body>
<h1>회원정보 수정</h1>
<hr>
<form class="container"action="/user/update" method="post">
	<h3>기본정보</h3>
	<div class="row">
		<div class="col-8"><input name="id" class="form-control" type="text" placeholder="아이디" value="${user.id}" disabled="disabled"/></div>
		<div class="col-8"><input name="id" type="hidden" value="${user.id}"/></div>
	</div>
	<div class="row">
		<div class="col-8"><input name="password" class="form-control" type="password" placeholder="변경할 비밀번호"/></div>
	</div>
	<div class="row">
		<div class="col-8"><input name="password2" class="form-control" type="password" placeholder="비밀번호 재입력"/></div>
	</div>
	<hr>
	<h3>신상정보</h3>
	<div class="row">
		<div class="col-8"><input name="name" class="form-control" type="text" placeholder="이름" value="${user.name}"/></div>
	</div>
	<div class="row">
		<div class="col-8"><input name="phoneNumber" class="form-control" type="text" placeholder="휴대전화 번호" value="${user.phoneNumber}"/></div>
	</div>
	<div>*예시:000-0000-0000</div>
	<hr>
	<div>
		<input type="submit" class="form-control btn btn-success" value="회원정보 수정">
	</div>
	<hr>
	<a class="btn btn-secondary" href="/">메인 화면으로</a>
</form>
<c:if test="${binding.hasErrors()}">
	<h2>*알림</h2>
</c:if>
<c:forEach var="g" items="${binding.globalErrors}">
	<div>${g.defaultMessage}</div>
</c:forEach>
<c:forEach var="f" items="${binding.fieldErrors}">
	<div>${f.defaultMessage}</div>	
</c:forEach>
</body>
</html>