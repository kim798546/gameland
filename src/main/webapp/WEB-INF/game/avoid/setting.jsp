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
<title>Welcome Avoid Game!</title>
</head>
<body>
<h1>Block 피하기 게임 세계에 오신 것을 환영합니다.</h1>
<hr>
<main class="container">
<div class="row">
<img class="col-4" alt="xxx" src="/img/avoidGame.jpg">
<pre class="col-6 nanum text-left" style="font-size: 20pt">
간단설명:
하늘에서 떨어지는 수 많은 블록들을 방향키를 이용해 피하시면 됩니다.
1. 가운데에 A문자가 적혀있는 블록이 캐릭터 입니다.
2. 화살표 버튼이나 키보드의 방향키로 캐릭터를 조작합니다.
3. 하늘에서 수 많은 블록들이 떨어집니다. 캐릭터와 부딪히면 게임종료.
4. 블록이 바닥까지 떨어졌을 때 점수가 1점 추가 됩니다.
5. 난이도는 3단계까지 있으며,
   난이도에 따라 블록의 속도와 수가 달라집니다.
6. 1단계: 쉬움, 2단계: 보통, 3단계: 어려움
7. Start 버튼을 눌러 게임을 시작하고,
   Stop 버튼을 눌러 일시정지 할 수 있습니다.
8. 난이도 선택 후 플레이 해주세요!
</pre>
</div>
	<hr>
	<h3 class="col-12">플레이 할 난이도를 선택해주세요.</h3>
	<a href="/game/avoid/setting/1" class="btn btn-success">Level1</a>
	<a href="/game/avoid/setting/2" class="btn btn-success">Level2</a>
	<a href="/game/avoid/setting/3" class="btn btn-success">Level3</a>
	<hr>
	<div><a href="/" class="btn btn-secondary">메인 화면으로</a></div>
</main>
</body>
</html>