<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String customerId = request.getParameter("id");
	List<Map<String,Object>> list = new ArrayList<>();
	OrdersService ordersService = new OrdersService();
	
	int currentPage = 1;
	if( request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	
	list = ordersService.getCustomerOrderList(customerId, currentPage, rowPerPage);
	
	int lastPage = ordersService.selectCountOrderListByCustomer(customerId);
		System.out.println("total : " + lastPage);
	lastPage =(int) Math.ceil((double)lastPage/rowPerPage);
		System.out.println("lastPage : " + lastPage);
	
	
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
		<h3><%=customerId %>님의 주문내역</h3>
	</div>
	<div>
		<table border="1">
			<thead>
			<tr>
				<th>주문번호</th>
				<th>상품번호</th>
				<th>상품이름</th>
				<th>상품가격</th>
				<th>재고상태</th>
				<th>주문수량</th>
				<th>주문가격</th>
				<th>주문주소</th>
				<th>주문상태</th>
				<th>업데이트날짜</th>
				<th>주문시간</th>
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
					<td><%=m.get("orderQuantity") %></td>
					<td><%=m.get("orderPrice") %></td>
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
			<a href="<%=request.getContextPath() %>/admin/customer/orderListById.jsp?currentPage=<%=currentPage-1 %>">이전</a>
	<%
		} if(currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath() %>/admin/customer/orderListById.jsp?currentPage=<%=currentPage+1 %>">다음</a>
	<%
		}
	%>
	</div>
</body>
</html>



