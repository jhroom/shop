package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class DriverListener implements ServletContextListener {


    public void contextDestroyed(ServletContextEvent sce)  {
    	System.out.println("driver Listener 종료");
    }

    public void contextInitialized(ServletContextEvent sce)  {
    	System.out.println("driver Listener 시작");
    	
    	// 톰캣부팅시 aplication.setAttribute에 currentCounter 0으로 초기화
    	sce.getServletContext().setAttribute("currentCounter", 0);
    	
    	try {
    		Class.forName("org.mariadb.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("class forName 오류");
			e.printStackTrace();
		}
    }
	
}
