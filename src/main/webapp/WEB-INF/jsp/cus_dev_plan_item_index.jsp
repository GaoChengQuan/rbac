<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		//查询指定id的销售机会
		$.post("${ctx}/saleChance/selectById.action", 
				{id : '${param.saleChanceId}'}, 
				function(result) {
					if(result.status==util.SUCCESS) {
						$("#customerName").val(result.data.customerName);
						$("#chanceSource").val(result.data.chanceSource);
						$("#linkMan").val(result.data.linkMan);
						$("#linkPhone").val(result.data.linkPhone);
						$("#successRate").val(result.data.successRate);
						$("#overview").val(result.data.overview);
						$("#description").val(result.data.description);
						$("#createMan").val(result.data.createMan);
						$("#createTime").val(result.data.createTime);
						$("#assignMan").val(result.data.assignMan);
						$("#assignTime").val(result.data.assignTime);
					}
					
				}, 
				"json");
		
		/*展示数据的datagrid表格*/
		$("#datagrid").edatagrid({
			url:'${ctx}/cusDevPlan/selectAll.action?saleChanceId=${param.saleChanceId}',//只查询已分配咨询师的
			saveUrl:'${ctx}/cusDevPlan/add.action?saleChanceId=${param.saleChanceId}',
			updateUrl:'${ctx}/cusDevPlan/update.action?saleChanceId=${param.saleChanceId}',
			destroyUrl:'${ctx}/cusDevPlan/delete.action',
			title:'开发计划项',
			singleSelect:true,
			toolbar:'#toolbar',
			rownumbers:true,
			fitColumns:true,
			columns:[[    
			     {field:'id',title:'编号',width:50,align:'center'},    
			     {field:'planDate',title:'日期',width:100,align:'center',editor:{type:'datebox',options:{required:true}}},    
			     {field:'planItem',title:'计划内容',width:80,align:'center',editor:{type:'validatebox',options:{required:true}}},    
			     {field:'exeAffect',title:'执行效果',width:80,align:'center',editor:{type:'validatebox',options:{required:true}}}  
			]],
			onSuccess : function() {
				$('#datagrid').edatagrid('reload');
				console.log("onSuccess");
			},
			onDestroy : function() {
				$('#datagrid').edatagrid('reload');
				console.log("onDestroy");
			}
		});
	});
	
	//更新销售机会客户开发状态
	function updateSaleChanceDevResult(devResult){
		 $.post("${ctx}/saleChance/updateDevResult.action",
				 {saleChanceId:'${param.saleChanceId}',devResult:devResult},
				 function(result){
					 if(result.status == util.SUCCESS){
						 $.messager.alert("系统提示","执行成功！");
						 //执行成功或失败后，隐藏工具条，因为不需要开发了
						 $("#toolbar").hide();
					 }else{
						 $.messager.alert("系统提示","执行失败！");
					 }
		 		},
		 		"json");
	 }
		
</script>
</head>
<body>
	<!-- 营销机会信息面板  开始 -->
	<div id="p" class="easyui-panel" title="销售机会信息" style="width: 700px;height: 320px">
	 	<table cellspacing="8px">
	   		<tr>
	   			<td>客户名称：</td>
	   			<td><input type="text" id="customerName" name="customerName" readonly="readonly"/></td>
	   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	   			<td>机会来源</td>
	   			<td><input type="text" id="chanceSource" name="chanceSource" readonly="readonly"/></td>
	   		</tr>
	   		<tr>
	   			<td>联系人：</td>
	   			<td><input type="text" id="linkMan" name="linkMan" readonly="readonly"/></td>
	   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	   			<td>联系电话：</td>
	   			<td><input type="text" id="linkPhone" name="linkPhone" readonly="readonly"/></td>
	   		</tr>
	   		<tr>
	   			<td>成功几率(%)：</td>
	   			<td><input type="text" id="successRate" name="successRate" readonly="readonly"/></td>
	   			<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;</td>
	   		</tr>
	   		<tr>
	   			<td>概要：</td>
	   			<td colspan="4"><input type="text" id="overview" name="overview" style="width: 420px" readonly="readonly"/></td>
	   		</tr>
	   		<tr>
	   			<td>机会描述：</td>
	   			<td colspan="4">
	   				<textarea rows="5" cols="50" id="description" name="description" readonly="readonly"></textarea>
	   			</td>
	   		</tr>
	   		<tr>
	   			<td>创建人：</td>
	   			<td><input type="text" readonly="readonly" id="createMan" name="createMan" /></td>
	   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	   			<td>创建时间：</td>
	   			<td><input type="text" id="createTime" name="createTime" readonly="readonly"/></td>
	   		</tr>
	   		<tr>
	   			<td>指派给：</td>
	   			<td>
	   				<input type="text" readonly="readonly" id="assignMan" name="assignMan" />
	   			</td>
	   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	   			<td>指派时间：</td>
	   			<td><input type="text" id="assignTime" name="assignTime" readonly="readonly"/></td>
	   		</tr>
	   	</table>
	 </div>
	 <!-- 营销机会信息面板  结束  -->
	 
	 <br/>
	 
	<!-- 客户开发计划项table -->
	<table id="datagrid" style="width:700px;height:250px" idField="id"></table>
	
	<!-- toolbar 开始 -->
	 <div id="toolbar">
	 	<c:if test="${param.show!='true' }">
		 	<a href="javascript:$('#datagrid').edatagrid('addRow')" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加计划</a>
		 	<a href="javascript:$('#datagrid').edatagrid('destroyRow')" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除计划</a>
		 	<a href="javascript:$('#datagrid').edatagrid('cancelRow')" class="easyui-linkbutton" iconCls="icon-undo" plain="true">撤销行</a>
		 	<a href="javascript:$('#datagrid').edatagrid('saveRow')" class="easyui-linkbutton" iconCls="icon-save" plain="true">保存计划</a>
		 	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-kfcg" plain="true" onclick="updateSaleChanceDevResult(2)">开发成功</a>
		 	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-zzkf" plain="true" onclick="updateSaleChanceDevResult(3)">终止开发</a>
	 	</c:if>
	 </div>
	<!-- toolbar 结束 -->
</body>
</html>


