package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BrainTraServlet
 */
@WebServlet("/OmoiyalinkBrainTra")
public class BrainTraServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public BrainTraServlet() {
        // TODO Auto-generated constructor stub
    }

    //メニュー表示
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		
		
		request.getRequestDispatcher("/WEB-INF/jsp/brainTra.jsp").forward(request, response);
    }
		// TODO Auto-generated method stub
	
	//選択肢
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String action = request.getParameter("action");

        if ("start".equals(action)) {
            response.sendRedirect("BrainTraPlayServlet");     //ゲーム開始ボタン
        } else if ("history".equals(action)) {
            response.sendRedirect("BrainTraMngServlet");		     //履歴閲覧
        } else {
            response.sendRedirect("OmoiyalinkBrainTra");	// メニューに戻る
        }
        
        
        
    

		// TODO Auto-generated method stub
		//doGet(request, response);
	}
}

