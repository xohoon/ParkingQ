<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://xn--9o7bnhu7d.kr/android.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
</head>
<body>
    <style>
        .container {
            background-color: #5b847e;
            width: 100%;
            height: 100%;
            padding-top: 20%;
            padding-bottom:30%;
        }
        .main_btn{
        margin-left: 33%; 
        margin-bottom: 10%; 
        padding: 5% 6%; 
        border-radius: 20%; 
        width: 35%; 
        background-color: #e0e0e0;
        }
    </style>
    
    <script>
    $(document).ready(function(){
    	
    	var isAndroid = '${android}';
    	console.log('>>>>>' + isAndroid);
    	
    	if ( isAndroid == 'true' ) {
    		$('#down_btn').remove();
    		$('.container').css({
    			'padding-top' : '45%',
    			'padding-bottom' : '55%'
    		});
    	} 	
    	$('#community_btn').on('click', function(){
    		location.href='/';
    	});
    });
    </script>
    
    <div class="container">
		<div class="main_btn" id="down_btn">
		    <img src="/images/mobile/down_btn.png" width="100%">
		  <span style="margin-left: 12%; font-weight: bold;">다운로드</span>
		</div>
    <div class="main_btn" id="qr_btn">
		    <img src="/images/mobile/qr_btn.png" width="100%">
		  <span style="margin-left: 12%; font-weight: bold;">QR촬영</span>
		</div>
   <div class="main_btn" id="community_btn">
		    <img src="/images/mobile/site_btn.png" width="100%">
		  <span style="margin-left: 12%; font-weight: bold;">커뮤니티</span>
		</div>
    </div>
</body>
</html>