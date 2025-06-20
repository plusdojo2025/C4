package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.PostsDao;
import dto.PostsDto;

@WebServlet("/OmoiyalinkMyPost")
public class MyPostServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. 未ログイン・ログアウトの場合はログイン画面などにリダイレクト
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		try {
			// 2. セッションからログインユーザーIDを取得（"id"属性で統一）
			HttpSession session = request.getSession(false);
			Integer userIdObj = (Integer) session.getAttribute("id");
			if (userIdObj == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = userIdObj;

			// 3. 自分の投稿のみDBから取得
			PostsDao postDao = new PostsDao();
			List<PostsDto> myPosts = postDao.selectByUserId(userId);

			// 4. JSPへ渡す
			request.setAttribute("myPosts", myPosts);

			// 5. マイ投稿一覧JSPへフォワード
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPost.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。投稿一覧を取得できませんでした。");
			request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
