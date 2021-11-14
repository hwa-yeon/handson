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
		int num = Integer.parseInt(request.getParameter("num"));
		String state = request.getParameter("state");

	
		 Class.forName("com.mysql.jdbc.Driver");
	
	     Connection conn = DriverManager.getConnection(
	         "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
	     
	     String sqlStr = "update orders set order_state=? where order_num=?";
	     PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	     
	     pstmt.setString(1, state);
	     pstmt.setInt(2, num);
	     pstmt.executeUpdate();
	     
	     pstmt.close();
	     conn.close();	
	%>
<script>
location.href = 'orderlist.jsp';
</script>
</body>
</html>