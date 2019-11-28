<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<div class="container">
	<h5>이달의 BEST11</h5>
	<table class="table table-hover">
		<tr>
			<th>best 게시글</th>
			<th>best 사진</th>
		</tr>
		<tr>
			<td></td>
			<td rowspan="5"></td>		
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td></td>
		</tr>
	
	</table>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>글쓴이</th>
				<th>조회수</th>
				<th>조회수</th>
				<th>추천</th>
				<th>날짜</th>
				
			</tr>
		</thead>
		<tbody>
		<!-- 게시글 list 뽑는 부분 -->
		
		<c:forEach items="${list }" var="board">
			<tr>
				<td>John</td>
				<td>Doe</td>
				<td>john@example.com</td>
				<td>John</td>
				<td>Doe</td>
				<td>john@example.com</td>
				<td>John</td>
			</tr>
		
		</c:forEach>
		
		</tbody>
	</table>
</div>




