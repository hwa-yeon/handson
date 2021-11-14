<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/menu.css">
<link rel="stylesheet" href="../css/table.css">
<title>핸손</title>
</head>
<body>
<% 
	String festival = request.getParameter("festival");
	if(session.getAttribute("sessionID") == null) { 
%>
<script>
alert("로그인 후 이용가능합니다.");
location.href = '../users/login.jsp';
</script>
<%
	} 
	else {
		String ID = (String)session.getAttribute("sessionID");
	
		 Class.forName("com.mysql.jdbc.Driver");
	
	      Connection conn = DriverManager.getConnection(
	          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
	      
	      String sqlStr = "select * from users where user_id=?";
	      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	      pstmt.setString(1, ID);
	      
	      ResultSet rs = pstmt.executeQuery();
	      
	      if(rs.next()) {
	    	  if(rs.getString("user_purpose").equals("구매자")) {
	    		  %>
	    		  <script>
	    		  alert("판매자만 접근가능한 페이지입니다.");
	    		  location.href = "index.jsp";
	    		  </script>
	    		  <% } else {
	    			  %>
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
        <form action="insertProduct.jsp" method="post">
			<input type="hidden" name="ID" value="<%= session.getAttribute("sessionID") %>">
			
			<table>
			<tr><td>상품명</td>		
			<td><input type="text" name="name" style="width:80%;"></td></tr>
			<tr><td>상품 사진</td>
			<td><input type="file" name="filename1" entype="multipart/form-data"></td></tr>
			<tr><td>상품 가격</td>		
			<td><input type="text" name="price" style="width:80%;"></td></tr>
			<tr><td>상품 정보</td>	
			<td><textarea name="info" style="width:80%; height:300px"></textarea></td></tr>
			<tr><td>카테고리</td>	
			<td><select name="category" style="width:80%">
				<option>식품</option>
				<option>의류</option>
				<option>악세서리</option>
				<option>인테리어</option>
				<option>기타</option>
			</select>
			</td></tr>
			</table>
			<br>
			<div  style="text-align: right;  padding-right:50px;">
			<input id="button" type="submit" value="상품 등록하기">
			</div>
		</form>
        </div>
        </div>
	    			  <%
	    		  }
	    	  }
	      rs.close();
	      pstmt.close();
	      conn.close();
	      }
%>
</body>
</html>