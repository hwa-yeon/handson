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
<%
		String product = request.getParameter("product");
%>

	<script>
		var ret = confirm("정말 삭제하시겠습니까?");
		if(ret == true) {
			location.href = 'deleteProduct.jsp?product=<%= product %>';
		}
		else {
			location.href = 'index.jsp';
		}
  </script>
</body>
</html>