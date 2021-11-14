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
    String[] check = request.getParameterValues("product_check");
    if (check != null) {
        for (int i = 0; i < check.length; ++i) {
		String[] array = check[i].split(",");
		String id = (String)session.getAttribute("sessionID");
	  
	      Class.forName("com.mysql.jdbc.Driver");

	      Connection conn = DriverManager.getConnection(
	          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
	      
	      String sqlStr = "delete from basket where product_name=? and user_id=?";
	      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	      pstmt.setString(1, array[0]);
	      pstmt.setString(2, id);
	      
	      pstmt.executeUpdate();
	      
	      pstmt.close();
	      conn.close();
		  
        }
        %>
		  <script>
		  location.href = 'basket.jsp';
		  </script>
		 <%
    }
		 %>
</body>
</html>