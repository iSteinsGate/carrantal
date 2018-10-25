<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

<title>用户的租赁界面</title>
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
		#reverse{
			height:485px;
			background-image: url("image/carbg.jpg");
			background-repeat: no-repeat;
			background-size:cover;
		}
		#content{
			width:390px;
			height:460px;
			margin-top:15px;
			margin-left:450px;
			font-size:15px;
		}
		#content table{
			background-color: #FFFFFF;
		}
		#reservetable{
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
			height:35px;
			width:150px;
		}
</style>
<script type="text/javascript">
	$(function(){
		/* 重新预约 */
		$("#reLease").click(function(){
			location.href="${pageContext.request.contextPath }/carlists";
		})
		/* 去归还 */
		$("#return").click(function(){
			location.href="${pageContext.request.contextPath }/user_return?id=${recode.id}";
		})
		/*计算费用  */
		$("#getCost").click(function(){
			$.ajax({
				url:"${pageContext.request.contextPath }/service_lease?id=${recode.id}",
				type:"post",
				success:function(data){
					$.messager.alert('费用',"使用费用为："+data+"元",'info');
				}
			})
		})
	})
</script>
</head>
<body>
	<div id="container">
		<!-- 头部 -->
		<jsp:include page="top.jsp"></jsp:include>

		<c:if test="${recode==null }">
			<div style="height:50px;text-align:center;"><h2>您还没有租车</h2></div>
		</c:if>
		<c:if test="${recode!=null }">
			<!-- 预约信息-->
			<div id="reverse">
				<div id="content">
					<form id="reverseCarForm" action="reversecar" method="post">
					<div id="reservetable">
						<table class="table-edit" height="300px" align="center"
							border="1px" cellpadding="0px" cellspacing="0px">
							<tr class="title">
								<td colspan="2" align="center"><strong>租赁信息</strong></td>
							</tr>
							<tr>
								<td width="65px;">车牌号：</td>
								<td>${recode.car.number }</td>
							</tr>
							<tr>
								<td>品牌：</td>
								<td>${recode.car.brand }</td>
							</tr>
							<tr>
								<td>型号：</td>
								<td>${recode.car.model }</td>
							</tr>
							<tr>
								<td>图片:</td>
								<td><img width="60px" height="50px" border="0"
									src="${recode.car.picture }"></td>
							</tr>
							<tr>
								<td>特点:</td>
								<td>${recode.car.description }</td>
							</tr>
							<tr>
								<td>价格(元/天):</td>
								<td>${recode.car.price }</td>
							</tr>
							<tr>
								<td>押金(元):</td>
								<td>${recode.car.deposit }</td>
							</tr>
							<tr>
								<td>租赁日期:</td>
								<td><fmt:formatDate value="${recode.starttime }"
										pattern="yyyy-MM-dd HH:mm:ss" /></td>
							</tr>
							<tr>
								<td>预计使用天数:</td>
								<td>${recode.estimateday}</td>
							</tr>
							<tr>
								<td>租赁状态:</td>
								<td>${recode.state }</td>
							</tr>
							<tr align="center">
								
								<c:if test="${recode.state=='正在用车' }">
								<td align="center">
									<input id="getCost"type="button" value="计算费用"></td>
								<td align="center">
									<input id="return"type="button" value="去归还"></td>
									
								</c:if>
								<c:if test="${recode.state=='请求还车' }">
									<td colspan="2" align="center">正在请求归还，请等候...</td>
								</c:if>
								<c:if test="${recode.state=='已还车' }">
									<td colspan="2"align="center"><input id="reLease"type="button" value="重新预约"></td>
								</c:if>
							</tr>
						</table>
						</div>
					</form>
				</div>
			</div>
		</c:if>
		<!-- 底部 -->
		<div style="height: 35px;background-color:#E0ECFF;text-align:center;margin-top:10px;">Copyright© tanqinghui 版权所有</div>
	</div>
</body>
</html>