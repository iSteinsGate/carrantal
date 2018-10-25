<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 1.logo -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--1.logo --%>
<div id="logo">
	<div class="top"><img src="image/logo.png" width="100%" height="100%"/></div>
	<div class="top"><img src="image/title.png" width="100%" height="100%"/></div>
	<div class="top" id="top2">
		<c:if test="${user!=null }">
			<a  data-options="menu:'#user-menu'" class="easyui-menubutton">我的用户</a>
			<div id="user-menu" style="display:none">
				<div><a href="/userinfo" >个人信息</a></div>
				<div><a href="/updateinfo">信息修改</a></div>
				<div class="menu-sep"></div>
				<div><a href="/exit">退出登录</a></div>
			</div>
			<a data-options="iconCls:'icon-help',menu:'#car-menu'" class="easyui-menubutton">我的租车</a>&nbsp;&nbsp;&nbsp;
			<div id="car-menu" style="display:none">
				<div><a href="/user_reserve?uid=${user.uid}">我的预约</a></div>
				<div><a href="/user_lease?uid=${user.uid }">我的租赁</a></div>
			</div>
		</c:if>
		<c:if test="${user==null }">
		<a href="/login">登录</a>&nbsp;&nbsp;|&nbsp;
		<a href="/register">注册</a>&nbsp;&nbsp;
		</c:if>
		<img src="image/tx.jpg" width="18px"/>&nbsp;12345678901
	</div>
	<div class="clear"></div>
</div>
<%-- 2.菜单栏 --%>
<div id="menu">
	<ul>
		<li><a href="${pageContext.request.contextPath }/" style="font-size:25px;">首页</a></li>
		<li><a href="#">公司简介</a></li>
		<li><a href="${pageContext.request.contextPath }/carlists">车辆展示</a></li>
		<li><a href="#">租车咨询</a></li>
		<li><a href="#">关于我们</a></li>
	</ul>
</div>
<%-- 3.搜索栏 --%>
<div id="search">
	<form action="${pageContext.request.contextPath }/searchcar" method="post">
		<input id="text-search" type="text" name="model" placeholder="Search">&nbsp;&nbsp;&nbsp;
		<button id="sub-search"type="submit" >开始搜索</button>
	</form>
</div>
<div class="clear"></div>