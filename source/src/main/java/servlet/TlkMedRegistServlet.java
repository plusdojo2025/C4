package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TlkMedRegistServlet
 */
@WebServlet("/OmoiyalinkTlkMedRegistServlet")
public class TlkMedRegistServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * Default constructor.
	 */
	public TlkMedRegistServlet() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ログインしているかチェックする
		if (checkNoneLogin(request, response)) {
			return;
		}

		// 服薬登録画面？ページにフォワードする （）
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/tlkMedRegist.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response)) {
			return;
		}
		if (checkLogout(request, response)) {
			return;
		}
		
		//リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		String takenTime 	=		 request.getParameter("takeTime");
		String takenMed  	= 		request.getParameter("takeMed");
		String memo			=		 request.getParameter("memo");
		String[] selectedOptions = request.getParameterValues("options");
		
	   //データ変換
		
		
		//ログインユーザーの取得
		
		
		//DTOに詰める
		
		//DAOで登録
		
	}
	
}
