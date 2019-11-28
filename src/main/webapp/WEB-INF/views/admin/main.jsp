<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.admin_main_icon{
	margin-top: 3px;
    margin-right: 13px;	
}


#columnchart_material, #piechart{
float: left;
}

.admin_chart{
	margin-top: 50px;
}

</style>


<ul class="nav nav-tabs nav-justified">
    <li class="nav-item">
      <a class="nav-link active" href="<c:url value='/admin/main'/>">메인</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<c:url value='/admin/member'/>">회원정보</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<c:url value='/admin/board'/>">게시판정보</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="<c:url value='/admin/message'/>">메세지정보</a>
    </li>
</ul>

<div class="admin_chart">
<div id="piechart" style="width: 700px; height: 500px;"></div>
<div id="columnchart_material" style="width: 500px; height: 500px;"></div>
</div>

<div class="clearfix"></div>



<div class="admin_total">
	<span class="admin_total_text"><i class="fas fa-user float-left admin_main_icon"></i> 최근 가입유저 5명, 최근 가입한 사용자 수 ( 7일 ) : </span>
	<span class="admin_total_value">${memberCount }</span>
	<span class="float-right"><a href="<c:url value='/admin/member'/>">[자세히보기]</a></span>
</div>

	<table id="datatable-scroller" class="table table-bordered" style="border-collapse: collapse; border-spacing: 0; width: 100%; text-align: center; vertical-align: middle;">
		<thead class="thead-dark">
			<tr>
				<th>순번</th>
				<th>권한</th>
				<th>아이디</th>
				<th>닉네임</th>
				<th>이메일</th>
				<th>QR코드</th>
			</tr>
		</thead>

		<tbody id="admin_tbody">
			<c:forEach items="${member}" var="list">
				<tr role="row" class="odd test1" value="${list.no }">
					<td class="admin_memberNo">${list.no }</td>
					<td class="admin_memberType">${list.type }</td>
					<td class="admin_memberId">${list.id }</td>
					<td class="admin_memberNick">${list.nick }</td>
					<td class="admin_memberEmail">${list.email }</td>
					<td class="admin_memberKey">${list.key }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>



<div class="admin_total">
	<span class="admin_total_text "><i class="fas fa-clipboard-list float-left admin_main_icon"></i>최근 등록된 게시글 5개, 최근 게시글 갯수 ( 7일 ) : </span>
	<span class="admin_total_value">${boardCount }</span>
	<span class="float-right"><a href="<c:url value='/admin/board'/>">[자세히보기]</a></span>
</div>

	<table id="datatable-scroller" class="table table-bordered" style="border-collapse: collapse; border-spacing: 0; width: 100%; text-align: center; vertical-align: middle;">
		<thead class="thead-dark">
			<tr>
				<th>순번</th>
				<th>글번호</th>
				<th>분류</th>
				<th>아이디</th>
				<th>제목</th>
				<th>일자</th>
			</tr>
		</thead>
		<tbody id="admin_tbody">
		
				<c:forEach items="${alarm}" var="list">
				<tr role="row" class="odd">
					<td class="admin_boardNo">${list.no }</td>
					<td class="admin_boardANo">${list.ano }</td>
					<td class="admin_boardType">${list.type }</td>
					<td class="admin_boardId">${list.id }</td>
					<td class="admin_boardSubject">${list.subject }</td>
					<td class="admin_boardSubject">${list.ADate }</td>
				</tr>
		</c:forEach>
		</tbody>
	</table>
	
	
	<div class="admin_total">
	<span class="admin_total_text"><i class="fas fa-envelope float-left admin_main_icon"></i>최근 작성된 메세지 5개, 최근 메세지수 갯수 ( 7일 ) : </span> 
	<span class="admin_total_value">${messageCount }</span>
	<span class="float-right"><a href="<c:url value='/admin/message'/>">[자세히보기]</a></span>
</div>

	<table id="datatable-scroller" class="table table-bordered" style="border-collapse: collapse; border-spacing: 0; width: 100%; text-align: center; vertical-align: middle;">
		<thead class="thead-dark">
			<tr>
				<th>순번</th>
				<th>방번호</th>
				<th>보내는사람</th>
				<th>받는사람</th>
				<th>내용</th>
				<th>확인여부</th>
				<th>일자</th>
			</tr>
		</thead>
		<tbody id="admin_tbody">
			<c:forEach items="${message}" var="list">
				<tr role="row" class="odd">
					<td class="admin_messageNo">${list.no }</td>
					<td class="admin_messageRoomId">${list.roomId }</td>
					<td class="admin_messageId">${list.id }</td>
					<td class="admin_messageToId">${list.toId }</td>
					<td class="admin_messageContent">${list.content }</td>
					<c:choose>
						<c:when test="${list.read == 0 }">
						<td class="admin_messageRead">읽지않음</td>
						</c:when>
						<c:otherwise>
						<td class="admin_messageRead">읽음</td>
						</c:otherwise>
					</c:choose>
					<td class="admin_messageMDate">${list.MDate }</td>
				</tr>
		</c:forEach>
		</tbody>
	</table>







<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>
$('.topheader_subject_text').html('관리페이지');
    
    $(document).ready(function(){
    	memberChart();
    	boardChart();
    });
    
    function memberChart(){
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = new google.visualization.DataTable(); 
        $.ajax({
      	  type : 'post',
      	  url : '/admin/getMemberChart',
      	  dataType : 'json',
      	  async : false,
      	 success : function(callback){
      		data.addColumn('date', '날짜'); 
            data.addColumn('number', '가입자수');
            data.addColumn('number', '메세지수');
            data.addColumn('number', '방문자수');
            $.each(callback.result,function(index,item){
            	data.addRows(6);
            		data.setCell(index,0,new Date(item.tDate));
            		data.setCell(index,1,item.memberCount);
            		data.setCell(index,2,item.messageCount);
            		data.setCell(index,3,item.visitCount);
            });
      	 }
        });
        var options = {
        };
        var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    }
    
    
    
    function boardChart(){
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
          var data = new google.visualization.DataTable(); 
          $.ajax({
        	  type : 'post',
        	  url : '/admin/getBoardChart',
        	  dataType : 'json',
        	  async : false,
        	 success : function(callback){
        		 data.addColumn('string', '분류'); 
                 data.addColumn('number', '작성률%');
            	 data.addRows(4);
              	 data.setCell(0,0,'자유게시판');
      	  		 data.setCell(1,0,'오시는거죠');
      	  		 data.setCell(2,0,'정보공유');
      	  		 data.setCell(3,0,'이용후기');
         	     $.each(callback,function(key,value){
            	  	if ( key == 'freeCount' ) {
            	  		data.setCell(0,1,value);
            	  	} else if ( key == 'meetCount' ) {
            	  		data.setCell(1,1,value);
            	  	} else if ( key == 'infoCount' ) {
            	  		data.setCell(2,1,value);
            	  	} else if ( key == 'reviewCount' ) {
            	  		data.setCell(3,1,value);
            	  	}
              });
        	 }
          });
        var options = {
          title: '게시판 작성 분포'
        };
        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, options);
      }
    }
    </script>