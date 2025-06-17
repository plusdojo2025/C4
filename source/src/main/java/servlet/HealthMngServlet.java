package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.HealthrecordDao;
import dto.HealthrecordDto;

@WebServlet("/OmoiyalinkHealthMng")
public class HealthMngServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	// 1ページあたりの表示件数（固定値。変更したい場合はここを修正）
	private static final int PAGE_SIZE = 10;

	/**
	 * GETリクエスト時の処理：体調記録一覧（10件単位・ページ送り付き）を表示
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// ---- 未ログイン・ログアウト指示時は以降の処理を中断 ----
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		// ★ログインユーザーIDの取得（セッションから取り出す）
		int userId = (int) request.getSession().getAttribute("userId");

		// ページ番号を取得（未指定・不正な値は0：最新ページ扱い）
		int page = 0;
		String pageParam = request.getParameter("page");
		if (pageParam != null) {
			try {
				page = Integer.parseInt(pageParam);
				if (page < 0)
					page = 0;
			} catch (NumberFormatException e) {
				page = 0;
			}
		}

		// DAOでこのユーザーの全体調記録を取得（降順）
		HealthrecordDao dao = new HealthrecordDao();
		HealthrecordDto cond = new HealthrecordDto();
		cond.setUserId(userId); // ←必ず自分のデータだけ取得
		List<HealthrecordDto> allRecords = dao.select(cond);

		// 取得件数に応じて、表示すべき10件分を抽出
		int totalRecords = (allRecords == null) ? 0 : allRecords.size();
		int fromIndex = page * PAGE_SIZE;
		int toIndex = Math.min(fromIndex + PAGE_SIZE, totalRecords);

		// 実際に表示する10件分のリストを生成
		List<HealthrecordDto> pageRecords = (totalRecords > 0 && fromIndex < totalRecords)
				? allRecords.subList(fromIndex, toIndex)
				: null; // レコード無しまたは範囲外ならnull

		// JSPに渡す値をセット
		request.setAttribute("records", pageRecords); // 今回表示する10件分
		request.setAttribute("page", page); // 現在ページ番号
		request.setAttribute("hasNext", toIndex < totalRecords); // 「次へ」ボタン表示可否
		request.setAttribute("hasPrev", page > 0); // 「前へ」ボタン表示可否

		// 一覧表示JSP（/WEB-INF/jsp/healthMng.jsp）へフォワード
		request.getRequestDispatcher("/WEB-INF/jsp/healthMng.jsp").forward(request, response);
	}

	// POSTリクエストもGETと同じ認証チェックを行う
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		doGet(request, response);
	}
}
