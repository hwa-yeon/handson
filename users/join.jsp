<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<html>
<head>
<link rel="stylesheet" href="../css/menu.css">
<link rel="stylesheet" href="../css/loginjoin.css">
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
  <h1>회원가입</h1>
  <form action="insertUser.jsp" method="post">
  <table>
  	 <tr><td>아이디</td> <td><input type="text" name="ID"></td></tr>
     <tr><td>비밀번호</td> <td><input type="password" name="password"></td></tr>
     <tr><td>비밀번호 확인</td> <td><input type="password" name="password2"></td></tr>
     <tr><td>이름</td> <td><input type="text" name="name"></td></tr>
     <tr><td>닉네임</td> <td><input type="text" name="nickName"></td></tr>
     <tr><td>전화번호</td> <td><input type="text" name="phoneNum"></td></tr>
     <tr><td>주소</td> <td><input type="text" name="address"></td></tr>
     <tr><td>가입 목적</td> <td><input type="radio" name="purpose" value="판매자" />판매자 <input type="radio" name="purpose" value="구매자" />구매자</td></tr>
     </table>
     <br>
    <input id="button" type="submit" value="가입하기">
  </form>
  </div>
  </div>
</body>
</html>
          
