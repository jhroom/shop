package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.SignService;

@WebServlet("/idckController")
public class IdCheckController extends HttpServlet {
	private SignService signService;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 전에 기본생성자를 안지웠어서 컨트롤러가 실행된것처럼 아이디 받아오고 중복검사도 했지만 그전에 이미 응답을 해버려서 
		// 다시 jsp로 응답한 값이 없던 거였다.
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		
		this.signService = new SignService();
		
		String unckId = request.getParameter("idck");
			System.out.println("넘어온아이디값 : " + unckId);
		
		String ckId = signService.idCkService(unckId);
			System.out.println("중복검사된ID : " + ckId);
			
		Gson gson = new Gson();
		String jsonStr = "";
		
		if(ckId == null) {
			jsonStr = gson.toJson("y");
		} else {
			jsonStr = gson.toJson("n");
		}
		System.out.println("jsonStr : "  +  jsonStr);
	
		PrintWriter out = response.getWriter();
		out.write(jsonStr);
		out.flush();
		out.close();
		
	}
	

}
