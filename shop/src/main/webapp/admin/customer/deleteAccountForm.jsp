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
	<p>삭제를 원하시면 <b>계정삭제</b>를 정확히 적어주세요</p>
	<form action="<%=request.getContextPath() %>/customer/deleteAccountAction.jsp" method="post">
		<input type="text" name="customerId" value="<%=customerId %>" readonly>
		탈퇴확인<input type="text" name="check">
		<button type="submit">삭제</button>
	</form>
</body>
<script>
	//팝업알림?
</script>
</html>