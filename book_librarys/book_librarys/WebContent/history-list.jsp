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
					<form class="layui-form xbs" action="History" method="post">
						<div class="layui-form-pane" style="text-align: center;">
							<div class="layui-form-item" style="display: inline-block;">
								<div class="layui-input-inline">
								<input type="hidden" name="method" value="history_search">
									<input type="text" name="string" placeholder="请输入图书名或账号" autocomplete="off" class="layui-input">
								</div>
								<div class="layui-input-inline" style="width:80px">
									<button class="layui-btn" lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
								</div>
							</div>
						</div>
					</form>
					<table class="layui-table">
						<thead>
							<tr>
								<th>ID</th>
                                <th>图书名</th>
                                <th>用户账号</th>
                                <th>姓名</th>
                                 <th>开始时间</th>
                                <th>结束时间</th>
                                <th>是否超时</th>
                                <th>操作</th>
                            </tr>
						</thead>
						<tbody>
							<c:forEach items="${history }" var="history" varStatus="status" >
							<tr>
							<td>${status.index+1 }</td>
								<td class="td-status">
									<span class="layui-btn layui-btn-normal layui-btn-mini">${history.bname }</span>
								</td>
								<td class="td-status">
									<span class="layui-btn layui-btn-normal layui-btn-mini">${history.uname }</span>
								</td>
								<td class="td-status">
									<span class="layui-btn layui-btn-normal layui-btn-mini">${history.sname }</span>
								</td>
	                                <td>${history.begintime }</td>  
	                                <td><c:choose>
	                                	<c:when test="${empty history.endtime }">
	                                	<span class="layui-btn layui-btn-normal layui-btn-mini">待还书</span>
	                                	</c:when>
	                                	<c:otherwise>
	                                	${history.endtime }
	                                	</c:otherwise>
	                                </c:choose>
	                                </td>  
	                                <td><c:choose>
	                                	<c:when test="${history.timeout eq 0 }">
	                                	<span class="layui-btn layui-btn-normal layui-btn-mini">正常</span>
	                                	</c:when>
	                                	<c:when test="${history.timeout eq 1 }">
	                                	<span class="layui-btn layui-btn-danger layui-btn-mini">超时(-1分信用积分)</span>
	                                	</c:when>
	                                	<c:otherwise>
	                                	<span class="layui-btn layui-btn-danger layui-btn-mini">进行中</span>
	                                	</c:otherwise>
	                                </c:choose>
	                                </td>
								<td class="td-manage">
								<c:choose>
	                                	<c:when test="${empty history.endtime }">
	                                	<span class="layui-btn layui-btn-normal layui-btn-mini">进行中无法删除</span>
	                                	</c:when>
	                                	<c:otherwise>
	                                	<a title="删除" href="javascript:;" onclick="member_del('${history.hid }',this,'1')" style="text-decoration:none">
										<i class="layui-icon">&#xe640;</i>
									</a>
	                                	</c:otherwise>
	                                </c:choose>
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
		// 用户-编辑
		function member_edit(title, url, id, w, h) {
			x_admin_show(title, url, w, h);
		}
			/*用户-删除*/
			function member_del(hid,obj, id) {
				layer.confirm('确认要删除吗？', function(index) {
					//发异步删除数据
					//$(obj).parents("tr").remove();
					layer.msg('已删除!', {
						icon: 1,
						time: 2000
					});
					setTimeout(function(){ 
						window.location.href="History?method=history_delete&hid="+hid;
	                    }, 800);
				});
			}
		</script>
	</body>

</html>