<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Welcome Game Land!</title>
<link rel="icon" href="/img/favicon.png">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="/css/h-tag-font.css">
<script src=/webjars/bootstrap/js/bootstrap.js></script>
<script src=/webjars/jquery/jquery.js></script>
<style>
.flex {
	display: flex;
}

.card {
	flex-grow: 1;
	margin: 50px;
}
main {
	background-color: black;
}
</style>
</head>
<body>
<h1>Welcome Game Land!</h1>
<hr>
<sec:authorize access="isAnonymous()">
	<h3>*랭킹 등록을 원하시면 로그인 후 플레이 해주세요!</h3>
	<a class="btn btn-success" href="/user/login">로그인</a>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
	<h3><sec:authentication property="name"/>님 환영합니다.</h3>
	<form action="/user/update">
		<input type="hidden" name="id" value="<sec:authentication property="name"/>">
		<input type="submit" class="btn btn-secondary" value="회원정보 수정">
		<a class="btn btn-secondary" href="/user/logout">로그아웃</a>
	</form>
</sec:authorize>
<main class = "flex">
<div class="card">
  <div class="card-body text-center">
  <video id="video1" src="/video/avoidGame.mp4" controls="controls" width="300px"></video>
    <h4 class="card-title">Avoid Game</h4>
    <div class="card-text">떨어지는 블록에 부딪히지 말고</div>
    <div class="card-text">끝까지 생존하세요!</div>
    <a class="btn btn-secondary" href="/game/avoid/setting">블록피하기 게임 플레이!</a>
	<a class="btn btn-secondary" href="/game/avoid/record/page/1/10?level=1">랭킹</a>
  </div>
</div>
<div class="card">
  <div class="card-body text-center">
  <video id="video2" src="/video/snakeGame.mp4" controls="controls"></video>
    <h4 class="card-title">Snake Game</h4>
    <p class="card-text">먹이를 찾아서 몸집을 키우세요!</p>
    <a class="btn btn-secondary" href="/game/snake/setting">스네이크 게임 플레이!</a>
    <a class="btn btn-secondary" href="/game/snake/record/page/1/10?level=1">랭킹</a>
  </div>
</div>
</main>
</body>
<!-- 비디오가 로드되는 속도가 일정하지 않아서 불가피하게 아래에 둠 -->
<script type="text/javascript">
let isLoaded = false;
video1.onloadeddata = function() {
	video2.style.height = getComputedStyle(video1).height;
}
video2.onloadeddata = function() {			
		video2.style.height = getComputedStyle(video1).height;
}	
</script>
</html>