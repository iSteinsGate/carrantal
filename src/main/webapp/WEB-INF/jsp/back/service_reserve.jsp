<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>处理预约</title>
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
		$("#reserveGrid").datagrid({
			//定义标题所有列
			columns : [ [{
				title:'ck',
				checkbox : true
			}, {
				title : '预约编号',
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
				title : '预约时间',
				field : 'starttime',
				width : 150,
				align : 'center',
				  formatter:function(value,row,index){  
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
				 formatter:function(value,row,index){  
                    if(value=="0"){
                    	return "正在预约";
                    }else if(value=="1"){
                    	return "预约成功";
                    }else{
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
			toolbar : [ {
				text : '处理预约',
				iconCls : 'icon-edit',
				handler : function() {
					/* alert('edit...'); */
					//选择的那行记录
					var rows = $('#reserveGrid').datagrid('getSelections');
					var row = $('#reserveGrid').datagrid('getSelected');
					if(row==null || rows.length>1){
						$.messager.alert('提示','请选择一行','info');
					}else{
						//选择了一行
						$.messager.confirm('处理确认','你确定处理该条预约?',function(flag){
							if(flag){
								//确认处理，发送请求
								var id = row.id;
								location.href="/service_reserve?id="+id;
							}
						})
					}
				}
			} ,
			{
				text : '查询',
				iconCls : 'icon-search',
				handler : function() {
					//alert('search...');
					$("#queryReserveWindow").window(
							'open');
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
		//开始查找，jax请求数据，并刷新重新加载reserveGridb表
		$("#query").click(function(){
			/*获取选中radio的值  */
			var state = $('input:radio:checked').val();
			
			$("#queryReserveWindow").window('close');
			$.ajax({
				url:"${pageContext.request.contextPath }/reservelist?state="+state,
				/* data:{"state":state}, */
				type:"post",
				dataType:"json",
				success:function(data){
					if(data.total=='0'){
						$.messager.confirm('提示','没有找到记录，请重新输入！！',function(flag){
							if(flag){
								$("#queryReserveWindow").window('open');
							}
						})
					}else{
						//刷新查询到的数据
						$("#reserveGrid").datagrid("loadData",{'total':data.total, 'rows':data.rows });
					}
				}
			});
		});
		
	});
</script>
</head>
<body class="easyui-layout">
	<!-- 用户表格 -->
	<div region="center" border="false">
		<table id="reserveGrid"></table>
	</div>
	<!-- 查询预约记录窗口 -->
	<div class="easyui-window" id="queryReserveWindow" title="选择条件"
		collapsible="false" minimizable="false" closed="true" modal="true"
		resizable="false" maximizable="false" style="top: 60px; left: 420px;">
		<form id="queryReserveForm" method="post">
			<table class="table-edit" width="150px" align="center">
				<tr>
					<td align="center"><strong>请选择预约状态</strong></td>
				</tr>
				<tr>
					<td align="center"><input class="rad" type="radio" name="flag" value="0">正在预约</td>
				</tr>
				<tr>
					<td align="center"><input class="rad" type="radio" name="flag" value="1">预约成功</td>
				</tr>
				<tr>
					<td align="center"><input class="rad" type="radio" name="flag" value="2">预约失败</td>

				</tr>
				<tr align="center">
					<td><input type="button" value="开始查找" id="query"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>