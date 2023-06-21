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
<link rel="stylesheet" href="/css/h-tag-font.css">
<link rel="icon" href="/img/favicon.png">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<script src=/webjars/bootstrap/js/bootstrap.min.js></script>
<script src=/webjars/jquery/jquery.min.js></script>
<title>Welcome Snake Game!</title>
</head>
<body>
<h1>Snake 게임 세계에 오신 것을 환영합니다.</h1>
<hr>
<main class="container">
<div class="row">
<img class="col-4" alt="xxx" src="/img/snakeGame.jpg">
<pre class="col-6 nanum text-left" style="font-size: 20pt">
간단설명:
목표물을 향해 이동하여 캐릭터의 몸집을 키우시면 됩니다.
1. 파란색 블록이 캐릭터, 흰색 블록이 목표물입니다.
2. 게임이 시작되면 캐릭터는 일정한 속도로 이동합니다.
3. 화살표 버튼이나 키보드의 방향키로 캐릭터의 방향을 조절합니다.
4. 캐릭터가 목표물을 집어 삼키면 길이가 길어지고, 1점이 추가됩니다.
5. 캐릭터가 벽에 부딪히거나, 자기 자신과 만나면 게임 종료.
6. 난이도는 3단계까지 있으며,
   난이도에 따라 캐릭터의 속도가 달라집니다.
7. 1단계: 쉬움, 2단계: 보통, 3단계: 어려움
8. Start 버튼을 눌러 게임을 시작하고,
   Stop 버튼을 눌러 일시정지 할 수 있습니다.
9. 난이도 선택 후 플레이 해주세요!
</pre>
</div>
	<hr>
	<h3 class="col-12">플레이 할 난이도를 선택해주세요.</h3>
	<a href="/game/snake/setting/1" class="btn btn-success">Level1</a>
	<a href="/game/snake/setting/2" class="btn btn-success">Level2</a> 
	<a href="/game/snake/setting/3" class="btn btn-success">Level3</a>
	<hr>
	<div><a href="/" class="btn btn-secondary">메인 화면으로</a></div>
</main>
</body>
</html>