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
	table td{
		height:34px;
	}
</style>
<script type="text/javascript">
	$(function() {
		
		//页面加载完成后，创建数据表格datagrid
		$("#userGrid").datagrid({
			//定义标题所有列
			columns : [ [   {
				title : 'ck',
				checkbox : true
			}, 
			        {
				title : '用户编号',
				field : 'uid',
				width : 80,
				align : 'center'
			}, {
				title : '用户名',
				field : 'username',
				width : 130,
				align : 'center'
			}, {
				title : '密码',
				field : 'password',
				width : 130,
				align : 'center'
			}, {
				title : '真实姓名',
				field : 'realname',
				width : 130,
				align : 'center'
			}, {
				title : '电话',
				field : 'phone',
				width : 130,
				align : 'center'
			}, {
				title : '角色',
				field : 'role',
				width : 130,
				align : 'center'
			} ] ],
			//指定数据表格发送ajax请求的地址
			url : '${pageContext.request.contextPath }/userlist',
			rownumbers : true,//显示行数
			//fitColumns: true,列少的时候,设置为true比较合适
			fit : true,//自适应
			border : false,
			//singleSelect : true,//只能选择一个
			//定义工具栏
			toolbar : [ {
				text : '添加',
				iconCls : 'icon-add',
				//为按钮绑定单击事件
				handler : function() {
					/* 	alert('add...'); */
					$("#addUserWindow").window('open');
				}
			}, {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					/* alert('remove...'); */
					//选择的那行记录
					var rows = $('#userGrid').datagrid('getSelections');
					//alert(rows.length);
					if(rows.length=='0'){
						$.messager.alert('提示信息','请选择用户','warning');
					}else{
						$.messager.confirm('删除确认','你确定删除选中的用户?',function(flag){
							if(flag){
								//确认删除，发送请求
								var array = new Array();
								for(var i=0;i<rows.length;i++){
									var user=rows[i];
									array.push(user.uid);
								}
								var ids = array.join(",");
								//alert(ids);
								location.href="deleteusers?ids="+ids;
							}
						})
					}
				}
			}, {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					/* alert('edit...'); */
					//选择的那行记录
					var rows = $('#userGrid').datagrid('getSelections');
					var row = $('#userGrid').datagrid('getSelected');
					if(row==null || rows.length>1){
						$.messager.alert('提示','请选择一行','info');
					}else{
						//选择了一行，先加载数据 再打开窗口
						$("#updateUserForm").form('load',row);
						$("#updateUserWindow").window('open');
					}
					
				}
			}, {
				text : '查询',
				iconCls : 'icon-search',
				handler : function() {
					//alert('search...');
					$("#queryUserWindow").window('open');
				}
			} ],
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
			var flag = $("#addUserForm").form('validate');
			if (flag) {
				$("#addUserForm").submit();
				//关闭窗口
				$("#addUserWindow").window('close');
			}
		});
		//确定修改
		$("#update").click(function() {
			var flag = $("#updateUserForm").form('validate');
			if (flag) {
				$("#updateUserForm").submit();
				//关闭窗口
				//$("#updateUserWindow").window('close');
								
			}
		});
		//开始查找，jax请求数据，并刷新重新加载userGridb表
		$("#query").click(function(){
			var content = $("#content").val();
			var flag = $("#flag").val();
			//alert(content);
			//alert(flag);
			$("#queryUserWindow").window('close');
			$.ajax({
				url:"${pageContext.request.contextPath }/queryuser",
				data:{"content":content,"flag":flag},
				type:"post",
				dataType:"json",
				success:function(data){
					//alert(data.total);
					if(data.total=='0'){
						$.messager.confirm('提示','没有找到该用户，请重新输入！！',function(flag){
							if(flag){
								$("#queryUserWindow").window('open');
							}
						})
					}else{
						//刷新查询到的数据
						$("#userGrid").datagrid("loadData",{'total':data.total, 'rows':data.rows });
					}
				}
			});
		});
		
		var reg = /^1[3|4|5|7|8][0-9]{9}$/;
		//扩展手机号校验规则
		$.extend($.fn.validatebox.defaults.rules, {
			telephone : {
				validator : function(value, param) {
					return reg.test(value);
				},
				message : '手机号输入有误！'
			},
			equals : {
				validator : function(value, param) {
					return value == $(param[0]).val();
				},
				message : '两次输入密码不一致'
			}
		});
	});
