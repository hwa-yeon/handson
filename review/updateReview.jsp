<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>핸손</title>
</head>
<body>
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
	<%
		int num = Integer.parseInt(request.getParameter("num"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");

	
		 Class.forName("com.mysql.jdbc.Driver");
	
	     Connection conn = DriverManager.getConnection(
	         "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
	     
	     String sqlStr = "update review set review_title=?, review_content=?, image_path=? where review_num=?";
	     PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	     
	     pstmt.setString(1, title);
	     pstmt.setString(2, content);
	     pstmt.setString(3, fullpath);
	     pstmt.setInt(4, num);
	     pstmt.executeUpdate();
	     
	     pstmt.close();
	     conn.close();	
	%>
<script>
location.href = 'list.jsp';
</script>
</body>
</html>