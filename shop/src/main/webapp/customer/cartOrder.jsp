<%@page import="service.OrdersService"%>
<%@page import="vo.Orders"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("\r\ncartOrder 시작");
	request.setCharacterEncoding("utf8");
	
	String addr = request.getParameter("addr");		System.out.println("addr : " + addr);
	String addrDetail = request.getParameter("addrDetail");		System.out.println("addrDetail : " + addrDetail);
	
	

	List<Map<String,Object>> list = (List<Map<String,Object>>)session.getAttribute("orderList");
	System.out.println("orderList : " + list.toString());
	
	int orderPrice = 0; 
	
	Orders order = null;
	for(Map<String,Object> m : list){
		order = new Orders();
		
		order.setGoodsNo((int)m.get("goodsNo"));
		order.setCustomerId((String)session.getAttribute("id"));
		order.setOrderQuantity((int)m.get("cartQuantity"));
		order.setOrderState("배송준비중");
		order.setOrderAdress(addr + " " + addrDetail);
		
		orderPrice = (int)m.get("goodsPrice")*(int)m.get("cartQuantity");
		order.setOrderPrice(orderPrice);
		System.out.println("오더객체 : " + order.toString());
		
		OrdersService ordersService = new OrdersService();
		
		if( ordersService.addOrder(order)){
			System.out.println("오더성공");
			session.removeAttribute("orderList");
		} else {
			System.out.println("오더실패");
			session.removeAttribute("orderList");
		}
		
	}
	
%>