</script>
</head>
<body class="easyui-layout">
	<!-- 用户表格 -->
	<div region="center" border="false">
		<table id="userGrid"></table>
	</div>
	<!-- 查询用户窗口 -->
	<div class="easyui-window" id="queryUserWindow" title="查询用户信息"
		collapsible="false" minimizable="false" closed="true" modal="true"
		resizable="false" maximizable="false" style="top: 60px; left: 420px;">
		<form id="queryUserForm"  method="post">
			<table class="table-edit" width="100%" align="center">
				<tr>
					<td><select id="flag"name="flag">
							<option value="1">根据姓名查找</option>
							<option value="0">根据电话号码查找</option>
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
	<!-- 添加用户窗口 -->
	<div class="easyui-window" id="addUserWindow" title="添加用户"
		collapsible="false" minimizable="false" closed="true" modal="true"
		resizable="false" maximizable="false" style="top: 40px; left: 320px;">
		<div region="center" style="overflow: auto; padding: 5px;"
			border="false">
			<!-- 用户添加表单 -->
			<form id="addUserForm" action="adduser" method="post">
				<table class="table-edit" width="100%" align="center">
					<tr class="title">
						<td colspan="2" align="center"><strong style="font-size:20px">用户信息</strong></td>
					</tr>
					<tr>
						<td>用户名：</td>
						<td><input type="text" name="username"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>密码：</td>
						<td><input type="password" id="pwd" name="password"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>确认密码：</td>
						<td><input type="password" id="repwd" name="name"
							validType="equals['#pwd']" class="easyui-validatebox"
							required="true" /></td>
					</tr>
					<tr>
						<td>真实姓名：</td>
						<td><input type="text" name="realname"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>手机号:</td>
						<td><input type="text" name="phone"
							data-options="validType:'telephone'" class="easyui-validatebox"
							required="true" /></td>
					</tr>
					<tr>
						<td>角色:</td>
						<td><input type="radio" name="role" value="用户"
							checked="checked">用户 <input type="radio" name="role"
							value="管理员">管理员</td>
					</tr>
					<tr height="35px">
						<td colspan="2" align="center"><input type="button"
							value="确定" id="add"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 修改用户窗口 -->
	<div class="easyui-window" id="updateUserWindow" title="修改用户信息"
		collapsible="false" minimizable="false" closed="true" modal="true"
		resizable="false" maximizable="false" style="top: 40px; left: 320px;">
		<div region="center" style="overflow: auto; padding: 5px;"
			border="false">
			<!-- 用户修改表单 -->
			<form id="updateUserForm" action="updateuser" method="post">
				<!-- 隐藏的uid -->
				<input type="hidden" name="uid">
				<table class="table-edit" width="100%" align="center">
					<tr class="title">
						<td colspan="2" align="center"><strong>用户信息</strong></td>
					</tr>
					<tr>
						<td>用户名：</td>
						<td><input type="text" name="username"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>密码：</td>
						<td><input type="password" id="pwd2" name="password"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>确认密码：</td>
						<td><input type="password" id="repwd" name="repassword"
							validType="equals['#pwd2']" class="easyui-validatebox"
							required="true" /></td>
					</tr>
					<tr>
						<td>真实姓名：</td>
						<td><input type="text" name="realname"
							class="easyui-validatebox" required="true" /></td>
					</tr>
					<tr>
						<td>手机号:</td>
						<td><input type="text" name="phone"
							data-options="validType:'telephone'" class="easyui-validatebox"
							required="true" /></td>
					</tr>
					<tr>
						<td>角色:</td>
						<td><input type="radio" name="role" value="用户" id="role"
							checked>用户 <input type="radio" name="role"
							value="管理员">管理员</td>
					</tr>
					<tr height="35px">
						<td colspan="2" align="center"><input type="button"
							value="确定" id="update"></td>
						<td colspan="2" align="center"><input type="reset"
							value="重置" ></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>