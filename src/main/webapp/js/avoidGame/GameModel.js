/**
 * Avoid Game과 관련된 로직을 해당 js에서 처리합니다.
 */

 class Game {
	
	constructor(line=1, column=1, cycle=0, ch="A") {
		this.line = line; //위치 기록을 위해 line, column 설정
		this.column = column;
		this.ch = ch;
		this.isStart = false;
		this.cycle=cycle;
	}
	
	//각 block들의 index를 파악하기 위해 만든 메소드
	setBlockNumber(number) {
		this.blockNumber = number;
	}
	
	//block의 column을 랜덤하게 재설정
	setRandomColumn(columnChecker) {
		columnChecker[this.column-1] = 0; //바꾸기 전 column 위치를 0으로 설정(0은 비어있다는 의미)
		do {
			this.column = parseInt(Math.random()*40+1);		
		} while(columnChecker[this.column-1] != 0); //바꾼 후의 column이 비어있을때까지 반복
		columnChecker[this.column-1] = 1; //바꾼 후의 column이 채워졌다는 의미로 1대입
	}
	
	//객체를 숨김
	hide(object) {
		object.style.display = 'none';
	}
	
	//객체를 화면에 표시
	show(object) {
		object.style.display = 'inline';
	}
	
	//block이 떨어지는 속도 설정
	setCycle(value) {
		this.cycle = value;
	}
	
	//캐릭터를 왼쪽으로 1칸 이동 후 blockMap에 바뀐 위치 저장	
	moveLeft(object, width, blockMap) {
		this.hide(object);
		blockMap[this.line-1][this.column-1] = null;
		if(this.column>1)
			this.column--;
		object.style.left = width*(this.column-1) + 'px';
		this.show(object);
		blockMap[this.line-1][this.column-1] = this;
	}
	
	//캐릭터를 오른쪽으로 1칸 이동 후 blockMap에 바뀐 위치 저장
	moveRight(object, width, blockMap) {
		this.hide(object);
		blockMap[this.line-1][this.column-1] = null;
		if(this.column<40)
			this.column++;
		object.style.left = width*(this.column-1) + 'px';
		this.show(object);
		blockMap[this.line-1][this.column-1] = this;
	}
	
	//게임이 종료되면 실행되는 메소드
	gameEnd(recordChecker) {
		
		//게임이 종료되었을 때 Start버튼과 Stop버튼 누르지 못하게 막음
		document.querySelector("#btnStart").disabled = "true";
		document.querySelector("#btnStop").disabled = "true";
		
		//게임 종료 관련 팝업 출력
		const popup = document.querySelector('.popup');
		popup.style.display = 'inline';
		
		//username, level, score, elapseTime에 랭킹 관련 기록들을 담아서 서버로 전송
		const url = '/game/avoid/record/create';
		const data = {
			userName: recordChecker.userName,
			level: recordChecker.level,
			score: recordChecker.score-1, //부딪힐 때도 점수가 1점 추가되기 때문에 -1(맵핑처리)
			elapseTime: recordChecker.elapseTime
		};
		const options = {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(data)
		};
		
		//로그인해야 정보가 서버로 전송되도록 조건 처리
		if(recordChecker.userName != "anonymousUser")
			fetch(url, options)
				.then(response => console.log(response))
				.catch(error => {
					console.log(error)
				});
	}
	
	//반복적으로 수행되면서 캐릭터와 block들을 조작하는 메소드
	run(object, timerChecker, target, width, height, blockMap, columnChecker, elapseTimeId, recordChecker, setFinalScore, finalScoreTag) {	
		
		//블록을 1칸 아래로 이동 후 바뀐 위치를 blockMap에 저장
		this.hide(object);
		this.line++;
		if(blockMap[this.line-1][this.column-1]==null){
			blockMap[this.line-2][this.column-1]=null; //원래 있던 곳을 null로 만들고, 이동 후 위치 좌표를 넣는다.
			blockMap[this.line-1][this.column-1]=this;
		} else { //캐릭터와 부딪힌 경우 게임 종료
			for(let i=0; i<timerChecker.length; i++){
				clearTimeout(timerChecker[i]);
			}
			clearInterval(elapseTimeId);
			this.gameEnd(recordChecker);
			return;
		}
		object.style.left = width*(this.column-1) + 'px';
		object.style.top = height*(this.line-1) + 'px';
		this.show(object);
		
		//블록이 20line까지 내려왔을 때의 처리
		if(this.line==20){
			//블록의 위치를 재설정 후 blockMap에 위치 저장
			blockMap[this.line-1][this.column-1]=null;
			this.line=2;
			columnChecker[this.column-1] = 0;
			do {
				this.column = parseInt(Math.random()*40+1);		
			} while(columnChecker[this.column-1] != 0); //바꾼 column 자리가 비어있을 때까지 반복
			columnChecker[this.column-1] = 1; //바꾼 column 자리를 저장
			blockMap[this.line-1][this.column-1]=this;
			
			//length는 block의 개수를 의미. 난이도에 따라 block이 떨어지는 속도 다르게 설정
			if(timerChecker.length==10)
				this.setCycle = parseInt(Math.random()*50+50);
			else if(timerChecker.length==15)
				this.setCycle = parseInt(Math.random()*45+40);
			else
				this.setCycle = parseInt(Math.random()*40+30);
			
			//점수 설정	
			setFinalScore(); //score를 1증가시키는 메소드
			finalScoreTag.innerHTML = sprintf("Score: %04d점", recordChecker.score); //화면 상에 점수 출력
		}
		
		//run 메소드 반복 수행
		timerChecker[this.blockNumber] = this.timer = setTimeout(() => {
			this.run(object, timerChecker, target, width, height, blockMap, columnChecker, elapseTimeId, recordChecker, setFinalScore, finalScoreTag)
		}, this.cycle);
	}
	
	//일시 정지 시 사용
	stop() {
		clearTimeout(this.timer);
	}
}