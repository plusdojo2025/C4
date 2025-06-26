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
import dao.ReactionsDao;
import dto.PostsDto;

@WebServlet("/OmoiyalinkMyPost")
public class MyPostServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		try {
			HttpSession session = request.getSession(false);
			Integer userIdObj = (Integer) session.getAttribute("id");
			if (userIdObj == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = userIdObj;

			PostsDao postDao = new PostsDao();
			List<PostsDto> myPosts = postDao.selectByUserId(userId);

			// --- ここが重要！「いいね」情報をセット ---
			ReactionsDao reactionsDao = new ReactionsDao();
			for (PostsDto post : myPosts) {
				post.setLikedByCurrentUser(reactionsDao.isUserLiked(post.getPostId(), userId));
				post.setLikeCount(reactionsDao.getLikeCountByPostId(post.getPostId()));
				post.setLikedUsers(reactionsDao.getLikedUserNames(post.getPostId()));
			}

			request.setAttribute("myPosts", myPosts);
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

		// 1. 未ログイン・ログアウトチェック
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		try {
			request.setCharacterEncoding("UTF-8");

			HttpSession session = request.getSession(false);
			Integer userIdObj = (Integer) session.getAttribute("id");
			if (userIdObj == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = userIdObj;

			// 2. 削除対象のpostIdをリクエストから取得
			String postIdStr = request.getParameter("deletePostId");
			if (postIdStr != null && !postIdStr.isEmpty()) {
				int postId = Integer.parseInt(postIdStr);
				PostsDao postDao = new PostsDao();
				postDao.deleteById(postId, userId);
			}

			// 3. 削除後も再度マイ投稿一覧を取得し表示
			doGet(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "削除処理でエラーが発生しました。");
			request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);
		}
	}
}
