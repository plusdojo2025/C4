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

	// ログインチェック
	private boolean checkNoneLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("id") == null) {
			response.sendRedirect("OmoiyalinkLogin");
			return true;
		}
		return false;
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response))
			return;

		HttpSession session = request.getSession(false);
		String pref = (String) session.getAttribute("pref");
		String city = (String) session.getAttribute("city");
		request.setAttribute("pref", pref != null ? pref : "");
		request.setAttribute("city", city != null ? city : "");

		request.getRequestDispatcher("/WEB-INF/jsp/onboardRegist.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response))
			return;
		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession(false);
		Integer userIdObj = (Integer) session.getAttribute("id");
		if (userIdObj == null) {
			response.sendRedirect("OmoiyalinkLogin");
			return;
		}
		int userId = userIdObj;

		// パラメータ取得
		String pref = request.getParameter("pref");
		String city = request.getParameter("city");
		if (pref == null || pref.isEmpty())
			pref = (String) session.getAttribute("pref");
		if (city == null || city.isEmpty())
			city = (String) session.getAttribute("city");

		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String[] tags = request.getParameterValues("tags");
		String tag = (tags != null && tags.length > 0) ? String.join(",", tags) : "";

		// 必須チェック
		if (title == null || title.isEmpty() || content == null || content.isEmpty() || tag == null || tag.isEmpty()) {
			request.setAttribute("errorMessage", "タイトル・内容・タグは必須です。");
			request.setAttribute("pref", pref != null ? pref : "");
			request.setAttribute("city", city != null ? city : "");
			request.getRequestDispatcher("/WEB-INF/jsp/onboardRegist.jsp").forward(request, response);
			return;
		}

		// DTO生成（全てsetterで値をセット）
		PostsDto post = new PostsDto();
		post.setUserId(userId);
		post.setTag(tag);
		post.setTitle(title);
		post.setContent(content);
		post.setCreatedAt(new Date());
		post.setPref(pref);
		post.setCity(city);

		try {
			PostsDao dao = new PostsDao();
			dao.insert(post);
			response.sendRedirect("OmoiyalinkMyPost");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "投稿処理中にエラーが発生しました");
		}
	}
}
