<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<title>汽车租赁系统</title>
</head>
	<style>
	body{
			margin:0px;
			padding:0px;
			font-size:12px;
			background-color:white;/*背景颜色*/
		}
		#container{
			border:0px solid red;
			width:1300px;
			margin:auto;/*居中  */
		}
		#lunbo{
		width:100%;
		height:500px;
		}
		#lunbo span{
			position:relative;/*相对定位*/
			bottom:350px;
			left:425px;
			font-size:50px;
			font-family:"华文楷体";
			/* font-weight:bold; */
		}
		#lunboicon ul li{
			list-style-type:circle;
			font-size: 40px;
			color:gray;
		}
		
		#icon1{
			position:absolute;
			left:650px;
			bottom:5px;
		}
		#icon2{
			position:absolute;
			left:700px;
			bottom:5px;
		}
		#icon3{
			position:absolute;
			left:750px;
			bottom:5px;
		}
		#hot{
			border:0px solid blue;
			width:1280px;
			height:37px;
			font-size:30px;
			fong-family:"宋体";
			padding-left:20px;
		}
		#product{
			border:0px solid black;
			width:100%;
			height:400px;
		}
		#product-left{
			border:0px solid red;
			width:378px;
			height:400px;
			float:left;
		}
		#product-right{
			border:0px solid green;
			width:916px;
			height:400px;
			float:left;
		}
		.item{
			border:0px solid blue;
			width:303px;
			height:200px;
			float:left;
		}
		.item-desc{
			position:relative;
			left:30px;
			color:gray;
		}
		.item-pic{
		position:relative;
		left:85px;
		width:220px;
		height:130px;
		}
		.item-pic:hover{/*鼠标移动上去*/
			left:70px;
		}
	</style>
<script type="text/javascript">
	$(function(){
		//初始icon颜色
		$("#icon1").css({"color":"black","list-style-type":"disc"});
		//轮播图 每隔2.5秒轮换
		var time = setInterval("changeImg()", 2500)
	})
	var i = 1;
	function changeImg(){
		i++;
		$("#lunboimg").attr("src","image/lunbo"+i+".jpg");
		//icon颜色变化
		$("#icon"+i).css({"color":"black","list-style-type":"disc"});
		if(i!=1){
			$("#icon1").css({"color":"gray","list-style-type":"circle"});
		}
		if(i!=2){
			$("#icon2").css({"color":"gray","list-style-type":"circle"});
		}
		if(i!=3){
			$("#icon3").css({"color":"gray","list-style-type":"circle"});
		}
		if(i==3){
			i=0;
		}
	}
</script>
<body>
	<div id="container">
		<%-- 1.top --%>
		<jsp:include page="top.jsp"></jsp:include>
		<!-- 3.轮播图 -->
		<div id="lunbo">
			<img id="lunboimg" src="image/lunbo1.jpg"width="100%" height="500px"/>
			<span id="lunbo2">你的需求,就是我们的追求!</span>
		</div>
		<%--轮播下的切换 --%>
		<div id="lunboicon">
			<ul >
			<li id="icon1" ></li>
			<li id="icon2" ></li>
			<li id="icon3" ></li>

			</ul>
		</div>
		<!-- 4.热门推荐 -->
		<div id="hot">
			<span style="font-size:20px;">热门推荐</span>
			<img  src="image/hot.jpg"/>
		</div>
		<!-- 5.推荐商品 -->
		<div id="product">
			<div id="product-left"><img src="image/product-left.jpg" width=100% height=100%></div>
			<div id="product-right">
			<c:forEach items="${carList }" var="car">
				<!-- 单个商品 -->
				<div class="item">
					<div><img src="image/icon.png">
					<span style="font-size:20px;font-family:'微软雅黑';margin-left:-25px;">${car.model }</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span style="color:#ED701D;text-align:right;font-size:25px;">￥${car.price }</span>/天起
					</div>
					<span class="item-desc">${car.description}</span>
					<div class="item-pic">
					<a href="${pageContext.request.contextPath }/carinfo?cid=${car.cid }"><img src="${car.picture }" width="220px" height="130px"/></a>
					</div>
				</div>
			</c:forEach>
			</div>
			<div class="clear">
			</div>
		</div>
		
		<%-- 底部 --%>
		<div style="height: 45px;background-color:#E0ECFF;text-align:center;margin-top:25px;"><br>Copyright© tanqinghui 版权所有</div>
	</div>
</body>
</html>