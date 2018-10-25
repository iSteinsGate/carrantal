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
<script type="text/javascript">
	$(function() {
		//显示的列
		var columns =[ [
		                
					{
						title : 'ck',
						checkbox : true
					},
					{
						title : '汽车编号',
						field : 'cid',
						width : 100,
						align : 'center'
					},
					{
						title : '车牌号',
						field : 'number',
						width : 120,
						align : 'center'
					},
					{
						title : '品牌',
						field : 'brand',
						width : 100,
						align : 'center'
					},
					{
						title : '型号',
						field : 'model',
						width : 110,
						align : 'center'
					},
					{
						title : '图片',
						field : 'picture',
						width : 130,
						align : 'center',
						//图片显示
						formatter : function(value, row, index) {
							  
							return '<img width="60px" height="50px" border="0" src="${pageContext.request.contextPath}/'+value+'"/>';
						}
					}, {
						title : '描述',
						field : 'description',
						width : 150,
						align : 'center'
					}, {
						title : '价格(元/天)',
						field : 'price',
						width : 100,
						align : 'center'
					}, {
						title : '押金（元）',
						field : 'deposit',
						width : 100,
						align : 'center'
					} ,
					{
						title : '状态',
						field : 'state',
						width : 100,
						align : 'center',
						//出租显示
						formatter : function(value, row, index) {
							//1:表示已经出租 0：表示未出租
							if(value=="1"){
								return "已经出租";
							}else{
								return "未出租";
							} 
						}
					}] ];
		//工具栏
		var toolbar =[ {
			text : '添加',
			iconCls : 'icon-add',
			//为按钮绑定单击事件
			handler : function() {
				$("#addCarWindow").window('open');
			}
		}, {
			text : '删除',
			iconCls : 'icon-remove',
			handler : function() {
				/* alert('remove...'); */
				//选择的那行记录
				var rows = $('#carGrid').datagrid('getSelections');
				if(rows.length=='0'){
					$.messager.alert('提示信息','请选择汽车','info');
				}else{
					$.messager.confirm('删除确认','你确定删除选中的车辆?',function(flag){
						if(flag){
							//确认删除，发送请求
							var array = new Array();
							for(var i=0;i<rows.length;i++){
								var car=rows[i];
								array.push(car.cid);
							}
							var ids = array.join(",");
							alert(ids);
							location.href="deletecar?ids="+ids;
						}
					})
				}
			}
		}, {
			text : '修改',
			iconCls : 'icon-edit',
			handler : function() {
				var rows = $('#carGrid').datagrid('getSelections');
				var row = $('#carGrid').datagrid('getSelected');
				if(row==null || rows.length>1){
					$.messager.alert('提示','请选择一行','info');
				}else{
					//选择了一行，先加载数据 再打开窗口
					$("#updateCarWindow").form('load',row);
					//显示图片
					$(".carpicture").attr("src",row.picture)
					$("#updateCarWindow").window('open');
				}
				
			}
		}, {
			text : '查询',
			iconCls : 'icon-search',
			handler : function() {
				//alert('search...');
				$("#queryCarWindow").window('open');
			}
		} ];
		
	//页面加载完成后，创建数据表格datagrid
	$("#carGrid").datagrid({
			//指定数据表格发送ajax请求的地址
			url : '${pageContext.request.contextPath }/carlist',
			//定义标题所有列
			columns : columns,
			rownumbers : true,//显示行数
			fit : true,//自适应
			border : false,
			//singleSelect : true,//只能选择一个
			//定义工具栏
			toolbar : toolbar,
			//显示分页条
			pagination : true,
			//每行可以选择显示的记录数
			pageList : [ 5, 7, 10 ]
		})
	})
</script>
<script type="text/javascript">
	$(function() {
		//确认添加
		$("#add").click(function() {
			var flag = $("#addCarForm").form('validate');
			if (flag) {
				$("#addCarForm").submit();
				//关闭窗口
				$("#addCarForm").window('close');
			}
		});
		//确定修改
		$("#update").click(function() {
			var flag = $("#updateCarForm").form('validate');
			if (flag) {
				$("#updateCarForm").submit();
				//关闭窗口
				$("#updateCarForm").window('close');
			}
		});
		//开始查找
		//开始查找，jax请求数据，并刷新重新加载userGridb表
		$("#query").click(function(){
			var content = $("#content").val();
			var flag = $("#flag").val();
			//alert(content);
			//alert(flag);
			$("#queryCarWindow").window('close');
			$.ajax({
				url:"${pageContext.request.contextPath }/querycar",
				data:{"content":content,"flag":flag},
				type:"post",
				dataType:"json",
				success:function(data){
					alert(data.total);
					if(data.total=='0'){
						$.messager.confirm('提示','没有找到该车，请重新输入！！',function(flag){
							if(flag){
								$("#queryCarWindow").window('open');
							}
						})
					}else{
						//刷新查询到的数据
						$("#carGrid").datagrid("loadData",{'total':data.total, 'rows':data.rows });
					}
				}
			});
		});
	});
