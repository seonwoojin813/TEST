<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.sql.*" %>
<%
    //custno를 이용해서 데이터 찾아오기
    int custno = Integer.parseInt(request.getParameter("custno"));

//데이터베이스 접속
Class.forName("oracle.jdbc.OracleDriver");
Connection con = DriverManager.getConnection(
		"jdbc:oracle:thin:@192.168.0.100:1521/xe",
		"user06", "user06");
//기본키를 가지고 데이터 찾아오기
PreparedStatement pstmt =
  con.prepareStatement("select * from member_tbl_02 where custno=?");
  pstmt.setInt(1, custno);
//SQL 실행
ResultSet rs = pstmt.executeQuery();

rs.next();
String custname = rs.getString("custname");
String phone = rs.getString("phone");
String address = rs.getString("address");
Date joindate = rs.getDate("joindate");
String grade = rs.getString("grade");
String city = rs.getString("city");

rs.close();
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
   <h2 align="center">홈쇼핑 회원 정보 수정</h2>
   <form id="update.form">
     <table align="center" border="1">
     <tr>
     <td align="center" width="250">회원번호(자동발생)</td>
     <td width="250">
     <input type="text" value=<%=custno%>
      name="custno" id="custno"
      readonly="readonly"/></td>
     </tr>
     <tr>
     <td align="center">회원성명</td>
     <td>
     <input type="text" 
     name="custname" id="custname" value='<%=custname%>'/>
     </td>
     </tr>
      <tr>
     <td align="center">회원전화</td>
     <td>
     <input type="text" name="phone" id="phone" value='<%=phone%>'/>
     </td>
     </tr>
      <tr>
     <td align="center">회원주소</td>
     <td>
     <input type="text" name="address" id="address" value='<%=address%>'/>
     </td>
     </tr>
      <tr>
     <td align="center">가입일자</td>
     <td>
     <input type="text" value="<%=joindate %>"
      name="joindate" id="joindate"/>
     </td>
     </tr>
     <tr>
     <td align="center">고객등급[A:VIP,B:일반,C:직원]</td>
     <td>
     <input type="text" name="grade" id="grade" value='<%=grade%>'/>
     </td>
     </tr>
      <tr>
     <td align="center">도시코드</td>
     <td>
     <input type="text" name="city" id="city" value='<%=city%>'/>
     </td>
     </tr>
     <tr>
     <td colspan="2" align="center">
     <input type="button" value="수정" id="updatebtn"/>
     <input type="button" value="조회" id="searchbtn"/>
     </table>
   </form>
 <script>
   //등록버튼을 클릭하면
   document.getElementById("updatebtn")
   .addEventListener("click", function(e){
   //회원성명 입력란을 찾아오기
 	
 	/*
 	//유효성 검사가 있으면 이렇게
	 var c = document.getElementById('city')
	 	if(c.value.trim().length == 0){
	 	alert("도시코드가 입력되지 않았습니다.");
	 	c.focus();
	 	return;		
	 	}
 	*/
 	
 	//유효성검사란 말이 없으면 이렇게
 	//var n = document.getElementById('custname')
 	
 	//입력란 찾아오기
 	var no = document.getElementById('custno')
 	var n = document.getElementById('custname')
 	var p = document.getElementById('phone')
 	var a = document.getElementById('address')
 	var j = document.getElementById('joindate')	
 	var g = document.getElementById('grade')
 	var c = document.getElementById('city')
 	
 	
 	//폼의 데이터 전송
 	//document.getElementById("registerform").submit();
 	
 	//폼의 데이터를 가지고 insert.jsp 파일에 ajax요청
 	//ajax 객체 생성
 	var request = new XMLHttpRequest();
 	
 	//전송할 URL을 생성
     var url = "update.jsp?"
     //URL에 파라미터 붙이기
    url += "custno=" + no.value;
 	url += "&custname=" + n.value;
 	url += "&phone=" + p.value;
 	url += "&address=" + a.value;
 	url += "&joindate=" + j.value;
 	url += "&grade=" + g.value;
 	url += "&city=" + c.value;
     		
 	//alert(url); --> 이건 여기서 확인
 	//값을 확인 하고싶으면 console.log(url); ->크롬에서 확인
 	
 	//ajax 요청을 생성
    request.open('GET', encodeURI(url));
    request.send('');
  
    
    //요청에 성공했을 때 수행할 내용 작성
    request.onreadystatechange = function(){
 	 //readyState == 4, 데이터를 전부 받은 상태
 	   if(request.readyState == 4){
 		  alert("회원정보 수정이 완료되었습니다.")
 	   }
    }
    
 	
 });
 </script>
</body>
</html>