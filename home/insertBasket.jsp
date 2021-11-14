<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.Timestamp" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핸손</title>
</head>
<body>
	<%
    String count = request.getParameter("count");
  	String name = request.getParameter("product_name");
	String ID = request.getParameter("user_id");
  %>
  <%
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      
      String sqlStr = "select * from users where user_id=?";
      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
      pstmt.setString(1, (String)session.getAttribute("sessionID"));
      
      ResultSet rs = pstmt.executeQuery();
      
      if(rs.next()) {
    	  if(rs.getString("user_purpose").equals("판매자")) {
    		  %>
    		  <script>
    		  alert("구매자만 접근가능한 페이지입니다.");
    		  location.href = "index.jsp";
    		  </script>
    		  <% } else {
    			  
    			  sqlStr = "select * from basket where user_id=? and product_name=?";
    			  
    			  PreparedStatement pstmt1 = conn.prepareStatement(sqlStr);
			      pstmt1.setString(1, ID);
			      pstmt1.setString(2, name);
			
			      rs = pstmt1.executeQuery();
			      if(rs.next()) {
 %>
 				  <script>
 				  alert("이미 장바구니에 담았습니다.");
 				  location.href = 'index_detail.jsp?name=<%=rs.getString("product_name") %>';
 				  </script>
 <% 
 				  }
			      else {

				      sqlStr = "INSERT INTO basket (user_id, product_name, basket_count) VALUES (?, ?, ?)";
				      
				      PreparedStatement pstmt2 = conn.prepareStatement(sqlStr);
				      pstmt2.setString(1, ID);
				      pstmt2.setString(2, name);
				      pstmt2.setInt(3, Integer.parseInt(count));
				
				      pstmt2.executeUpdate();
				      
				      pstmt2.close();
			      
      
  %>
  <%
  	  rs.close();
      pstmt.close();
  	  pstmt1.close();
      conn.close();
  %>
<script>
	alert("장바구니에 담았습니다.");
	location.href = '../basket/basket.jsp';
</script>
<%
			      }
    		  }
      } else {
%>
<script>
	alert("로그인 후 이용가능합니다.");
	location.href = '../users/login.jsp';
</script>
<% } %>
</body>
</html>