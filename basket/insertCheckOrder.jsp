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
	  int order_totalprice = 0;
	  String order_state ="배송준비중";
		  
    String[] check = request.getParameterValues("product_check");
    if (check != null) {
        for (int i = 0; i < check.length; ++i) {
		String[] array = check[i].split(",");
	      
		if(i==0) product_name = array[0];
		order_count++;
		order_totalprice += Integer.parseInt(array[1]);
		
	      String sqlStr = "delete from basket where product_name=? and user_id=?";
	      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	      pstmt.setString(1, array[0]);
	      pstmt.setString(2, id);
	      
	      pstmt.executeUpdate();
	      
	      pstmt.close();
		  %>
		  
		 <%
        }
        String sqlStr = "INSERT INTO orders (product_name, user_id, order_count, order_totalprice, order_state) VALUES (?, ?, ?, ?, ?)";
	      
          PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	      pstmt.setString(1, product_name);
	      pstmt.setString(2, id);
	      pstmt.setInt(3, order_count);
	      pstmt.setInt(4, order_totalprice);
	      pstmt.setString(5, order_state);
	      
	      pstmt.executeUpdate();
	      
	      pstmt.close();
	      conn.close();
	      %>
	     <script>
	      alert("주문이 완료되었습니다.");
		  location.href = '../users/myPage.jsp';
		  </script>
		  <% 
    } else {
		 %>
		 <script>
	      alert("주문할 상품을 선택해주세요.");
		  location.href = 'basket.jsp';
		  </script>
		  <% } %>
</body>
</html>