<%@page import="java.util.Map"%>
<%@page import="service.OrdersService"%>
<%@page import="vo.Orders"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//주문리스트 받을 객체
	List<Map<String, Object>> list = new ArrayList<>();

	//기본 현재 페이지 1
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	//페이지당 보여줄 개수
	final int rowPerPage = 5;
	
	OrdersService orderService = new OrdersService();
	
	//전체 주문리스트
	list = orderService.getOrdersList(currentPage, rowPerPage);
	
	//전체 주문개수
	int totalOrders = orderService.lastPage();
	
	//마지막 페이지 구하기
	int lastPage = (int)Math.ceil((double)totalOrders/rowPerPage);
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
	<h3>고객 전체 주문 리스트</h3>
	<div>
		<table border="1">
			<thead>
				<tr>
					<th>주문번호</th>
					<th>상품번호</th>
					<th>상품이름</th>
					<th>고객ID</th>
					<th>주문가격</th>
					<th>주문수량</th>
					<th>배송지</th>
					<th>배송상태</th>
					<th>수정된날짜</th>
					<th>오더날짜</th>
				</tr>
			</thead>
			<tbody>
			<%
				for(Map<String, Object> o : list) {
			%>
				<tr>
					<td><%=o.get("orderNo") %></td>
					<td><%=o.get("goodsNo") %></td>
					<td><%=o.get("goodsName") %></td>
					<td><a href="<%=request.getContextPath()%>/admin/orders/orderListOne.jsp?customerId=<%=o.get("customerId")%>">
						<%=o.get("customerId") %></a></td>
					<td><%=o.get("orderPrice") %></td>
					<td><%=o.get("orderQuantity") %></td>
					<td><%=o.get("orderAddress") %></td>
					<td><%=o.get("orderState") %></td>
					<td><%=o.get("updateDate") %></td>
					<td><%=o.get("createDate") %></td>
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
		<a href="<%=request.getContextPath() %>/admin/orders/orderList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
	<%
		} if(currentPage < lastPage) {
	%>
		<a href="<%=request.getContextPath() %>/admin/orders/orderList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
	<%
		}
	%>
	</div>
	
</body>
</html>