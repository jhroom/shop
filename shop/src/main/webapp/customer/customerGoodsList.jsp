<%@page import="service.GoodsService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="service.CustomerService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//요청을 분석이 Controller 		: java class request response  해주는 Servlet
	//밑에 jsp 가 View
	//나중에 분리한다해도 view 에서 for / if 같이 java code가 나온다 
	// 대체 기술이 커스텀 태그   태그처럼생겼지만 자바코드로 바뀐다 (jstl 라이브러리,EL?) >> JSP
	// 자바코드못쓰는 뷰 템플릿이 수많이있다.  ex 타임리프?
	int rowPerPage = 20;
	if(request.getParameter("rowPerPage") != null){			//동기 처리이다
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	GoodsService goodsService = new GoodsService();
	
	// list 자바컨트롤러의 모델값
	List<Map<String, Object>> list = goodsService.getCustomerGoodsList(currentPage, rowPerPage);
	//redirect 새로운 jsp 호출
	//분리하면 servlet / 연겷기술 forword(매개변수가 request, response)  (include)
	//
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<a href="">인기순</a>
		<a href="">판매량순</a>
		<a href="">낮은가격순</a>
		<a href="">높은가격순</a>
		<a href="">최신순</a>
	</div>
	
	<div>
	<table border="1">
		<tr>
			<%	
				int i= 1;
				for(Map<String, Object> m : list) {
			%>
				<td>
					<div><a href="<%=request.getContextPath()%>/customer/customerGoodsOne.jsp?goodsNo=<%=m.get("goodsNo")%>">
							<img src='<%=request.getContextPath()%>/upload/<%=m.get("fileName")%>' width="100px"></a></div>
					<div><%=m.get("goodsName") %></div>
					<div><%=m.get("goodsPrice") %></div>
				</td>
			<%
					if(i%4==0){
			%>
						</tr><tr>
			<%
					}
					i++;
				}
				//테이블 깨지는거 방지 4로 안채워지면 할 방법
				int cnt = 4- (list.size() % 4);
				if(cnt == 4) {
					cnt = 0;
				}
				
				for(int j=0; j<cnt; j++){
				%>
					<td>&nbsp;</td>
				<%
				}
			%>
		</tr>
	</table>
	</div>
	
</body>
</html>








