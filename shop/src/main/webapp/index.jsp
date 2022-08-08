<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 	user : <%=session.getAttribute("user")%> <!-- customer / employee -->
   <br>
   id : <%=session.getAttribute("id")%> <!-- 로그인 아이디 -->
   <br>
   name : <%=session.getAttribute("name")%> <!-- 로그인 이름 -->
   <div>
   <p><a href="loginForm.jsp">로그인페이지</a></p>
   
   	<%
   		if("employee".equals(session.getAttribute("user"))){
   	%>
   			<a href="adminIndex.jsp">관리자 페이지</a>
   	<%
   		}
   	%>
   </div>
</body>
</html>