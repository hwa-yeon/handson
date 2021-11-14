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
		  
		      Class.forName("com.mysql.jdbc.Driver");

		      Connection conn = DriverManager.getConnection(
		          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
		      
		        String sqlStr = "update review set product_name=? where product_name=?";
			     PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			     
			     pstmt.setString(1, "삭제된 상품");
			     pstmt.setString(2, product);
			     pstmt.executeUpdate();
			     
			     sqlStr = "delete from basket where product_name=?";
			     pstmt = conn.prepareStatement(sqlStr);
			     
			     pstmt.setString(1, product);
			     pstmt.executeUpdate();
		      
			     sqlStr = "delete from product where product_name=?";
			     pstmt = conn.prepareStatement(sqlStr);
			     
			     pstmt.setString(1, product);
			     pstmt.executeUpdate();
			     
			  pstmt.close();
		      conn.close();
		  %>
		  <script>
		  alert("삭제가 완료되었습니다.");
		  location.href = 'index.jsp';
		  </script>
		  
</body>
</html>