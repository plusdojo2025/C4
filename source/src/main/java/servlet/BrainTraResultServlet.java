package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BrainTrainingResultsDao;
import dto.BrainTrainingResultsDto;

@WebServlet("/OmoiyalinkBrainTraResult")
public class BrainTraResultServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();

		Integer winCount = (Integer) session.getAttribute("winCount");
		if (winCount == null)
			winCount = 0;
		@SuppressWarnings("unchecked")
		List<String> history = (List<String>) session.getAttribute("history");
		if (history == null)
			history = new ArrayList<>();

		// すでにDB登録済なら何もしない、未登録なら保存
		Boolean saved = (Boolean) session.getAttribute("braintra_saved");
		if (saved == null)
			saved = false;

		if (winCount > 0 && !saved) {
			try {
				int userId = (int) session.getAttribute("userId"); // 認証必須
				BrainTrainingResultsDto dto = new BrainTrainingResultsDto();
				dto.setUser_id(userId);
				dto.setScore(winCount);
				dto.setGame_type("後出しじゃんけん");
				dto.setPlayed_at(new Date());
				BrainTrainingResultsDao dao = new BrainTrainingResultsDao();
				boolean result = dao.insert(dto);
				request.setAttribute("saveResult", result ? "スコア保存完了" : "スコア保存失敗");
				session.setAttribute("braintra_saved", true); // 一度だけ保存
			} catch (Exception e) {
				request.setAttribute("saveResult", "スコア保存時にエラーが発生しました");
			}
		}

		request.setAttribute("winCount", winCount);
		request.setAttribute("history", history);

		request.getRequestDispatcher("/WEB-INF/jsp/brainTraResult.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
