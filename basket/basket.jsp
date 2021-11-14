<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/menu.css">
<link rel="stylesheet" href="../css/table.css">
<script>
        function check(box) {
            var mes = document.getElementById("checkproduct");
            var boxvalue = box.value;
            var array = boxvalue.split(",");
            
            x = parseInt(mes.value);
            y = parseInt(array[1]);
            if(box.checked) {
                var z = x + y;
                mes.value = z;
            }
            else {
                var z = x - y;
                mes.value = z;
            }
        }
    </script>
<title>핸손</title>
</head>
<body>
<% 
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
	      
	      ResultSet rset = pstmt.executeQuery();
	      
	      if(rset.next()) {
	    	  if(rset.getString("user_purpose").equals("판매자")) {
	    		  %>
	    		  <script>
	    		  alert("구매자만 접근가능한 페이지입니다.");
	    		  location.href = "../home/index.jsp";
	    		  </script>
	    		  <% } else {
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
		        <li><a href="basket.jsp">장바구니</a></li>
		        <li><a href="../review/list.jsp">리뷰게시판</a></li>
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
      <form method="post" name="form">
      <table>
      <tr>
      	<th></th>
        <th>이미지</th>
        <th>상품명</th>
        <th>가격</th>
        <th>수량</th>
        <th>총가격</th>
      </tr>
<%
	sqlStr = "select * from basket where user_id=?";
	pstmt = conn.prepareStatement(sqlStr);
	pstmt.setString(1, ID);

	ResultSet rs = pstmt.executeQuery();
	
	int total = 0;
	
	while(rs.next()) {
		sqlStr = "select * from product where product_name=?";
		pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, rs.getString("product_name"));

		ResultSet rs1 = pstmt.executeQuery();
		
		if(rs1.next()) {
		
		int price = rs1.getInt("product_price");
		int count = rs.getInt("basket_count");
		int total_price = price * count;
%>
        <tr>
          <td><input type="checkbox" name="product_check" value="<%= rs.getString("product_name") %>,<%= total_price %>" onclick="check(this)"></td>
          <td><img src="<%=rs1.getString("image_path")%>" width=150 height=120></img></td>
          <td><%= rs.getString("product_name") %></td>
          <td><%= price %>원</td>
          <td><%= count %> 개</td>
          <td>총 <%= total_price %>원</td>
        </tr>
        
<%   
	 total += total_price;
	 rs1.close();  	 
		}
	}

%>
</table>
<br>
<div  style="text-align: right;  padding-right:50px;">
 <input type="submit" value="선택 상품 삭제하기" onclick="javascript: form.action='deleteCheckBasket.jsp';" id='button'>
 <input type="text" style="border:0; width:123px;" readonly>
 <input type="submit" value="총 상품 삭제하기" onclick="javascript: form.action='deleteAllBasket.jsp';" id='button'>
 <br>
  선택상품: <input type="text" id="checkproduct" value="0" style="border:0; width:50px; text-align:right;" readonly>원
 <input type="submit" value="선택 상품 주문하기" onclick="javascript: form.action='insertCheckOrder.jsp';" id='button'>
  총상품: <input type="text" id="allproduct" value=<%= total %> style="border:0; width:50px; text-align:right;" readonly>원
 <input type="submit" value="총 상품 주문하기" onclick="javascript: form.action='insertAllOrders.jsp?total_price=<%= total %> ';" id='button'>
</div>
</form>

        
        </div>
        </div>
<%
	    		  rs.close();
	    		  }
	    	  }
	      rset.close();
	      pstmt.close();
	      conn.close();
	      } 
%>

</body>
</html>