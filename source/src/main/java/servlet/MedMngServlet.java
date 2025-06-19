package servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MedicationsDao;
import dto.MedicationsDto;

/**
 * お薬管理画面サーブレット ・お薬一覧の表示 ・お薬情報の更新・削除
 */
@WebServlet("/OmoiyalinkMedMng")
public class MedMngServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * お薬一覧画面（GETリクエスト時）の処理 ログインチェック→ユーザーのお薬リストを取得し、JSPへフォワード
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 未ログイン・ログアウト済みの場合は以降の処理を中断
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		try {
			// 2. セッションからログインユーザーのIDを取得（なければ強制ログイン画面遷移）
			HttpSession session = request.getSession();
			Integer userId = (Integer) session.getAttribute("user_id");
			if (userId == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}

			// 3. このユーザーが登録したお薬のみをDBから取得
			MedicationsDao dao = new MedicationsDao();
			MedicationsDto searchDto = new MedicationsDto();
			searchDto.setUserId(userId);
			List<MedicationsDto> medicationList = dao.select(searchDto);

			// 4. 取得結果をJSPに渡す（cardList という名前でセット）
			request.setAttribute("cardList", medicationList);

			// 5. 一覧画面（medMng.jsp）へ遷移（/WEB-INF/jsp/medMng.jsp とするのが安全！）
			request.getRequestDispatcher("/WEB-INF/jsp/medMng.jsp").forward(request, response);
		} catch (Exception e) {
			// 6. エラー発生時はエラーメッセージ表示（同じ画面にフォワード）
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。お薬情報を取得できませんでした");
			request.getRequestDispatcher("/WEB-INF/jsp/medMng.jsp").forward(request, response);
		}
	}

	/**
	 * お薬情報の更新・削除（POSTリクエスト時）の処理 フォーム送信→DB更新→結果表示または一覧再表示
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. ログインチェック
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		request.setCharacterEncoding("UTF-8"); // 文字化け対策
		try {
			// 2. セッションからユーザーIDを取得
			HttpSession session = request.getSession();
			Integer userId = (Integer) session.getAttribute("user_id");
			if (userId == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}

			// 3. フォームから入力値・hidden値を取得
			// （hiddenで送る場合：<input type="hidden" name="medicationId" ...>等）
			int medicationId = Integer.parseInt(request.getParameter("medicationId"));
			String nickName = request.getParameter("nickName"); // 愛称
			String formalName = request.getParameter("formalName"); // 正式名称
			String dosage = request.getParameter("dosage"); // 用量
			String createdAtStr = request.getParameter("created_at"); // 登録日付（yyyy-MM-dd）
			String memo = request.getParameter("memo"); // メモ
			String intakeTimeStr = request.getParameter("intake_time"); // 服薬時間

			// 4. 日付データ変換（例外発生時はcatchで処理）
			Date createdAt = Date.valueOf(createdAtStr);
			Date intakeTime = null;
			if (intakeTimeStr != null && !intakeTimeStr.isEmpty()) {
				intakeTime = Date.valueOf(intakeTimeStr); // ※型やデータ形式はDB仕様に合わせて調整！
			}

			// 5. 入力内容からDTO生成
			MedicationsDto dto = new MedicationsDto(medicationId, userId, nickName, formalName, dosage, createdAt, memo,
					intakeTime);

			// 6. どちらのボタンか判定（value属性："更新" or "削除"）
			String submit = request.getParameter("submit");
			boolean result = false;
			MedicationsDao dao = new MedicationsDao();

			if ("更新".equals(submit)) {
				// --- 更新ボタン押下時 ---
				result = dao.update(dto);
				request.setAttribute("message", result ? "お薬情報を更新しました。" : "更新に失敗しました。");
			} else if ("削除".equals(submit)) {
				// --- 削除ボタン押下時 ---
				result = dao.delete(dto);
				request.setAttribute("message", result ? "お薬情報を削除しました。" : "削除に失敗しました。");
			}

			// 7. 結果は一覧画面（GET）にリダイレクト（PRGパターン推奨）
			response.sendRedirect(request.getContextPath() + "/OmoiyalinkMedMng");
		} catch (Exception e) {
			// 8. 入力エラー・DBエラー時は元の画面にエラーメッセージ付きで戻す
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/medMng.jsp").forward(request, response);
		}
	}
}
