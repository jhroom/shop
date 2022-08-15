<%@page import="service.CustomerService"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf8");

	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	String customerName = request.getParameter("customerName");
	String customerAdress = request.getParameter("customerAdress");
	String customerTel = request.getParameter("customerTel");
	
	//고객정보 담을 객체
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	customer.setCustomerName(customerName);
	customer.setCustomerAdress(customerAdress);
	customer.setCustomerTel(customerTel);
	
	CustomerService customerService = new CustomerService();
	
	if(customerService.addCustomer(customer)) {
		response.sendRedirect(request.getContextPath()+"/login/loginForm.jsp?JoinCustomer");
	} else {
		response.sendRedirect(request.getContextPath()+"/login/loginFrom.jsp?JoinFail");
	}
	
%>
</body>
</html>