/**
 * RecordChecker(최종 점수 및 시간 체크)
 */

 class RecordChecker {
	 
	 constructor(userName, level) {
		 this.score = 0;
		 this.elapseTime = 0;
		 this.userName = userName;
		 this.level = level;
	 }
	 
	 //user의 이름을 저장
	 setUser(userName) {
		 this.userName = userName;
	 }
	 
	 //점수 1점 추가
	 addScore() {
		 this.score++;
		 this.resolve();
	 }
	 
	 then(resolve, reject) {
		 this.resolve = resolve;
		 this.reject = reject;
		 this.addScore();
	 }
 }