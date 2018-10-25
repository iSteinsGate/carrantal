<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
table td {
	height: 30px;
	text-align: center;
}
</style>
<script type="text/javascript">
	$(function() {

		//页面加载完成后，创建数据表格datagrid
		$("#reserveGrid")
				.datagrid({
					//定义标题所有列
					columns : [ [ {
						title : 'ck',
						checkbox : true
					},  {
						title : '预约编号',
						field : 'id',
						width : 80,
						align : 'center'
					}, {
						title : '用户编号',
						field : 'uid',
						width : 130,
						align : 'center'
					}, {
						title : '车辆编号',
						field : 'cid',
						width : 130,
						align : 'center'
					}, {
						title : '预约时间',
						field : 'starttime',
						width : 150,
						align : 'center',
						formatter : function(value, row, index) {
							var unixTimestamp = new Date(value);
							return unixTimestamp.toLocaleString();
						}
					}, {
						title : '预计使用天数',
						field : 'estimateday',
						width : 130,
						align : 'center'
					}, {
						title : '预约状态',
						field : 'state',
						width : 130,
						align : 'center',
						formatter : function(value, row, index) {
							if (value == "0") {
								return "正在预约";
							} else if (value == "1") {
								return "预约成功";
							} else {
								return "预约失败";
							}
						}
					} ] ],
					//指定数据表格发送ajax请求的地址
					url : '${pageContext.request.contextPath }/reservelist',
					rownumbers : true,//显示行数
					//fitColumns: true,列少的时候,设置为true比较合适
					fit : true,//自适应
					border : false,
					//singleSelect : true,//只能选择一个
					//定义工具栏
					toolbar : [
							{
								text : '删除',
								iconCls : 'icon-remove',
								handler : function() {
									/* alert('remove...'); */
									//选择的那行记录
									var rows = $('#reserveGrid')
											.datagrid('getSelections');
									//alert(rows.length);
									if (rows.length == '0') {
										$.messager.alert('提示信息',
												'请选择记录', 'info');
									} else {
										$.messager.confirm(
											'删除确认',
											'你确定删除选中的记录?',
											function(flag) {
												if (flag) {
													//确认删除，发送请求
													var array = new Array();
													for (var i = 0; i < rows.length; i++) {
														var recode = rows[i];
														array
																.push(recode.id);
													}
													var ids = array
															.join(",");
													//alert(ids);
													location.href = "delete_reserve?ids="
															+ ids;
												}
											})
									}
								}
							}],
					//显示分页条
					pagination : true,
					//每行可以选择显示的记录数
					pageList : [ 5, 7, 10 ]
				})
	})
</script>
</head>
<body class="easyui-layout">
	<!-- 用户表格 -->
	<div region="center" border="false">
		<table id="reserveGrid"></table>
	</div>
</body>
</html>