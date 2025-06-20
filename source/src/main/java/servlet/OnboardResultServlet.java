package servlet;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PostsDao;
import dto.PostsDto;

/**
 * 投稿検索・結果表示サーブレット
 */
@WebServlet("/OnboardResult")
public class OnboardResultServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 未ログインチェック
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		// 全件検索
		PostsDao dao = new PostsDao();
		PostsDto searchDto = new PostsDto(); // 空条件で全件
		List<PostsDto> postsList = dao.select(searchDto);

		// 取得結果をJSPに渡す
		request.setAttribute("postsList", postsList);
		// 初回アクセスや未入力の場合は全件リストでフォームを表示
		request.getRequestDispatcher("/WEB-INF/jsp/searchForm.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 未ログインチェック
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		try {
			request.setCharacterEncoding("UTF-8");

			// 検索条件取得
			String prefecture = request.getParameter("prefecture");
			String tag = request.getParameter("tag");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String city = request.getParameter("city");

			// DTOに検索条件を詰める（必要な項目のみでOK）
			PostsDto searchDto = new PostsDto(0, tag, title, content, new Date(), prefecture, city);

			// 検索実行
			PostsDao dao = new PostsDao();
			List<PostsDto> postsList = dao.select(searchDto);

			// 結果をセット
			request.setAttribute("postsList", postsList);

			// 検索画面（または結果画面）へ
			request.getRequestDispatcher("/WEB-INF/jsp/onboardResult.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			// 必要ならエラー画面やエラーメッセージを追加
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "検索処理でエラーが発生しました");
		}
	}
}
