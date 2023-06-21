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
<script type="text/javascript" src="/js/avoidGame/GameModel.js"></script>
<script type="text/javascript" src="/js/avoidGame/RecordChecker.js"></script>
<script type="text/javascript" src="/js/sprintf.js"></script>
<title>Welcome Avoid Game!</title>
</head>
<style>
body {
	background-image: url("/img/background-galaxy.jpg");
	background-repeat: no-repeat;
	background-size: cover;
}

main {
	border: 10px solid red;
	position: relative;
	background-color: black;
	box-sizing: content-box;
}

.btns {
	border-left: 10px solid red;
	border-right: 10px solid red;
	border-bottom: 10px solid red;
	background-color: black;
	box-sizing: content-box;	
}

.user {
	position: relative;
	border-left: 10px solid red;
	border-right: 10px solid red;
	border-top: 10px solid red;
	background-color: black;
	box-sizing: content-box;
	color: white;
}
.block, #character {
	position: absolute;
	font-family: monospace;
	font-size: 15pt;
}
#elapseTimeTag, #finalScoreTag {
	position: absolute;
	font-family: monospace;
	font-size: 15pt;
	background-color: black;
	color: white;
}

#userTag {
	position: relative;
	font-family: monospace;
	font-size: 10pt;
	color: white;
}

#btnStart, #btnStop, #btnLeft, #btnRight {
	position: relative;
}

#btnLeft, #btnRight {
	width: 100px;
}

#character {
	background-color: blue;
	color: red;
}

.countDown {
	position: absolute;
	display: none;
	background-color: black;
	color: white;
	font-size: 30pt;
}

.popup {
	position: absolute;
	top: 50%;
	left: 50%;
	transform : translate(-50%, -50%);
	color: white;
	display: none;
}


</style>
<script type="text/javascript">
let blocks = []; //블록 객체가 담길 곳
let alpha = new Game(20, 20); //20 line, 20 column
let blockMap = Array.from(Array(20), () => Array(40).fill(null)); //20X40의 2차원 배열, Game객체의 위치를 저장하기 위함
blockMap[19][19] = alpha; //alpha의 위치 저장
let timerChecker = new Array(10).fill(null); //각 block의 timerId를 저장(정지시킬 때 사용하기 위함)
let columnChecker = new Array(40).fill(0); //column의 위치가 중복되지 않게하려고 만듦
let color = ["Red","Green","Yellow","Blue","Magenta","Cyan","White"]; //block의 색 지정에 쓰임
let isStart = false;
let isStopButtonOn = false;
let elapseTimeId = 0;
let recordChecker = new RecordChecker("<sec:authentication property="name"/>", ${level});

//recordChecker에 접근하는 block들이 많기 때문에 동시에 접근하는 걸 방지
async function setFinalScore() {
	 await recordChecker;
}

