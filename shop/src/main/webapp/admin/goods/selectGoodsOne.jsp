<%@page import="java.util.Map.Entry"%>
<%@page import="service.GoodsService"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//관리자외 접근금지
	if(!"employee".equals(session.getAttribute("user")) ) {
		response.sendRedirect(request.getContextPath()+"/login/loginForm.jsp?errorMsg=Invalid Acess");
		return;
	}

	Map<String, Object> goodsOne = null;

	int goodsNo = 0;
	if(request.getParameter("goodsNo") != null ) {
		goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	} else {
		response.sendRedirect(request.getContextPath()+"/admin/goods/adminGoodsList.jsp?errorMsg=Invalid Acess");
		return;
	}
		System.out.println("goodsNo : " + goodsNo);
		
	GoodsService goodsService = new GoodsService();
	
	//goodsNo 따른 goods,img 합친 객체
	goodsOne = goodsService.getGoodsAndImg(goodsNo);
		System.out.println("goodsOne : " + goodsOne);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세보기</title>
</head>
<body>
	<div>
		<img src="<%=request.getContextPath() %>/upload/<%=goodsOne.get("fileName") %>">
	</div>
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
	<a href="<%=request.getContextPath() %>/admin/goods/updateGoodsForm.jsp?goodsNo=<%=goodsNo%>">상품수정</a>
	<a href="<%=request.getContextPath() %>/admin/goods/adminGoodsList.jsp">상품관리페이지</a>
	</div>

</body>
</html>