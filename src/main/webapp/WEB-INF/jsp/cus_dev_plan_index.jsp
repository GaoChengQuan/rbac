<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
		$(function() {
			/* 渲染table */
			$("#datagrid").datagrid({
				url : "${ctx}/saleChance/pageList.action?status=1",//status=1是已经查询已经指派人的营销机会
				method : "get",
				fit : true,
				fitColumns : true,
				pagination : true,
				toolbar: "#toolbar",
				columns:[[    
				     {field:'cb',checkbox:true,align:'center'},    
				     {field:'id',title:'编号',width:50,align:'center'},    
				     {field:'customerName',title:'客户名称',width:100,align:'center'},    
				     {field:'overview',title:'概要',width:80,align:'center'},    
				     {field:'linkMan',title:'联系人',width:80,align:'center'},    
				     {field:'createMan',title:'创建人',width:80,align:'center'},    
				     {field:'createTime',title:'创建时间',width:100,align:'center'},    
				     {field:'assignMan',title:'指派人',width:80,align:'center'},    
				     {field:'assignTime',title:'指派时间',width:100,align:'center'},    
				     {field:'devResult',title:'客户开发状态',width:80,align:'center',formatter:function(value,row,index){
				    	 //客户开发状态 0 未开发 1 开发中 2 开发成功 3 开发失败
				    	 if(value==0){
				    		 return "未开发";
				    	 }else if(value==1){
				    		 return "开发中";
				    	 }else if(value==2){
				    		 return "开发成功";
				    	 }else if(value==3){
				    		 return "开发失败";
				    	 } else {
				    		 return "未开发"
				    	 }
				     }},    
				     {field:'a',title:'操作',width:80,align:'center',formatter:function(value,row,index){
				    	 if(row.devResult==2||row.devResult==3){
				    		 return "<a href='javascript:openCusDevPlanTab("+row.id+")'>查看详细信息</a>";
				    	 }else{
				    		 return "<a href='javascript:openCusDevPlanInfoTab("+row.id+")'>开发</a>";
				    	 }
				     }},    
				]] 
			});
		});
		
		//可以修改添加开发项
		function openCusDevPlanTab(id){
			 window.parent.openTab('客户开发计划项管理','${ctx}/cusDevPlan/index.action?saleChanceId='+id+'&show=true','icon-khkfjh');
		}
		 
		//只能查看开发信息
		function openCusDevPlanInfoTab(id){
			window.parent.openTab('查看客户开发计划项','${ctx}/cusDevPlan/index.action?saleChanceId='+id,'icon-khkfjh');
		}
	</script>
</head>
<body>
	<table id="datagrid"></table>
</body>
</html>