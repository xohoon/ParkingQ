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
            background-color: white;
            width: 100%;
            height: auto;
        }
    </style>

    <div class="container">


        <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top" style="z-index: 9999;">
            <a class="navbar-brand" href="#">파킹큐</a>
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                        게시판
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="/freeboard/mlist">자유게시판</a>
                        <a class="dropdown-item" href="/meetboard/mlist">오시는거죠</a>
                        <a class="dropdown-item" href="/infoboard/mlist">정보공유</a>
                        <a class="dropdown-item" href="/reviewboard/mlist">이용후기</a>
                    </div>
                </li>
            </ul>
        </nav>

        <div class="container-fluid" style="margin-top:70px; position: relative">

            <div class="layout-title" style="padding: 10px 10px 30px 10px;">
                <i class="far fa-comment-dots" style="font-size: 2rem;"></i>
                <span style="font-size: 1.4rem; position: absolute; margin-left: 5%;">자유게시판</span>
            </div>


            <div class="layout-content">
                <div style="border: 1px solid blue; height: auto;">
                
                
                
                <!-- 예제 -->
                <div style="border: 1px solid red; margin-bottom: 5%">
            	 작성코드1
                </div>
                <div style="border: 1px solid red; margin-bottom: 5%">
          	      작성코드2
                </div>
                <div style="border: 1px solid red; margin-bottom: 5%">
          	      작성코드3
                </div>
                <div style="border: 1px solid red; margin-bottom: 5%">
           	     작성코드4
                </div>
                

                </div>
                
                
                <!-- 페이징 START / 글 view 일 경우에는 페이징 요소 제거 -->
                <ul class="pagination" style="text-align: center; margin: 13%;">
                    <li class="page-item"><a class="page-link" href="#">이전</a></li>
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item active"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item"><a class="page-link" href="#">다음</a></li>
                </ul>
                <!-- 페이징 END -->
                
            </div>
        </div>
    </div>
</body>
</html>