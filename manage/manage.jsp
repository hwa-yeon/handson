<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/menu.css">
<link rel="stylesheet" href="../css/manage.css">
<meta charset="UTF-8">
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
	    	  if(rs.getString("user_purpose").equals("관리자")) {
	    		  %>
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
	          
	          <br><br>
				<div class="manage">
				<article>
				<div><a href="productlist.jsp">부적절한 상품 삭제</a></div>
				</article>
				<article>
				<div><a href="reviewlist.jsp">부적절한 리뷰 삭제</a></div>
				</article>
				<article>
				<div><a href="orderlist.jsp">주문처리상태 변경</a></div>
				</article>
				</div>

			  </div>
			  </div>
			  <% 
	    		   } else {
	    			  %>
	    			 <script>
					alert("관리자만 접근가능한 페이지입니다.");
					location.href = '../home/index.jsp';
					</script>
  
<% 
				} 
	    	  } 
	}
	    	  %>
</body>
</html>