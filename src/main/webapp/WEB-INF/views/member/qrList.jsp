<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>

var qr_no;
var qr_id;
var qr_key;

$(document).ready(function(){
	
	
	$.ajax({
		type : 'post',
		dataType : 'json',
		url : '/member/getQr',
		async : false,
		success : function(data){
			
			console.log('QR JSON -> ' + data);
			
			$.each(data.result, function(index,item){
				console.log(item.no + ' : ' + item.id + ' : ' + item.key);
				addQrInfo(item.no, item.id, item.key);
			});
			
		}
	});
	

});


function addQrInfo(no, id, key) {
	$('#qr_info').append(
			'<tr>'
			+'<td>' + no + '</td>'
			+'<td>' + id + '</td>'
			+'<td>' + key + '</td>'
			+'</tr>'
			);
}

</script>




  <table class="table">
    <thead>
      <tr>
        <th>NO</th>
        <th>ID</th>
        <th>KEY</th>
      </tr>
    </thead>
    <tbody id="qr_info">
    </tbody>
  </table>


