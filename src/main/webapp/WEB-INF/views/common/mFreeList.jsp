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
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
</head>

<body>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <style>
        td {
	margin: 100%;
}

#profile_td {
	vertical-align: middle;
}

.container {
	background-color: white;
	width: 100%;
	height: auto;
}

.table table-hover {
	display: inline;
}

table td img {
	width: 60%;
	height: 10%;
}

td span {
	display: inline-block;
}

td div {
	width: 20%;
}
</style>

    <div class="container">

        <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top" style="z-index: 9999;">
            <a class="navbar-brand" href="/common/mmain?android=true">파킹큐</a>
            <ul class="navbar-nav">
                <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown"> 게시판 </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="/freeboard/mlist">자유게시판</a> <a class="dropdown-item" href="/meetboard/mMeetList">오시는거죠</a> <a class="dropdown-item" href="/reviewboard/mlist">이용후기</a>
                    </div>
                </li>
            </ul>

        </nav>

        <div class="container-fluid" style="margin-top: 70px; position: relative">

            <div class="layout-title" style="padding: 10px 10px 30px 10px;">
                <i class="far fa-comment-dots" style="font-size: 2rem;"></i> <span style="font-size: 1.4rem; position: absolute; margin-left: 5%;">자유게시판</span>
            </div>

            <div class="layout-content">
                <div style="height: auto;">

                    <!-- 예제 -->
                    <table width="100%" class="table table-hover">
                        <tbody>
                            <!-- 게시글 list 뽑는 부분 -->

                            <c:forEach items="${list}" var="fboard">
                                <tr class='move' href='<c:out value="${fboard.no }"/>'>
                                    <td id="profile_td" style="text-align: center">
                                        <div id="profile_div">
                                            <img id="porfile" style="width: 70px;" src="/local_img/profile/<c:out value="${fboard.profile}"/>">
                                        </div>
                                    </td>
                                    <td style="text-align: left">
                                        <c:out value="${fboard.title}" /> <br>
                                        <c:out value="${fboard.id }" />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div style="width: 100%; display: flex; justify-content: center; margin-top: 20px;">
                    <!-- 페이징 START / 글 view 일 경우에는 페이징 요소 제거 -->
                    <ul class="pagination">
                        <c:if test="${pageMaker.prev}">
                            <li class="page-item"><a class="page-link" href="${pageMaker.startPage -1}">Previous</a></li>
                        </c:if>

                        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                            <li class="page-item ${pageMaker.cri.pageNum == num ? " active":""} ">
								<a class=" page-link" href="${num}">${num}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${pageMaker.next}">
                            <li class="page-item"><a class="page-link" href="${pageMaker.endPage + 1 }">Next</a></li>
                        </c:if>
                    </ul>
                    <!-- 페이징 END -->
                </div>

            </div>
        </div>
    </div>

    <form id='actionForm' action="/freeboard/mlist" method='get'>
        <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
        <input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
        <input type='hidden' name='type' value='<c:out value="${ pageMaker.cri.type }"/>'> <input type='hidden' name='keyword' value='<c:out value="${ pageMaker.cri.keyword }"/>'>
    </form>

    <script type="text/javascript">
        var actionForm = $("#actionForm");

        $(".page-item a").on("click", function(e) {
            e.preventDefault();
            console.log('click');
            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });

        $(".move").on(
            "click",
            function(e) {
                e.preventDefault();
                actionForm.append("<input type='hidden' name='no' value='" +
                    $(this).attr("href") + "'>");
                actionForm.attr("action", "/freeboard/mGet");
                actionForm.submit();
            });

    </script>
</body>

</html>
