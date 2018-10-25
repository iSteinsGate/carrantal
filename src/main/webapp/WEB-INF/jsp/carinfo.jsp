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
<title>预约界面</title>
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
			top:175px;
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
</style>
<script type="text/javascript">
	$(function(){
		$("#reservebtn").click(function(){
			$("#reserveCarWindow").window("open");
		})
		$("#startbtn").click(function(){
			var flag = $("#reserveCarForm").form("validate");
			//alert(flag);
			if(flag){
				$("#reserveCarForm").submit();
			}
		})
	})
</script>
</head>
<body>
	<div id="container">
		<!-- 头部 -->
		<jsp:include page="top.jsp"></jsp:include>
		<div id="car">
			<div id="content">
			<!-- 车辆信息-->
			<form id="reverseCarForm" action="reversecar" method="post">
				<!-- 隐藏的cid -->
				<input type="hidden" name="cid">
				<div id="cartable">
				<table  align="center" border="1px" cellpadding="0px" cellspacing="0px">
					<tr>
						<td colspan="2"><h2>${car.model }</h2></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
						<img width="200px" height="110px" src="${car.picture }">
						</td>
					</tr>
					<tr>
						<td width="65px;">车牌号：</td>
						<td>${car.number }</td>
					</tr>
					<tr>
						<td>品牌：</td>
						<td>${car.brand }</td>
					</tr>
					<tr>
						<td>特点:</td>
						<td>${car.description }</td>
					</tr>
					<tr>
						<td>价格(元/天):</td>
						<td>${car.price }</td>
					</tr>
					<tr>
						<td>押金(元):</td>
						<td>${car.deposit }</td>
					</tr>
					<tr height="35px">
						<td colspan="2" align="center"><input type="button"
							value="立即预定" id="reservebtn" style="font-size:16px;color:#FFFFFF;background-color:#65A5E1;"></td>
					</tr>
				</table>
				</div>
			</form>
			</div>
		</div>
		<!-- 底部 -->
		<div style="height: 35px;background-color:#E0ECFF;text-align:center;margin-top:10px;">Copyright© tanqinghui 版权所有</div>
	</div>
	<!-- 预约订单 -->
	<!-- 查询车辆窗口 -->
	<div class="easyui-window" id="reserveCarWindow" title="填写预约订单"
		collapsible="false" minimizable="false" closed="true" modal="true"
		resizable="false" maximizable="false" style="top: 250px; left: 550px;">
		<form id="reserveCarForm"  method="post" action="/reserve">
			<input type="hidden" name="cid" value="${car.cid }">
			<input type="hidden" name="uid" value="${user.uid }">
			<table   height="100px"align="center">
				<tr>
					<td>预约日期:</td>
					<td><input type="datetime-local" name="starttime"class="easyui-validatebox" required="true"></td>
				</tr>
				
				<tr>
					<td>预计使用天数:</td>
					<td><input type="text"  name="estimateday"class="easyui-validatebox" required="true"></td>
				</tr>
				<tr align="center">
					<td colspan="2"><input type="button" value="开始预约" id="startbtn"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>