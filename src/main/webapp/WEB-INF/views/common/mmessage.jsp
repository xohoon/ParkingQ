<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
</head>
<body>
    <style>
        .container {
            background-color: #5b847e;
            width: 100%;
            height: 100%;
            padding-top: 10%;
            padding-bottom: 10%;
            position: relative;
        }
        message_img{
            z-index: 100;
        }
        .btn{
            z-index: 9999;
            position: absolute;
            left: 35%;
            top: 75%;
            width: 30%;
            height: 8%;
        }
    </style>
    
    <script>
    $(document).ready(function(){
        $('.btn').on('click',function(){
            location.href='/common/mmain';
        });
    });
    </script>

    <div class="container">
        <img class="message_img"src="/images/mobile/message.png" style="width: 100%;height: 100%">
        <button class="btn btn-danger">확인</button>
    </div>
</body>
</html>