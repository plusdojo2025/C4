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

	// スコア受信・DB保存・結果画面遷移
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// 1. 勝利回数の取得
		int winCount = 0;
		try {
			winCount = Integer.parseInt(request.getParameter("winCount"));
		} catch (Exception e) {
			System.out.println("[DEBUG] winCountパースエラー: " + e.getMessage());
		}
		System.out.println("[DEBUG] 受信 winCount: " + winCount);

		// 2. ユーザーIDの取得（セッションから）＋nullチェック
		Integer userIdObj = (Integer) request.getSession().getAttribute("id");
		if (userIdObj == null) {
			System.out.println("[DEBUG] userId is null! ログイン画面へリダイレクト");
			response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
			return;
		}
		int userId = userIdObj;
		System.out.println("[DEBUG] セッション userId: " + userId);

		// 3. DB保存処理
		BrainTrainingResultsDto dto = new BrainTrainingResultsDto();
		dto.setUser_id(userId);
		dto.setScore(winCount);
		dto.setGame_type("後出しじゃんけん");
		dto.setPlayed_at(new Date());

		BrainTrainingResultsDao dao = new BrainTrainingResultsDao();
		boolean saved = dao.insert(dto);
		System.out.println("[DEBUG] DAO.insert結果: " + saved);

		// 4. JSPへ値渡し
		request.setAttribute("winCount", winCount);
		request.setAttribute("saveResult", saved ? "スコア保存しました" : "保存に失敗しました");

		// 5. 結果画面へ遷移
		request.getRequestDispatcher("/WEB-INF/jsp/brainTraResult.jsp").forward(request, response);
	}

	// GETは直接アクセスさせない
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "https://plusdojo.jp/c4/ OmoiyalinkBrainTra");
	}
}
