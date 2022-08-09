<%@page import="vo.Goods"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//관리자외 접근금지
	if(!"employee".equals(session.getAttribute("user")) ) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?errorMsg=Invalid Acess");
		return;
	}

	int rowPerPage = 5; //페이지 당 보여줄 상품갯수
	int currentPage = 1;
	
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	List<Goods> goodsList = new ArrayList<>();
	
	GoodsService goodsService = new GoodsService();
	
	//페이지에따라 받아오는 상품리스트객체
	goodsList = goodsService.getGoodsListByPage(rowPerPage, currentPage);
	
	//상품  총 개수
	int totalGoods = goodsService.lastPage();
		System.out.println("totalGoods : " + totalGoods);
	
	//마지막페이지 구하기
	int lastPage = (int)Math.ceil((double)totalGoods/rowPerPage);
		System.out.println("lastPage : " + lastPage);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div><!-- 상단메뉴 -->
		<ul>
		<li><a href="<%=request.getContextPath() %>/employeeList.jsp">사원관리페이지</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/adminGoodsList.jsp">상품관리페이지</a></li><!-- 상품목록/등록/수정 -->
		<li><a href="<%=request.getContextPath() %>/admin/adminOrderList.jsp">주문관리페이지</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/adminCustomerList.jsp">고객관리페이지</a></li>
		<li><a href="<%=request.getContextPath() %>/admin/adminNoticeList.jsp">공지관리페이지</a></li>
		</ul>
	</div>
	<table>
		<thead>
			<tr>
				<th>상품번호</th>
				<th>상품이름</th>
				<th>상품가격</th>
				<th>상품재고</th>
			</tr>
		</thead>
		<%
			for(Goods list : goodsList) {
		%>
		<tbody>
			<tr>
				<td><%=list.getGoodsNo() %></td>
				<td><a href="<%=request.getContextPath() %>/admin/selectGoodsOne.jsp?goodsNo=<%=list.getGoodsNo()%>"><%=list.getGoodsName() %></a></td>
				<td><%=list.getGoodsPrice() %></td>
				<td><%=list.getSoldOut() %></td>
				<td>
					<a href="<%=request.getContextPath() %>/admin/updateGoodsForm.jsp?goodsNo=<%=list.getGoodsNo()%>">상품수정</a>
				</td>
			</tr>
		</tbody>
		<%
			}
		%>
	</table>
	<div>
	<%
		if(currentPage > 1) {
	%>
		<a href="<%=request.getContextPath() %>/admin/adminGoodsList.jsp?currentPage=<%=currentPage-1 %>">이전</a>
	<%
		} if(currentPage < lastPage) {
	%>
		<a href="<%=request.getContextPath() %>/admin/adminGoodsList.jsp?currentPage=<%=currentPage+1 %>">다음</a>
	<%
		}
	%>
	</div>
	<div>
		<a href="<%=request.getContextPath() %>/admin/addGoodsForm.jsp">상품추가</a>
	</div>
</body>
</html>


