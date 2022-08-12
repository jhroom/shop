<%@page import="java.util.Map"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	GoodsService goodsService = new GoodsService();
	Map<String,Object> map = goodsService.getGoodsAndImg(goodsNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div>
		<img src="<%=request.getContextPath()%>/upload/<%=map.get("fileName") %>">
	</div>
	<div>
		<table>
			<tr>
				<td>상품이지</td>
			</tr>
		</table>
	</div>
</body>
</html>