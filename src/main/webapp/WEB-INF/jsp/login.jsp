<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/top.css" type="text/css" />
<title>登录界面</title>
<style type="text/css">
body {
	margin: 0px;
	padding: 0px;
	font-size: 12px;
	background-color: white; /*背景颜色*/
}

#container {
	width: 1300px;
	height: 625px;
	margin: auto; /*居中  */
}

#loginbg {
	margin: auto;
	height: 450px;
	background-image: url("image/login.jpg");
	background-size:cover; 
	background-repeat: no-repeat;
	margin-top:20px;
	
}

#login {
	width: 395px;
	height: 420px;
	margin: auto;
	position: absolute;
	left: 480px;
	top: 220px;
	background-image: url(image/center.jpg);
	background-repeat: no-repeat;
}

#login-titel {
	font-size: 30px;
	font-family: "微软雅黑";
	font-weight: bold; /*粗体*/
	color: white; /*字体颜色*/
	margin-top: 30px;
	margin-left: 125px;
}

#input {
	margin-top: 37px;
	margin-left: 80px;
}

#username {
	margin-top: 10px;
}

#password {
	margin-top: 18px;
}
/*输入框大小高度  */
#input input {
	height: 31px;
	width: 275px;
	font-size: 12px;
	/* 	border-radius:4px; */
}
/*  图片按扭*/
#btn {
	margin-top: 64px;
	margin-left: 46px;
	cursor: pointer;
}
</style>
<script type="text/javascript">
	function login() {
		document.loginForm.submit();
	}
</script>
</head>
<body>
	<div id="container">
		<jsp:include page="top.jsp"></jsp:include>
		<div id="loginbg">
			<div id="login">
				<div id="login-titel">
					<span>用户登录</span>
				</div>
				<div id="input">
					<form id="loginForm" action="/login" method="post">
						<div id="username">
							<input type="text" name="username" placeholder="请输入用户名">
						</div>
						<div id="password">
							<input type="password" name="password" placeholder="请输入密码">
						</div>
					</form>
				</div>
				<div>${error }</div>
				<div id="btn">
					<a id="abtn" onclick="document:loginForm.submit()"><img
						src="image/btn.jpg"></a>
				</div>
			</div>
		</div>
		<!-- 底部 -->
		<div
			style="height: 35px; background-color: #E0ECFF; text-align: center;">Copyright©
			tanqinghui 版权所有</div>
	</div>
</body>
</html>