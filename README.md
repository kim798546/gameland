# Game Land 프로젝트
사용자가 직접 플레이 가능한 게임 홈페이지 입니다.

## 프로젝트 소개
블록 피하기 게임과 스네이크 게임을 플레이 하실 수 있습니다!<br>
회원가입 및 로그인을 하면 게임 기록이 랭킹에 기록됩니다.

## 개발환경
- `Java(jdk17)`
- `IDE: Eclipse(2022-12)`
- `Framework: Spring Boot(3.1.0)`
- `Database: Oracle 21c XE`
- `ORM: Mybatis`
<br>

## 개발환경 부가설명
- Eclipse Plug in: STS(Spring Tool Suite), Tern, Node.js
- 웹페이지 구현 시 사용 언어: java, html5, css3, javascript(ECMAscript6)
- 주요 라이브러리 및 프레임 워크<br>
Spring Framework<br>
Mybatis Framework<br>
Spring Security(보안 관련 처리)<br>
BCryptPasswordEncoder(패스워드 암호화)<br>
Spring Web(Tomcat)<br>
Lombok(getter, setter를 비롯한 주요 메소드 생성 자동화)<br>
Validation(사용자 입력 데이터 검증)<br>
Page Helper(많은 데이터를 페이지화)<br>
JSP(View 역할)
- Oracle:<br>
Scott유저에 계정 정보를 담은 Users 테이블과 랭킹 정보를 담은 Record, Record2 테이블 생성
<br>

## 주요 기능
### 1. 계정 관련<br>
- 메인 화면: 웹 브라우저에서 실행 시 보이는 맨 처음 화면<br>
(관련 설정: SecurityConfig.java, View: home.jsp)<br>
- 로그인 화면: View-> login.jsp, Controller-> UserLoginController.java<br>
- 회원 가입: View-> create.jsp, Controller-> UserCreateController.java<br>
- 아이디 찾기: View-> id.jsp, Controller-> UserFindController.java<br>
- 비밀번호 찾기: View-> pw.jsp, Controller-> UserFindController.java<br>
- 아이디 찾기, 비밀번호 찾기 결과:<br>
View->result.jsp, Controller-> UserFindResultController.java<br>
- 회원정보 수정: View-> update.jsp, Controller-> UserUpdateController<br>
- 회원 가입, 회원정보 수정 완료:<br>
### 2. 게임 관련
View-> success.jsp, Controller-> UserSuccesController.java<br>
- 게임 메인 페이지: 게임 별로 난이도 설정 및 게임 설명<br> 
**블록피하기 게임**<br>
View-> /WEB-INF/game/avoid/setting.jsp, Controller->AvoidGameController.java<br>
**스네이크 게임**<br>
View-> /WEB-INF/game/snake/setting.jsp, Controller-> SnakeGameController.java<br>
- 게임 플레이 페이지: 실제 게임을 플레이 할 수 있습니다.<br>
로그인 되어 있다면 AJAX로 Controller에 결과 데이터를 전송합니다.<br>
(fetch 사용)<br>
**블록피하기 게임** View-> /WEB-INF/game/avoid/game.jsp,<br>
Controller->com.example.imple.game.avoid.controller.RecordCreateController.java<br>
**스네이크 게임** View-> /WEB-INF/game/snake/game.jsp,<br>
Controller->com.example.imple.game.snake.controller.RecordCreateController.java<br>
- 랭킹 페이지: 사용자의 기록을 확인할 수 있습니다.<br>
**블록피하기 게임** View-> /WEB-INF/game/avoid/record/page.jsp,<br>
Controller: com.example.imple.game.avoid.controller.RecordPageController.java<br>
**스네이크 게임** View-> /WEB-INF/game/avoid/snake/page.jsp,<br>
Controller: com.example.impler.game.snake.controller.RecordPageController.java<br>

## 테스트 방법
1. src/main/resources/sql에서 Record.sql, Users.sql을 실행하여<br>
테이블을 생성합니다.
2. Boot Dashboard에서 Tomcat 서버를 실행합니다.
3. 웹 브라우저에서 기능을 확인합니다.
