<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/menu.css">
<link rel="stylesheet" href="../css/table.css">
<title>핸손</title>
</head>
<body>
      <header class="menu">
	  	    		<a href="../home/index.jsp" id="title">핸손</a>
	  	        	<ul>
	  	        	<li><a href="../users/join.jsp">회원가입</a></li>
	  	            <% if(session.getAttribute("sessionID") == null) { %>
	  	            <li><a href="../users/login.jsp">로그인</a></li>
	  	            <% } else { %>
	  	            <li><a href="../users/logout.jsp">로그아웃</a></li>
	  	            <% } %>
	  		        <li><a href="../basket/basket.jsp">장바구니</a></li>
	  		        <li><a href="../review/list.jsp">리뷰게시판</a></li>
	  	            <li><a href="../users/myPage.jsp">마이페이지</a></li>
	  	            <li><a href="manage.jsp">관리자페이지</a></li>
	  	        </ul>
	  	    </header>
	  	    <div class="wrap">
	          <nav class="category">
	          	<h2>카테고리</h2>
	          	<ul>
	  	        	<li><a href="../home/index_food.jsp">식품</a></li>
	  		        <li><a href="../home/index_clothes.jsp">의류</a></li>
	  		        <li><a href="../home/index_accessory.jsp">악세서리</a></li>
	  	            <li><a href="../home/index_interior.jsp">인테리어</a></li>
	  	            <li><a href="../home/index_etc.jsp">기타</a></li>
	  	        </ul>
	  	        <a href="../home/productSell.jsp" id="sell">*상품추가하기(판매자전용)</a>
	          </nav>
	          <div class="content">
         <%
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      Statement stmt = conn.createStatement();
 %>
      
      <table>
      <tr>
      <th>상품명</th>
      <th>판매자</th>
      <th>삭제</th>
      </tr>
  
<%
	String sqlStr = "select * from product";
	ResultSet rs = stmt.executeQuery(sqlStr);
	
	while(rs.next()) {
		sqlStr = "select * from users where user_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	      pstmt.setString(1, rs.getString("user_id"));
	      
	      ResultSet rset = pstmt.executeQuery();
	      if(rset.next()) {
%>
<tr>
<td><a href="../home/index_detail.jsp?name=<%=rs.getString("product_name") %>"  style="text-decoration:none; color:black"><%= rs.getString("product_name") %></a></td>
<td><%= rset.getString("user_nickName") %></td>
<td><a href="../home/deleteProduct.jsp?product=<%= rs.getString("product_name") %>">삭제</a></td>
</tr>
<%
	      }
	      rset.close();
	      pstmt.close();
	}
	rs.close();
	stmt.close();
	conn.close();
%>

</table>
        </div>
        </div>
</body>
</html>