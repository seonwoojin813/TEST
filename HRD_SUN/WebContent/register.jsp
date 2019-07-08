<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
    //시퀀스 다음 값 가져오기
    
    //1.드라이버 클래스를 로드
    Class.forName("oracle.jdbc.OracleDriver");
    //2.데이터베이스 연결
    Connection con = DriverManager.getConnection(
    		"jdbc:oracle:thin:@192.168.0.100:1521/xe",
    		"user06", "user06");
    //입력받아야하는 항목이 있으면 ?로 작성		
    PreparedStatement pstmt = con.prepareStatement(
    		"select max(custno) from member_tbl_02");
    //?가 있으면 물음표를 채우기
    //select 구문은 ResultSet으로 받아야 하고
    //나머지는 정수로 받으면 됩니다.
    //실행할 때 select는 executeQuery()
    //나머지는 executeUpdate()
    //3.PreparedStatement를 만들어서 SQL을 실행
    ResultSet rs = pstmt.executeQuery();
    //4.결과를 사용(Select 에서만 사용)
    //결과를 저장할 변수를 만들어
    int maxno = -1;
    
    //가장 큰 글번호 찾기
    //하나일때는 if 여러개일떄는 while	
    	if(rs.next()){
    		maxno = rs.getInt("max(custno)");
    	}
    //마지막 번호 + 1
    maxno = maxno + 1;
  
    
    //5.열었던 모든 객체를 닫기
    rs.close();
    pstmt.close();
    con.close();	
    
    
    
    //현재 날짜 가져오기
    java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
    
    //toString을 호출하면 yyyy-MM-DD 형식의 문자열로 리턴
    String disp = today.toString();
    //-를 ""(공백)으로 변환
    disp = disp.replace("-", "");
%>

        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <h2 align="center">홈쇼핑 회원 등록</h2>
   <form action="insert.jsp" id="registerform">
     <table align="center" border="1">
     <tr>
     <td align="center" width="250">회원번호(자동발생)</td>
     <td width="250">
     <input type="text" value=<%=maxno%>
      name="custno" id="custno"
      readonly="readonly"/></td>
     </tr>
     <tr>
     <td align="center">회원성명</td>
     <td>
     <input type="text" 
     name="custname" id="custname"/>
     </td>
     </tr>
      <tr>
     <td align="center">회원전화</td>
     <td>
     <input type="text" name="phone" id="phone"/>
     </td>
     </tr>
      <tr>
     <td align="center">회원주소</td>
     <td>
     <input type="text" name="address" id="address"/>
     </td>
     </tr>
      <tr>
     <td align="center">가입일자</td>
     <td>
     <input type="text" value="<%=disp %>"
      name="joindate" id="joindate"/>
     </td>
     </tr>
     <tr>
     <td align="center">고객등급[A:VIP,B:일반,C:직원]</td>
     <td>
     <input type="text" name="grade" id="grade"/>
     </td>
     </tr>
      <tr>
     <td align="center">도시코드</td>
     <td>
     <input type="text" name="city" id="city"/>
     </td>
     </tr>
     <tr>
     <td colspan="2" align="center">
     <input type="button" value="등록" id="registerbtn"/>
     <input type="button" value="조회" id="searchbtn"/>
     </table>
   </form>
</body>
<script>

//조회버튼을 클릭하면 
document.getElementById("searchbtn").addEventListener("click", function(e){ 
//페이지 이동 
location.href = "list.jsp"; 
}); 


//등록버튼을 클릭하면
document.getElementById("registerbtn")
.addEventListener("click", function(e){
	//회원성명 입력란을 찾아오기
	var n = document.getElementById('custname')
	if(n.value.trim().length == 0){
	alert("회원성명이 입력되지 않았습니다.");
	n.focus();
	return;		
	}
	var p = document.getElementById('phone')
	if(p.value.trim().length == 0){
	alert("회원전화가 입력되지 않았습니다.");
	p.focus();
	return;		
	}
	var a = document.getElementById('address')
	if(a.value.trim().length == 0){
	alert("회원주소가 입력되지 않았습니다.");
	a.focus();
	return;		
	}
	var j = document.getElementById('joindate')
	if(j.value.trim().length == 0){
	alert("가입일자가 입력되지 않았습니다.");
	j.focus();
	return;		
	}
	var g = document.getElementById('grade')
	if(g.value.trim().length == 0){
	alert("고객등급이 입력되지 않았습니다.");
	g.focus();
	return;		
	}
	var c = document.getElementById('city')
	if(c.value.trim().length == 0){
	alert("도시코드가 입력되지 않았습니다.");
	c.focus();
	return;		
	}
	
	//폼의 데이터 전송
	//document.getElementById("registerform").submit();
	
	//폼의 데이터를 가지고 insert.jsp 파일에 ajax요청
	//ajax 객체 생성
	var request = new XMLHttpRequest();
	
	//전송할 URL을 생성
    var url = "insert.jsp?"
    //URL에 파라미터 붙이기
    url += "custno=" + 
    document.getElementById("custno").value;
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
		  alert("회원등록이 완료되었습니다.")
	   }
   }
   
	
});
</script>
</html>