<%@page import="service.CustomerService"%>
<%@page import="repository.CustomerDao"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	
	CustomerService customerService = new CustomerService();
	Customer customer2 = new Customer();
	
	if( customerService.getCustomer(customer).getCustomerId() != null ) {
		System.out.println("세션 적용전까지 성공");
		customer2 = customerService.getCustomer(customer);
		
		session.setAttribute("user", "customer");
		session.setAttribute("id", customer2.getCustomerId());
		session.setAttribute("name", customer2.getCustomerName());
		
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	} else {
		System.out.println("로그인실패");
		response.sendRedirect(request.getContextPath()+ "/loginForm.jsp?errorMsg=loginFail");
	}
	
	
%>
