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
  <%
    String num = request.getParameter("num");
  	String nickname = request.getParameter("nickname");
  	String ID = (String)session.getAttribute("sessionID");

      Class.forName("com.mysql.jdbc.Driver");
      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      Statement stmt = conn.createStatement();
  %>
  <table style="border:1px solid #444444;">

  <%
        String sqlStr = "UPDATE review SET review_read = review_read + 1 WHERE review_num = " + num;
        stmt.executeUpdate(sqlStr);
        sqlStr = "SELECT * FROM review WHERE review_num =" + num;
        ResultSet rs = stmt.executeQuery(sqlStr);
        if (rs.next()) {
  %>
        <tr><td id="color">상품명</td>		
        <td colspan="3"><%= rs.getString("product_name") %></td></tr>
		<tr><td id="color">제목</td>		
		<td colspan="3"><%= rs.getString("review_title") %></td></tr>
		<tr><td id="color">작성자</td>	
		<td><%= nickname %></td>	
		<td id="color">작성일</td>	
		<td><%= rs.getString("review_date") %></td></tr>
		<tr><td id="color">조회수</td>	
		<td><%= rs.getInt("review_read") %></td>	
		<td id="color"><a href="heart.jsp?num=<%= num %>" style="text-decoration:none; color: black;">좋아요</a></td>	
		<td><%= rs.getInt("review_heart") %></td></tr>
		<tr><td id="color" style="height:400px;">내용 </td>	
		<td colspan="3" style = "width:750px; height:400px;">
		<img src="<%=rs.getString("image_path")%>" width=512 height=384></img> <br> <%= rs.getString("review_content") %></td></tr>
		</table>
  <%    
  		if(ID != null) {
  			if(ID.equals(rs.getString("user_id"))) {
  				
   %>
   <div style=" text-align:right; padding-right:30px">
   	<a href='deleteAsk.jsp?num=<%= rs.getInt("review_num") %>'>delete</a>
	<a href='editReview.jsp?num=<%= rs.getInt("review_num") %>'>edit</a> <br>
	</div>
   <% 
    	  }
      	}
      }
    %>
    <strong style="color:rgb(38, 78, 142);">댓글</strong>
    <table style="width:90%;">
    <%
        sqlStr = "select * from comments where review_num=" + num;
    	rs = stmt.executeQuery(sqlStr);
    	
    	while(rs.next()) {
    		String user_id = rs.getString("user_id");
    		String sql = "select * from users where user_id=?";
    	      
    	      PreparedStatement pstmt = conn.prepareStatement(sql);
    	      pstmt.setString(1, user_id);
    	      
    	      ResultSet rset = pstmt.executeQuery();
    	      if(rset.next()) {
    %>
            <tr>
              <td colspan="2" style="border:1px solid #444444; text-align: left"><%= rs.getString("comment_content") %></td>
              <td style="border:1px solid #444444; width:50px"><%= rset.getString("user_nickName") %></td>
            </tr>
    <%   	} 
    	   rset.close();
    	}
    %>
    <form action="insertComments.jsp" method="post">
    <input type="hidden" name="num" value="<%= num %>">
    <input type="hidden" name="ID" value="<%= session.getAttribute("sessionID") %>">
    <tr>
    	<td colspan="3" style="border:1px solid #444444;"><textarea name="content" style=" width:90%; height:70px"></textarea>
    	&nbsp&nbsp<input type="submit" value="댓글 작성"  id="button"></td>
    </tr>
    </form>
    </table>	
    <% 
      rs.close();
      stmt.close();
      conn.close();
  %>
  
  <br>
  <div style=" text-align:right; padding-right:20px">
  <button type="button" onclick="location.href='list.jsp' " id='button'>리뷰 목록보기</button>
  </div>
  </div>
  </div>
</body>
</html>
        