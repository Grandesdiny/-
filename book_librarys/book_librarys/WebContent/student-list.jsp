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
					<a href="javascript:;">当前用户：${uname }</a>
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
							<a href="Index?method=books">
								<i class="iconfont">&#xe761;</i> 图书清单
								<i class="iconfont nav_right">&#xe6a7;</i>
							</a>
						</li>
						<c:choose>
						<c:when test="${utype eq 2 }">
						<li class="list">
							<a href="Student?method=students">
								<i class="iconfont">&#xe70b;</i> 用户管理
								<i class="iconfont nav_right">&#xe6a7;</i>
							</a>
						</li>
						<li class="list">
							<a href="Type?method=types">
								<i class="iconfont">&#xe6a3;</i> 图书分类管理
								<i class="iconfont nav_right">&#xe697;</i>
							</a>
						</li>
						</c:when>
						<c:otherwise>
						<li class="list">
							<a href="Admin?method=users">
								<i class="iconfont">&#xe70b;</i> 管理员管理
								<i class="iconfont nav_right">&#xe6a7;</i>
							</a>
						</li>
						</c:otherwise>
						</c:choose>
						<li class="list">
							<a href="History?method=history">
								<i class="iconfont">&#xe6a3;</i> 图书日志管理
								<i class="iconfont nav_right">&#xe697;</i>
							</a>
						</li>
					</ul>
				</div>
			</div>
			<!-- 左侧菜单结束 -->
			<!-- 右侧主体开始 -->
			<div class="page-content">
				<div class="content">
					<!-- 右侧内容框架，更改从这里开始 -->
					<form class="layui-form xbs" action="Student" method="post">
						<div class="layui-form-pane" style="text-align: center;">
							<div class="layui-form-item" style="display: inline-block;">
								<div class="layui-input-inline">
								<input type="hidden" name="method" value="student_search">
									<input type="text" name="uname" placeholder="请输入账号" autocomplete="off" class="layui-input">
								</div>
								<div class="layui-input-inline" style="width:80px">
									<button class="layui-btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
								</div>
							</div>
						</div>
					</form>
					<xblock><button class="layui-btn" onclick="member_add('添加用户','student-add.jsp','600','500')"><i class="layui-icon">&#xe608;</i>添加</button></xblock>
					<table class="layui-table">
						<thead>
							<tr>
                                <th>ID</th>
                                <th>用户账号</th>
                                <th>姓名</th>
                                <th>电话</th>
                                 <th>当前分数</th>
                                <th>可借数量</th>
                                <th>操作</th>
                            </tr>
						</thead>
						<tbody>
							<c:forEach items="${student }" var="student" varStatus="status"> 
							<tr>
								<td>${status.index+1 }</td>
	                                <td>${student.uname }</td>
								<td class="td-status">
									<span class="layui-btn layui-btn-normal layui-btn-mini">${student.sname }</span>
								</td>
	                                <td>${student.tel }</td>  
	                                <td><c:choose>
	                                	<c:when test="${student.grade gt 0 }">
	                                	${student.grade }
	                                	</c:when>
	                                	<c:otherwise>
	                                	<span class="layui-btn layui-btn-danger layui-btn-mini">已停用</span>
	                                	</c:otherwise>
	                                </c:choose>
	                                </td>
	                                 <td>${student.maxnum }</td>
								<td class="td-manage">
								<c:choose>
	                                	<c:when test="${student.grade gt 0 }">
	                                	</c:when>
	                                	<c:otherwise>
	                                	<a style="text-decoration:none" onclick="member_recover(${student.sid},this,'10001')" href="javascript:;" title="恢复">
                               			 <i class="layui-icon">&#xe618;</i>
                            			</a>
	                                	</c:otherwise>
	                                </c:choose>
									<a title="编辑" href="javascript:;" onclick="member_edit('编辑','Student?method=student_update&sid=${student.sid }','4','500','400')" class="ml-5" style="text-decoration:none">
										<i class="layui-icon">&#xe642;</i>
									</a>
									<a style="text-decoration:none" onclick="member_password('${student.uname}',this,'10001')" href="javascript:;" title="重置密码">
										<i class="layui-icon">&#xe631;</i>
									</a>
									<a title="删除" href="javascript:;" onclick="member_del('${student.sid }','${student.uname }',this,'1')" style="text-decoration:none">
										<i class="layui-icon">&#xe640;</i>
									</a>
								</td>
							</tr>
							</c:forEach>
							
						</tbody>
					</table>
					<!-- 右侧内容框架，更改从这里结束 -->
				</div>
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

			/*用户-添加*/
			function member_add(title, url, w, h) {
				 //添加iframe标签
				x_admin_show(title, url, w, h);
			}
			/*用户-查看*/
			function member_show(title, url, id, w, h) {
				x_admin_show(title, url, w, h);
			}
			   /*用户-恢复*/
            function member_recover(sid,obj,id){
                layer.confirm('确认要恢复吗？',function(index){
                	layer.msg('已恢复!', {
						icon: 1,
						time: 1000
					});
					setTimeout(function(){ 
						window.location.href="Student?method=student_recover&sid="+sid;
	                    }, 800);
                    
                });
            }
			
			// 用户-编辑
			function member_edit(title, url, id, w, h) {
				x_admin_show(title, url, w, h);
			}
			/*密码-重置*/
			function member_password(uname,obj,id) {
				layer.confirm('确认重置密码？',function(index){
					layer.msg('已重置!', {
						icon: 1,
						time: 1000
					});
					setTimeout(function(){ 
                    	window.location.href="Student?method=student_password&uname="+uname;
	                    }, 800);
                });
			}
			/*用户-删除*/
			function member_del(sid,uname,obj, id) {
				layer.confirm('确认要删除吗？', function(index) {
					layer.msg('已删除!', {
						icon: 1,
						time: 1000
					});
					setTimeout(function(){ 
						window.location.href="Student?method=student_delete&sid="+sid+"&uname="+uname;
	                    }, 800);
				});
			}
		</script>
	</body>

</html>