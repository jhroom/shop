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
	<form action="<%=request.getContextPath() %>/admin/updateGoodsAction.jsp" method="post" enctype="multipart/form-data">
	
		<input type="hidden" name="goodsNo" value="<%=goodsNo %>">
		<div>
		이미지파일<input type="file" name="goodsFile">
		파일이름<input type="text" name="fileName">
		</div>
		<div>
		상품이름<input type="text" name="goodsName">
		상품가격<input type="text" name="goodsPrice">
		수량상태<input type="text" name="soldOut">
		</div>
		
		<button type="submit">상품수정</button>
		<a href="<%=request.getContextPath() %>/admin/adminGoodsList.jsp">상품관리페이지</a>
	</form>

</body>
</html>