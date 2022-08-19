<%@page import="service.CustomerService"%>
<%@page import="repository.CustomerDao"%>
<%@page import="vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	
	Customer paramcustomer = new Customer();
	paramcustomer.setCustomerId(customerId);
	paramcustomer.setCustomerPass(customerPass);
	
	CustomerService customerService = new CustomerService();
	Customer customer = new Customer();
	
	if( customerService.getCustomer(paramcustomer).getCustomerId() != null ) {
		System.out.println("세션 적용전까지 성공");
		customer = customerService.getCustomer(paramcustomer);
		
		session.setAttribute("user", "customer");
		session.setAttribute("id", customer.getCustomerId());
		session.setAttribute("name", customer.getCustomerName());
		
		response.sendRedirect(request.getContextPath()+"/login/index.jsp");
	} else {
		System.out.println("로그인실패");
		response.sendRedirect(request.getContextPath()+ "/login/loginForm.jsp?errorMsg=loginFail");
	}
	
	
%>