window.onload = function() {
	//출력화면 설정
	let main               	  = document.querySelector("main");
	let btns			   	  = document.querySelector(".btns");
	let b                 	  = document.querySelectorAll(".block"); // block 태그들의 배열
	let width             	  = parseFloat(getComputedStyle(b[0]).width); //width로 각 블록들의 x좌표 설정
	let height            	  = parseFloat(getComputedStyle(b[0]).height); //height로 각 블록들의 y좌표 설정
	character.style.top   	  = 19*height+"px";
	character.style.left  	  = 19*width+"px";
	main.style.height     	  = 20*height+"px";
	main.style.width      	  = 40*width+"px";
	main.style.padding	  	  = "0px";
	btns.style.width	  	  = 40*width+"px";
	btns.style.padding	  	  = "0px";
	elapseTimeTag.style.top   = "0px";
	elapseTimeTag.style.right = "0px";
	finalScoreTag.style.top   = height+"px";
	finalScoreTag.style.right = "0px";
	
	//user관련 출력화면 설정
	let user = document.querySelector(".user"); 
	if(user != null){
		user.style.width      = 40*width+"px";
		user.style.padding	  = "0px";		
	}
	
	//countDown관련 출력화면 설정
	let countDown = document.querySelectorAll(".countDown");
	for(c of countDown){
		c.style.top  = 8*height+"px";
		c.style.left = 20*width+"px";		
	}
	
	//Start버튼을 눌렀을 때의 처리
	btnStart.onclick = function(e) {	
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
		
		
		//gameStart()를 실행하며 게임시작 시켜주는 함수
		let elapseTime = recordChecker.elapseTime
		let getElapseTime = function() {
			countDown[0].style.display = 'none';
			elapseTimeId = setInterval(()=>{
				elapseTimeTag.innerHTML = sprintf("Time: %04d초", ++recordChecker.elapseTime);
			}, 1000);
			gameStart();
		}
		
		let gameStart = function() {
			isStopButtonOn = false;
			//blocks에 모든 블록들이 들어감
			if(isStart==false){ //게임이 시작하지 않은 경우에만 설정
				isStart=true;
				for(let i=0; i<b.length; i++) {
					//각 블록의 색 설정(검은색은 안보여서 제외)
					let randomColor = color[parseInt(Math.random()*7)];
					b[i].style.backgroundColor = randomColor;
					b[i].style.color = randomColor;
					
					let line   = 1;//블록의 초기 line은 1
					
					//블록의 column은 random. 이미 자리가 있다면 columncheck[column-1]이 1이다. 비어있어야 들어갈 수 있음
					let column = 0;
					do {
						column = parseInt(Math.random()*40+1);		
					} while(columnChecker[column-1] != 0);
					columnChecker[column-1] = 1;
					
					//블록이 떨어지는 속도 조절
					let cycle  = 0;
					if(b.length==10)
						cycle = parseInt(Math.random()*50+50);
					else if(b.length==15)
						cycle = parseInt(Math.random()*45+40);
					else
						cycle = parseInt(Math.random()*40+30);
					
					let block = new Game(line,column,cycle);//셋팅한 값으로 block 생성
					
					block.setBlockNumber(i);//block에 번호를 부여, timerChecker에 timerId를 넣을 때 blockNumber를 기반으로 함. 
					blocks.push(block);//순서대로 blocks배열에 넣음
					blockMap[line-1][column-1]=block;//각 block의 위치를 blockMap 배열에 저장
				}			
			} 
			//블록들을 가동 시킴, 
			for(let i=0; i<blocks.length; i++){
				blocks[i].run(b[i], timerChecker, alpha, width, height, blockMap, columnChecker, elapseTimeId, recordChecker, setFinalScore, finalScoreTag);
				timerChecker.push(blocks[i].timer);
			}
		}
		
		//게임 시작
		setTimeout(getElapseTime, 4000);
			
		
	};
	
	//Stop 버튼을 누르면 모든 블록 정지
	btnStop.onclick = function(e) {
		isStopButtonOn = true;
		for(let i=0; i<blocks.length; i++){
			blocks[i].stop();			
		}
		clearInterval(elapseTimeId);
	};
	
	//왼쪽 화살표 누르면 캐릭터 1칸 왼쪽으로 이동
	btnLeft.onmousedown = function(e) {
		if(isStopButtonOn == false)
			alpha.moveLeft(character, width, blockMap);
	};
	
	//오른쪽 화살표 누르면 캐릭터 1칸 오른쪽으로 이동
	btnRight.onmousedown = function(e) {
		if(isStopButtonOn == false)
			alpha.moveRight(character, width, blockMap);
	};
	
	//키보드로 캐릭터 조작
	document.onkeydown = function(e) {
		if(isStopButtonOn == false){
			if(e.key=="ArrowLeft")
				alpha.moveLeft(character, width, blockMap);
			else if(e.key=="ArrowRight")
				alpha.moveRight(character, width, blockMap);			
		}
	}
}
</script>
<body>
<audio src="/audio/happyrock.mp3" autoplay="autoplay" loop="loop"></audio>
<sec:authorize access="isAuthenticated()">
<div class="container user">
	<div id="userTag"><sec:authentication property="name"/>님 환영합니다.</div>
</div>
</sec:authorize>
<main class="container">
	<span id="elapseTimeTag">Time: 0000초</span>
	<span id="finalScoreTag">Score: 0000점</span>
	<c:forEach begin="1" end="${numOfBlocks}">
		<span class='block'>A</span>
	</c:forEach>
	<span id="character">A</span>
	<span class="countDown">1</span>
	<span class="countDown">2</span>
	<span class="countDown">3</span>
	<div class="container popup">
		<div class="row">
			<div class="col-8 offset-2 border border-1 border-secondary rounded-3 bg-light">
				<div class="row"><div class="col-12 text-weight-bold text-secondary text-center p-2 fs-3 ">Game Over</div></div>
				<div class="row">
					<a class="col-5 btn btn-primary" href="/game/avoid/setting/${level}">다시하기</a>
					<a class="col-4 btn btn-danger" href="/">종료</a>
					<a class="col-3 btn btn-success" href="/game/avoid/record/page/1/10?level=${level}">랭킹</a>
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
	<div class="row justify-content-center">
		<img id="btnLeft"  class="col-6"  alt="xxx" src="/img/leftArrow.png">
		<img id="btnRight" class="col-6" alt="xxx" src="/img/rightArrow.png">
	</div>
	<div class="row">
		<span class="col-4 text-light ms-1">현재 난이도: level${level}</span>
		<a href="/game/avoid/setting" class="col-3 offset-4 mb-1  btn btn-secondary">난이도<br>재 설정</a>	
	</div>
</div>
<footer>
<span class="bg-light">음원 출처: https://www.bensound.com/free-music-for-videos. License code: AP9BGCBZBMNR3UNK</span><br>
<span class="bg-light">사진 출처: https://pixabay.com</span>
</footer>

</body>
</html>