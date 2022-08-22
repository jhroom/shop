package listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import service.CounterService;

/**
 * Application Lifecycle Listener implementation class CounterListener
 *
 */
@WebListener
public class CounterListener implements HttpSessionListener {
   private CounterService counterService;
   // 세션이 생성될때 마다 DB카운터를 1씩 증가
   // 세션이 생성될때 마다 application attribute에 현재접속카운터를 1씩 증가


    public void sessionCreated(HttpSessionEvent se)  {
    	System.out.println("CounterListener sessionCreated 시작");
    	counterService = new CounterService();
        counterService.count();
        
        int n = (Integer)(se.getSession().getServletContext().getAttribute("currentCounter"));
        se.getSession().getServletContext().setAttribute("currentCounter", n+1 );

    }

    public void sessionDestroyed(HttpSessionEvent se)  { 
    	System.out.println("CounterListener sessionDestroyed 시작");
    	// 세션이 소멸되면 application attribute에 현재접속카운터를 1씩 감소
    	se.getSession().getServletContext().setAttribute("currentCounter",
    			(Integer)(se.getSession().getServletContext().getAttribute("currentCounter"))-1 );
    }
	
}
