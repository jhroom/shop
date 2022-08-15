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
	
	<form action="<%=request.getContextPath() %>/admin/goods/updateGoodsAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="goodsNo" value="<%=goodsNo %>">
		
		<div>
		이미지파일<input type="file" name="goodsFile">
		</div>
		
		<div>
		상품이름<input type="text" name="goodsName">
		상품가격<input type="text" name="goodsPrice">
		수량상태<input type="text" name="soldOut">
		</div>
		
		<button type="submit">상품수정</button>
	</form>
	
	<a href="<%=request.getContextPath() %>/admin/goods/adminGoodsList.jsp">상품관리페이지</a>
	
</body>
</html>