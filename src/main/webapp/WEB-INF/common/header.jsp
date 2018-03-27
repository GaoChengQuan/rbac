<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<script type="text/javascript">
	var ctx = "${pageContext.request.contextPath}";
</script>

<link rel="stylesheet" href="${ctx}/static/lib/jquery-easyui/themes/default/easyui.css" />
<!-- 图标样式-->
<link rel="stylesheet" href="${ctx}/static/lib/jquery-easyui/themes/icon.css" />
<link rel="stylesheet" href="${ctx}/static/lib/jquery-easyui/themes/myicon.css" />
<!-- jquery核心库-->
<script src="${ctx}/static/lib/jquery-easyui/jquery.min.js" type="text/javascript"
	charset="utf-8"></script>
<!-- easyui核心库-->
<script src="${ctx}/static/lib/jquery-easyui/jquery.easyui.min.js"
	type="text/javascript" charset="utf-8"></script>
	
<script type="text/javascript" src="${ctx}/static/lib/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}/static/lib/jquery-easyui/jquery.edatagrid.js"></script>

<script type="text/javascript" src="${ctx}/static/common/js/util.js"></script>


