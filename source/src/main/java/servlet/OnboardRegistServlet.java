package servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostsDao;
import dto.PostsDto;

@WebServlet("/OnboardRegist")
public class OnboardRegistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		HttpSession session = request.getSession(false);
		if (session == null) {
			response.sendRedirect("OmoiyalinkLogin");
			return;
		}

		// DTOごと持つ設計なら
		/*
		 * UsersDto user = (UsersDto) session.getAttribute("user"); if (user == null) {
		 * response.sendRedirect("OmoiyalinkLogin"); return; } String pref =
		 * user.getPref(); String city = user.getCity();
		 */

		// セッション属性（pref, city）が使われている場合はこちら
		String pref = (String) session.getAttribute("pref");
		String city = (String) session.getAttribute("city");

		request.setAttribute("pref", pref);
		request.setAttribute("city", city);

		request.getRequestDispatcher("/WEB-INF/jsp/onboardRegist.jsp").forward(request, response);
	}

	private boolean checkLogout(HttpServletRequest request, HttpServletResponse response) {
		// 必要なら共通メソッドを使う
		return false;
	}

	private boolean checkNoneLogin(HttpServletRequest request, HttpServletResponse response) {
		// 必要なら共通メソッドを使う
		return false;
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		request.setCharacterEncoding("UTF-8");

		try {
			HttpSession session = request.getSession(false);
			if (session == null) {
				response.sendRedirect("OmoiyalinkLogin");
				return;
			}

			// === ここで他サーブレット同様、"id" でユーザーIDを取得 ===
			Integer userIdObj = (Integer) session.getAttribute("id");
			if (userIdObj == null) {
				response.sendRedirect("OmoiyalinkLogin");
				return;
			}
			int userId = userIdObj;

			// pref, cityもセッションから取得（フォーム送信値優先ならrequest.getParameter()でもOK）
			String pref = request.getParameter("pref");
			String city = request.getParameter("city");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String[] tags = request.getParameterValues("tags");

			// 必須チェック
			if (title == null || title.isEmpty() || content == null || content.isEmpty() || tags == null
					|| tags.length == 0) {

				request.setAttribute("errorMessage", "タイトル・内容・タグは必須です。");
				request.getRequestDispatcher("/WEB-INF/jsp/onboardRegist.jsp").forward(request, response);
				return;
			}

			String tag = String.join(",", tags);
			PostsDto post = new PostsDto(userId, tag, title, content, new Date(), pref, city);

			PostsDao dao = new PostsDao();
			dao.insert(post);

			response.sendRedirect("OmoiyalinkMyPosts");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "投稿処理中にエラーが発生しました");
		}
	}
}