</script>
</head>
<body class="easyui-layout">
	<!-- 汽车表格 -->
	<div region="center" border="false">
		<table id="carGrid"></table>
	</div>
	<!-- 查询车辆窗口 -->
	<div class="easyui-window" id="queryCarWindow" title="查询用户信息"
		collapsible="false" minimizable="false" closed="true" modal="true"
		resizable="false" maximizable="false" style="top: 60px; left: 420px;">
		<form id="queryUserForm"  method="post">
			<table class="table-edit" width="100%" align="center">
				<tr>
					<td><select id="flag"name="flag">
							<option value="0">根据车牌号查找</option>
							<option value="1">根据车名查找</option>
					</select>
					</td>
				</tr>
				<tr>
					<td><input type="text" name="content" id="content"></td>
				</tr>
				<tr align="center">
					<td><input type="button" value="开始查找" id="query"></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 添加车辆窗口 -->
	<div class="easyui-window" id="addCarWindow" title="添加车辆"
		collapsible="false" minimizable="false" closed="true" modal="true"
		resizable="false" maximizable="false" style="top: 40px; left: 320px;">
		<div region="center" style="overflow: auto; padding: 5px;"
			border="false">
			<!-- 车辆添加表单 -->
			<!-- enctype="multipart/form-data"：上传图片 -->
			<form id="addCarForm" action="addcar" method="post"
				enctype="multipart/form-data">
				
				<table class="table-edit" width="100%" align="center">
					<tr class="title">
						<td colspan="2" align="center"><strong>车辆信息信息</strong></td>
					</tr>
					<tr>
						<td width="65px;">车牌号：</td>
						<td><input type="text" name="number"
							class="easyui-validatebox"  required="true" /></td>
					</tr>
					<tr>
						<td>品牌：</td>
						<td><input type="text" id="pwd2" name="brand"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>型号：</td>
						<td><input type="text" id="repwd" name="model"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>图片:</td>
						<td>
							<!-- 上传图片 --> 
							<input type="file" name="pictureFile"/></td>
					</tr>
					<tr>
						<td>描述:</td>
						<td><input type="text" name="description"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>价格(元/天):</td>
						<td><input type="text" name="price"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>押金(元):</td>
						<td><input type="text" name="deposit"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>出租状态:</td>
						<td><input type="radio" name="state" value="1"
							>已经出租 <input type="radio" name="state"
						   checked value="0">未出租</td>
					</tr>
					<tr height="35px">
						<td colspan="2" align="center"><input type="button"
							value="确定" id="add"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 修改车辆窗口 -->
	<div class="easyui-window" id="updateCarWindow" title="修改车辆"
		collapsible="false" minimizable="false" closed="true" modal="true"
		resizable="false" maximizable="false" style="top: 20px; left: 320px;">
		<div region="center" style="overflow: auto; padding: 5px;"
			border="false">
			<!-- 车辆修改表单 -->
			<!-- enctype="multipart/form-data"：上传图片 -->
			<form id="updateCarForm" action="updatecar" method="post"
				enctype="multipart/form-data">
				<!-- 隐藏的cid -->
				<input type="hidden" name="cid">
				<table class="table-edit" width="100%" align="center">
					<tr class="title">
						<td colspan="2" align="center"><strong>车辆信息信息</strong></td>
					</tr>
					<tr>
						<td width="65px;">车牌号：</td>
						<td><input type="text" name="number"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>品牌：</td>
						<td><input type="text" id="pwd2" name="brand"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>型号：</td>
						<td><input type="text" id="repwd" name="model"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>图片:</td>
						<td><input type="hidden" name="picture" value="">
						<img width="60px" height="50px" border="0" class="carpicture">
						
							<!-- 上传图片 --> <input type="file" name="pictureFile"/></td>
					</tr>
					<tr>
						<td>描述:</td>
						<td><input type="text" name="description"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>价格(元/天):</td>
						<td><input type="text" name="price"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>押金(元):</td>
						<td><input type="text" name="deposit"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>出租状态:</td>
						<td><input type="radio" name="state" value="1"
							>已经出租 <input type="radio" name="state"
							value="0">未出租</td>
					</tr>
					<tr height="35px">
						<td colspan="2" align="center"><input type="button"
							value="确定" id="update"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>