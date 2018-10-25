<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>汽车租赁系统</title>
</head>
<style>
body {
	margin: 0px;
	padding: 0px;
	font-size: 12px;
	background-color: white; /*背景颜色*/
}

#container {
	/* border:1px solid red; */
	width: 1300px;
	height: 625px;
	margin: auto; /*居中  */
}
#carlogo{
	width:1300px;
	height:90px;
	margin-top:10px;
}
#carlist {
	border: 0px solid gray;
	width: 1300px;
	height: 50px;
	font-size: 5px;
	margin-top:5px;
	background-color:#E0ECFF;
}
#carlist-left{
	width:200px;
	height:35px;
	border:0px solid red;
	float:left;
	margin-left:46px;
	text-align:right;
	margin-top:13px;
}
#carlist-left span{
	font-size:23px;
	font-weight:bold;
}
#carlist-right{
	width:950px;
	height:50px;
	border:0px solid black;
	float:left;
}
#carlist ul li {
	display: inline; /*显示在一行*/
	margin-left: 45px;
}

/* 品牌字位置 */
#bran_bmw{
	position:relative;
	bottom:12px;
	left:12px;
	font-size:15px;
}
#bran_feng{
	position:relative;
	bottom:12px;
	left:12px;
	font-size:15px;
}
#bran_vw{
	position:relative;
	bottom:12px;
	left:12px;
	font-size:15px;
}
#bran_aodi{
	position:relative;
	bottom:12px;
	left:12px;
	font-size:15px;
}
#hot {
	width: 1280px;
	height: 37px;
	/* border:1px solid blue; */
	font-size: 30px;
	fong-family: "宋体";
	padding-left: 20px;
}

#product {
	/* border:1px solid black; */
	width: 100%;
	/* height: 400px; */
}

.item {
	border: 1px solid gray;
	width: 290px;
	height: 185px;
	float: left;
	margin-left: 25px;
	margin-top: 10px;
}

.content {
	padding-left: 30px;
	padding-top: 20px;
}
/*汽车的描述*/
.item-desc {
	position: relative;
	left: 30px;
	color: gray;
}
/*汽车图片的位置*/
.item-pic {
	position: relative;
	left: 75px;
	width: 220px;
	height: 130px;
}
/*鼠标移动上去*/
.item-pic:hover {
	/*汽车变大*/
	/* transform:scale(1.1); */
	/*左移*/
	left: 60px;
}

.rent {
	width:110px;
	height:35px;
	position: relative;
	bottom: 48px;
	left: 90px;
	font-size: 25px;
}

#page {
	height: 30px;
	font-size: 15px;
	text-align: center;
	margin-top:20px;
}
</style>
<body>
	<div id="container">
		<%-- 1.top --%>
		<jsp:include page="top.jsp"></jsp:include>
		<%--logo --%>
		<div id="carlogo">
			<img src="image/logocar.jpg" width="100%" height="100%">
		</div>
		<%--品牌选择栏 --%>
		<div id="carlist">
		<div id="carlist-left">
			<span>品&nbsp;牌&nbsp;选&nbsp;择</span>
		</div>
		<div id="carlist-right">
			<ul>
				<li><a
					href="${pageContext.request.contextPath }/carlists?brand=0"><img src="images/bmwicon.jpg" width="33px" height="33px"><span id="bran_bmw">宝马</span></a></li>
				<li><a
					href="${pageContext.request.contextPath }/carlists?brand=2"><img src="images/fengicon.jpg" width="30px" height="30px"><span id="bran_feng">丰田</span></a></li>
				<li><a
					href="${pageContext.request.contextPath }/carlists?brand=1"><img src="images/vwicon.jpg" width="30px" height="30px"><span id="bran_vw">大众</span></a></li>
				<li><a
					href="${pageContext.request.contextPath }/carlists?brand=3"><img src="images/aodiicon.jpg" width="60px" height="30px"><span id="bran_aodi">奥迪</span></a></li>
			</ul>
		</div>
		</div>
		<%-- 5.汽车列表 --%>
		<div id="product">
			<c:forEach items="${pageBean.rows }" var="car">
				<div class="item">
					<div class="content">
						<span
							style="font-family: '微软雅黑'; margin-left: -2px; font-size: 15px;">${car.model }</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<span style="color: #ED701D; text-align: right; font-size: 20px;">￥${car.price }</span>/天起
					</div>
					<span class="item-desc">${car.description }</span>
					<div class="item-pic">
						<img src="${car.picture }" width="150px" height="80px" />
					</div>
					<div class="rent">
						<a href="/carinfo?cid=${car.cid }">租车详情</a>
					</div>
				</div>
			</c:forEach>
			<div class="clear"></div>

		</div>
		<%-- 分页 --%>
		<div id="page">
			<%-- 上一页 --%>
			<c:if test="${pageBean.currentPage!=1 }">
				<a
					href="${pageContext.request.contextPath }/carlists?page=${pageBean.currentPage-1 }">&lt;上一页</a>&nbsp;&nbsp;&nbsp
			</c:if>
			<%-- 页数 --%>
			<c:forEach begin="1" end="${pageBean.pageCount }" var="currentPage">
				<%-- 判断是否是当前页 ,当前页不能点--%>
				<c:if test="${pageBean.currentPage==currentPage }">
					<a href="javascript:void(0);" style="color: gray;">[${currentPage }]</a>&nbsp;&nbsp;&nbsp
				</c:if>
				<%-- 不是当前页 --%>
				<c:if test="${pageBean.currentPage!=currentPage }">
					<a
						href="${pageContext.request.contextPath }/carlists?page=${currentPage }">[${currentPage }]</a>&nbsp;&nbsp;&nbsp
				</c:if>
			</c:forEach>
			<%-- 下一页 --%>
			<c:if test="${pageBean.currentPage!=pageBean.pageCount }">
				<a
					href="${pageContext.request.contextPath }/carlists?page=${pageBean.currentPage+1 }">下一页&gt;</a>&nbsp;&nbsp;&nbsp
			</c:if>
		</div>
		<%-- 底部 --%>
		<div
			style="height: 45px; background-color: #E0ECFF; text-align: center;"><br>Copyright©
			tanqinghui 版权所有</div>
	</div>
</body>
</html>