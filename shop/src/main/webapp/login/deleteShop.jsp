<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("user")== null){
		response.sendRedirect(request.getContextPath()+"/login/loginForm.jsp?errorMsg=Not login");
		return;
	}
	String user = (String)session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
	<h1>회원탈퇴</h1>
		<form action="<%=request.getContextPath()%>/login/deleteShopAction.jsp" method="post">
			비밀번호<input type="password" name="pass">
			<button type="submit">제출</button>
		</form>
	</div>

</body>
</html>