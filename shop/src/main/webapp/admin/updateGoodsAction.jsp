<%@page import="vo.Goods"%>
<%@page import="service.GoodsService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf8");

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String goodsName = request.getParameter("goodsName");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	String soldOut = request.getParameter("soldOut");
	
	GoodsService goodsService = new GoodsService();
	Goods goods = new Goods();
	
	goods.setGoodsNo(goodsNo);
	goods.setGoodsName(goodsName);
	goods.setGoodsPrice(goodsPrice);
	goods.setSoldOut(soldOut);
		System.out.println("goods 수정된 객체 : " + goods);
	
	// 업데이트할 굿즈 객체를 
	boolean result = new GoodsService().modifyGoods(goods);
	
	if(result){
		response.sendRedirect(request.getContextPath()+"/admin/adminGoodsList.jsp?updateSuccess");
	}
	
%>