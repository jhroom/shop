<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="service.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	System.out.println("\r\ncartList 시작");

	//String customerId = request.getParameter("customerId"); System.out.println("customerId : " + customerId);
	//int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); System.out.println("goodsNo : " + goodsNo);
	
	CartService cartService = new CartService();
		System.out.println("getAttributeId : " + (String)session.getAttribute("id"));
	List<Map<String,Object>> list = cartService.getCartById((String)session.getAttribute("id"));
	System.out.println("list : " + list.size());
	
	//세션이 없거나 고객이 아닌사람이 장바구니 간다면 빈장바구니로 가기
	if( list.size() == 0 || (String)session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath()+"/customer/emptyCart.jsp");
		return;
	}
	session.setAttribute("orderList", list);
	// session.removeAttribute(); //나중에 이세션은 지우기
	int price = 0;
	
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
		<table>
			<thead>
				<tr>
					<th></th>
					<th>상품이름</th>
					<th>상품가격</th>
					<th>수량</th>
					<th>재고상태</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(Map<String,Object> m : list){
					price += (int)m.get("goodsPrice")*(int)m.get("cartQuantity");
					
			%>
				<tr>
				
					<td><img src="<%=request.getContextPath()%>/upload/<%=m.get("fileName")%>" width="100px"></td>
					<td><%=m.get("goodsName") %></td>
					<td><%=m.get("goodsPrice") %></td>
					<td><%=m.get("cartQuantity") %></td>
					<td><%=m.get("soldOut") %></td>
				</tr>
				
				
			<%
				}
				
			%>
				
			</tbody>
		</table>
		<div><%=list.get(0).get("address") %></div>
		
		<form action="<%=request.getContextPath()%>/customer/cartOrder.jsp?" method="post">
			Address<input type="text" name="addr">
			Address Detail<input type="text" name="addrDetail">
			결제금액<input type="text" name="orderPrice" value="<%=price %>" readonly>
			<button type="submit" id="btn">주문하기</button>
		</form>
		장바구니 상품구매할거 마다 수량이나 주소 바꿀수 있게?
		주문후 재고 상태 바뀌면 주문 못하게?
		
	</div>

</body>
<script>
	$('#btn').click(function(){
		
	});
</script>
</html>
