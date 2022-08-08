<%@page import="java.util.Map.Entry"%>
<%@page import="service.GoodsService"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Map<String, Object> goodsOne = null;

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
		System.out.println("goodsNo : " + goodsNo);
		
	GoodsService goodsService = new GoodsService();
	
	//상품번호에 따른 goods img 합친 객체
	goodsOne = goodsService.getGoodsAndImg(goodsNo);
		System.out.println("goodsOne : " + goodsOne);
	goodsOne.entrySet();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기</title>
</head>
<body>
	<div>
		<table>
		<%
			for(Entry<String,Object> map : goodsOne.entrySet()) {
		%>
			<tr>
				<td><%=map.getKey() %></td>
				<td><%=map.getValue() %></td>
			</tr>
		<%
			}
		%>
	</table>
	</div>

</body>
</html>