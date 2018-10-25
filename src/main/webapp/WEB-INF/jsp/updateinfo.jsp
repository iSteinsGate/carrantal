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
	href="${pageContext.request.contextPath }/css/top.css"
	type="text/css" />
<title>修改用户信息</title>
<style type="text/css">
body{
			margin:0px;
			padding:0px;
			font-size:12px;
			background-color:white;/*背景颜色*/
		}
	#container{
		width:1300px;
		margin:auto;/*居中  */
		}
		#car{
			height:460px;
			background-image: url("image/carbg.jpg");
			background-repeat: no-repeat;
			background-size:cover;
		}
		#content{
			width:390px;
			height:420px;
			margin-top:15px;
			margin-left:450px;
			font-size:15px;
		}
		#reservebtn:hover{
			cursor:pointer;
		}
		#content table{
			background-color: #FFFFFF;
		}
		#cartable{
			width:390px;
			height:380px;
			position:absolute;
			left:450px;
			top:250px;
		}
		#content tr{
		text-align:center;
		}
		#content td{
			height:40px;
			width:150px;
		}
		.easyui-window td{
			height:40px;
		}
		input{
			height:30px;
		}
</style>
</head>
<body>
	<div id="container">
		<!-- 头部 -->
		<jsp:include page="top.jsp"></jsp:include>
		<div id="car">
			<div id="content">
			<!-- 修改用户信息-->
			<form id="updateuserform" action="user_update" method="post">
				<div id="cartable">
				<input type="hidden" name="uid" value="${user.uid }">
				<table  align="center" border="1px" cellpadding="0px" cellspacing="0px">
					<tr>
						<td colspan="2"><h2>个人信息</h2></td>
					</tr>
					<tr>
						<td width="65px;">用户名：</td>
						<td><input type="text" name="username" value="${user.username}"></td>
					</tr>
					<tr>
						<td>密码：</td>
						<td><input type="text" name="password" value="${user.password}"></td>
					</tr>
					<tr>
						<td>电话号码:</td>
						<td><input type="text" name="phone" value="${user.phone }"></td>
					</tr>
					<tr>
						<td>真实姓名:</td>
						<td><input type="text" name="realname" value="${user.realname }"></td>
					</tr>
					<tr>
						<td><input type="submit" value="确定修改"></td>
						<td><input type="reset" value="重置"></td>
					</tr>
				</table>
				</div>
			</form>
			</div>
		</div>
		<!-- 底部 -->
		<div style="height: 35px;background-color:#E0ECFF;text-align:center;margin-top:10px;">Copyright© tanqinghui 版权所有</div>
	</div>
</body>
</html>