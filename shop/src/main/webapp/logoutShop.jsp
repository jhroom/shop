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
		response.sendRedirect(request.getContextPath() +  "/loginForm.jsp");
		return;
	}
	else {
		session.invalidate();
		response.sendRedirect(request.getContextPath() +  "/loginForm.jsp");
	}
%>

</body>
</html>