package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BrainTrainingResultsDao;
import dto.BrainTrainingResultsDto;

@WebServlet("/OmoiyalinkBrainTraMng")
public class BrainTraMngServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;
	private static final int PAGE_SIZE = 10;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// セッション取得・ログインチェック
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		int userId = (int) session.getAttribute("userId");

		// 昇順・降順の取得（デフォルトは降順）
		String order = request.getParameter("order");
		boolean asc = "asc".equalsIgnoreCase(order);

		// ページ番号
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

		// DAOで該当ユーザーの全履歴を「昇順・降順指定で」取得（ここを修正！）
		BrainTrainingResultsDao dao = new BrainTrainingResultsDao();
		List<BrainTrainingResultsDto> allList = dao.selectByUserId(userId, asc);

		// nullガード
		if (allList == null)
			allList = new ArrayList<>();

		// ページング
		int totalRecords = allList.size();
		int fromIndex = page * PAGE_SIZE;
		int toIndex = Math.min(fromIndex + PAGE_SIZE, totalRecords);

		List<BrainTrainingResultsDto> pageList = (fromIndex < totalRecords) ? allList.subList(fromIndex, toIndex)
				: new ArrayList<>();

		// JSPに渡す
		request.setAttribute("records", pageList);
		request.setAttribute("page", page);
		request.setAttribute("hasNext", toIndex < totalRecords);
		request.setAttribute("hasPrev", page > 0);
		request.setAttribute("order", asc ? "asc" : "desc");

		request.getRequestDispatcher("/WEB-INF/jsp/brainTraMng.jsp").forward(request, response);
	}

	// POST不要ならdoPostはGETへ転送でOK
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
