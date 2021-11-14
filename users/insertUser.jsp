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
  	String name = request.getParameter("name");
  	String nickName = request.getParameter("nickName");
  	String phoneNum = request.getParameter("phoneNum");
  	String address = request.getParameter("address");
  	String purpose = request.getParameter("purpose");
  %>
  <%
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
      
	 String sqlStr1 = "select * from users where user_id=?";
	 String sqlStr2 = "select * from users where user_nickName=?";

      
      PreparedStatement pstmt1 = conn.prepareStatement(sqlStr1);
      pstmt1.setString(1, ID);
      
      PreparedStatement pstmt2 = conn.prepareStatement(sqlStr2);
      pstmt2.setString(1, nickName);
      
      ResultSet rs1 = pstmt1.executeQuery();
      ResultSet rs2 = pstmt2.executeQuery();
      
      if(!password.equals(password2)) {
   %>
   <script>
   		alert("비밀번호를 확인해주세요.");
   		location.href = 'join.jsp';
   	</script>
   <%
      } else if(rs1.next()) {
    %>
    <script>
    	alert("아이디가 중복됩니다.");
    	location.href = 'join.jsp';
    </script>
    <% 
    	rs1.close();
   		pstmt1.close();
      } else if(rs2.next()) {
     %>
     <script>
     	alert("닉네임이 중복됩니다.");
    	location.href = 'join.jsp';
    </script>
     <% 
     	rs2.close();
		pstmt2.close();
      }	
      else {
 
      String sqlStr = "INSERT INTO users (user_id, user_pw, user_name, user_phoneNum, user_nickName, user_address, user_purpose) VALUES (?, ?, ?, ?, ?, ?, ?)";
      
      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
      pstmt.setString(1, ID);
      pstmt.setString(2, password);
      pstmt.setString(3, name);
      pstmt.setString(4, phoneNum);
      pstmt.setString(5, nickName);
      pstmt.setString(6, address);
      pstmt.setString(7, purpose);
      
      pstmt.executeUpdate();
 	%>
 	 <script>
   		alert("회원가입에 성공하였습니다.");
   		location.href = 'login.jsp';
   	</script>
 <% 
      pstmt.close();
      }
      conn.close();
  %>
</body>
</html>