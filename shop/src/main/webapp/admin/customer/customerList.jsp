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
<%@ include file="../../theme/header.jsp" %>
	<div class="container">
	<div class="row">
	
		<div class="col-sm-3 list">
			<%-- <%@ include file="../managementList.jsp" %> --%>
			<jsp:include page="../managementList.jsp"/>
		</div>
		
		<div class="col-sm-9">
			<table  class="table table-striped">
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
						<td><a href="<%=request.getContextPath()%>/admin/customer/orderListById.jsp?id=<%=list.getCustomerId()%>"><%=list.getCustomerId() %></a></td>
						<td><%=list.getCustomerPass().substring(0,8)+"...." %><a href="<%=request.getContextPath() %>/admin/customer/updatePassForm.jsp?id=<%=list.getCustomerId()%>"><br>변경하기</a></td>
						<td><%=list.getCustomerName() %></td>
						<td><%=list.getCustomerAdress() %></td>
						<td><%=list.getCustomerTel() %></td>
						<td><%=list.getUpdateDate() %></td>
						<td><%=list.getCreateDate() %></td>
						<td><a href="<%=request.getContextPath()%>/admin/customer/deleteAccountForm.jsp?id=<%=list.getCustomerId()%>">탈퇴</a></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
		</div>
		
	</div>
	</div>
<%@ include file="../../theme/footer.jsp" %>