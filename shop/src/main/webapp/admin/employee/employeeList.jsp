<%@page import="vo.Employee"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.EmployeeService"%>
<%@page import="repository.EmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//관리자외 접근금지
	if(!"employee".equals(session.getAttribute("user")) ) {
		response.sendRedirect(request.getContextPath()+"/login/loginForm.jsp?errorMsg=Invalid Acess");
		return;
	}

	ArrayList<Employee> list = new ArrayList<>();

	int currentPage = 1;
	if( request.getParameter("currentPage") != null ) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
		System.out.println("currentPage : " + currentPage);
			
	int rowPerPage = 5;
	
	EmployeeService empService = new EmployeeService();
	list = empService.getEmployeeList(currentPage, rowPerPage);
		/* System.out.println(list); */
		
	int lastPage = empService.lastPage();
		System.out.println("total : " + lastPage);
	lastPage =(int) Math.ceil((double)lastPage/rowPerPage);
		System.out.println("lastPage : " + lastPage);
	
%>
	<%@ include file="../../theme/header.jsp" %>
	<div class="container">
	<div class="row">
	
		<div class="col-sm-3">
			<%@ include file="../managementList.jsp" %>	
		</div>
	
		<div class="col-sm-9">
			<table border="1" class="table table-striped table-dark">
				<thead>
				<tr>
					<th>id</th>
					<th>name</th>
					<th>create date</th>
					<th>update date</th>
					<th>권한</th>
				</tr>
				</thead>
			<%
				for(Employee emp : list){
			%>
				<tbody>
				<tr>
					<td><%=emp.getEmployeeId() %></td>
					<td><%=emp.getEmployeeName() %></td>
					<td><%=emp.getCreateDate() %></td>
					<td><%=emp.getUpdateDate() %> </td>
					<td>
					<form action="<%=request.getContextPath() %>/admin/employee/updateActiveAction.jsp" method="post">
					<select name="active">
					<%
						if(emp.getActive().equals("N")) {
					%>
						<option selected><%=emp.getActive() %></option>
						<option>Y</option>
					<%
						} else {
					%>
						<option selected><%=emp.getActive() %></option>
						<option>N</option>
					<%
						}
					%>	
						
					</select>
					<input type="hidden" value="<%=emp.getEmployeeId() %>" name="empId">
					<button type="submit" >적용</button>
					</form>
					</td>
				</tr>
				</tbody>
			<%
				}
			%>
			</table>
		<%
			if(currentPage > 1) {
		%>
				<a href="<%=request.getContextPath() %>/admin/employee/employeeList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
		<%
			} if(currentPage < lastPage) {
		%>
				<a href="<%=request.getContextPath() %>/admin/employee/employeeList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
		<%
			}
		%>
		</div>
	</div>
	</div>
<%@ include file="../../theme/footer.jsp" %>




