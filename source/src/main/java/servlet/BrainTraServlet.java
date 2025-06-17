package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
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

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    //メニュー表示
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/jsp/brainMenu.jsp").forward(request, response);
    }
		// TODO Auto-generated method stub
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	//選択肢
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String action = request.getParameter("action");

        if ("start".equals(action)) {
            response.sendRedirect("BrainTraPlayServlet"); //ゲーム開始ボタン
        } else if ("history".equals(action)) {
            response.sendRedirect("BrainTraMng");		//履歴閲覧
        } else {
            // メニューに戻る
            response.sendRedirect("OmoiyalinkBrainTra");
        }
    }
		// TODO Auto-generated method stub
		//doGet(request, response);
	}


