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
		String name = request.getParameter("name");
		int price = Integer.parseInt(request.getParameter("price"));
		String info = request.getParameter("info");
		String category = request.getParameter("category");

	
		 Class.forName("com.mysql.jdbc.Driver");
	
	     Connection conn = DriverManager.getConnection(
	         "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
	     
	     String sqlStr = "update product set product_price=?, product_info=?, product_category=?, image_path=? where product_name=?";
	     PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	     
	     pstmt.setInt(1, price);
	     pstmt.setString(2, info);
	     pstmt.setString(3, category);
	     pstmt.setString(4, fullpath);
	     pstmt.setString(5, name);
	     pstmt.executeUpdate();
	     
	     pstmt.close();
	     conn.close();	
	%>
<script>
location.href = 'index.jsp';
</script>
</body>
</html>