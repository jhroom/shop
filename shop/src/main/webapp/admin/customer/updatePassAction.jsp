<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String customerId = request.getParameter("customerId");
	System.out.println(customerId);
	String customerPass = request.getParameter("newCustomerPass");
	System.out.println(customerPass);
	
	CustomerService customerService = new CustomerService();
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	
	if(customerService.modifyCustomerPass(customer)) {
		System.out.println("고객 패스워드변경성공");
		response.sendRedirect(request.getContextPath()+"/admin/customer/customerList.jsp?updatePass");
	} else {
		System.out.println("고객 패스워드변경 실패");
		response.sendRedirect(request.getContextPath()+"/admin/customer/customerList.jsp?updateFail");
	}
	
%>
</body>
</html>