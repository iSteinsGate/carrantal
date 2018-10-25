<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/js/easyui/themes/icon.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-1.8.3.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/ztree/jquery.ztree.all-3.5.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/js/ztree/zTreeStyle.css"
	type="text/css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/top.css" type="text/css" />
<title>注册界面</title>
<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	font-size: 12px;
	background-color: white; /*背景颜色*/
}

#container {
	width: 1300px;
	margin: auto; /*居中  */
}

#register {
	margin: auto;
	height: 500px;
	background-image: url("image/registerbg.jpg");
	background-repeat: no-repeat;
	background-size:cover;
	margin-top:20px;
}

#content {
	position:relative;
	left:400px;
	top:25px;
	border:0px solid red;
	width: 550px;
	height: 450px;
	background-color: #FFFFFF;
}

#content input {
	margin-top: 18px;
	font-size: 12px;
	text-indent:30px;/* 文本缩进*/
}
#icon1{
	position:absolute;
	left:149px;
	top:77px;
}
#icon2{
	position:absolute;
	left:149px;
	top:133px;
}
#icon3{
	position:absolute;
	left:149px;
	top:189px;
}
#icon4{
	position:absolute;
	left:149px;
	top:245px;
}
#icon5{
	position:absolute;
	left:149px;
	top:301px;
}
</style>
<script type="text/javascript">
	$(function() {
		var reg = /^1[3|4|5|7|8][0-9]{9}$/;
		//扩展手机号校验规则
		$.extend($.fn.validatebox.defaults.rules, {
			telephone : {
				validator : function(value, param) {
					return reg.test(value);
				},
				message : '手机号输入有误！'
			},
			equals : {
				validator : function(value, param) {
					return value == $(param[0]).val();
				},
				message : '两次输入密码不一致'
			}
		});
		/* 表单校验 */
		$("#registerBtn").click(function() {
			var flag = $("#registerForm").form('validate');
			//alert(flag);
			if (flag) {
				$.messager.confirm('提示', '注册成功，去登陆', function(r) {
					if (r) {
						$("#registerForm").submit();
					}
				});
			}
		});
	})
</script>
</head>
<body>
	<div id="container">
		<!-- 头部 -->
		<jsp:include page="top.jsp"></jsp:include>
		<div id="register">
			<!-- 用户注册表单 -->
			<div id="content">
				<form id="registerForm" action="/register" method="post">

					<table class="table-edit" height="300px" align="center"
						border="0px" cellspacing="0px;">
						<tr>
							<td><h2>用户注册</h2></td>
						</tr>
						<tr>
							<td><img id="icon1"src="image/user.png"><input type="text" name="username"
								class="easyui-validatebox" required="true"
								style="height: 30px; width: 250px;" placeholder="请输入字母和数字" /></td>
						</tr>
						<tr>
							<td><img id="icon2"src="image/pwd.png"><input type="password" id="pwd" name="password"
								placeholder="请输入密码" class="easyui-validatebox" required="true"
								style="height: 30px; width: 250px;" /></td>
						</tr>
						<tr>
							<td><img id="icon3"src="image/pwd.png"><input type="password" id="repwd" name="name"
								placeholder="确认密码" validType="equals['#pwd']"
								class="easyui-validatebox" required="true"
								style="height: 30px; width: 250px;" /></td>
						</tr>
						<tr>
							<td><img id="icon4"src="image/user.png"><input type="text" name="realname" placeholder="请输入真实姓名"
								class="easyui-validatebox" required="true"
								style="height: 30px; width: 250px;" /></td>
						</tr>
						<tr>
							<td><img id="icon5"src="image/phone.png"><input type="text" name="phone" placeholder="请输入手机号码"
								data-options="validType:'telephone'" class="easyui-validatebox"
								required="true" style="height: 30px; width: 250px;" /></td>
						</tr>
						<tr >
							<td align="center"><input type="button" value="确定"
								id="registerBtn" style="background-color:#fabe00;width:255px;height:40px;color:#ffffff;font-size:15px;"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<!-- 底部 -->
		<div
			style="height: 35px; background-color: #E0ECFF; text-align: center;">Copyright©
			tanqinghui 版权所有</div>
	</div>
</body>
</html>