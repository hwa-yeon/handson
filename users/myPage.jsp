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
	<a href="myPage_detail.jsp" style="color:black; text-decoration:none; font-size:30px; margin-left:30px; margin-top:40px">
	안녕하세요. <%= rs.getString("user_nickName") %>님</a><br>
	<span style="margin-left: 30px">사용자 이름: <%= rs.getString("user_name") %> /</span>
	<span>사용자 닉네임: <%= rs.getString("user_nickName") %></span>
	<hr>
	<% if(!rs.getString("user_purpose").equals("판매자")) { %>
	<h3 style="margin-left: 30px">주문내역</h3>
	<table>
	<tr>
	<th>이미지</th>
	<th>상품명</th>
	<th>수량</th>
	<th>상품총금액</th>
	<th>주문처리상태</th>
	</tr>
	<%
	sqlStr = "select * from orders where user_id=?";
	pstmt = conn.prepareStatement(sqlStr);
    pstmt.setString(1, ID);
    rs = pstmt.executeQuery();
    while(rs.next()) {
    	int count = rs.getInt("order_count");
    	int cnt = count-1;
    	sqlStr = "select * from product where product_name=?";
    	PreparedStatement pstmt1 = conn.prepareStatement(sqlStr);
        pstmt1.setString(1, rs.getString("product_name"));
        ResultSet rset = pstmt1.executeQuery();
        if(rset.next()) {
    %>
    	<tr>
    	<td><img src="<%=rset.getString("image_path")%>" width=150 height=120></img></td>
    	<% if(cnt == 0) { %>
    	<td><%= rs.getString("product_name") %></td>
    	<% } else { %>
    	<td><%= rs.getString("product_name") %> 외 <%= cnt %>개</td>
    	<% } %>
    	<td><%= count %>개</td>
    	<td><%= rs.getInt("order_totalprice") %>원</td>
    	<td><%= rs.getString("order_state") %></td>
    	</tr>
    <%
        }
        rset.close();
        pstmt1.close();
    }
    
	%>
	</table>
	
	<%
      }
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