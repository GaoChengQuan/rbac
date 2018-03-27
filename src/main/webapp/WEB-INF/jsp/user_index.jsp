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
				url : "${ctx}/user/pageList.action",
				method : "get",
				fit : true,
				fitColumns : true,
				pagination : true,
				toolbar: "#toolbar",
				columns : [[
					{field:"cb",checkbox:true,align:"center"},
					{field:"id",title:"编号",width:80,align:"center"},
					{field:"name",title:"用户名",width:80,align:"center"},
					{field:"trueName",title:"真实姓名",width:80,align:"center"},
					{field:"email",title:"邮箱",width:80,align:"center"},
					{field:"phone",title:"联系电话",width:80,align:"center"},
					{field:"roleName",title:"角色",width:80,align:"center"},
				]],
			});
			
			/* 初始化添加、修改的dialog */
			$("#dialog").dialog({
				closed : true,
			    buttons : [
			        {
			        	text : "保存",
			        	iconCls : "icon-ok",
			        	handler : function() {
			        		doAddOrUpdate();
			        	}
			        },
			        {
			        	text : "关闭",
			        	iconCls : "icon-cancel",
			        	handler : function() {
			        		$("#dialog").dialog("close");
			        	}
			        }
			    ]
			}); 
		});
		
		/* 搜索 */
		function doSearch(){
			$('#datagrid').datagrid('load', {    
			    name : $("#s_name").val(),    
			    email : $("#s_email").val(),   
			    roleName : $("#s_roleName").val() 
			});  
		}
		
		/* 删除 */
		function doDelete() {
			//getSelections none 返回所有被选中的行，当没有记录被选中的时候将返回一个空数组。 
			var ids = util.getSelectedIds($("#datagrid").datagrid("getSelections"));
			//[1,2,3]
			if (ids.length == 0) {
				$.messager.alert("系统提示", "请选择要删除的数据");
				return;
			}
			$.messager.confirm("系统提示", "您确认要删除这"+ids.length+"几条数据么", function(r){
				if(r) {
					ids = ids.join(',');// '1,2,3'
					$.ajax({
						url : "${ctx}/user/delete.action",
						data : {ids : ids},
						dataType : "json",
						type : "POST",
						success : function(jsonObj) {
							$.messager.alert("系统提示", jsonObj.msg);
							if(jsonObj.status == util.SUCCESS) {
								$("#datagrid").datagrid("reload");
							}
						}
					});
				}
			});
		}
		
		var url;
		/* 打开添加dialog */
		function openAddDialog(){
			url = "${ctx}/user/add.action";
			$("#dialog").dialog("open");
			$("#form").form("clear");
		}
		
		/* 打开修改dialog */
		function openUpdateDialog(){
			url = "${ctx}/user/update.action";
			var selections = $("#datagrid").datagrid("getSelections");
			if(selections.length == 0) {
				$.messager.alert("系统提示", "请选择要删除的行");
				return;
			}
			var row = selections[0];
			$("#dialog").dialog("open").dialog("setTitle", "修改信息");
			//load读取记录填充到表单中。数据参数可以是一个字符串或一个对象类型，如果是字符串则作为远程URL，否则作为本地记录
			$("form").form("load", row);
		}
		
		/* 真正的去添加或者更新用户 */
		function doAddOrUpdate() {
			$("#form").form("submit", {
				url : url,
				onSubmit : function() {// do some check
					if($("#roleName").combobox("getValue") == "") {
						$.messager.alert("系统提示", "请选择用户角色");
						return false;
					}
					return $(this).form('validate');//返回false终止表单提交
				},
				success : function(data) {
					// change the JSON string to javascript object
					var jsonObj = eval("(" + data + ")");
					$.messager.alert("系统提示", jsonObj.msg);
					if(jsonObj.status == util.SUCCESS) {
						$("#dialog").dialog("close");
						$("#datagrid").datagrid("reload");
					}
				}
			})
		}
	</script>
</head>
<body>
	<table id="datagrid"></table>
	
	<!-- toolbar 开始 -->
	<div id="toolbar">
		<a href="javascript:openAddDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
		<a href="javascript:openUpdateDialog()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
		<a href="javascript:doDelete()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
		<div>
			用户名：<input type="text" id="s_name"/>
			邮箱：<input type="text" id="s_email"/>
			角色：<select id="s_roleName" class="easyui-combobox" 
					editable="false" panelHeight="auto">
					<option value="">请选择...</option>
					<option value="系统管理员">系统管理员</option>
					<option value="销售主管">销售主管</option>
					<option value="客户经理">客户经理</option>
					<option value="高管">高管</option>
				</select>
			<a href="javascript:doSearch()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
		</div>
	</div>
	<!-- toolbar 结束 -->
	
	<!-- 添加和修改的dialog 开始 -->
    <div id="dialog" style="width:650;height:280,padding: 10px 20px">
       <form action="" id="form" method="post">
           <input type="hidden" id="id" name="id"/>
           <table cellspacing="8px">
               <tr>
                  <td>用户名：</td>
                  <td><input type="text" id="name" name="name" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
                   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td>密码：</td>
                  <td><input type="text" id="password" name="password" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
               </tr>
               <tr>
                  <td>真实姓名：</td>
                  <td><input type="text" id="trueName" name="trueName" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
                   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td>邮箱：</td>
                  <td><input type="text" id="email" name="email" class="easyui-validatebox" required="true" validType="email"/><font color="red">*</font></td>
               </tr>
               <tr>
                  <td>联系电话：</td>
                  <td><input type="text" id="phone" name="phone" class="easyui-validatebox" required="true"/><font color="red">*</font></td>
                   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td>用户角色：</td>
                  <td>
                      <select class="easyui-combobox" id="roleName" panelHeight="auto" editable="false" name="roleName" style="width:160">
                          <option value="">请选择...</option>
                          <option value="系统管理员">系统管理员</option>
                          <option value="销售主管">销售主管</option>
                          <option value="客户经理">客户经理</option>
                          <option value="高管">高管</option>
                      </select>
                      <font color="red">*</font></td>
               </tr>
           </table>
       </form>
    </div>
    <!-- 添加和修改的dialog 结束 -->
</body>
</html>