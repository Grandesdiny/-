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
    <!-- 中部开始 -->
    <div class="wrapper">
        <!-- 右侧主体开始 -->
        <div class="page-content">
          <div class="content">
            <!-- 右侧内容框架，更改从这里开始 -->
                <div class="layui-form-item">
                    <label for="L_username" class="layui-form-label">
                        账号
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="uname" name="uname" disabled="" value="${uname }" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="L_repass" class="layui-form-label">
                        <span class="x-red">*</span>旧密码
                    </label>
                    <div class="layui-input-inline">
                        <input type="password" id="password" name="oldpass" required="" lay-verify="required"
                        autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="L_pass" class="layui-form-label">
                        <span class="x-red">*</span>新密码
                    </label>
                    <div class="layui-input-inline">
                        <input type="password" id="password1" name="newpass" required="" lay-verify="required"
                        autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid layui-word-aux">
                        6到16个字符
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="L_repass" class="layui-form-label">
                        <span class="x-red">*</span>确认密码
                    </label>
                    <div class="layui-input-inline">
                        <input type="password" id="password2" name="repass" required="" lay-verify="required"
                        autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="L_repass" class="layui-form-label">
                    </label>
                    <button  class="layui-btn" onclick="updatePwd()">
                        确认修改
                    </button>
                </div>
            <!-- 右侧内容框架，更改从这里结束 -->
          </div>
        </div>
        <!-- 右侧主体结束 -->
    </div>
    <!-- 中部结束 -->
</body>
<script type="text/javascript">
			function updatePwd() {
				var pwd = document.getElementById("password").value;
				var pwd1 = document.getElementById("password1").value;
				var pwd2 = document.getElementById("password2").value;
				if(pwd1 == pwd2) {
					$.ajax({
						url: "Login",
						type: "get",
						async: true,
						dataType: "json",
						data: {
							"method": "updateUsers",
							"pwd": pwd,
							"pwd1": pwd1,
						},
						success: function(result) {
							if(result == "1") {
								layer.msg('修改成功！', {
									icon: 1,
									time: 1000
								});
								setTimeout(function(){ 
									window.parent.location.reload(); //刷新父页面
					        		 x_admin_close();
								}, 1000);
								
							} else if(result == "2") {
								layer.msg('密码错误，请检查！', {
									icon: 5,
									time: 1000
								});
							}
						},
						error: function() {
							console.log("失败");
						},
					});
				} else {
					layer.msg('两次密码不同，请重新输入！！', {
						icon: 5,
						time: 1000
					});
				}
			}
		</script>
</html>