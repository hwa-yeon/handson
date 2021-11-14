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
	    	<a href="../home/index.jsp" id="title">핸손</a>
	        <ul>
	        	<li><a href="../users/join.jsp">회원가입</a></li>
	            <% if(session.getAttribute("sessionID") == null) { %>
	            <li><a href="../users/login.jsp">로그인</a></li>
	            <% } else { %>
	            <li><a href="../users/logout.jsp">로그아웃</a></li>
	            <% } %>
		        <li><a href="../basket/basket.jsp">장바구니</a></li>
		        <li><a href="list.jsp">리뷰게시판</a></li>
	            <li><a href="../users/myPage.jsp">마이페이지</a></li>
	            <li><a href="../manage/manage.jsp">관리자페이지</a></li>
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
		int num = Integer.parseInt(request.getParameter("num"));
	
		 Class.forName("com.mysql.jdbc.Driver");
	
	     Connection conn = DriverManager.getConnection(
	         "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
	     
	     String sqlStr = "select * from review where review_num=?";
	     PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	     
	     pstmt.setInt(1, num);
	     ResultSet rs = pstmt.executeQuery();
	     
	     if(rs.next()) {
	%>
	<form action="updateReview.jsp" method="post">
	<input type="hidden" name="num" value="<%= rs.getInt("review_num") %>">
	<table>
	<tr><td>상품명</td>		<td><input type="text" name="product" value="<%= rs.getString("product_name") %>" style="width:100%;" readonly></td></tr>
	<tr><td>제목</td>		<td><input type="text" name="title" value="<%= rs.getString("review_title") %>" style="width:100%;"></td></tr>
	<tr><td>사진 변경</td>		<td><input type="file" name="filename1" entype="multipart/form-data"></td></tr>
	<tr><td>내용 </td>	<td><textarea name="content" style="width:100%; height:300px"><%= rs.getString("review_content") %></textarea></td></tr>
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