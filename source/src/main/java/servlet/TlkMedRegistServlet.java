package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MedicationLogsDao;
import dto.MedicationLogsDto;
import dto.UsersDto;

/**
 * 服薬記録登録サーブレット GET: 登録画面表示 POST: 服薬記録を登録（複数選択可）
 */
@WebServlet("/OmoiyalinkTlkMedRegistServlet")
public class TlkMedRegistServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 服薬登録画面の表示（GET時）
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ログインチェック（未ログイン時は強制リダイレクト）
		if (checkNoneLogin(request, response)) {
			return;
		}
		// 登録フォーム（tlkMedRegist.jsp）へフォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/tlkMedRegist.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * 服薬記録の登録（POST時） ・1回の登録で複数の薬が選択された場合、すべて登録 ・成功/失敗でメッセージ＋遷移
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ログイン・ログアウトチェック
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		request.setCharacterEncoding("UTF-8"); // 文字化け対策

		try {
			// --- 入力値取得 ---
			String takenTimeStr = request.getParameter("takenTime"); // 服薬日付（yyyy-MM-dd）
			String memo = request.getParameter("memo"); // メモ
			String[] selectedTakenMed = request.getParameterValues("takenMed"); // 薬名配列

			// --- 入力値チェック ---
			if (takenTimeStr == null || selectedTakenMed == null || selectedTakenMed.length == 0) {
				request.setAttribute("message", "服薬日と薬を選択してください。");
				request.getRequestDispatcher("/WEB-INF/jsp/tlkMedRegist.jsp").forward(request, response);
				return;
			}

			// --- 日付変換 ---
			Date takeTime = Date.valueOf(takenTimeStr);

			// --- セッションからユーザー情報取得 ---
			HttpSession session = request.getSession();
			UsersDto user = (UsersDto) session.getAttribute("user");
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = user.getUserId();

			// --- 複数登録時の成功/失敗判定用 ---
			int successCount = 0;
			int totalCount = selectedTakenMed.length;

			// --- 服薬記録をすべて登録（失敗してもループは止めない） ---
			for (String med : selectedTakenMed) {
				MedicationLogsDto dto = new MedicationLogsDto();
				dto.setUserId(userId);
				dto.setTakenTime(takeTime);
				dto.setMemo(memo);
				dto.setTakenMed(med);

				boolean result = new MedicationLogsDao().insert(dto);
				if (result)
					successCount++;
			}

			// --- 登録結果メッセージ生成 ---
			String message;
			if (successCount == totalCount) {
				message = "服薬記録を登録しました。";
			} else if (successCount == 0) {
				message = "登録に失敗しました。";
			} else {
				message = "一部の服薬記録は登録できませんでした。";
			}
			// 登録後は一覧画面へリダイレクト（PRGパターン推奨）
			request.getSession().setAttribute("message", message);
			response.sendRedirect(request.getContextPath() + "/TlkMedMngServlet");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/tlkMedRegist.jsp").forward(request, response);
		}
	}
}
