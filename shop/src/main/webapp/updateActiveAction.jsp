<%@page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String empActive = request.getParameter("active");
	String empId = request.getParameter("empId");
	
	EmployeeService service = new EmployeeService();
	boolean updateActive  = service.modifyEmployeeActive(empId,empActive);
	
	if(updateActive) {
		response.sendRedirect(request.getContextPath()+"/employeeList.jsp?updateSuccess");
	} else {
		
	}
%>