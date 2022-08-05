<%@page import="service.SignService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	String url = null;
	if( request.getParameter("employee")!= null) {
		url = request.getParameter("employee");
		
	} else if (request.getParameter("customer")!= null) {
		url = request.getParameter("customer");
	} else {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	}
			System.out.println("url : " + url);

	String checkId = request.getParameter("checkId");

	SignService signService = new SignService();
	
	if( signService.idCheckService(checkId) ) {
		response.sendRedirect(request.getContextPath()+"/"+url+".jsp?checkedId="+checkId);
	} else {
		response.sendRedirect(request.getContextPath()+"/"+url+".jsp?errorMsg=duplicatedID");
	}
	
%>

