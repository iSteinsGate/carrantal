<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>汽车租赁管理系统</title>
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
<style type="text/css">
#title {
	font-size: 50px;
	font-style: italic; /*字体斜体*/
	font-family: "微软雅黑";
	font-weight: bold; /*粗体*/
	color: white; /*字体颜色*/
	text-indent: 330px; /*开头距离*/
	letter-spacing: 25px; /*字体间距*/
}
</style>
<script type="text/javascript">
	$(function() {
		//页面加载完成后，执行这段代码----动态创建ztree
		var setting = {
			data : {
				simpleData : {
					enable : true
				//使用简单json数据构造ztree节点
				}
			},
			callback:{
				//为ztree节点绑定单击时间
				onClick:onClick
			}
		};
		//基本管理节点数据
		var baseNodes=[
					{"name":"用户信息", "page":"page_userlist"},
					{"name":"车辆信息", "page":"page_carlist"},
					{"name":"预约信息", "page":"page_reservelist"},
					{"name":"租赁信息", "page":"page_leaselist"},
					{"name":"归还信息", "page":"page_returnlist"},
					];
		//业务办理节点数据
		var businessNodes=[
					{"name":"预约处理", "page":"page_reserve"},
					{"name":"租赁处理", "page":"page_return"}
						];
		
		//调用API初始化ztree
		$.fn.zTree.init($("#baseMenu"), setting, baseNodes);
		$.fn.zTree.init($("#businessMenu"), setting, businessNodes);
	});
	//添加选项卡
	function onClick(event,treeId,treeNode){
		var e = $("#tabs").tabs("exists",treeNode.name);
		//如果该选项卡已经存在就不用添加了
		if(e){
			$("#tabs").tabs("select",treeNode.name)
		}
		else{
			$("#tabs").tabs('add',{
				title:treeNode.name, 
				content:'Tab Body', 
				closable:true,
				//请求的页面内容
				content:'<iframe frameborder="0" height="100%" width="100%" src="'+treeNode.page+'"></iframe>'
				}
			)
		}
	}
</script>
</head>
<body class="easyui-layout">
	<%-- 使用div元素描述每个区域 --%>
	<div data-options="region:'north',border:false"
		style="height: 100px; padding: 10px; background-color: #2EAFBB;">
		<div id="title">汽车租赁管理系统</div>
		<div style="position: absolute; right: 185px; top: 54px;">
			<c:if test="${admin!=null }">
			[<strong>${admin.realname }</strong>],欢迎您！
			</c:if>
		</div>
		<div>
		<div id="adminMenu" style="display:none">
			<div><a >修改密码</a></div>
			<div class="menu-sep"></div>
			<div><a href="/exit">退出登录</a></div>
		</div>
			<a href="/exit" data-options="iconCls:'icon-help',menu:'#adminMenu'"class="easyui-menubutton" style="position: absolute; right: 80px; top: 50px;">控制面板</a>
		</div>
	</div>
	<%-- 左侧菜单栏 --%>
	<div data-options="region:'west',border:false" title="系统菜单" style="width: 160px;overflow:auto">
		<div class="easyui-accordion" fit="true">
			<div title="基本信息" data-options="iconCls:'icon-mini-add'">
				<ul id="baseMenu" class="ztree"></ul>
			</div>
			<div title="业务办理" data-options="iconCls:'icon-mini-add'">
				<ul id="businessMenu" class="ztree"></ul>
			</div>
		</div>
	</div>
	<div data-options="region:'center',border:false" style="overflow: auto">
	<%-- 选项卡 --%>
	<div id="tabs" class="easyui-tabs" data-options="fit:true">
		<div title="首页" style="text-align:center">欢迎使用汽车租赁系统！！</div>
	</div>
	</div>
	<div data-options="region:'south',border:false" style="height: 50px;background-color:#E0ECFF;text-align:center;">Copyright© tanqinghui 版权所有</div>
</body>
</html>