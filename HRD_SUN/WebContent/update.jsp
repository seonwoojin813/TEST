<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
    
    <%
    //파라미터 인코딩 처
    request.setCharacterEncoding("utf-8");
    
    //파라미터 읽기
    String custno = request.getParameter("custno");
    String custname = request.getParameter("custname");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String joindate = request.getParameter("joindate");
    String grade = request.getParameter("grade");
    String city = request.getParameter("city");
    
    //앞의 숫자 4개를 가져와서 년도 4자리 정수 만들기
    //joindate에서 년도 4자리 월 2자리 일 2자리를 추출해서
    //java.sql.Date로 만들기
    //Date(1900년도 지나온 년도, 월-1, 일)
    int year = Integer.parseInt(joindate.substring(0,4));
    int month = Integer.parseInt(joindate.substring(5,7));
    int day = Integer.parseInt(joindate.substring(8));
    Date updatedate = new Date(year-1900, month-1, day);
    
  //데이터베이스 접속
    Class.forName("oracle.jdbc.OracleDriver");
    Connection con = DriverManager.getConnection(
    		"jdbc:oracle:thin:@192.168.0.100:1521/xe",
    		"user06", "user06");
   
   PreparedStatement pstmt = con.prepareStatement("update member_tbl_02 " + 
   "set custname=?, phone=?, address=?, joindate=?, grade=?, city=? where custno=?");
   
   pstmt.setString(1, custname);
   pstmt.setString(2, phone);
   pstmt.setString(3, address);
   pstmt.setDate(4, updatedate);
   pstmt.setString(5, grade);
   pstmt.setString(6, city);
   pstmt.setInt(7, Integer.parseInt(custno));
   
   pstmt.executeQuery();
   
   pstmt.close();
   con.close();
   
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>