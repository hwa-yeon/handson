<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/menu.css">
<link rel="stylesheet" href="../css/loginjoin.css">
<meta charset="UTF-8">
<title>핸손</title>
</head>
<body>	
 <header class="menu">
	   	<a href="../home/index.jsp" id="title">핸손</a>
	       <ul>
	       	<li><a href="join.jsp">회원가입</a></li>
	           <% if(session.getAttribute("sessionID") == null) { %>
	           <li><a href="login.jsp">로그인</a></li>
	           <% } else { %>
	           <li><a href="logout.jsp">로그아웃</a></li>
	           <% } %>
		        <li><a href="../basket/basket.jsp">장바구니</a></li>
		        <li><a href="../review/list.jsp">리뷰게시판</a></li>
	           <li><a href="myPage.jsp">마이페이지</a></li>
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
	 String ID = (String)session.getAttribute("sessionID");
	 String password = (String)session.getAttribute("sessionpw");
	 
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      
      String sqlStr = "select * from users where user_id=? and user_pw=?";
      
      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
      pstmt.setString(1, ID);
      pstmt.setString(2, password);
      
      ResultSet rs = pstmt.executeQuery();
      if(rs.next()) {
      %>
      <h1>내 정보</h1>
      <table>
      <tr><td>사용자 이름</td><td><%= rs.getString("user_name") %></td><tr>
      <tr><td>사용자 닉네임</td><td><%= rs.getString("user_nickName") %></td><tr>
      <tr><td>사용자 아이디</td><td><%= rs.getString("user_id") %></td><tr>
      <tr><td>사용자 전화번호</td><td><%= rs.getString("user_phoneNum") %></td><tr>
      <tr><td>사용자 주소</td><td><%= rs.getString("user_address") %></td><tr>
      <tr><td>가입 목적</td><td><%= rs.getString("user_purpose") %></td><tr>
      </table>
	<br>
	<div style="text-align: right; margin-right: 20px"><a href='editUser.jsp' style="color:black">정보수정</a>
	<a href='logout.jsp' style="color:black">로그아웃</a>
	<a href='deleteAsk.jsp' style="color:black">회원탈퇴</a></div>
	
	<%
      }
    rs.close();
	pstmt.close();
    conn.close();
	 } else {
	%>
	<script>
	alert("로그인 후 이용 가능합니다.");
	location.href = 'login.jsp';
	</script>
	<% } %>
	</div>
	</div>
</body>
</html>