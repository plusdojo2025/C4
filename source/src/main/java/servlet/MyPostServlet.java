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
import dto.UsersDto;

/**
 * マイ投稿一覧画面サーブレット ログインユーザーの投稿だけを一覧表示
 */
@WebServlet("/OmoiyalinkMyPost")
public class MyPostServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * GETリクエスト時 ログインチェック→自分の投稿一覧をJSPへ渡して表示
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. 未ログイン・ログアウトの場合はログイン画面などにリダイレクト
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		try {
			// 2. セッションからログインユーザー情報を取得
			HttpSession session = request.getSession(false);
			// UsersDtoは "user" または "loginUser" で格納することを推奨
			UsersDto user = (UsersDto) session.getAttribute("user");
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = user.getUserId();

			// 3. 自分の投稿のみDBから取得
			PostsDao postDao = new PostsDao();
			List<PostsDto> myPosts = postDao.selectByUserId(userId);

			// 4. JSPへ渡す
			request.setAttribute("myPosts", myPosts);

			// 5. マイ投稿一覧JSPへフォワード（/WEB-INF/jsp/myPost.jspなどが一般的）
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myPost.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			// 6. エラー時はトップページやエラー画面に遷移
			request.setAttribute("message", "エラーが発生しました。投稿一覧を取得できませんでした。");
			request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);
		}
	}

	/**
	 * POSTリクエスト時（未使用ならGETへ転送 or 405返却でもOK）
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// GETに統一する場合
		doGet(request, response);
		// または
		// response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED,
		// "POSTは未サポートです");
	}
}
