<%@page import="vo.Employee"%>
<%@page import="service.EmployeeService"%>
<%@page import="vo.Customer"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//로그인 된사람만
	if(session.getAttribute("user")== null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?errorMsg=Not login");
		return;
	}
	//로그인 된사람 세션아이디 , 입력된 비밀번호 받기
	String user = (String)session.getAttribute("id");
	String pass = request.getParameter("pass");
	
	boolean TnF = false;
	
	//고객 직원 분기
	if(session.getAttribute("user").equals("customer")){
		
		Customer customer = new Customer();
		customer.setCustomerId(user);
		customer.setCustomerPass(pass);
		
		CustomerService customerService = new CustomerService();
		TnF = customerService.signOutCustomer(customer);
		
	} else if(session.getAttribute("user").equals("employee")) {
		
		Employee employee = new Employee();
		employee.setEmployeeId(user);
		employee.setEmployeePass(pass);
		
		EmployeeService employeeService = new EmployeeService();
		TnF = employeeService.signOutEmployee(employee);
		
	} else{
		System.out.print("잘못받아옴");
		
		response.sendRedirect(request.getContextPath()+ "/loginForm.jsp?errorMsg=invalidAcess");
	}
	
	if(TnF){ //탈퇴 성공시
		session.invalidate();
		response.sendRedirect(request.getContextPath()+ "/loginForm.jsp");
	} else { //비밀번호 틀릴시
		response.sendRedirect(request.getContextPath()+ "/loginForm.jsp?errorMsg=outShopFail");
	}
	
%>





