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
  Class.forName("com.mysql.jdbc.Driver");

  Connection conn = DriverManager.getConnection(
      "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737");
  
	  String product_name = "";
	  String id = (String)session.getAttribute("sessionID");
	  int order_count = 0;
	  int order_totalprice = Integer.parseInt(request.getParameter("total_price"));
	  String order_state ="배송준비중";
		  
	  String sqlStr = "select * from basket where user_id=?";
	  PreparedStatement pstmt = conn.prepareStatement(sqlStr);
      pstmt.setString(1, id);
      ResultSet rs = pstmt.executeQuery();
		
	 while(rs.next()) {
    	if(product_name.equals("")) product_name = rs.getString("product_name");
		order_count++;
	 }
		
		 sqlStr = "delete from basket where user_id=?";
	     pstmt = conn.prepareStatement(sqlStr);
	      pstmt.setString(1, id);
	  	  pstmt.executeUpdate();
	    
          sqlStr = "INSERT INTO orders (product_name, user_id, order_count, order_totalprice, order_state) VALUES (?, ?, ?, ?, ?)";
          pstmt = conn.prepareStatement(sqlStr);
	      pstmt.setString(1, product_name);
	      pstmt.setString(2, id);
	      pstmt.setInt(3, order_count);
	      pstmt.setInt(4, order_totalprice);
	      pstmt.setString(5, order_state);
	      
	      pstmt.executeUpdate();
	      
	      rs.close();
	      pstmt.close();
	      conn.close();
	      %>
	     <script>
	      alert("주문이 완료되었습니다.");
		  location.href = '../users/myPage.jsp';
		  </script>
		 
</body>
</html>