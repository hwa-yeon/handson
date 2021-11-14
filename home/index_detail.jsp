<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<html>
<head>
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
    String name = request.getParameter("name");

      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      Statement stmt = conn.createStatement();

        String sqlStr = "SELECT * FROM product WHERE product_name=?";
        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
        pstmt.setString(1, name);

    	ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
        	String ID = rs.getString("user_id");
        	String session_id = (String)session.getAttribute("sessionID");
        	
        	sqlStr = "SELECT * FROM users WHERE user_id =?";
        	pstmt= conn.prepareStatement(sqlStr);
        	pstmt.setString(1, ID);
        	ResultSet rset = pstmt.executeQuery();
        	if(rset.next()) {
  %>
       <table>
       <tr>
       <td style="width:900px"><img src = "<%=rs.getString("image_path")%>" width=600 height=480></img></td>
       <td style="text-align:left; font-size: 20px">상품명:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <%= rs.getString("product_name") %><br>
       상품정보:&nbsp&nbsp&nbsp&nbsp&nbsp <%= rs.getString("product_info") %><br>
       판매자닉네임: <%= rset.getString("user_nickName") %><br>
       가격:&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp <%= rs.getString("product_price") %>원<br><br>
       <form  action="insertBasket.jsp" method="post">
       수량: <select name="count" style="width:70px">
				<option>1</option>
				<option>2</option>
				<option>3</option>
				<option>4</option>
				<option>5</option>
			</select>
			<input type="hidden" name="product_name" value="<%= rs.getString("product_name") %>">
			<input type="hidden" name="user_id" value="<%= session.getAttribute("sessionID") %>">
			<input id="button" type="submit" value="장바구니 담기">
		</form>
       </td>
       </tr>
       </table>
 
 	<%    
  		if(session_id != null) {
  			if(ID.equals(session_id)) {
  				
   %>
   <div style=" text-align:right; padding-right:50px">
   	<a href='deleteAsk.jsp?product=<%= rs.getString("product_name") %>'>delete</a>
	<a href='editProduct.jsp?product=<%= rs.getString("product_name") %>'>edit</a> <br>
	</div>
   <% 
    	  }
      	}
 	
 	%>
    <% 
       		 }
        	rset.close();
        }
      rs.close();
      pstmt.close();
      stmt.close();
      conn.close();
  %>
  
  <br>
  <div style=" text-align:right; padding-right:50px">
  <button type="button" onclick="location.href='index.jsp' " id='button'>상품 목록보기</button>
  </div>
  </div>
  </div>
</body>
</html>
        