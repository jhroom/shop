<%@page import="vo.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
//관리자외 접근금지
	if(!"employee".equals(session.getAttribute("user")) ) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?errorMsg=Invalid Acess");
		return;
	}

	List<Customer> customerList = new ArrayList<>();
	final int rowPerPage = 5;
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	CustomerService customerService = new CustomerService();
	customerList = customerService.getCustomerList(currentPage, rowPerPage);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 관리 페이지</title>
</head>
<body>
	<div><!-- 상단메뉴 -->
		<ul>
		<li><a href="<%=request.getContextPath() %>/employeeList.jsp">사원관리페이지</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/adminGoodsList.jsp">상품관리페이지</a></li><!-- 상품목록/등록/수정 -->
		<li><a href="<%=request.getContextPath() %>/admin/adminOrderList.jsp">주문관리페이지</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/adminCustomerList.jsp">고객관리페이지</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/adminNoticeList.jsp">공지관리페이지</a></li>
		</ul>
	</div>
	<table border="1">
		<thead>
			<tr>
				<th>id</th>
				<th>Pass</th>
				<th>Name</th>
				<th>Adress</th>
				<th>Tel</th>
				<th>Update Date</th>
				<th>Create Date</th>
				<th>계정 삭제</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(Customer list : customerList) {
		%>
			<tr>
				<td><%=list.getCustomerId() %></td>
				<td><%=list.getCustomerPass() %><a href="<%=request.getContextPath() %>/customer/updatePassForm.jsp?id=<%=list.getCustomerId()%>">변경하기</a></td>
				<td><%=list.getCustomerName() %></td>
				<td><%=list.getCustomerAdress() %></td>
				<td><%=list.getCustomerTel() %></td>
				<td><%=list.getUpdateDate() %></td>
				<td><%=list.getCreateDate() %></td>
				<td><a href="<%=request.getContextPath()%>/customer/deleteAccountForm.jsp?id=<%=list.getCustomerId()%>">탈퇴</a></td>
			</tr>
		<%
			}
		%>
		</tbody>
		</table>
</body>
</html>