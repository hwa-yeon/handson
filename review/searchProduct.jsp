<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<html>
<head>
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
  <h3 style = "color: rgb(38, 78, 142); margin:20px">상품명을 입력하세요:</h3>
  <form method="post">
     <span style="margin-left:20px">상품명:</span>    <input type="text" name="product"> &nbsp
    <input type="submit" value="검색" id="button">
  </form>
 
  <%
    String product = request.getParameter("product");
    if (product != null) {
  %>
  <%
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      Statement stmt = conn.createStatement();
 
      String sqlStr = "SELECT * FROM product WHERE product_name LIKE ";
	sqlStr += "'%" + product +"%'";
      ResultSet rset = stmt.executeQuery(sqlStr);
  %>
      <hr>
      <form method="post" action="write.jsp" >
        <table style="width:60%; margin-left: 30px">
          <tr>
          	<th></th>
            <th>상품명</th>
            <th>판매자</th>
          </tr>
          
          <%
      while (rset.next()) {
        String product_name = rset.getString("product_name");
        String seller_id = rset.getString("user_id");
        
        String sql1 = "select * from users where user_id=?";
	      
	      PreparedStatement pstmt1 = conn.prepareStatement(sql1);
	      pstmt1.setString(1, seller_id);
	      
	      ResultSet rset1 = pstmt1.executeQuery();
	      if(rset1.next()) {
  %>
          <tr>
            <td><input type="radio" name="product" value="<%= product_name %>"></td>
            <td><%= product_name %></td>
            <td><%= rset1.getString("user_nickName") %></td>
          </tr>
  <%
	      }
	      rset1.close();
	      pstmt1.close();
      }
  %>
        </table>
          <br>
        <div style="text-align:right; margin-right: 490px">
        <input type="submit" value="선택하기" id='button'>
        <input type="reset" value="초기화" id='button'>
        </div>
      </form>
  <%
  	 
      rset.close();
      stmt.close();
      conn.close();
    }
  %>
  </div>
  </div>
</body>
</html>
          
