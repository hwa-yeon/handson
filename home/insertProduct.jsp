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
  	String name = request.getParameter("name");
	String price = request.getParameter("price");
  	String info = request.getParameter("info");
  	String category = request.getParameter("category");
  %>
  <%
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/handson?characterEncoding=utf-8", "root", "popo3737"); 
 
      String sqlStr = "INSERT INTO product (user_id, product_name, product_info, product_price, product_category, image_path) VALUES (?, ?, ?, ?, ?, ?)";
      
      PreparedStatement pstmt = conn.prepareStatement(sqlStr);
      pstmt.setString(1, ID);
      pstmt.setString(2, name);
      pstmt.setString(3, info);
      pstmt.setInt(4, Integer.parseInt(price));
      pstmt.setString(5, category);
      pstmt.setString(6, fullpath);

      pstmt.executeUpdate();
      
  %>
  <%
      pstmt.close();
      conn.close();
  %>
<script>
	location.href = 'index.jsp';
</script>
</body>
</html>