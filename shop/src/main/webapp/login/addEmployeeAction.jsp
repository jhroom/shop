<%@page import="service.EmployeeService"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf8");

	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employeePass");
	String employeeName = request.getParameter("employeeName");
	
	Employee employee = new Employee();
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePass);
	employee.setEmployeeName(employeeName);
	
	if(new EmployeeService().addEmployee(employee) ) {
		response.sendRedirect(request.getContextPath()+"/login/loginForm.jsp?JoinEmployee");
	} else {
		response.sendRedirect(request.getContextPath()+"/login/loginForm.jsp?JoinFail");
	}
	
%>
