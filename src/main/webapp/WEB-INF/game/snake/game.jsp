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
<script type="text/javascript" src="/js/sprintf.js"></script>
<script type="text/javascript" src="/js/snakeGame/GameModel.js"></script>
<title>Welcome Snake Game!</title>
<style type="text/css">

body {
	background-image: url("/img/forest.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}

main {
	background-color: black;
	border: 10px solid red;
	box-sizing: content-box;
}

.relative {
	position: relative;
}

.absolute {
	position: absolute;
}

.btns {
	background-color: black;
	border-left: 10px solid red;
	border-right: 10px solid red;
	border-bottom: 10px solid red;
	box-sizing: content-box;
}

.record {
	color: white;
	background-color: black;
	border-left: 10px solid red;
	border-right: 10px solid red;
	border-top: 10px solid red;
	box-sizing: content-box;
}

.popup {
	position: absolute;
	top: 50%;
	left: 50%;
	transform : translate(-50%, -50%);
	color: white;
	display: none;
	z-index: 9999;
}

.countDown {
	position: absolute;
	display: none;
	background-color: black;
	color: white;
	font-size: 30pt;
	top: 150px;
	left: 190px;
}

.character {
	width: 20px;
	height: 20px;
	background-color: blue;
}

#target {
	width: 20px;
	height: 20px;
	background-color: white;
}

</style>
<script type="text/javascript">
let c = new Game(); //character를 control할 Game 객체
let t = new Game(parseInt(Math.random()*20+1), parseInt(Math.random()*20+1)); //목표물을 control할 Game 객체
let blocks = []; //character 객체를 저장하기 위함
let blockTags = []; //character html태그를 저장하기 위함
let blockMap = Array.from(Array(20), () => Array(20).fill(null)); //20X20의 2차원 배열, Game객체의 위치를 저장하기 위함
blockMap[c.line-1][c.column-1] = c; //2차원 배열에 c의 위치를 저장
blockMap[t.line-1][t.column-1] = t; //2차원 배열에 t의 위치를 저장
blocks.splice(0, 0, c); //blocks에 c를 삽입

window.onload = function() {
	//character를 blocksTags에 삽입
	let character = document.querySelector(".character");
	blockTags.splice(0, 0, character);
	
	//출력 화면 설정
	let main = document.querySelector("main");
	let btns = document.querySelector(".btns");
	let record = document.querySelector(".record");
	let width = 20;
	let height = 20;
	main.style.padding = "0px";
	main.style.width = "400px";
	main.style.height = "400px";
	btns.style.padding = "0px";
	btns.style.width = "400px";
	btns.style.height = "250px";
	record.style.padding = "0px";
	record.style.width = "400px";
	target.style.top = (t.line-1)*20+"px";
	target.style.left = (t.column-1)*20+"px";
	
	//Start버튼을 눌렀을 때의 처리
	let countDown = document.querySelectorAll(".countDown");
	let level = parseInt(character.dataset.level);
	btnStart.onclick = function() {
			//countDown
			setTimeout(()=>{
				countDown[2].style.display = 'inline'; //3
			},1000);
			setTimeout(()=>{
				countDown[2].style.display = 'none'; 
				countDown[1].style.display = 'inline'; //2
			},2000);
			setTimeout(()=>{
				countDown[1].style.display = 'none';
				countDown[0].style.display = 'inline'; //1
			},3000);
			
			//run메소드를 호출하며 게임 시작
			setTimeout(()=>{
				countDown[0].style.display = 'none';
					c.isStart=true;
					let cycle=0;
					
					//레벨에 따른 캐릭터 속도 조절
					if(level==1)
						cycle = 200;
					else if(level==2)
						cycle = 100;
					else if(level==3)
						cycle = 50;
					c.run(blockTags, blocks, target, t, width, height, blockMap, cycle); 
			},4000);
	}
	
	//Stop버튼 누르면 캐릭터 정지
	btnStop.onclick = function() {
		let tail = blocks.length-1;
		clearTimeout(blocks[tail].timerId); 
	}
	
	//왼쪽 화살표 누르면 캐릭터 방향 왼쪽으로 전환
	btnLeft.onclick = function() {
		blocks[0].setDirectionLeft();
	}
	
	//왼쪽 화살표 누르면 캐릭터 방향 위쪽으로 전환
	btnUp.onclick = function() {
		blocks[0].setDirectionTop();
	}
	
	//왼쪽 화살표 누르면 캐릭터 방향 오른쪽으로 전환
	btnRight.onclick = function() {
		blocks[0].setDirectionRight();
	}
	
	//왼쪽 화살표 누르면 캐릭터 방향 아래쪽으로 전환
	btnDown.onclick = function() {
		blocks[0].setDirectionBottom();
	}
	
	//키보드로 캐릭터 조작
	document.onkeydown = function(e) {
		if(e.key == "ArrowLeft")
			blocks[0].setDirectionLeft();
		else if(e.key == "ArrowUp")
			blocks[0].setDirectionTop();
		else if(e.key == "ArrowRight")
			blocks[0].setDirectionRight();
		else if(e.key == "ArrowDown")
			blocks[0].setDirectionBottom();
	}
	
}
</script>
</head>
<body>
<audio src="/audio/clapandyell.mp3" autoplay="autoplay" loop="loop"></audio>
<div class="container record">
	<div class="row">
		<div class="col-5 offset-7 text-right">
			<sec:authorize access="isAuthenticated()">
		      		<sec:authentication property="name"/><span>님 환영합니다.</span>
		   	</sec:authorize>
		</div>
	</div>
	<div class="row">
		<div id="finalScoreTag" class="col-4 offset-8 text-right">Score: 0000점</div>
	</div>
</div>
<main class="container relative">
	<div id="tail" class="character absolute" data-level="${level}" data-userName="<sec:authentication property="name"/>"></div>
	<div id="target" class="absolute"></div>
	<span class="countDown">1</span>
	<span class="countDown">2</span>
	<span class="countDown">3</span>
	<div class="container popup">
		<div class="row">
			<div class="col-8 offset-2 border border-1 border-secondary rounded-3 bg-light">
				<div class="row"><div class="col-12 text-weight-bold text-secondary text-center p-2 fs-3 ">Game Over</div></div>
				<div class="row">
					<a class="col-5 btn btn-primary" href="/game/snake/setting/${level}">다시하기</a>
					<a class="col-4 btn btn-danger" href="/">종료</a>
					<a class="col-3 btn btn-success" href="/game/snake/record/page/1/10?level=${level}">랭킹</a>
				</div>
			</div>
		</div>
	</div>
</main>
<div class="container btns">
	<div class="row">
		<button id="btnStart" type="button" class="col-3 mt-1 offset-1  btn btn-success btn-lg">Start</button>
		<button id="btnStop" type="button" class="col-3  mt-1 offset-4 btn btn-danger btn-lg">Stop</button>
	</div>
	<div class="row">
		<button id="btnUp" class="col-2 offset-5 btn btn-secondary">▲</button>
	</div>
	<div class="row">
		<button id="btnLeft" type="button" class="col-2 offset-3 btn btn-secondary btn-lg">◀</button>
		<button id="btnRight" type="button" class="col-2 offset-2 btn btn-secondary btn-lg">▶</button>
	</div>
	<div class="row">
		<button id="btnDown" class="col-2 offset-5 btn btn-secondary">▼</button>
	</div>
	<div class="row">
		<span class="col-4 text-light ms-1">현재 난이도: level${level}</span>
		<a href="/game/snake/setting" class="col-3 offset-4 mb-1  btn btn-secondary">난이도<br>재 설정</a>	
	</div>
</div>
<footer>
	<span class="bg-light">음원 출처: https://www.bensound.com/free-music-for-videos. License code: L5C1KBZSKQFRZ0PI</span><br>
	<span class="bg-light">사진 출처: https://pixabay.com</span>
</footer>
</body>
</html>