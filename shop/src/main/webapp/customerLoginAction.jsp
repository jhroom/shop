<%@page import="model.CustomerDao"%>
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
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	
	Customer customer = null;
	
	CustomerDao dao = new CustomerDao();
	
	customer = dao.login(customerId, customerPass);
	
	if( customer.getCustomerId() != null) {
		session.setAttribute("user", "customer");
		session.setAttribute("id", customer.getCustomerId());
		session.setAttribute("name", customer.getCustomerName());
		
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	} else {
		System.out.println("로그인실패");
		response.sendRedirect(request.getContextPath()+ "/loginForm.jsp?errorMsg=loginFail");
	}
	
	
	
	
%>
</body>
</html>