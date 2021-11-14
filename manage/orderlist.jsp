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
      <th>구매자</th>
      <th>상품총금액</th>
      <th>주문처리상태</th>
      <th>변경하기</th>
      </tr>
  
<%
	String sqlStr = "select * from orders";
	ResultSet rs = stmt.executeQuery(sqlStr);
	
	while(rs.next()) {
		int count = rs.getInt("order_count");
    	int cnt = count-1;
    	
		sqlStr = "select * from users where user_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	      pstmt.setString(1, rs.getString("user_id"));
	      
	      ResultSet rset = pstmt.executeQuery();
	      if(rset.next()) {
%>
<form action="updateOrder.jsp" method="post">
<input type="hidden" name="num" value="<%= rs.getInt("order_num") %>">
<tr>
<td><%= rs.getString("product_name") %> 외 <%= cnt %>개</td>
<td><%= rset.getString("user_nickName") %></td>
<td><%= rs.getInt("order_totalprice") %></td>
<td><input type="text" list="state" name="state" autocomplete='off' value="<%= rs.getString("order_state") %>">
			<datalist id="state">
				<option value="배송준비중">
				<option value="배송중">
				<option value="배송완료">
			</datalist></td>
<td><input id="button" type="submit" value="변경하기"></td>
</tr>
</form>
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