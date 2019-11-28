$(document).ready(function(){

            // Email Type Check
            var exp = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

            // Member Info Input Check
            var idCheck = false;
            var passCheck = false;
            var nickCheck = false;
            var emailCheck = false;

            // Animation Process
            var animating = false,
                submitPhase1 = 1100,
                submitPhase2 = 400,
                logoutPhase1 = 800,
                $login = $(".login"),
                $app = $(".app"),
                $join = $(".join");
            	$choose = $(".choose");

            // progressbar hide
            $("#progressBar").hide();
            $("#progress-text").hide();

            function ripple(elem, e) {
                $(".ripple").remove();
                var elTop = elem.offset().top,
                    elLeft = elem.offset().left,
                    x = e.pageX -
                    elLeft,
                    y = e.pageY - elTop;
                var $ripple = $("<div class='ripple'></div>");
                $ripple.css({
                    top: y,
                    left: x
                });
                elem.append($ripple);
            };
            
            
        	/************************* Alert Message *************************/
        	
        	function autoClosingAlert(selector, message ,delay) {
                var alert = $(selector).alert();
                $(selector).html('<strong>'+message+'</strong>');
                alert.show();
                window.setTimeout(function () {
                    alert.hide()
                }, delay);
            }
        	
        	
        	 var unReadCountRepeat;

            
            
            // Login Process
            $('.login__submit').click(function (e) {
                        var id = $('#id').val();
                        var pass = $('#pass').val();
                        var checkPoint = false;

                        $.ajax({
                                type: "post",
                                url: "/member/login",
                                data: {
                                    id: id,
                                    pass: pass
                                },
                                async: false,
                                success: function (data) {
                                    if (data == 1) {
                                        console.log(data);
                                        checkPoint = true;
                                        console
                                            .log('[1] ajax Login checkPoint : ' +
                                                checkPoint +
                                                " , data : " +
                                                data);
                                        autoClosingAlert(
                                            '#successMessage',
                                            '로그인 되었습니다.',
                                            2000);
                                    } else if (data == 0) {
                                        console
                                            .log('[1] ajax Login checkPoint : ' +
                                                checkPoint +
                                                " , data : " +
                                                data);
                                        autoClosingAlert(
                                            '#dangerMessage',
                                            '비밀번호를 다시 확인 해주세요.',
                                            2000);
                                    } else if (data == -1) {
                                        console
                                            .log('[1] ajax Login checkPoint : ' +
                                                checkPoint +
                                                " , data : " +
                                                data);
                                        autoClosingAlert(
                                            '#warningMessage',
                                            '등록되지 않은 아이디 입니다.',
                                            2000);

                                    }
                                }

                            });

                        if (checkPoint === false) {
                            console
                                .log('[2] ajax Login checkPoint (login fail) : ' +
                                    checkPoint);
                            return;
                        } else {
                        	// 로그인 된 경우 뷰 화면 구성
                        	var ment = greeting();
                        	console.log(ment);
                            $('.app__hello').html(ment);
                            var profileName = getMemberInfo();
                            
                            var unReadCount = unReadCountById(id);
                            $('#message_modal').html(unReadCount);
                            
                            unReadCountRepeat = setInterval(function(){
                            	unReadCount = unReadCountById(id);
                                 $('#message_modal').html(unReadCount);
                            }, 3000);
                           
                            console.log('profileName 테스트 : ' + profileName);
                            $('.app__user-photo').attr('src', '/local_img/profile/' + profileName );
                            $('.app__userId').html(id);
                            
                            getFriendNews();
                            $('.app__newslink').on('click',function(){
                            	var num = $(this).parents('.app__meeting').attr('value');
                            	var type = $(this).parents('.app__meeting').attr('data');
                            	
                            	if ( type == 'reviewboard' ) {
                            		$('.app__newslink').attr('href','/reviewboard/list/main');
                            	} else {
                            		$('.app__newslink').attr('href','/'+type+'/get?no='+num);
                            	}
                            });
                            
                        }

                        animating = true;
                        var that = this;
                        ripple($(that), e);
                        $(that).addClass("processing");
                        setTimeout(function () {
                            $(that).addClass("success");
                            setTimeout(function () {
                                $app.show();
                                $app.css("top");
                                $app.addClass("active");
                            }, submitPhase2 - 70);
                            setTimeout(function () {
                                $login.hide();
                                $login.addClass("inactive");
                                animating = false;
                                $(that).removeClass(
                                    "success processing");
                            }, submitPhase2);
                        }, submitPhase1);

                    });
            
            
            function getFriendNews(){
            	$.ajax({
            		type : 'post',
            		url : '/member/getFriendNews',
            		dataType : 'json',
            		async: false,
            		success : function(data){
            			$('.app__meetings').html('');
            			$.each(data.result,function(index,item){
            				var strType;
            				if ( item.type == 'freeboard' ) {
            					strType = '자유게시판';
            				} else if ( item.type == 'meetboard' ){
            					strType = '오시는거죠';
            				} else if ( item.type == 'infoboard' ){
            					strType = '정보공유';
            				} else if ( item.type == 'reviewboard' ){
            					strType = '이용후기';
            				}
            				addFriendNews(item.no, item.type, strType, item.id ,item.subject, item.date, item.file );
            				console.log(item.type);
            			});
            		}
            	});
            }
            
            
            function addFriendNews(no, type, strType, id, subject, date, file ){
            	$('.app__meetings').append(
            			'<div class="app__meeting" value="'+ no +'" data="'+ type +'">'
            			+'<img src="/local_img/profile/'+ file +'" alt="" class="app__meeting-photo rounded" />'
            			+'<p class="app__meeting-name"><a href="#" class="app__newslink" target="_blank">'+ subject +'</a></p>'
            			+'<p class="app__meeting-info">'
            			+'<span class="app__meeting-place">[ '+ strType +' ]</span>'
            			+'<span class="app__meeting-time" style="font-weight : bold;"> '+ id +'</span>'
            			+'</p>'
            			+'</div>'
            			);
            }
            
            
            // 인사말 map
            function greeting(){
            	 var map = newMap();
                 map.put(1,'안녕하세요 ^^');
                 map.put(2,'뻐..파킹큐!!!');
                 map.put(3,'오늘은 치킨각 :)');
                 map.put(4,'#@$#^#&*&');
                 map.put(5,'크리스마스엔 케빈과...');
                 map.put(6,'오늘은 눈이 올까?');
                 map.put(7,'왜 이제 왔어??');
                 map.put(8,'사랑합니다 고갱님 ♡');
                 map.put(9,'하하하...');
                 map.put(10,'후기작성하실꺼죠?');
                 map.put(11,'하시시부리..');
                 map.put(12,'붕어빵이먹고싶다..');
                 map.put(13,'?');
                 map.put(14,'글쎄....');
                 map.put(15,'넘나좋은것ㅋ');
                 map.put(17,'WTF');
                 map.put(18,'프로젝트가 언제끝나..');
                 map.put(19,'다들 취업 화이팅 ^^');
                 map.put(20,'극한직업 진숙쌤');
                 var result = Math.floor(Math.random()*20)+1;
                 return map.get(result);
            }
            
            
            // map 로직
            function newMap() {
         	   var map = {};
         	   map.value = {};
         	   map.getKey = function(id) {
         	     return id;
         	   };
         	   map.put = function(id, value) {
         	     var key = map.getKey(id);
         	     map.value[key] = value;
         	   };
         	   map.contains = function(id) {
         	     var key = map.getKey(id);
         	     if(map.value[key]) {
         	       return true;
         	     } else {
         	       return false;
         	     }
         	   };
         	   map.get = function(id) {
         	     var key = map.getKey(id);
         	     if(map.value[key]) {
         	       return map.value[key];
         	     }
         	     return null;
         	   };
         	   map.remove = function(id) {
         	     var key = map.getKey(id);
         	     if(map.contains(id)){
         	       map.value[key] = undefined;
         	     }
         	   };
         	   return map;
         	 }
            
            
            
            

            function getMemberInfo(){
            	var id = '';
				var nick = '';
				var file = '';
            	$.ajax({
        			type : 'post',
        			dataType : 'json',
        			url : '/member/viewMemberInfo',
        			async : false,
        			success : function(data) {
        				
        				$.each(data, function(index, item) {
        					id = item.id;
        					nick = item.nick;
        					file = item.file;
        				});
        				console.log('아이디 : ' + id + ' / 닉네임 : ' + nick + ' / 파일 : ' + file);
        			}
        		});
            	return file;
            }
            
            
            function unReadCountById(id){
            	var unReadCount;
            	$.ajax({
            		type : 'post',
            		url : '/message/unReadCountById',
            		async : false,
            		data : {
            			id : id
            		},
            		success : function(data) {
            			console.log('읽지 않은 메세지 갯수 : ' + data);
            			unReadCount = data;
            			console.log('interval > unreadcount ');
            		}
            	});
            	console.log('메세지 최종 확인 : ' + unReadCount);
            	return unReadCount;
            }
            
            
            // Logout Process , Session delete
            $(document)
                .on(
                    "click",
                    ".app__logout",
                    function (e) {
                    	
                    	
                    	/*var target = $("#zeroForm");
                    	console.log(target);
                    	target.submit();*/
                    	
                    	
                    	 $.ajax({
                             type: 'post',
                             url: '/member/LogoutConnectionLog',
                             data: {
                                 userId: $.cookie('userId')
                             },
                             async: false,
                             success: function (data) {
                                 console.log('Update LogoutConnect Log : ' + data);
                                /* $.removeCookie("userId");*/
                                 console.log('delete cookie');
                                 clearInterval(unReadCountRepeat);
                             }
                         });
                    	
                    	
                        $.ajax({
                                type: 'post',
                                url: '/member/deleteSession',
                                async: false,
                                success: function (result) {
                                    console.log('ajax >>> deleteSession success');
                                   console.log("RESULT: " + result);
                                }
                            });

                        if (animating)
                            return;
                        $(".ripple").remove();
                        animating = true;
                        var that = this;
                        $(that).addClass("clicked");
                        setTimeout(function () {
                            $app.removeClass("active");
                            $login.show();
                            $login.css("top");
                            $login.removeClass("inactive");
                        }, logoutPhase1 - 120);
                        setTimeout(function () {
                            $app.hide();
                            animating = false;
                            $(that).removeClass("clicked");
                        }, logoutPhase1);
                    });

            // move Join Form
            $('.login__signup').click(function (e) {
                animating = true;
                var that = this;
                ripple($(that), e);
                $(that).addClass("processing");
                setTimeout(function () {
                    $(that).addClass("success");
                    setTimeout(function () {
                        $join.show();
                        $join.css("top");
                        $join.addClass("active");
                    }, submitPhase2 - 70);
                    setTimeout(function () {
                        $login.hide();
                        $login.addClass("inactive");
                        animating = false;
                        $(that).removeClass("success processing");
                    }, submitPhase2);
                }, submitPhase1);
            });
            

            // Member Input Validation Check
            $('input[name=memberInfo]').keyup(function () {
                var currvalue = $(this).val();
                var oper = $(this).data("oper");

                textCheck(oper, currvalue);
            });

            function textCheck(oper, value) {

                $
                    .ajax({
                        type: "post",
                        url: "/member/check" + oper,
                        data: {
                            id: value,
                            nick: value,
                            email: value
                        },
                        async: false,
                        success: function (data) {
                            if (oper === 'id') {
                                if (data == 1) {
                                    console
                                        .log('ajax idCheck : equals id');
                                    $('.join__inputtext').html(
                                        '이미 등록 된 아이디 입니다.');
                                    $('.join__inputtext').css(
                                        'color', 'red');
                                    idCheck = false;
                                } else if (data != 1) {
                                    console
                                        .log('ajax idCheck : not equals id');
                                    $('.join__inputtext').html(
                                        '사용 가능한 아이디 입니다.');
                                    $('.join__inputtext').css(
                                        'color', 'white');
                                    idCheck = true;
                                } else {
                                    $('.join__inputtext').html('');
                                    idCheck = false;
                                }

                            } else if (oper === 'email') {
                                if (data == 1) {
                                    console
                                        .log('ajax emailCheck : equals email');
                                    $('.join__inputtext').html(
                                        '이미 등록 된 이메일 입니다.');
                                    $('.join__inputtext').css(
                                        'color', 'red');
                                    emailCheck = false;
                                } else if (exp.test(value) == false) {
                                    console
                                        .log('ajax emailCheck : different type email');
                                    $('.join__inputtext').html(
                                        '이메일 형식이 올바르지 않습니다.');
                                    $('.join__inputtext').css(
                                        'color', 'red');
                                    emailCheck = false;
                                } else if (data != 1) {
                                    console
                                        .log('ajax emailCheck : not equls email');
                                    $('.join__inputtext').html(
                                        '사용 가능한 이메일 입니다.');
                                    $('.join__inputtext').css(
                                        'color', 'white');
                                    emailCheck = true;
                                } else {
                                    $('.join__inputtext').html('');
                                    emailCheck = false;
                                }

                            } else if (oper === 'nick') {
                                if (data == 1) {
                                    console
                                        .log('ajax nickCheck : equals nick');
                                    $('.join__inputtext').html(
                                        '이미 등록 된 닉네임 아이디 입니다.');
                                    $('.join__inputtext').css(
                                        'color', 'red');
                                    nickCheck = false;
                                } else if (data != 1) {
                                    console
                                        .log('ajax nickCheck : not equals nick');
                                    $('.join__inputtext').html(
                                        '사용 가능한 닉네임 입니다.');
                                    $('.join__inputtext').css(
                                        'color', 'white');
                                    nickCheck = true;
                                } else {
                                    $('.join__inputtext').html('');
                                    nickCheck = false;
                                }
                            }
                        }

                    });

                if (oper === 'pass') {
                    if (value.length < 4) {
                        console
                            .log('ajax passCheck : different type pass');
                        $('.join__inputtext').html('비밀번호는 4글자 이상 입니다.');
                        $('.join__inputtext').css('color', 'red');
                        passCheck = false;
                    } else if (value.length >= 4) {
                        console
                            .log('ajax passCheck : correct type pass');
                        $('.join__inputtext').html('사용 가능한 비밀번호 입니다.');
                        $('.join__inputtext').css('color', 'white');
                        passCheck = true;
                    } else if (value.length == 0) {
                        $('.join__inputtext').html('');
                        passCheck = false;
                    }

                }
            }

            // Join Process
            $(document)
                .on(
                    "click",
                    ".join__logout",
                    function (e) {

                        var id = $('#joinId').val();
                        var pass = $('#joinPass').val();
                        var nick = $('#joinNick').val();
                        var email = $('#joinEmail').val();
                        var checkPoint = false;

                        console
                            .log("[1] joinCheck >>> initial checkPoint value : " +
                                checkPoint);

                        if (idCheck == false) {
                            $('.join__inputtext').html(
                                '아이디를 다시 확인해주세요.');
                            $('.join__inputtext').css('color',
                                'red');
                            return;
                        } else if (passCheck == false) {
                            $('.join__inputtext').html(
                                '비밀번호를 다시 확인해주세요.');
                            $('.join__inputtext').css('color',
                                'red');
                            return;
                        } else if (nickCheck == false) {
                            $('.join__inputtext').html(
                                '닉네임을 다시 확인해주세요.');
                            $('.join__inputtext').css('color',
                                'red');
                            return;
                        } else if (emailCheck == false) {
                            $('.join__inputtext').html(
                                '이메일을 다시 확인해주세요.');
                            $('.join__inputtext').css('color',
                                'red');
                            return;
                        }

                        console.log("[2] previous ajax");

                        $.ajax({
                            type: 'post',
                            url: '/member/join',
                            data: {
                                id: id,
                                pass: pass,
                                nick: nick,
                                email: email
                            },
                            async: false,
                            success: function (data) {
                                if (data == 1) {
                                    checkPoint = true;
                                    console
                                        .log("[3] ajax join success : " +
                                            checkPoint);
                                } else {
                                    console
                                        .log("[3] ajax join fail : " +
                                            checkPoint);
                                }
                            }
                        });

                        if (checkPoint === false) {
                            console
                                .log("[4] final join failed : " +
                                    checkPoint);
                            $('.join__inputtext').html(
                                '회원가입에 실패 했습니다.');
                            $('.join__inputtext').css('color',
                                'red');
                            return;
                        }
                        if (animating)
                            return;
                        $(".ripple").remove();
                        animating = true;
                        var that = this;
                        $(that).addClass("clicked");
                        setTimeout(function () {
                            $join.removeClass("active");
                            $choose.show();
                            $choose.css("top");
                            $choose.addClass("active");
                            $choose.removeClass("inactive");
                        }, logoutPhase1 - 120);
                        setTimeout(function () {
                            $join.hide();
                            animating = false;
                            $(that).removeClass("clicked");
                        }, logoutPhase1);
                    });


            // Arrow Icon
            $(function () {
                function swing() {
                    $('#icon-arrow').animate({
                        'margin-top': '55px'
                    }, 600).animate({
                        'margin-top': '85px'
                    }, 600, swing);
                }
                swing();
            });

            /*
             * $(function () { function swing() {
             * $('#btn__signup').animate({ 'padding-bottom': '0px' },
             * 600).animate({ 'padding-bottom': '20px' }, 600, swing); }
             * swing(); });
             */
            
            // Choose Process
            $(document).on("click", ".choose__logout", function (e) {
                    	
            	
            	var defaultProfilePath = $('#profile-default').attr('src');
            	console.log('선택 된 프로필 이름 -> ' + defaultProfilePath);
            	var realProfileName = defaultProfilePath.split('/');
            	console.log('0 : ' + realProfileName[0] + ' / 1 : ' + realProfileName[1] + ' / 2 : ' + realProfileName[2] + ' / 3 : ' + realProfileName[3]);
            	console.log('작성 된 아이디 확인 -> ' + $('#joinId').val());
            	
            	
                    	$.ajax({
                    		type : 'POST',
                    		url : '/member/updateProfile',
                    		async : false,
                    		data : {
                    			id : $('#joinId').val(),
                    			pfile : realProfileName[3]
                    		},
                    		success: function(data){
                    			if ( data == 1 ) {
                    				console.log('default profile update success');
                    			} else {
                    				console('default profile update fail');
                    			}
                    		}
                    		
                    	});

                        if (animating)
                            return;
                        $(".ripple").remove();
                        animating = true;
                        var that = this;
                        $(that).addClass("clicked");
                        setTimeout(function () {
                        	$choose.removeClass("active");
                            $login.show();
                            $login.css("top");
                            $login.removeClass("inactive");
                        }, logoutPhase1 - 120);
                        setTimeout(function () {
                        	$choose.hide();
                            animating = false;
                            $(that).removeClass("clicked");
                        }, logoutPhase1);
                        
                        
                    });
            
            
            
            $('.fa-sync').on('click' , function(){
         	   $('#profile-default').attr('src',function(){
         		   var ranResult = Math.floor(Math.random() * 14) + 1;
         		   console.log(ranResult);
         		   var imagePath = '/images/kakao/kakao-' + ranResult + '.png';
         		   return imagePath;
         	   });
            });
            
            
            
            
            
            
            

            // home icon click [ move main page ]
            $('#icon-home').click(function () {
                wrapWindowByMask();
                runProgress();
                $(".progress").show('fast'); // progress bar show
                $("#progress-text").show('fast');
                $(this).hide('slow'); // home btn hide
                $('#icon-arrow').hide('slow'); // arrow btn hide
            });

            // process progress-bar
            function runProgress() {
                var num = 0;
                var android = $.cookie('android');
                console.log(android);
                var setTimger = setInterval(function () {
                    $('.progress-bar').css('width', function () {
                        num = num + Math.floor(Math.random() * 5);
                        if (num > 100) {
                            num = 100;
                        }
                        console.log("progress-bar value : " + num);
                        $('#progress-text').html(num + '%');
                        if (num == 100) {
                            $('#progress-text').html('');
                        }
                        return num + '%';
                        if (num == 100) {
                            clearInterval(setTimger);
                            $('#progress-text').css("left", "47%")
                            $('#progress-text').html('success');
                            setInterval(function () {
                                $('#progress-text').append('.');
                            }, 500);
                            setTimeout(function () {
                            	if ( android == 'true' ) {
                            		location.href = "../freeboard/mlist";
                            	} else {
                            		location.href = "../common/main";
                            	}
                            }, 2000);
                        }
                    });
                    if (num >= 100) {
                        clearInterval(setTimger);
                        $('#progress-text').css("left", "47%")
                        $('#progress-text').html('success');
                        setInterval(function () {
                            $('#progress-text').append('.');
                        }, 500);
                        setTimeout(function () {
                        	if ( android == 'true' ) {
                        		location.href = "../freeboard/mlist";
                        	} else {
                        		location.href = "../common/main";
                        	}
                        }, 2000);
                    }
                }, 50);
            }

            function wrapWindowByMask() {
                // 화면의 높이와 너비를 구한다.
                var maskHeight = $(document).height();
                var maskWidth = $(window).width();

                // 마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
                $('#mask').css({
                    'width': maskWidth,
                    'height': maskHeight
                });

                // 애니메이션 효과 - 일단 1초동안 까맣게 됐다가 80% 불투명도로 간다.
                $('#mask').fadeTo("slow", 0.8);

                // 윈도우 같은 거 띄운다.
                $('.window').show();
            }
            
            
            
            
            
            // message 
            $('.user-profile').click(function() {
                if(!$(this).hasClass('active')){
                    
                    $('.user-profile.active').removeClass('active');
                    $(this).addClass('active');
                    
                    var temp =   $('#'+$(this).attr('data-up'));
                    
                    hideUI('.chat-container')
                    showUI('#'+$(this).attr('data-up'));
                    temp.addClass('active').removeClass('hidechat');
                    temp.prevAll('.chat-container').addClass('hidechat').removeClass('active');
                    temp.nextAll('.chat-container').removeClass('active').removeClass('hidechat');
                }
            });
      showUI('#cont1');
       
      function showUI(ele){
          console.log($(ele));
          var kids = $(ele).children(), temp;
          for( var i = kids.length-1 ; i >=0  ; i-- ){
              temp  = $(kids[i]);
              
              if(temp.is('div')){
                  temp.animate({
                      marginTop:0,
                  },400).css({opacity:1}).fadeIn()
              }
              else{
                  temp.css({opacity:1}).fadeIn()
              }   
          }
      }
      
       function hideUI(ele){
          console.log($(ele));
          var kids = $(ele).children(), temp;
          for( var i = kids.length-1 ; i >=0  ; i-- ){
              temp  = $(kids[i]);
              
              if(temp.is('div')){
                  temp.animate({
                      marginTop:'30px',
                  }).css({opacity:0});
              }
              else{
                  temp.css({opacity:0});
              }   
          }
      }
       

       
 });
