<%@page import="service.EmployeeService"%>
<%@page import="repository.EmployeeDao"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String empId = request.getParameter("employeeId");
	String empPw = request.getParameter("employeePass");
	
	Employee employee = new EmployeeService().getEmployee(empId, empPw);
	
	if(employee.getEmployeeId() != null) {
		System.out.println("세션 적용전까지 성공");
		System.out.println(employee);
		
		session.setAttribute("user", "employee");
		session.setAttribute("id", employee.getEmployeeId());
		session.setAttribute("name", employee.getEmployeeName());
		response.sendRedirect(request.getContextPath()+ "/index.jsp");
		
	} else {
		System.out.println("로그인실패");
		response.sendRedirect(request.getContextPath()+ "/loginForm.jsp?errorMsg=loginFail");
	}
%>
