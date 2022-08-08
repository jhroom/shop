<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String goodsNo = request.getParameter("goodsNo");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정</title>
</head>
<body>
	<h1>상품수정 form</h1>
	<form action="<%=request.getContextPath() %>/admin/updateGoodsAction.jsp" method="post">
		<input type="hidden" name="goodsNo" value="<%=goodsNo %>">
		이름<input type="text" name="goodsName">
		가격<input type="text" name="goodsPrice">
		수량<input type="text" name="soldOut">
		<button type="submit">상품수정</button>
	</form>

</body>
</html>