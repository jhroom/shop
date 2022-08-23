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
		
		customer = customerService.getCustomer(paramcustomer);
		
		session.setAttribute("user", "customer");
		session.setAttribute("id", customer.getCustomerId());
		session.setAttribute("name", customer.getCustomerName());
		System.out.println("customer세션 적용 성공");
		
		response.sendRedirect(request.getContextPath()+"/login/index.jsp");
	} else {
		System.out.println("로그인실패");
		response.sendRedirect(request.getContextPath()+ "/login/loginForm.jsp?errorMsg=loginFail");
	}
	
	
%>
