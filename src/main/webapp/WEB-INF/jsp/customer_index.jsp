<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="easyui-datagrid" 
		style="width: 700px; height: 250px"
		data-options="pagination:true,fitColumns:true,fit:true,singleSelect:true,collapsible:true,url:'${ctx}/customer/pageList.action',method:'get'">
		<thead>
			<tr>
				<th data-options="field:'id',width:80">ID</th>
				<th data-options="field:'num',width:100">客户编号</th>
				<th data-options="field:'name',width:80,align:'right'">公司名称</th>
				<th data-options="field:'region',width:80,align:'right'">客户地区</th>
				<th data-options="field:'manager_name',width:250">客户经理姓名</th>
			</tr>
		</thead>
	</table>
</body>
</html>