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
<title>Game Land Success</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Dancing+Script:wght@500;700&family=Kalam:wght@700&family=Nanum+Pen+Script&family=Hahmlet:wght@600&display=swap');
.hahmlet {
	font-family: 'Hahmlet', serif;
}
</style>
<script type="text/javascript">
window.onload = function() {
	let img = document.querySelector("img");
	img.style.border = "0px";
}
</script>
</head>
<body>
<main class="container text-center mt-5">
<img alt="xxx" src="/img/success.jpg" class="form-control">
<article class="hahmlet row">
	<c:choose>
		<c:when test="${param.create ne null}"><h1>회원 가입에 성공했습니다.</h1></c:when>
		<c:when test="${param.update ne null}"><h1>회원 정보 수정이 완료되었습니다.</h1></c:when>
	</c:choose>
</article>
<a class="row btn btn-success form-control mt-3" href="/">메인 화면으로</a>
</main>
</body>
</html>