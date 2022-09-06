<%@page import="java.util.Map"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(request.getParameter("goodsNo") == null){
		response.sendRedirect(request.getContextPath()+"/customer/customerGoodsList.jsp");
		return;
	}
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
			<thead>
				<tr>
					<th>상품이름</th>
					<th>상품가격</th>
					<th>재고상태</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><%=map.get("goodsName") %></td>
					<td><%=map.get("goodsPrice") %></td>
					<td><%=map.get("soldOut") %></td>
				</tr>
			</tbody>
		</table>
	</div>
	<form action="<%=request.getContextPath() %>/customer/addCart.jsp" id="form">
		<input type="hidden" name="customerId" id="id" value="<%=session.getAttribute("id")%>">
		<input type="hidden" name="goodsNo" id="no" value="<%=goodsNo%>">
		<select name="cartQuantity">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
		</select>
		<button type="button" id="btn" >장바구니담기</button>
	</form>

	수량선택
	카트담기구현해야함
	
	<a href="<%=request.getContextPath() %>/customer/cartList.jsp">장바구니로</a>
	
</body>
<script>
	$('#btn').click(function(){
		if($('#id').val() == 'null'){
			alert('로그인 후 이용가능합니다');
			location.href="../login/loginForm.jsp";
		} else {
			$('#form').submit();
		}
	});
</script>
</html>




