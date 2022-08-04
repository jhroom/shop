<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	<%=session.getAttribute("user")%> <!-- customer / employee -->
   <br>
   <%=session.getAttribute("id")%> <!-- 로그인 아이디 -->
   <br>
   <%=session.getAttribute("name")%> <!-- 로그인 이름 -->
   <div>
   <p><a href="loginForm.jsp">로그인창</a></p>
   <p><a href="logoutShop.jsp">로그아웃</a></p>
   	<p><a href="deleteShop.jsp">회원탈퇴</a></p>
   </div>
</body>
</html>