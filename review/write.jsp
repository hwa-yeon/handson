<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/menu.css">
<link rel="stylesheet" href="../css/table.css">
<meta charset="UTF-8">
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
String product = request.getParameter("product");
if(session.getAttribute("sessionID") != null) { 
	String ID = (String)session.getAttribute("sessionID");
	
	 Class.forName("com.mysql.jdbc.Driver");

     Connection conn = DriverManager.getConnection(
         "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
     
     String sqlStr = "select * from users where user_id=?";
     PreparedStatement pstmt = conn.prepareStatement(sqlStr);
     pstmt.setString(1, ID);
     
     ResultSet rs = pstmt.executeQuery();
     
     if(rs.next()) {
   	  if(rs.getString("user_purpose").equals("판매자")) {
   		  %>
   		  <script>
   		  alert("구매자만 접근가능한 페이지입니다.");
   		  location.href = "list.jsp";
   		  </script>
   		  <% } else {
%>
	<form action="insertReview.jsp" method="post">
	<input type="hidden" name="ID" value="<%= session.getAttribute("sessionID") %>">
	
	<table>
	<tr><td colspan="2"><a href="searchProduct.jsp">상품 검색하기</a></td></tr>
	<tr><td>상품</td>	<td><input type="text" name="product" value="<%= product %>" style="width:100%;"readonly></td></tr>
	<tr><td>제목</td>	<td><input type="text" name="title" style="width:100%;"></td></tr>
	<tr><td>사진</td><td><input type="file" name="filename1" entype="multipart/form-data"></td></tr>
	<tr><td>내용</td>	<td><textarea name="content" style="width:100%; height:300px"></textarea></td></tr>
	</table>
	<br>
	<div  style="text-align: right;  padding-right:50px;">
	<input type="submit" value="글쓰기" id="button">
	</div>
	</form>
<%
	} 
     }
     rs.close();
     pstmt.close();
     conn.close();
}
	else {
%>
	<script>
	alert("로그인 후 이용가능합니다.");
	location.href = '../users/login.jsp';
	</script>
<%
	}
%>
</div>
</div>
</body>
</html>