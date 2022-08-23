<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	if(session.getAttribute("user")==null){
		response.sendRedirect(request.getContextPath() +  "/login/loginForm.jsp");
		return;
	}
	else {
		System.out.println("세션 해제");
		session.invalidate();
		response.sendRedirect(request.getContextPath() +  "/login/loginForm.jsp");
	}
%>

</body>
</html>