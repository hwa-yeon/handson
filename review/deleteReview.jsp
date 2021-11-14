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
			String num = request.getParameter("num");
			String id = (String)session.getAttribute("sessionID");
		  
		      Class.forName("com.mysql.jdbc.Driver");

		      Connection conn = DriverManager.getConnection(
		          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
		      Statement stmt = conn.createStatement();
		      
		      String sqlStr = "delete from comments where review_num=" + num;
		      stmt.executeUpdate(sqlStr);
		      
		      sqlStr = "delete from review where review_num=" + num;
		      stmt.executeUpdate(sqlStr);
		      
		 	  stmt.close();
		      conn.close();
		  %>
		  <script>
		  alert("삭제가 완료되었습니다.");
		  location.href = 'list.jsp';
		  </script>
		  
</body>
</html>