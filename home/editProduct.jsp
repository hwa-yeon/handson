<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
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
	    	<a href="index.jsp" id="title">핸손</a>
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
	            <li><a href="../manage/manage.jsp">관리자페이지</a></li>
	        </ul>
	    </header>
	    <div class="wrap">
        <nav class="category">
        	<h2>카테고리</h2>
        	<ul>
	        	<li><a href="index_food.jsp">식품</a></li>
		        <li><a href="index_clothes.jsp">의류</a></li>
		        <li><a href="index_accessory.jsp">악세서리</a></li>
	            <li><a href="index_interior.jsp">인테리어</a></li>
	            <li><a href="index_etc.jsp">기타</a></li>
	        </ul>
	        <a href="productSell.jsp" id="sell">*상품추가하기(판매자전용)</a>
        </nav>
        <div class="content">
	<%
		String product = request.getParameter("product");
	
		 Class.forName("com.mysql.jdbc.Driver");
	
	     Connection conn = DriverManager.getConnection(
	         "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
	     
	     String sqlStr = "select * from product where product_name=?";
	     PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	     
	     pstmt.setString(1, product);
	     ResultSet rs = pstmt.executeQuery();
	     
	     if(rs.next()) {
	%>
	<form action="updateProduct.jsp" method="post">
	<table>
			<tr><td>상품명</td>		
			<td><input type="text" name="name" style="width:80%;" value="<%= rs.getString("product_name") %>" readonly></td></tr>
			<tr><td>사진 변경</td>
			<td><input type="file" name="filename1" entype="multipart/form-data"></td></tr>
			<tr><td>상품 가격</td>		
			<td><input type="text" name="price" style="width:80%;" value="<%= rs.getInt("product_price") %>"></td></tr>
			<tr><td>상품 정보</td>	
			<td><textarea name="info" style="width:80%; height:300px"><%= rs.getString("product_info") %></textarea></td></tr>
			<tr><td>카테고리</td>	
			<td><input type="text" list="category" name="category" style="width:80%" autocomplete='off' value="<%= rs.getString("product_category") %>">
			<datalist id="category">
				<option value="식품">
				<option value="의류">
				<option value="악세서리">
				<option value="인테리어">
				<option value="기타">
			</datalist>
			</td></tr>
			</table>
	<br>
	<div  style="text-align: right;  padding-right:50px;">
	<input type="submit" value="수정하기" id="button">
	</div>
	</form>
	</div>
	</div>
	<% } 
	     rs.close();
	     pstmt.close();
	     conn.close();
	%>
</body>
</html>