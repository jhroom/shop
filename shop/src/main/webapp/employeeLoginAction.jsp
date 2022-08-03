<%@page import="model.EmployeeDao"%>
<%@page import="vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String empId = request.getParameter("employeeId");
	String empPw = request.getParameter("employeePass");
	
	Employee emp = new EmployeeDao().login(empId, empPw);
	
	if(emp.getEmployeeId() != null) {
		System.out.println("dd");
		session.setAttribute("user", "employee");
		session.setAttribute("id", emp.getEmployeeId());
		session.setAttribute("name", emp.getEmployeeName());
		
		response.sendRedirect(request.getContextPath()+ "/index.jsp");
	} else {
		System.out.println("로그인실패");
		response.sendRedirect(request.getContextPath()+ "/loginForm.jsp?errorMsg=loginFail");
	}
%>

</body>
</html>