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
		<!-- 顶部开始 -->
		<div class="container">
			<div class="logo">
				<a href="Index?method=books">图书管理系统V1.0</a>
			</div>
			<div class="open-nav"><i class="iconfont">&#xe699;</i></div>
			<ul class="layui-nav right" lay-filter="">
				<li class="layui-nav-item">
					<a href="javascript:;">当前用户：${sname }</a>
					<dl class="layui-nav-child">
						<!-- 二级菜单 -->
						<dd>
							<a href="javascript:;" onclick="member_edit('修改秘密','users-password.jsp','4','','510')">修改密码</a>
						</dd>
						<dd>
							<a href="javascript:exit();">退出</a>
						</dd>
					</dl>
				</li>
			</ul>
		</div>
		<!-- 顶部结束 -->
		<!-- 中部开始 -->
		<div class="wrapper">
			<!-- 左侧菜单开始 -->
			<div class="left-nav">
				<div id="side-nav">
					<ul id="nav">
						<li class="list" current>
							<a href="Student?method=users_books">
								<i class="iconfont">&#xe761;</i> 图书清单
								<i class="iconfont nav_right">&#xe6a7;</i>
							</a>
						</li>
						<li class="list">
							<a href="History?method=users_history">
								<i class="iconfont">&#xe70b;</i> 借阅信息
								<i class="iconfont nav_right">&#xe6a7;</i>
							</a>
						</li>
						<li class="list">
							<a href="Users?method=users">
								<i class="iconfont">&#xe6a3;</i> 个人信息
								<i class="iconfont nav_right">&#xe697;</i>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- 左侧菜单结束 -->
			<!-- 右侧主体开始 -->
			<div class="page-content">
			<form action="Users">
			<input type="hidden" name="method" value="updateStudent">
			<input type="hidden" name="sid" value="${student.getSid() }">
				<div class="content">
					<!-- 右侧内容框架，更改从这里开始 -->
                <div class="layui-form-item">
                    <label for="L_username" class="layui-form-label">
                        账号
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="uname" name="uname" disabled="" value="${student.getUname() }" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="L_repass" class="layui-form-label">
                        <span class="x-red">*</span>姓名
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="sname" name="sname" value="${student.getSname() }" required="" lay-verify="required"
                        autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="L_pass" class="layui-form-label">
                        <span class="x-red">*</span>电话
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="tel" name="tel" value="${student.getTel() }" required="" lay-verify="required"
                        autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="L_repass" class="layui-form-label">
                        <span class="x-red">*</span>信用积分
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="grade" name="grade" value="${student.getGrade() }" disabled="" required="" lay-verify="required"
                        autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="L_repass" class="layui-form-label">
                        <span class="x-red">*</span>可借图书
                    </label>
                    <div class="layui-input-inline">
                        <input type="text" id="maxnum" name="maxnum" value="${student.getMaxnum() }" disabled="" required="" lay-verify="required"
                        autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label for="L_repass" class="layui-form-label">
                    </label>
                    <input  class="layui-btn" type="submit" value="点击修改" onclick="updatePwd()">
                        	
                </div>
            <!-- 右侧内容框架，更改从这里结束 -->
				</div>
				</form>
			</div>
			<!-- 右侧主体结束 -->
		</div>
		<!-- 中部结束 -->
		<!-- 底部开始 -->
		<div class="footer">
			<div class="copyright">Copyright ©2017 x-admin v2.3 All Rights Reserved. 本后台系统由X前端框架提供前端技术支持</div>
		</div>
		<!-- 底部结束 -->
		<!-- 背景切换开始 -->
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
		<!-- 背景切换结束 -->
		<!-- 页面动态效果 -->
		<script>
		function exit() {
			layer.confirm("确认退出？", function(index){
				window.location.href="Login?method=exit";
				
			});
		}
		// 用户-编辑
		function member_edit(title, url, id, w, h) {
			x_admin_show(title, url, w, h);
		}
		function updatePwd() {
			layer.msg('修改成功！', {
				icon: 5,
				time: 1000
			});
		}
		</script>
	</body>

</html>