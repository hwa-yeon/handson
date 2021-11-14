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
	String password2 = request.getParameter("password2");
  	String nickName = request.getParameter("nickName");
  	String phoneNum = request.getParameter("phoneNum");
  	String address = request.getParameter("address");
  %>
  <%
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      
      if(!password.equals(password2)) {
   %>
   <script>
   		alert("비밀번호를 확인해주세요.");
   		location.href = 'editUser.jsp';
   	</script>
   <%
      } 
      else {
      String sqlStr = "update users set user_pw=?, user_phoneNum=?, user_nickName=?, user_address=? where user_id=?";
     
      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	     
      pstmt.setString(1, password);
      pstmt.setString(2, phoneNum);
      pstmt.setString(3, nickName);
      pstmt.setString(4, address);
      pstmt.setString(5, ID);
      pstmt.executeUpdate();
 	%>
 	 <script>
   		alert("회원정보를 수정하였습니다.");
   		location.href = 'myPage_detail.jsp';
   	</script>
 <% 
      pstmt.close();
      }
      conn.close();
  %>
</body>
</html>