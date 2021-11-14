<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/menu.css">
<link rel="stylesheet" href="../css/index.css">
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
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      Statement stmt = conn.createStatement();
 %>
      
      <table>
      <tr>
<%
	String sqlStr = "select * from product where product_category='식품'";
	ResultSet rs = stmt.executeQuery(sqlStr);
	int count = 0;
	
	while(rs.next()) {
	
	    	  if((count%4)==0 && count!= 0) {
%>
        </tr>
        <tr>
<% } %>
          <td><a href="index_detail.jsp?name=<%=rs.getString("product_name") %>"><img src = "<%=rs.getString("image_path")%>" width=250 height=200></img></a><br>
          <a href="index_detail.jsp?name=<%=rs.getString("product_name") %>"><%=rs.getString("product_name") %></a><br>
          <a href="index_detail.jsp?name=<%=rs.getString("product_name") %>"><%=rs.getString("product_price") %>원</a><br>
          </td>
<%   		    
	      count++;
	}
    rs.close();
    stmt.close();
    conn.close();
%>
</tr>
</table>
        </div>
        </div>
</body>
</html>