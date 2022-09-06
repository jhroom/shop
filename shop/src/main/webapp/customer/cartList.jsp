<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="service.CartService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	System.out.println("\r\n	CartList 시작");
	
	// 서비스 호출
	CartService cartService = new CartService();
	
	System.out.println("getAttributeId : " + (String)session.getAttribute("id"));
	
	//세션에 있는 아이디를 이용한 장바구니 리스트 가져오기
	List<Map<String,Object>> list = cartService.getCartById((String)session.getAttribute("id"));
	System.out.println("list : " + list.size());
	
	//세션의 id가 없거나 , 있는데 장바구니의 담긴개 없다면 빈장바구니 페이지로 가기
	if( list.size() == 0 || (String)session.getAttribute("id") == null){
		response.sendRedirect(request.getContextPath()+"/customer/emptyCart.jsp");
		return;
	}
	
	// 장바구니 리스트를 세션에 담기
	session.setAttribute("orderList", list);
	System.out.println("세션에담긴 리스트 " + list.toString());
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
				System.out.println("총 결제 금액 : " + price);
				
			%>
				
			</tbody>
		</table>
		
		<form action="<%=request.getContextPath()%>/customer/cartOrder.jsp?" method="post">
			받을 기본 주소
				<input type="text" name="address" value="<%=list.get(0).get("address") %>" readonly> <br/>
			Address
				<input type="text" name="addr">
			Address Detail
				<input type="text" name="addrDetail">
				<br/>
			결제금액
				<input type="text" name="orderPrice" value="<%=price %>" readonly>
				
				<button type="submit" id="btn">주문하기</button>
		</form>
		
			장바구니 상품구매할거  수량이나 주소 바꿀수 있게?
			주문후 재고 상태 바뀌면 주문 못하게?
			
			디폴트는 기본주소로 넘어가게 바꾸기하고
			선택사항으로 새로운주소로 오더시 그거에맞기 수정하기
		
	</div><!-- 전체 괄호 -->

</body>
<script>
	$('#btn').click(function(){
		
	});
</script>
</html>
