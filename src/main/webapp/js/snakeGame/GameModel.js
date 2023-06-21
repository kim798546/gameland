/**
 *  Snake Game과 관련된 로직을 해당 js에서 처리합니다.
 */

 class Game {
	 constructor(line=1, column=1, direction = "right") {
		 this.line = line; //line과 column으로 객체의 위치를 저장
		 this.column = column;
		 this.direction = direction; //캐릭터의 진행 방향 설정
		 this.isStart = false; //Start 버튼과 Stop
		 this.score = 0; //점수 기록을 위함
	 }
	
	//객체를 숨김 
	hide(object) {
		object.style.display = "none";
	}
	
	//객체를 화면에 표시
	show(object) { 
		object.style.display = "inline";
	}
	
	//게임이 종료되면 실행되는 메소드, recordChecker: 최종 점수에 대한 정보를 담은 객체
	gameEnd(recordChecker) { 
		
		//게임이 종료되었을 때 Start버튼과 Stop버튼 누르지 못하게 막음
		document.querySelector("#btnStart").disabled = "true"; 
		document.querySelector("#btnStop").disabled = "true";
		
		//게임 종료 관련 팝업 출력
		const popup = document.querySelector('.popup'); 
		popup.style.display = 'inline';
		
		//username, score, level에 랭킹 관련 기록들을 담아서 서버로 전송
		let record = document.querySelector("#tail");
		let userName = record.dataset.username;
		let score = recordChecker.score;
		let level = record.dataset.level;
		const url = '/game/snake/record/create'; //데이터를 보낼 url
		const data = { //key: value 형태로 데이터 저장
			userName: userName,
			score: score,
			level: level
		};
		const options = { //json 형식으로 데이터 전송
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(data)
		};
		
		//로그인해야 정보가 서버로 전송되도록 조건 처리
		console.log(userName);
		if(userName != "anonymousUser"){ 
			fetch(url, options)
			.then(response => console.log(response))
			.catch(error => {
				console.log(error)
			});	
		}
		
	}
	
	//target이 모서리에 위치하면 true를 리턴하는 메소드
	isCorner(line, column, maxLine, maxColumn) {
		let rtn = false;
		if(line==1 		 && column==1 		  ||
		   line==1 		 && column==maxColumn ||
		   line==maxLine && column==1   	  ||
		   line==maxLine && column==maxColumn)
			rtn = true;
		return rtn;
	}
	
	//left와 top값을 주면 해당 위치의 character객체(태그)를 return
	getNewCharacterTag(left, top) { 
		let character = document.createElement("div");
		character.classList.add("character");
		character.classList.add("absolute");
		character.style.left = left; 
		character.style.top = top;
		return character;
	}
	
	//캐릭터가 어떤 방향으로 target에 접근했는가에 따라 조건처리하여 새로운 Game 객체를 return
	getNewCharacter(object) { 
		let character = new Game(object.line, object.column, object.direction);
		if(character.direction == "left") //왼쪽으로 접근 시 1칸 왼쪽에 새 블록 생성
			character.column -= 1;
		else if(character.direction == "top") //위로 접근 시 1칸 위쪽에 새 블록 생성
			character.line -= 1;
		else if(character.direction == "right") //오른쪽으로 접근 시 1칸 오른쪽에 새 블록 생성
			character.column += 1;
		else if(character.direction == "bottom") //아래쪽으로 접근 시 1칸 아래쪽에 새 블록 생성
			character.line += 1;
		return character;
	}
	
	//target의 위치를 재설정하는 메소드
	setPositionOfTarget(target, t, width, height, blockMap) {
			
			//재설정 되기 전 line과 column 기록(좌표 변경 후 blockMap에서 기존 위치 제거하기 위함)
			let previousLineOfT = t.line; 
			let previousColumnOfT = t.column;
			
			//1부터 20사이의 랜덤수로 line과 column을 재설정
			do {
				t.line=parseInt(Math.random()*20+1);
				t.column=parseInt(Math.random()*20+1);				
			} while(blockMap[t.line-1][t.column-1]!=null || this.isCorner(t.line, t.column, 20, 20)); //해당 line, column에 이미 객체가 있거나 모서리라면 다시 설정 
			blockMap[previousLineOfT-1][previousColumnOfT-1] = null; //blockMap에서 기존 위치 제거
			
			//t의 line, column 기반으로 target 태그 위치 재설정 후 위치 정보를 blockMap에 기록
			target.style.left = width*(t.column-1) + 'px';  
			target.style.top = height*(t.line-1) + 'px';
			blockMap[t.line-1][t.column-1] = t;
	}
	
	//캐릭터의 맨 앞부분(head)를 움직일 때 사용
	moveHead(objectTag, objects, target, t, width, height, blockMap) {
		blockMap[this.line-1][this.column-1] = null; //blockMap에서 기존 위치 제거
		
		//방향에 따른 조건 처리
		if(this.direction=="left"){
				this.column--;	
		} else if(this.direction=="top"){
				this.line--;
		} else if(this.direction=="right"){
				this.column++;
		} else if(this.direction=="bottom"){
				this.line++;
		}
		
		//벽에 부딪혔다면 게임 종료
		if(this.line<1 || this.column<1 || this.line>20 || this.column>20){
			console.log("err1")
			objects[objects.length-1].isStart=false;
			this.gameEnd(objects[objects.length-1]);
			return;
		}
		
		//화면상에서 기존 위치에 있는 태그 숨긴 후 새로운 위치에 출력
		this.hide(objectTag); 
		objectTag.style.left = width*(this.column-1) + "px";
		objectTag.style.top  = height*(this.line-1) + "px";
		this.show(objectTag);
		
		
		if(blockMap[this.line-1][this.column-1]!=null){
			if(blockMap[this.line-1][this.column-1]==t){ //이동한 위치가 target의 위치와 같다면 target 위치 재설정
				this.setPositionOfTarget(target, t, width, height, blockMap);
				this.isHitTarget = true; //isHitTarget이 true이면 캐릭터의 길이가 늘어나도록 run 메소드에서 처리
				
				//점수 1점 추가, 바뀐 점수를 화면에 출력
				objects[objects.length-1].score += 1; 
				let finalScoreTag = document.querySelector("#finalScoreTag");
				finalScoreTag.innerHTML = sprintf("Score: %04d점", objects[objects.length-1].score);				
			} else{ //이동한 위치가 캐릭터 자신의 위치라면 게임 종료
				console.log("err2")
				objects[objects.length-1].isStart=false;
				this.gameEnd(objects[objects.length-1]);
				return;
			}
		}
		blockMap[this.line-1][this.column-1] = this; //바뀐 위치를 blockMap에 기록
	}
	
	//캐릭터의 맨 앞부분을 제외한 블록들은 자신보다 1칸 앞에 있는 블록 위치로 이동
	moveOthers(objectTag, line, column, width, height, blockMap) { 
		this.hide(objectTag);
		blockMap[this.line-1][this.column-1] = null;
		this.line = line;
		this.column = column;
		objectTag.style.left = width*(this.column-1) + 'px';
		objectTag.style.top  = height*(this.line-1) + 'px';
		this.show(objectTag);
		blockMap[this.line-1][this.column-1] = this;
	}
	
	//캐릭터의 방향을 왼쪽으로 전환
	setDirectionLeft() {
		this.direction="left";
	}
	
	//캐릭터의 방향을 오른쪽으로 전환
	setDirectionRight() {
		this.direction="right";
	}
	
	//캐릭터의 방향을 왼쪽으로 전환
	setDirectionTop() {
		this.direction="top";
	}
	
	//캐릭터의 방향을 아래쪽으로 전환
	setDirectionBottom() {
		this.direction="bottom";
	}
	
	//반복적으로 수행되면서 캐릭터와 target을 조작하는 메소드
	run(objectTags, objects, target, t, width, height, blockMap, cycle) {
		
		//Game객체들의 line과 column을 순서대로 저장(moveOthers 메소드에 대입하기 위함)
		let previousLine = [];
		let previousColumn = [];
		for(let e of objects){
			previousLine.push(e.line);
			previousColumn.push(e.column);			
		}
		
		//objects배열의 첫 번째 객체인 head를 1칸 이동
		objects[0].moveHead(objectTags[0], objects, target, t, width, height, blockMap);
		
		//길이가 2이상이면 head가 아닌 나머지 객체들을 자신의 바로 앞의 line, column 위치로 이동
		if(objects.length > 1) 
			for(let i=1; i<objects.length; i++){
				objects[i].moveOthers(objectTags[i], previousLine[i-1], previousColumn[i-1], width, height, blockMap);	
			}
			
		//head가 target과 부딪힌 경우 처리하는 로직
		if(objects[0].isHitTarget){
			let newCharacter = objects[0].getNewCharacter(objects[0]); //새로운 character 태그 생성
			if(newCharacter.line>0 && newCharacter.line<21 && newCharacter.column>0 && newCharacter.column<21){
				let left = (newCharacter.column-1)*width + "px";
				let top  = (newCharacter.line-1)*height + "px";
				let newCharacterTag = this.getNewCharacterTag(left, top);
				objects.splice(0, 0, newCharacter); //objects 맨 앞에 새로운 객체 삽입(head가 됨)
				objectTags.splice(0, 0, newCharacterTag); //objectsTags 맨 앞에 새로운 태그 삽입
				document.querySelector("main").appendChild(newCharacterTag); //main 태그 안에 새로운 character태그 삽입
				blockMap[newCharacter.line-1][newCharacter.column-1] = newCharacter; //blockMap에 위치 저장
			} else { //새로 생성된 character가 벽에 부딪혔다면 게임 종료
				console.log("err3")
				objects[objects.length-1].isStart=false;
				this.gameEnd(objects[objects.length-1]);
			}
		}
		
		//isStart가 true일 때만 run 메소드를 반복 수행
		if(this.isStart){ 
			objects[objects.length-1].timerId = setTimeout(()=>{
				this.run(objectTags, objects, target, t, width, height, blockMap, cycle)
			}, cycle);			
		}
	}
	 
 }