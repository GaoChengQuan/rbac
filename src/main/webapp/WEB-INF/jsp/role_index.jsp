<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
		var selfPermissionDatagrid;
		$(function() {
			/* 渲染table */
			$("#datagrid").datagrid({
				url : "${ctx}/role/pageList.action",
				method : "get",
				fit : true,
				fitColumns : true,
				pagination : true,
				toolbar: "#toolbar",
				columns : [[
					{field:"cb",checkbox:true,align:"center"},
					{field:"id",title:"编号",width:80,align:"center"},
					{field:"name",title:"角色名称",width:80,align:"center"},
					{field:"sn",title:"角色编号",width:80,align:"center"},
				]],
			});
			
			/* 初始化添加、修改的dialog */
			$("#dialog").dialog({
				width: 600,
			    height: 450,
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
			
			/* 所有权限表格 */
			var allPermissionDatagrid = $("#all_permission_datagrid").datagrid({
		        title: "所有权限",
		        width: 250,
		        height: 300,
		        pagination: true,
		        url: "${ctx}/permission/pageList.action",
		        rownumbers: true,
		        singleSelect: true,
		        fitColumns : true,
		        //数据表头信息
		        columns: [[
		            {field: "name", title: "名称", width: 1, align: "center"}
		        ]],
		        onDblClickRow: function (rowIndex, rowData) {
		            // 获取自身权限的所有对象
		            var selfRows = selfPermissionDatagrid.datagrid("getRows");

		            //查询要添加的权限是否在自身对象存在,如果存在,则选中要权限,没有的话,则追加权限
		            var isExist = false;
		            var index = 0;
		            for (var i = 0; i < selfRows.length; i++) {
		                if (selfRows[i].id == rowData.id) {
		                	isExist = true;
		                    index = i;
		                    break;
		                }
		            }
		            if (isExist) {//已经存在权限
		                selfPermissionDatagrid.datagrid("selectRow", index);
		            } else {//不存在权限，追加
		                selfPermissionDatagrid.datagrid("appendRow", rowData);
		            }
		        }
		    });
		    //设置所有权限的分页为简洁效果
		    var pager = allPermissionDatagrid.datagrid("getPager");
		    pager.pagination({
		        showPageList: false,
		        showRefresh: false,
		        displayMsg: "",

		    });

		    /* 自身权限表格 */
		    selfPermissionDatagrid = $("#self_permission_datagrid").datagrid({
		        title: "自身权限",
		        width: 250,
		        height: 300,
		        rownumbers: true,
		        singleSelect: true,
		        fitColumns: true,
		        columns: [[
		            {field: "name", title: "名称", width: 1, align: "center"}
		        ]],
		        onDblClickRow: function (rowIndex, rowData) {
		            selfPermissionDatagrid.datagrid("deleteRow", rowIndex);
		        }

		    });
		});
		
		/* 搜索 */
		function doSearch(){
			$('#datagrid').datagrid('load', {    
			    name : $("#s_name").val(),    
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
						url : "${ctx}/role/delete.action",
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
			url = "${ctx}/role/add.action";
			$("#dialog").dialog("open");
			$("#form").form("clear");
		}
		
		/* 打开修改dialog */
		function openUpdateDialog(){
			url = "${ctx}/role/update.action";
			var selections = $("#datagrid").datagrid("getSelections");
			if(selections.length == 0) {
				$.messager.alert("系统提示", "请选择要删除的行");
				return;
			}
			var row = selections[0];
			$("#dialog").dialog("open").dialog("setTitle", "修改信息");
			//load读取记录填充到表单中。数据参数可以是一个字符串或一个对象类型，如果是字符串则作为远程URL，否则作为本地记录
			$("form").form("load", row);
			// 回显自身权限的数据
            selfPermissionDatagrid.datagrid("options").url = "${ctx}/permission/selectByRoleId.action";
            selfPermissionDatagrid.datagrid("load", {
                roleId: row.id
            })
		}
		
		/* 真正的去添加或者更新用户 */
		function doAddOrUpdate() {
			$("#form").form("submit", {
				url : url,
				//提交之前的回调函数
				onSubmit : function(param) {// do some check
					var selfRows = selfPermissionDatagrid.datagrid("getRows");
                    for (var i = 0; i < selfRows.length; i++) {
                        param["permissions[" + i + "].id"] = selfRows[i].id;
                    }
					//return $(this).form('validate');//返回false终止表单提交
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
			角色名：<input type="text" id="s_name"/>
			<a href="javascript:doSearch()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
		</div>
	</div>
	<!-- toolbar 结束 -->
	
	<!-- 添加和修改的dialog 开始 -->
	
	<div id="dialog">
	    <form id="form" method="post">
	        <input type="hidden" name="id" />
	        <table align="center">
	            <tr>
	                <td>角色名称:<input name="name"/></td>
	                <td>角色编号:<input name="sn"/></td>
	            </tr>
	        <tr>
	            <td><table id="self_permission_datagrid" ></table></td>
	            <td><table id="all_permission_datagrid" ></table></td>
	        </tr>
	        </table>
	    </form>
	</div>
    <!-- 添加和修改的dialog 结束 -->
</body>
</html>