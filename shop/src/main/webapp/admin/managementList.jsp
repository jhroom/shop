<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<ul class="text-dark">
			<li><a href="<%=request.getContextPath() %>/admin/employee/employeeList.jsp">사원관리페이지</a></li>
			<li><a href="<%=request.getContextPath() %>/admin/goods/adminGoodsList.jsp">상품관리페이지</a></li><!-- 상품목록/등록/수정 -->
			<li><a href="<%=request.getContextPath() %>/admin/orders/orderList.jsp">주문관리페이지</a></li>
			<li><a href="<%=request.getContextPath() %>/admin/customer/customerList.jsp">고객관리페이지</a></li>
			<li><a href="<%=request.getContextPath() %>/admin/adminNoticeList.jsp">공지관리페이지</a></li>
		</ul>
