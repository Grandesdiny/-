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
					<input type="hidden" name="method" value="admin_add">
						<div class="layui-form-item">
							<label for="L_email" class="layui-form-label"> <span
							class="x-red">*</span>管理员账号
						</label>
							<div class="layui-input-inline">
								<input type="text" id="uname" name="uname" placeholder="请输入账号" required=""  autocomplete="off" class="layui-input">
							</div>
						</div>
						<div class="layui-form-item">
							<label for="L_repass" class="layui-form-label"> </label>
							<button class="layui-btn" onclick="addbooks()" >
							增加</button>
						</div>
					<!-- 右侧内容框架，更改从这里结束 -->
				</div>
			</div>
			<!-- 右侧主体结束 -->
		</div>
		<!-- 中部结束 -->
	</body>
<script type="text/javascript">
		//添加提交
		function addbooks() {
			$.ajax({
	    		url:"Admin",
	    		type:"post",
	    		data:{
	    			"method":"admin_add",
	    			"uname":$("#uname").val(),
	    		},
	    		success:function(result){
	    			console.log(result);
	    			if(result == "1"){
	    				 layer.msg('添加成功!', {
	    						icon: 1,
	    						time: 1000
	    					});
	    				 setTimeout(function(){ 
	    					 window.parent.location.reload(); //刷新父页面
		    	        	 x_admin_close();
	                     	}, 800);
	    				 
	    			}else{
	    				 layer.msg('添加失败!', {
	    						icon: 1,
	    						time: 1000
	    					});
	    			}
	    		},
	    		error: function () { 
	    			layer.msg('发生未知错误!', {
						icon: 1,
						time: 1000
					});
	    		}
	    		
	    	});
		        	
			}
</script>
</html>