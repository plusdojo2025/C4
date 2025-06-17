package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/OmoiyalinkHome")
public class HomeServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// セッション取得・ログインチェック
//		HttpSession session = request.getSession(false);
//		if (session == null || session.getAttribute("userId") == null) {
//			response.sendRedirect("/WEB-INF/jsp/login.jsp");
//			return;
//		}

		// ユーザー名取得（userNameがセッションにセットされている前提）
//		String userName = (String) session.getAttribute("userName");
//		if (userName == null)
//			userName = "ゲスト";

		// JSPへ渡す
//		request.setAttribute("userName", userName);

		// ホーム画面へフォワード
		request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);
	}

	// POST不要ならdoPostはGETへ転送でOK
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
