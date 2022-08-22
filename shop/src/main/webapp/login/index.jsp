<%@page import="service.CounterService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	CounterService counterService = new CounterService();
	int totalCounter = counterService.getTotalCount();
	int todayCounter = counterService.getTodayCount();
	int currentCount = (Integer)(application.getAttribute("currentCounter"));
%>
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
   <p><a href="<%=request.getContextPath() %>/login/loginForm.jsp">로그인페이지</a></p>
   
   	<%
   		if("employee".equals(session.getAttribute("user"))){
   	%>
   			<a href="<%=request.getContextPath() %>/admin/adminIndex.jsp">관리자 페이지</a>
   	<%
   		}
   	%>
   </div>
   total접속자수 : <%=totalCounter %>
   today접속자수 : <%=todayCounter %>
   현재접속자수 : <%=currentCount %>
</body>
</html>