package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BrainTrainingResultsDao;
import dto.BrainTrainingResultsDto;

@WebServlet("/OmoiyalinkBrainTraMng")
public class BrainTraMngServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;
	private static final int PAGE_SIZE = 10;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// セッションからuserId取得（"id"キー）＆nullチェック
		Integer userId = (Integer) request.getSession().getAttribute("id");
		if (userId == null) {
			response.sendRedirect("OmoiyalinkLogin");
			return;
		}

		// 並び順（昇順/降順）
		String order = request.getParameter("order");
		boolean asc = "asc".equalsIgnoreCase(order);

		// ページ番号（未指定または不正は0）
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

		// DBから全件取得→ページ分割
		BrainTrainingResultsDao dao = new BrainTrainingResultsDao();
		List<BrainTrainingResultsDto> allList = dao.selectByUserId(userId, asc);
		if (allList == null)
			allList = new ArrayList<>();

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

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
