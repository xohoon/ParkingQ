<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>Parking Q</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
<link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i" rel="stylesheet">


<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">

<!-- Custom scripts for this template -->
<script src="/resources/js/resume.min.js"></script>
<!-- SocketJS CDN -->
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>

<!-- Plugin JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="/resources/css/main.css" rel="stylesheet">


<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
 <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
 <![endif]-->

</head>

<body>

	<div class="nav">
		<div class='logo'></div>
		<ul class="menu">
			<li class="btMenu"><a href="javascript:void(0)">MENU</a></li>
			<li class="menuItem"><a href="#">메인</a></li>
			<li class="menuItem"><a href="/freeboard/list">자유게시판</a></li>
			<li class="menuItem"><a href="/meetboard/list">오시는거죠</a></li>
			<li class="menuItem"><a href="/infoboard/list?pageNum=1">정보공유</a></li>
			<li class="menuItem"><a href="/reviewboard/list">이용후기</a></li>
			<c:choose>
				<c:when test="${id eq 'test'}">
					<li class="menuItem"><a href="/admin/main">관리</a></li>
				</c:when>
			</c:choose>
			<li class="menuItem logout"><a href="#">로그아웃</a></li>
		</ul>
	</div>

	<!-- WRAPPER STARTS HERE-->
	<div class='wrapper'>

		<header>
			<!-- HEADER STARTS HERE-->

			<div class='container titles yomer-text-center'>
				<h1 id="header-text" data-scroll-reveal="wait 0.25s, then enter top and move 40px over 1s">
					주차된 차량의 주인분께 콕!
				</h1>
				<div class='subhead'>
					<p>주차된 차량의 전화번호를 입력하지 마시고  버튼 하나 눌러보세요</p>
					
				</div>
			</div>


		</header>
		<!-- /HEADER ENDS HERE-->
		<!-- ABOUT US STARTS HERE-->
		<section class='aboutus' id='about' style="padding-top: 3%;">
			<div class="container_div" style="margin:0px auto; width:97%">
			<div class='containerA'>
				<div class="row">
					<div class="col-md-12 yomer-text-center">
						<h2 class="main1">이런 기능들을 즐겨보세요</h2>
						<p class="bigtext">버튼 하나로 주차된 차량의 주인분께 연락을 드리는 파킹 큐는 여러분의 수고를 덜어 드리고자 만들어 졌습니다. 앱에서는 파킹큐의 편리함을 느끼시고 PC상에서는 자유로운 커뮤니티를 즐기세요!</p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-3 yomer-text-center">
						<a class="icon-widget icon-share adefault" href="#" data-scroll-reveal="wait 0.25s, then enter top and move 70px over 1s" style="cursor:pointer">Share</a>
						<h3>모임신청</h3>
						<small></small>
						<p>파킹 큐의 pc용 홈페이지에서는 앱과는 별도로 모임 게시판을 운영하고 있어요. 세차 모임, 여행 모임, 캠핑 모임 등 자동차를 이용한 갖가지의 모임들을 자유롭게 만들고 즐기시길 바랍니다. </p>
						<!-- <p>
							<a class="link-more" href="#"></a>
						</p> -->
					</div>
					<div class="col-md-3 yomer-text-center">
						<a class="icon-widget icon-follow adefault" href="#" data-scroll-reveal="wait 0.25s, then enter top and move 70px over 1s" style="cursor:pointer">Follow</a>
						<h3>친구</h3>
						<small></small>
						<p>파킹 큐의 pc용 홈페이지에서는 앱과 함께 친구 기능을 제공하고 있습니다. 커뮤니티 공간에서 만난 사람들과 자유롭게 친구를 맺어 보세요!</p>
						<!-- <p>
							<a class="link-more" href="#">Learn More</a>
						</p> -->
					</div>
					<div class="col-md-3 yomer-text-center">
						<a class="icon-widget icon-market adefault" href="#" data-scroll-reveal="wait 0.25s, then enter top and move 70px over 1s" style="cursor:pointer">Market</a>
						<h3>메신저</h3>
						<small></small>
						<p>파킹 큐는 pc용 홈페이지에서는 앱과 함께 메신저 기능을 제공하고 있습니다. 모임과 친구, 각종 커뮤니티 공간에서 자유롭게 메신저 기능을 이용해서 상대방과 소통해보세요!</p>
						<!-- <p>
							<a class="link-more" href="#">Learn More</a>
						</p> -->
					</div>
					<div class="col-md-3 yomer-text-center">
						<a class="icon-widget icon-recommend adefault" href="#" data-scroll-reveal="wait 0.25s, then enter top and move 70px over 1s" style="cursor:pointer">Recommend</a>
						<h3>피드백</h3>
						<small></small>
						<p>파킹 큐의 pc용 홈페이지에서는 앱과 함께 리뷰기능을 제공하고 있습니다. 단 한 번이라도 파킹 큐를 이용해서 알림을 보낸 적이 있으시다면 지금 바로 후기를 작성해 보세요!</p>
						<!-- <p>
							<a class="link-more" href="#">Learn More</a>
						</p> -->
					</div>
				</div>

			</div>
			
						<div class='containerB'>
							<div class="row">
								<div class="col-md-12 yomer-text-center">
									<h2 class="main1">파킹큐의 근황이에요</h2>
									<p class="bigtext2 bigtext">'콕'하고 누르면 '훅'하고 오는 파킹큐의 근황이에요. 사용해주신 여러분들이 있기에 저희가 있습니다. 정말 감사합니다.ㅠㅠ (꾸벅) 항상 더 나은 서비스를 고객님들께 제공하기 위해 최선을 다하도록 하겠습니다.</p>
								</div>
							</div>
							<div class="row adminRow">
								<div class="col-md-3 yomer-text-center joinAdmin">
									<h6>최근 가입유저(7일)</h6>
									<table id="datatable-scroller" class="table table-bordered"
										style="border-collapse: collapse; border-spacing: 0; width: 100%; text-align: center; vertical-align: middle;">
										<thead class="table-primary">
											<tr>
												<th style="background-color: #e3e3fc;">닉네임</th>
											</tr>
										</thead>

										<tbody id="admin_tbody">
											<c:forEach items="${member}" var="list">
												<tr role="row" class="odd test1" value="${list.no }">
													<td class="admin_memberNick">${list.nick }님</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>



									<!-- <p>
							<a class="link-more" href="#"></a>
						</p> -->
								</div>
								<div class="col-md-3 yomer-text-center joinAdmin">
									<h6>최근 등록된 게시글(7일)</h6>
									<table id="datatable-scroller" class="table table-bordered"
										style="border-collapse: collapse;padding-bottom: 10%; border-spacing: 0; width: 100%; text-align: center; vertical-align: middle;">
										<thead class="table-primary">
											<tr>
												<th>제목</th>
											</tr>
										</thead>

										<tbody id="admin_tbody">
											<c:forEach items="${alarm}" var="list">
												<tr role="row" class="odd test1" value="${list.no }">
													<td class="admin_memberNick">${list.subject }</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="col-md-3 yomer-text-center joinAdmin">
									<h6>최근 송신 메세지(7일)</h6>
									<table id="datatable-scroller" class="table table-bordered"
										style="border-collapse: collapse; border-spacing: 0; width: 100%; text-align: center; vertical-align: middle;">
										<thead class="table-primary">
											<tr>
												<th style="background-color: #e3e3fc;">보내는사람</th>
											</tr>
										</thead>

										<tbody id="admin_tbody">
											<c:forEach items="${message}" var="list">
												<tr role="row" class="odd test1" value="${list.no }">
													<td class="admin_memberNick">${list.id }님의메세지</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="col-md-3 yomer-text-center joinAdmin">
									<h6>자유게시판 베스트5</h6>
									<table id="datatable-scroller" class="table table-bordered"
										style="border-collapse: collapse; border-spacing: 0; width: 100%; text-align: center; vertical-align: middle;">
										<thead class="table-primary">
											<tr>
												<th>제목</th>
											</tr>
										</thead>

										<tbody id="admin_tbody">
											<c:forEach items="${best}" var="list">
												<tr role="row" class="odd test1" value="${list.no }">
													<td class="admin_memberNick">${list.title }</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>

						</div>

			</div>
		</section>
		<section class="whychose " id='whychose'>
			<div class="container">
				<div class="row">
					<div class="col-md-12 yomer-text-center">
						<div class="col-md-12 yomer-text-center">
							<h3>"이게.. 사실 이런 기분을 느끼면 안 되는데 몇 번 앱을 이용하다보니 배달음식이 온다는 생각으로 버튼을 누르게 되더라구요. 콕하고 누르면 훅하고 오니까!"</h3>
							<small>동준이 머리점 님의 후기</small>
						</div>
					</div>
				</div>
			</div>
		</section>



		<!-- FOOTER STARTS HERE-->
		<section class="testimonial " id='testimonial'>
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="gap"></div>
						<div class="row">
							<div class="col-md-6" style="margin:0 auto;">
								<blockquote>
									<p style="text-align:center; color:#777">개인정보처리방침</p>
									<p style="text-align:center; color:#777">이용약관</p>
									<p style="text-align:center; color:#777">위치기반서비스이용약관</p>
									<p style="text-align:center; color:#777">운영정책</p>
								</blockquote>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!--/ FOOTER ENDS HERE-->

		
	</div>



		<!-- Sweetalert  -->
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

		<!-- Common JS -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

		<!-- Login JS-->
		<script src="/resources/js/index.js"></script>
		<script src="/resources/js/scrollReveal.js"></script>
		
		<!-- Main JS  -->
		<script type="text/javascript" src="/resources/js/main/main.js" charset="utf-8"></script>
		<script type='text/javascript'>
			jQuery(document)
					.ready(
							function() {
								
								//모임게시판
								$('.icon-share').on('click',function(){
									location.href="/meetboard/list";
								});
								//리뷰게시판
								$('.icon-recommend').on('click',function(){
									location.href="/reviewboard/list";
								});
								
								//로그아웃
								$('.logout').on('click', function(){
									
									swal({
										  title: "로그아웃",
										  text: "로그아웃 하시겠습니까?",
										  icon: "warning",
										  buttons: ["취소", "로그아웃"],
										  dangerMode: true,
										})
										.then((willDelete) => {
										  if (willDelete) {
										    logoutUser();
										  } else {
										    swal("로그아웃이 취소 되었습니다.", {
										    	icon: "error",
										    	button : "확인"
										    });
										  }
										});
								});
								function logoutUser(){
									$.ajax({
										type : 'post',
										url : '/member/deleteSession',
										async : false ,
										success : function(data){
											console.log(data);
											location.href = '/common/login';
										}
									});
								}
								
								/* setInterval(function() {
									setTimeout(function() {
										$("#header-text").css("color",
												"#ffffff94");
										console.log('gray');
									}, 1000);
									setTimeout(
											function() {
												$("#header-text").css("color",
														"white");
												console.log('white');
											}, 1500);
								}, 3000); */

								$(".top").click(function() {
									$("html, body").animate({
										scrollTop : 0
									}, "slow");
									return false;
								});
								$(".btMenu")
										.click(
												function() {

													if ($(".menu").children(
															".menuItem").css(
															"display") == "none") {
														$(".menu").children(
																".menuItem")
																.slideDown();
													} else {
														$(".menu").children(
																".menuItem")
																.slideUp();
													}
												});
								$(window)
										.resize(
												function() {
													if ($(window).innerWidth() > 900) {
														$(".menu")
																.children(
																		".menuItem")
																.css("display",
																		"block");
													} else {
														$(".menu").children(
																".menuItem")
																.css("display",
																		"none");
													}
												});

								(function(k) {
									'use strict';
									k(
											[ 'jquery' ],
											function($) {
												var j = $.scrollTo = function(
														a, b, c) {
													return $(window).scrollTo(
															a, b, c)
												};
												j.defaults = {
													axis : 'xy',
													duration : parseFloat($.fn.jquery) >= 1.3 ? 0
															: 1,
													limit : !0
												};
												j.window = function(a) {
													return $(window)
															._scrollable()
												};
												$.fn._scrollable = function() {
													return this
															.map(function() {
																var a = this, isWin = !a.nodeName
																		|| $
																				.inArray(
																						a.nodeName
																								.toLowerCase(),
																						[
																								'iframe',
																								'#document',
																								'html',
																								'body' ]) != -1;
																if (!isWin)
																	return a;
																var b = (a.contentWindow || a).document
																		|| a.ownerDocument
																		|| a;
																return /webkit/i
																		.test(navigator.userAgent)
																		|| b.compatMode == 'BackCompat' ? b.body
																		: b.documentElement
															})
												};
												$.fn.scrollTo = function(f, g,
														h) {
													if (typeof g == 'object') {
														h = g;
														g = 0
													}
													if (typeof h == 'function')
														h = {
															onAfter : h
														};
													if (f == 'max')
														f = 9e9;
													h = $.extend({},
															j.defaults, h);
													g = g || h.duration;
													h.queue = h.queue
															&& h.axis.length > 1;
													if (h.queue)
														g /= 2;
													h.offset = both(h.offset);
													h.over = both(h.over);
													return this
															._scrollable()
															.each(
																	function() {
																		if (f == null)
																			return;
																		var d = this, $elem = $(d), targ = f, toff, attr = {}, win = $elem
																				.is('html,body');
																		switch (typeof targ) {
																		case 'number':
																		case 'string':
																			if (/^([+-]=?)?\d+(\.\d+)?(px|%)?$/
																					.test(targ)) {
																				targ = both(targ);
																				break;
																			}
																			targ = win ? $(targ)
																					: $(
																							targ,
																							this);
																			if (!targ.length)
																				return;
																		case 'object':
																			if (targ.is
																					|| targ.style)
																				toff = (targ = $(targ))
																						.offset()
																		}
																		var e = $
																				.isFunction(h.offset)
																				&& h
																						.offset(
																								d,
																								targ)
																				|| h.offset;
																		$
																				.each(
																						h.axis
																								.split(''),
																						function(
																								i,
																								a) {
																							var b = a == 'x' ? 'Left'
																									: 'Top', pos = b
																									.toLowerCase(), key = 'scroll'
																									+ b, old = d[key], max = j
																									.max(
																											d,
																											a);
																							if (toff) {
																								attr[key] = toff[pos]
																										+ (win ? 0
																												: old
																														- $elem
																																.offset()[pos]);
																								if (h.margin) {
																									attr[key] -= parseInt(targ
																											.css('margin'
																													+ b)) || 0;
																									attr[key] -= parseInt(targ
																											.css('border'
																													+ b
																													+ 'Width')) || 0
																								}
																								attr[key] += e[pos] || 0;
																								if (h.over[pos])
																									attr[key] += targ[a == 'x' ? 'width'
																											: 'height']
																											()
																											* h.over[pos]
																							} else {
																								var c = targ[pos];
																								attr[key] = c.slice
																										&& c
																												.slice(-1) == '%' ? parseFloat(c)
																										/ 100
																										* max
																										: c
																							}
																							if (h.limit
																									&& /^\d+$/
																											.test(attr[key]))
																								attr[key] = attr[key] <= 0 ? 0
																										: Math
																												.min(
																														attr[key],
																														max);
																							if (!i
																									&& h.queue) {
																								if (old != attr[key])
																									animate(h.onAfterFirst);
																								delete attr[key]
																							}
																						});
																		animate(h.onAfter);

																		function animate(
																				a) {
																			$elem
																					.animate(
																							attr,
																							g,
																							h.easing,
																							a
																									&& function() {
																										a
																												.call(
																														this,
																														targ,
																														h)
																									})
																		}
																	}).end()
												};
												j.max = function(a, b) {
													var c = b == 'x' ? 'Width'
															: 'Height', scroll = 'scroll'
															+ c;
													if (!$(a).is('html,body'))
														return a[scroll]
																- $(a)[c
																		.toLowerCase()]
																		();
													var d = 'client' + c, html = a.ownerDocument.documentElement, body = a.ownerDocument.body;
													return Math.max(
															html[scroll],
															body[scroll])
															- Math.min(html[d],
																	body[d])
												};

												function both(a) {
													return $.isFunction(a)
															|| typeof a == 'object' ? a
															: {
																top : a,
																left : a
															}
												}
												return j
											})
								}
										(typeof define === 'function'
												&& define.amd ? define
												: function(a, b) {
													if (typeof module !== 'undefined'
															&& module.exports) {
														module.exports = b(require('jquery'))
													} else {
														b(jQuery)
													}
												}));

								$(".menu").children("li:nth-child(3)").click(
										function() {
											$("body").scrollTo("#about", 600);

										});

								$(".menu").children("li:nth-child(4)")
										.click(
												function() {
													$("body").scrollTo(
															"#mission", 600);
												});

								$(".menu").children("li:nth-child(5)").click(
										function() {

											$("body").scrollTo("#whyus", 600);
										});

								$(".menu").children("li:nth-child(6)")
										.click(
												function() {
													$("body").scrollTo(
															"#whychose", 600);
												});

							});

			(function($) {
				window.scrollReveal = new scrollReveal();
			})();
		</script>
</body>

</html>
