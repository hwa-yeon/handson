<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핸손</title>
</head>
<body>
	<script>
		var ret = confirm("정말 탈퇴하시겠습니까?");
		if(ret == true) {
			location.href = 'deleteUser.jsp';
		}
		else {
			location.href = 'myPage_detail.jsp';
		}
  </script>
</body>
</html>