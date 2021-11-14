<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.Timestamp" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
 String realFolder = "";
 String filename1 = "";
 int maxSize = 1024*1024*5;
 String encType = "UTF-8";
 String savefile = "img";
 ServletContext scontext = getServletContext();
 realFolder = scontext.getRealPath(savefile);
 
 try{
  MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

  Enumeration<?> files = multi.getFileNames();
     String file1 = (String)files.nextElement();
     filename1 = multi.getFilesystemName(file1);
 } catch(Exception e) {
  e.printStackTrace();
 }
 
 String fullpath = realFolder + "\\" + filename1;
%>

<title>핸손</title>
</head>
<body>
	<%
    String ID = request.getParameter("ID");
  	String product = request.getParameter("product");
  	String title = request.getParameter("title");
  	String content = request.getParameter("content");
  	int readcount = 0;
  	int heartcount = 0;
  	Timestamp nowTime = new Timestamp(System.currentTimeMillis());
  %>
  <%
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
 
      String sqlStr = "INSERT INTO review (product_name, review_title, review_content, review_read, review_heart, user_id, review_date, image_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
      
      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
      pstmt.setString(1, product);
      pstmt.setString(2, title);
      pstmt.setString(3, content);
      pstmt.setInt(4, readcount);
      pstmt.setInt(5, heartcount);
      pstmt.setString(6, ID);
      pstmt.setString(7, nowTime.toString().substring(0,16));
      pstmt.setString(8, fullpath);
      
      pstmt.executeUpdate();
      
  %>
  <%
      pstmt.close();
      conn.close();
  %>
<script>
	location.href = 'list.jsp';
</script>
</body>
</html>