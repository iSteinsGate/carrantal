<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>处理归还</title>
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
		$("#leaseGrid").datagrid({
			//定义标题所有列
			columns : [ [{
				title:'ck',
				checkbox : true
			}, {
				title : '归还编号',
				field : 'id',
				width : 80,
				align:'center'
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
				title : '开始使用时间',
				field : 'starttime',
				width : 150,
				align : 'center',
				  formatter:function(value,row,index){ 
                      var time = new Date(value); 
                     return time.toLocaleString();
				  }
			}, {
				title : '预计使用天数',
				field : 'estimateday',
				width : 130,
				align : 'center'
			}, {
				title : '租赁状态',
				field : 'state',
				width : 130,
				align : 'center',
				 formatter:function(value,row,index){  
	                    if(value=="0"){
	                    	return "未还车";
	                    }else if(value=="1"){
	                    	return "请求归还";
	                    }else{
	                    	return "已还车";
	                    }
	                 } 
			} ] ],
			//指定数据表格发送ajax请求的地址
			url : '${pageContext.request.contextPath }/leaselist',
			rownumbers : true,//显示行数
			//fitColumns: true,列少的时候,设置为true比较合适
			fit : true,//自适应
			border : false,
			//singleSelect : true,//只能选择一个
			//定义工具栏
			toolbar : [ {
				text : '计算费用',
				iconCls : 'icon-edit',
				handler : function() {
					//选择的那行记录
					var rows = $('#leaseGrid').datagrid('getSelections');
					var row = $('#leaseGrid').datagrid('getSelected');
					if(row==null || rows.length>1){
						$.messager.alert('提示','请选择一行','info');
					}else{
						//选择了一行
						$.messager.confirm('处理确认','确定计算费用?',function(flag){
							if(flag){
								//确认处理，发送请求
								var id = row.id;
								$.ajax({
									url:"${pageContext.request.contextPath }/service_lease?id="+id,
									type:"post",
									success:function(data){
										$.messager.alert('费用',"使用费用为："+data+"元",'info');
									}
								})
								
							}
						})
					}
				}
			} ,{
				text : '处理还车',
				iconCls : 'icon-edit',
				handler : function() {
					/* alert('edit...'); */
					//选择的那行记录
					var rows = $('#leaseGrid').datagrid('getSelections');
					var row = $('#leaseGrid').datagrid('getSelected');
					if(row==null || rows.length>1){
						$.messager.alert('提示','请选择一行','info');
					}else{
						//选择了一行
						$.messager.confirm('处理确认','确定该用户还车?',function(flag){
							if(flag){
								//确认处理，发送请求
								var id = row.id;
								$.ajax({
									url:"${pageContext.request.contextPath }/service_lease?id="+id,
									type:"post",
									success:function(data){
										//赋值隐藏uid，cid的值
										$("input[name='uid']").attr("value",row.uid);
										$("input[name='cid']").attr("value",row.cid);
										//
										$("#cost").attr("value",data);
										$("#totalcost").attr("value",data);
										$("#returnWindow").window('open');
									}
								})
							}
						})
					}
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
	$(function(){
		
		var reg = /^\d+$/;
		//扩展数字校验规则
		$.extend($.fn.validatebox.defaults.rules, {
			cost : {
				validator : function(value, param) {
					return reg.test(value);
				},
				message : '输入有误！'
			}
		});
		//输入改变时，总费用改变
		$(":input").change(function(){
			var gasolinecost = $("input[name='gasolinecost']").val();
			var damagecost = $("input[name='damagecost']").val();
			var usecost = $("input[name='usecost']").val();
			var totalcost = Number(usecost)+Number(damagecost)+Number(gasolinecost);
			$("#totalcost").attr("value",totalcost); 
			})
			
		//处理归还
		$("#return").click(function() {
			var flag = $("#returnForm").form('validate');
			if(flag){
				$("#returnForm").submit();
				//关闭窗口
				$("#returnWindow").window('close');
			}
		})
	})
</script>
</head>
<body class="easyui-layout">
	<!-- 用户表格 -->
	<div region="center" border="false">
		<table id="leaseGrid"></table>
	</div>
	<!-- 处理归还窗口 -->
	<div class="easyui-window" id="returnWindow" title="归还处理"
		collapsible="false" minimizable="false" closed="true" modal="true"
		resizable="false" maximizable="false" style="top: 60px; left: 420px;">
		<form id="returnForm" method="post" action="${pageContext.request.contextPath }/service_return">
			<!-- 隐藏uid cid -->
			<input type="hidden" name="uid">
			<input type="hidden" name="cid">
			<table class="table-edit" width="300px" align="center">
				<tr align="center">
					<td colspan="2"><Strong>请输入费用:</Strong></td>
				</tr>
				<tr>
				<td>车辆使用费(元)：</td>
						<td><input type="text" id="cost" name="usecost" readonly="readonly"/></td>
				</tr>
				<tr>
				<td>请输入油费(元)：</td>
						<td><input type="text" name="gasolinecost" validType="cost"
							class="easyui-validatebox" required="true" value="0"/></td>
				</tr>
				<tr>
				<td>请输入破损费(元)：</td>
						<td><input type="text" name="damagecost" validType="cost"
							class="easyui-validatebox" required="true" value="0"/></td>
				</tr>
				<tr>
				<td>总费用(元)：</td>
						<td><input type="text" name="totalprice" readonly="readonly" id="totalcost"
							class="easyui-validatebox" required="true" value="0"/></td>
				</tr>
				<tr align="center">
					<td colspan="2"><input type=button value="处理归还" id="return"/></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>