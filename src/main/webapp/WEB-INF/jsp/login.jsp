<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<script type="text/javascript">
	 function submitForm() {
		$.ajax({
	        url : "${ctx}/user/login.action",
	        type : "POST",
	        dataType : "json",
	        data : $("#login-form").serialize(),
	        success : function(jsonObj) {
	           if(jsonObj.status == util.SUCCESS) {
	        	   window.location.href = "${ctx}/index.action";
	           } else {
	              alert(data.msg);
	           }
	        }
	     });
	 }
	</script>
</head>
<body>
	<form id="login-form" method="post">
		<input type="text" id="name" name="name" /> 
		<input type="password" id="password" name="password" />
	</form>
	<button  onclick="submitForm()">登录</button>
</body>
</html>