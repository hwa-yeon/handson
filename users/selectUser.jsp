<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핸손</title>
</head>
<body>
	<%
    String ID = request.getParameter("ID");
	String password = request.getParameter("password");
  %>
  <%
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      
      String sqlStr = "select * from users where user_id=? and user_pw=?";
      
      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
      pstmt.setString(1, ID);
      pstmt.setString(2, password);
      
      ResultSet rs = pstmt.executeQuery();
      
      if(rs.next()) {
    	  session.setAttribute("sessionID", ID);
    	  session.setAttribute("sessionpw", password);
	%>
	<script>
		location.href = '../home/index.jsp';
	</script>
 	<% 
      }
      else {
 %>
 <script>
 	alert("아이디 또는 비밀번호를 틀렸습니다.");
 	location.href = 'login.jsp';
 </script>
<% 
      }
%>
 
 <% 
 	  rs.close();
 	  pstmt.close();
      conn.close();
  %>
</body>
</html>