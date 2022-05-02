<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>图书管理系统</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="./css/font.css">
	<link rel="stylesheet" href="./css/xadmin.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/Swiper/3.4.2/css/swiper.min.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.bootcss.com/Swiper/3.4.2/js/swiper.jquery.min.js"></script>
    <script src="./lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="./js/xadmin.js"></script>

</head>
<body>
    <div class="login-logo"><h1>图书管理系统</h1></div>
    <div class="login-box">
        <form class="layui-form layui-form-pane" action="">
              
            <label class="login-title" for="username">帐号</label>
            <div class="layui-form-item">
                <label class="layui-form-label login-form"><i class="iconfont">&#xe6b8;</i></label>
                <div class="layui-input-inline login-inline">
                  <input type="text" id="username" name="username" lay-verify="required" placeholder="请输入你的帐号" autocomplete="off" class="layui-input">
                </div>
            </div>
            <label class="login-title" for="password">密码</label>
            <div class="layui-form-item">
                <label class="layui-form-label login-form"><i class="iconfont">&#xe82b;</i></label>
                <div class="layui-input-inline login-inline">
                  <input type="password" id="password" name="password" lay-verify="required" placeholder="请输入你的密码" autocomplete="off" class="layui-input">
                </div>
            </div>
             <label class="login-title" for="password">验证码</label>
            <div class="layui-form-item">
                <label class="layui-form-label login-form"><i class="iconfont">&#xe82b;</i></label>
                <div class="layui-input-inline login-inline">
                 <input type="text" name="password" lay-verify="required"  id="s1" placeholder="填写下方的验证码" autocomplete="off" class="layui-input"/>
                                    <canvas id="canvas" width="100" height="42" class="passcode" style="height:43px;cursor:pointer;"></canvas> 
                </div>
            </div>
            <div class="form-actions">
                <button class="btn btn-warning pull-right" id="btn1" type="button">登录</button> 
            </div>
        </form>
    </div>
	<div class="bg-changer">
        <div class="swiper-container changer-list">
            <div class="swiper-wrapper">
                <div class="swiper-slide"><img class="item" src="./images/a.jpg" alt=""></div>
                <div class="swiper-slide"><img class="item" src="./images/b.jpg" alt=""></div>
                <div class="swiper-slide"><img class="item" src="./images/c.jpg" alt=""></div>
                <div class="swiper-slide"><img class="item" src="./images/d.jpg" alt=""></div>
                <div class="swiper-slide"><img class="item" src="./images/e.jpg" alt=""></div>
                <div class="swiper-slide"><img class="item" src="./images/f.jpg" alt=""></div>
                <div class="swiper-slide"><img class="item" src="./images/g.jpg" alt=""></div>
                <div class="swiper-slide"><img class="item" src="./images/h.jpg" alt=""></div>
                <div class="swiper-slide"><img class="item" src="./images/i.jpg" alt=""></div>
                <div class="swiper-slide"><img class="item" src="./images/j.jpg" alt=""></div>
                <div class="swiper-slide"><img class="item" src="./images/k.jpg" alt=""></div>
                <div class="swiper-slide"><span class="reset">初始化</span></div>
            </div>
        </div>
        <div class="bg-out"></div>
        <div id="changer-set"><i class="iconfont">&#xe696;</i></div>   
    </div>
    <script>
  //登陆
    function login(){
    	$.ajax({
    		url:"Login",
    		type:"post",
    		data:{
    			"method":"login",
    			"uname":$("#username").val(),
    			"password":$("#password").val(),
    		},
    		success:function(result){
    			console.log(result);
    			if(result == "1"){
    				window.location.href ="Login?method=index";
    				
    			}else{
    				alert("账号或密码错误！");
    			}
    		},
    		error: function () { 
    			alert("密码错误，请重新输入！");
    		}
    		
    	});
    }

	
	// 验证码
		$(function(){
	    var show_num = [];
	    draw(show_num);
	    $("#canvas").on('click',function(){
	        draw(show_num);
	    })
	    $("#btn1").on('click',function(){
	        var val = $("#s1").val().toLowerCase();
	        var num = show_num.join("");
	        if(val==''){
	            alert('请输入验证码！');
	        }else if(val == num){
				login();
	            $("#s1").val('');
	            draw(show_num);
	        }else{
	            alert('验证码错误！请重新输入！');
	            $("#s1").val('');
	             draw(show_num);
	        }
	    })
	})
	
		//生成并渲染出验证码图形
	function draw(show_num) {
	    var canvas_width=$('#canvas').width();
	    var canvas_height=$('#canvas').height();
	    var canvas = document.getElementById("canvas");//获取到canvas的对象，演员
	    var context = canvas.getContext("2d");//获取到canvas画图的环境，演员表演的舞台
	    canvas.width = canvas_width;
	    canvas.height = canvas_height;
	    var sCode = "a,b,c,d,e,f,g,h,i,j,k,m,n,p,q,r,s,t,u,v,w,x,y,z,A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0";
	    var aCode = sCode.split(",");
	    var aLength = aCode.length;//获取到数组的长度
	    
	    for (var i = 0; i < 4; i++) {  //这里的for循环可以控制验证码位数（如果想显示6位数，4改成6即可）
	        var j = Math.floor(Math.random() * aLength);//获取到随机的索引值
	        // var deg = Math.random() * 30 * Math.PI / 180;//产生0~30之间的随机弧度
	        var deg = Math.random() - 0.5; //产生一个随机弧度
	        var txt = aCode[j];//得到随机的一个内容
	        show_num[i] = txt.toLowerCase();
	        var x = 10 + i * 20;//文字在canvas上的x坐标
	        var y = 20 + Math.random() * 8;//文字在canvas上的y坐标
	        context.font = "bold 23px 微软雅黑";
	
	        context.translate(x, y);
	        context.rotate(deg);
	
	        context.fillStyle = randomColor();
	        context.fillText(txt, 0, 0);
	
	        context.rotate(-deg);
	        context.translate(-x, -y);
	    }
	    for (var i = 0; i <= 5; i++) { //验证码上显示线条
	        context.strokeStyle = randomColor();
	        context.beginPath();
	        context.moveTo(Math.random() * canvas_width, Math.random() * canvas_height);
	        context.lineTo(Math.random() * canvas_width, Math.random() * canvas_height);
	        context.stroke();
	    }
	    for (var i = 0; i <= 30; i++) { //验证码上显示小点
	        context.strokeStyle = randomColor();
	        context.beginPath();
	        var x = Math.random() * canvas_width;
	        var y = Math.random() * canvas_height;
	        context.moveTo(x, y);
	        context.lineTo(x + 1, y + 1);
	        context.stroke();
	    }
	}
	
	//得到随机的颜色值
	function randomColor() {
	    var r = Math.floor(Math.random() * 256);
	    var g = Math.floor(Math.random() * 256);
	    var b = Math.floor(Math.random() * 256);
	    return "rgb(" + r + "," + g + "," + b + ")";
	}
	
        
    </script>
</body>
</html>