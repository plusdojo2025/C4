package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/OmoiyalinkHome")
public class HomeServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	//もしログインしていなかったらログインサーブレットにリダイレクトする。
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response)) {
			return;
		}
		
		// ログインページにフォワードする　　（ホーム？）
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response)) {
			return;
		}
		if (checkLogout(request, response)) {
			return;
		}

	}
}
