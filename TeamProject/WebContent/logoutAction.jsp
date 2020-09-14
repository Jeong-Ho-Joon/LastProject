<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
body { 
  background: url(image/bg7.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}
</style>
<meta charset="UTF-8">
<title>FVB</title>
</head>
<body>

<%
	session.invalidate();
%>
<script>
	alert("로그아웃 되었습니다");
	location.href= 'main.jsp';
</script>
</body>
</html>