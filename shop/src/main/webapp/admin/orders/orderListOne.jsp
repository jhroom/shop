<%@page import="service.OrdersService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String customerId = request.getParameter("customerId");
	
	List<Map<String,Object>> list = new ArrayList<>();
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int rowPerPage = 5;
	
	OrdersService orderService = new OrdersService();
	
	//고객아이디에 따른 주문 개수
	int totalOrders = orderService.getCountOrderListByCustomer(customerId);
	
	// 마지막페이지 구하기
	int lastPage = (int)Math.ceil((double)totalOrders/rowPerPage);
	System.out.println("lastPage : " + lastPage);
	
	//고객 아이디에따른 주문내역 리스트받아오기
	list = orderService.getCustomerOrderList(customerId, currentPage, rowPerPage);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<h3><%=customerId %>님의 주문내역</h3>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>주문번호</th>
					<th>상품번호</th>
					<th>상품이름</th>
					<th>상품가격</th>
					<th>재고상태</th>
					<th>주문가격</th>
					<th>주문수량</th>
					<th>배송주소</th>
					<th>배송상태</th>
					<th>수정한날자</th>
					<th>주문한날자</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Map<String,Object> m : list){
				%>
				<tr>
					<td><%=m.get("orderNo") %></td>
					<td><%=m.get("goodsNo") %></td>
					<td><%=m.get("goodsName") %></td>
					<td><%=m.get("goodsPrice") %></td>
					<td><%=m.get("soldOut") %></td>
					<td><%=m.get("orderPrice") %></td>
					<td><%=m.get("orderQuantity") %></td>
					<td><%=m.get("orderAddr") %></td>
					<td><%=m.get("orderState") %></td>
					<td><%=m.get("updateDate") %></td>
					<td><%=m.get("createDate") %></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	
	<div>
	<%
		if(currentPage > 1) {
	%>
		<a href="<%=request.getContextPath() %>/admin/orders/orderListOne.jsp?currentPage=<%=currentPage-1 %>">이전</a>
	<%
		} if(currentPage < lastPage) {
	%>
		<a href="<%=request.getContextPath() %>/admin/orders/orderListOne.jsp?currentPage=<%=currentPage+1 %>">다음</a>
	<%
		}
	%>
	</div>
</body>
</html>