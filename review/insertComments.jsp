<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.Timestamp" %>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핸손</title>
</head>
<body>
	<%
	int num = Integer.parseInt(request.getParameter("num"));
    String ID = request.getParameter("ID");
  	String content = request.getParameter("content");
  	Timestamp nowTime = new Timestamp(System.currentTimeMillis());
  %>
  <%
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      Statement stmt = conn.createStatement();
 
      String sqlStr = "INSERT INTO comments (review_num, user_id, comment_content, comment_date) VALUES (?, ?, ?, ?)";
      
      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
      pstmt.setInt(1, num);
      pstmt.setString(2, ID);
      pstmt.setString(3, content);
      pstmt.setString(4, nowTime.toString().substring(0,16));
      
      pstmt.executeUpdate();
      
      sqlStr = "SELECT * FROM review WHERE review_num =" + num;
      ResultSet rs = stmt.executeQuery(sqlStr);
  	
  		if(rs.next()) {
	  		String user_id = rs.getString("user_id");
	  		String sql = "select * from users where user_id=?";
	  	      
	  	      pstmt = conn.prepareStatement(sql);
	  	      pstmt.setString(1, user_id);
	  	      
	  	      ResultSet rset = pstmt.executeQuery();
	  	      if(rset.next()) {
  %>
 
<script>
	location.href = 'content.jsp?num=<%= num %>&nickname=<%= rset.getString("user_nickName") %>';
</script>
 <%
	  	      }
	  	      rset.close();
  		}
  	  rs.close();
  	  stmt.close();
      pstmt.close();
      conn.close();
  %>
</body>
</html>