<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
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
   if(session.getAttribute("sessionID") != null) { 
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      Statement stmt = conn.createStatement();
 %>
      
      <table style="width:100%; border-top:1px solid #444444; border-collapse:collapse;">
      <tr style="background-color: rgb(213, 198, 230);">
      	<th>상품명</th>
        <th>제목</th>
        <th>작성자</th>
        <th>날짜</th>
        <th>조회수</th>
        <th>좋아요</th>
      </tr>
<%

	String sqlStr = "select * from review where user_id=?";
	PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	pstmt.setString(1, (String)session.getAttribute("sessionID"));
	
	ResultSet rs = pstmt.executeQuery();
	
	while(rs.next()) {
		String ID = rs.getString("user_id");
		String sql = "select * from users where user_id=?";
	      
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1, ID);
	      
	      ResultSet rset = pstmt.executeQuery();
	      if(rset.next()) {
%>
        <tr>
          <td><%= rs.getString("product_name") %></td>
          <td><a href="content.jsp?num=<%= rs.getInt("review_num") %>&nickname=<%= rset.getString("user_nickName") %>" style="text-decoration:none; color:black"> 
          <%= rs.getString("review_title") %> </a></td>
          <td><%= rset.getString("user_nickName") %></td>
          <td><%= rs.getString("review_date") %></td>
          <td><%= rs.getInt("review_read") %></td>
          <td><%= rs.getInt("review_heart") %></td>
        </tr>
<%   	}
	      rset.close();
	}
    rs.close();
    stmt.close();
    conn.close();
   } else {
%>
<script>
	alert("로그인 후 이용 가능합니다.");
	location.href = '../users/login.jsp';
</script>
	<% } %>
</table>
<br>
<div  style="text-align: right;  padding-right:50px;">
<button type="button" onclick="location.href='list.jsp' " id='button'>전체 리뷰 보기</button>
 <button type="button" onclick="location.href='write.jsp' " id='button'>리뷰 작성하기</button>
</div>
</div>
</div>
</body>
</html>