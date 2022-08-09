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
	request.setCharacterEncoding("utf8");

	String check = request.getParameter("check");	System.out.println(check);
	if(!"계정삭제".equals(check)) {
		response.sendRedirect(request.getContextPath()+"/customer/customerList.jsp?writeCorrectly");
		return;
	}
	String customerId = request.getParameter("customerId");
	
	CustomerService customerService = new CustomerService();
	
	if(customerService.removeCustomerOut(customerId)){
		response.sendRedirect(request.getContextPath()+"/customer/customerList.jsp?accountRemove");
	} else {
		response.sendRedirect(request.getContextPath()+"/customer/customerList.jsp?removeFail");
	}
	
	
%>
</body>
</html>