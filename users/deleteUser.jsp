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
			 String ID = (String)session.getAttribute("sessionID");
		  
		      Class.forName("com.mysql.jdbc.Driver");

		      Connection conn = DriverManager.getConnection(
		          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
		      
			  String sqlStr = "delete from comments where user_id=?";
		      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		      pstmt.setString(1, ID);   
		      pstmt.executeUpdate();
		      
		      sqlStr = "delete from review where user_id=?";
		      pstmt = conn.prepareStatement(sqlStr);
		      pstmt.setString(1, ID);  
		      pstmt.executeUpdate();
		      
		      sqlStr = "delete from orders where user_id=?";
		      pstmt = conn.prepareStatement(sqlStr);
		      pstmt.setString(1, ID);  
		      pstmt.executeUpdate();
		      
		      sqlStr = "delete from basket where user_id=?";
		      pstmt = conn.prepareStatement(sqlStr);
		      pstmt.setString(1, ID);  
		      pstmt.executeUpdate();
		      
		      sqlStr = "delete from product where user_id=?";
		      pstmt = conn.prepareStatement(sqlStr);
		      pstmt.setString(1, ID);  
		      pstmt.executeUpdate();
		      
		      sqlStr = "delete from users where user_id=?";
		      pstmt = conn.prepareStatement(sqlStr);
		      pstmt.setString(1, ID);  
		      pstmt.executeUpdate();
		 
		 	  pstmt.close();
		      conn.close();
		  %>
		  <script>
		  alert("회원탈퇴가 완료되었습니다.");
		  location.href = 'logout.jsp';
		  </script>
		  
</body>
</html>