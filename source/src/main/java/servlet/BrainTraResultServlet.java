package servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BrainTrainingResultsDao;
import dto.BrainTrainingResultsDto;

@WebServlet("/OmoiyalinkBrainTraResult")
public class BrainTraResultServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	// POSTでスコアを受信＆保存
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		int winCount = 0;
		try {
			winCount = Integer.parseInt(request.getParameter("winCount"));
		} catch (Exception e) {
			// 万が一パースエラーなら0のまま
		}

		// 認証済みユーザーID
		int userId = (int) request.getSession().getAttribute("userId");

		// DB保存
		BrainTrainingResultsDto dto = new BrainTrainingResultsDto();
		dto.setUser_id(userId);
		dto.setScore(winCount);
		dto.setGame_type("後出しじゃんけん");
		dto.setPlayed_at(new Date());

		BrainTrainingResultsDao dao = new BrainTrainingResultsDao();
		boolean saved = dao.insert(dto);

		// 表示用
		request.setAttribute("winCount", winCount);
		request.setAttribute("saveResult", saved ? "スコア保存しました" : "保存に失敗しました");

		request.getRequestDispatcher("/WEB-INF/jsp/brainTraResult.jsp").forward(request, response);
	}

	// GETは直接アクセスさせない（またはエラー画面へ）
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "/OmoiyalinkBrainTra");
	}
}
