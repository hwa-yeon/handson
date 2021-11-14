<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<html>
<head>
  <title>핸손</title>
</head>
<body>
 
  <%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection(
	    "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
	Statement stmt = conn.createStatement();
	
		String num = request.getParameter("num");

        String sqlStr = "UPDATE review SET review_heart = review_heart + 1 WHERE review_num = " + num;
        stmt.executeUpdate(sqlStr);
        
        sqlStr = "SELECT * FROM review WHERE review_num =" + num;
        ResultSet rs = stmt.executeQuery(sqlStr);
    	
    		if(rs.next()) {
  	  		String user_id = rs.getString("user_id");
  	  		String sql = "select * from users where user_id=?";
  	  	      
  	  		  PreparedStatement pstmt = conn.prepareStatement(sql);
  	  	      pstmt.setString(1, user_id);
  	  	      
  	  	      ResultSet rset = pstmt.executeQuery();
  	  	      if(rset.next()) {
    %>
   
  <script>
  	location.href = 'content.jsp?num=<%= num %>&nickname=<%= rset.getString("user_nickName") %>';
  </script>
   <%
  		 pstmt.close();
   		rset.close();
   		rs.close();
   	 	stmt.close();
     	conn.close();
  	  	      }
    		}	
%>
    
</body>
</html>
        