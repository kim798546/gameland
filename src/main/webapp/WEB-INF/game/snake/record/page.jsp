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
<title>Snake Game 랭킹 페이지</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.css">
<script src=/webjars/bootstrap/js/bootstrap.js></script>
<script src=/webjars/jquery/jquery.js></script>
</head>
<body>
<div class="container">
<h1 class="bg-info text-white text-center p-3 mb-5">TOP100 랭킹</h1>
	<div class="container">	
		<div class="row">
	  		<a class="btn btn-outline-primary btn-lg col-4" href="/game/snake/record/page/1/10?level=1">Level1</a>
	  		<a class="btn btn-outline-primary btn-lg col-4" href="/game/snake/record/page/1/10?level=2">Level2</a>
			<a class="btn btn-outline-primary btn-lg col-4" href="/game/snake/record/page/1/10?level=3">Level3</a>  
		</div>
	</div>
	<table class="table table-hover text-center mt-2">
		<thead class="border bg-info text-light">
			<tr>
				<th>등수</th>
				<th>닉네임</th>
				<th>점수</th>
				<th>난이도</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="e" items="${list}" varStatus="status">
			<tr>
				<td>${status.count + (paging.pageNum-1)*10}</td>
				<td>${e.userName}</td>
				<td>${e.score}점</td>
				<td>${e.gameLevel}</td>
			</tr>		
		</c:forEach>
		</tbody>
	</table>
	<ul class="pagination justify-content-center" style="margin:20px 0">
	<c:choose>
		<c:when test="${paging.pageNum eq 1}">
			<li class="page-item disabled"><a class="page-link" href="/game/snake/record/page/1/${paging.pageSize}?level=${level}">&lt;&lt;</a></li>		
		</c:when>
		<c:otherwise>		
			<li class="page-item"><a class="page-link" href="/game/snake/record/page/1/${paging.pageSize}?level=${level}">&lt;&lt;</a></li>		
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${paging.pageNum eq 1}">
			<li class="page-item disabled"><a class="page-link" href="###">Previous</a></li>		
		</c:when>
		<c:otherwise>		
			<li class="page-item"><a class="page-link" href="/game/snake/record/page/${paging.pageNum-1}/${paging.pageSize}?level=${level}">Previous</a></li>		
		</c:otherwise>
	</c:choose>
	<c:forEach var="n" items="${paging.navigatepageNums}">
		<c:choose>
			<c:when test="${n eq paging.pageNum}">
				<li class="page-item active"><a class="page-link" href="/game/snake/record/page/${n}/${paging.pageSize}?level=${level}">${n}</a></li>		
			</c:when>
			<c:otherwise>			
				<li class="page-item"><a class="page-link" href="/game/snake/record/page/${n}/${paging.pageSize}?level=${level}">${n}</a></li>		
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:choose>	
		<c:when test="${paging.pageNum eq paging.pages}">
			<li class="page-item disabled"><a class="page-link" href="###">Next</a></li>		
		</c:when>
		<c:otherwise>		
			<li class="page-item"><a class="page-link" href="/game/snake/record/page/${paging.pageNum+1}/${paging.pageSize}?level=${level}">Next</a></li>		
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${paging.pageNum eq paging.pages}">
			<li class="page-item disabled"><a class="page-link" href="###">>></a></li>		
		</c:when>
		<c:otherwise>		
			<li class="page-item"><a class="page-link" href="/game/snake/record/page/${paging.pages}/${paging.pageSize}?level=${level}">>></a></li>		
		</c:otherwise>
	</c:choose>
	</ul>
	<a class="btn btn-secondary" href="/game/snake/setting/${level}">게임으로</a>
	<a class="btn btn-secondary" href="/">메인 화면으로</a>
</div>
</body>
</html>