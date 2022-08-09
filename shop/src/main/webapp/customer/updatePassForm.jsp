<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String customerId = request.getParameter("id");
	System.out.println(customerId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div>
	<h3>고객 password 변경</h3>
		<form action="<%=request.getContextPath()%>/customer/updatePassAction.jsp" method="post">
			변경될ID<input type="text" name="customerId" value="<%=customerId %>" readonly>
			변경할패스워드<input type="password" name="newCustomerPass">
			<button type="submit">제출</button>
		</form>
	</div>
</body>
</html>