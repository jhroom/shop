<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품추가</title>
</head>
<body>
	<h1>상품추가 form</h1>
	
	<form action="<%=request.getContextPath() %>/admin/goods/addGoodsAction.jsp" method="post" enctype="multipart/form-data">
	
		이미지<input type="file" name="goodsFile">
		이름<input type="text" name="goodsName">
		가격<input type="text" name="goodsPrice">
		수량<!-- <input type="text" name="soldOut"> -->
		<select name="soldOut">
			<option value="Y">재고있음</option>
			<option value="N">재고없음</option>
		</select>
		
		<button type="submit">상품추가</button>
	</form>
</body>
</html>