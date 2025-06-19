package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ReactionsDao;
import dto.ReactionsDto;

/**
 * リアクション取得APIサーブレット 指定したpostIdのリアクション情報（いいね数、ユーザーID一覧など）をJSONで返す
 */
@WebServlet("/ReactionsServlet")
public class ReactionsServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * GET: 指定した投稿ID(postId)に対するリアクションユーザー一覧＆件数をJSONで返す
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ログイン・ログアウトチェック
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		// postIdパラメータを取得し、バリデーション
		String postIdParam = request.getParameter("postId");
		int postId;
		try {
			postId = Integer.parseInt(postIdParam);
		} catch (NumberFormatException | NullPointerException e) {
			// パラメータ不正時は400 Bad Request
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "postIdが不正です");
			return;
		}

		try {
			// DAOからリアクションユーザー一覧を取得
			ReactionsDao reactionsDao = new ReactionsDao();
			List<ReactionsDto> users = reactionsDao.findUsersByPostId(postId);

			// --- JSONレスポンス生成 ---
			response.setContentType("application/json; charset=UTF-8");
			PrintWriter out = response.getWriter();

			// エスケープ処理（本来はJsonライブラリ使用推奨）
			out.print("{\"likeCount\":" + users.size() + ",\"users\":[");
			for (int i = 0; i < users.size(); i++) {
				// 必要に応じて名前やIDを取得
				// 本来はユーザー名やプロフィールを出す場合が多い
				out.print("{\"userId\":\"" + users.get(i).getUserId() + "\"}");
				if (i < users.size() - 1)
					out.print(",");
			}
			out.print("]}");
			out.flush();

		} catch (Exception e) {
			e.printStackTrace();
			// サーバーエラーの場合は500
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "リアクション取得に失敗しました");
		}
	}

	/**
	 * POST: 必要なら実装（リアクション追加など）
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 必要があればここに実装
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "POSTは未サポートです");
	}
}
