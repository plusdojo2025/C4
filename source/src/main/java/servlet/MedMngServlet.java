package servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MedicationsDao;
import dto.MedicationsDto;
import dto.UsersDto;

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
		// 未ログイン・ログアウト済みの場合は以降の処理を中断
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		try {
			// セッションからログインユーザーの情報を取得
			HttpSession session = request.getSession(false);
			UsersDto user = (UsersDto) session.getAttribute("user");
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = user.getUserId();

			// ユーザーが登録したお薬リストを取得
			MedicationsDao dao = new MedicationsDao();
			MedicationsDto searchDto = new MedicationsDto();
			searchDto.setUserId(userId);
			List<MedicationsDto> medicationList = dao.select(searchDto);

			// 取得結果をJSPに渡す
			request.setAttribute("cardList", medicationList);

			// 一覧画面（medMng.jsp）へフォワード
			request.getRequestDispatcher("/WEB-INF/jsp/medMng.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。お薬情報を取得できませんでした。");
			request.getRequestDispatcher("/WEB-INF/jsp/medMng.jsp").forward(request, response);
		}
	}

	/**
	 * お薬情報の更新・削除（POSTリクエスト時）の処理 フォーム送信→DB更新→結果表示または一覧再表示
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ログインチェック
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		request.setCharacterEncoding("UTF-8");
		try {
			// セッションからログインユーザー取得
			HttpSession session = request.getSession(false);
			UsersDto user = (UsersDto) session.getAttribute("user");
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = user.getUserId();

			// フォームから値を取得
			int medicationId = Integer.parseInt(request.getParameter("medicationId"));
			String nickName = request.getParameter("nickName");
			String formalName = request.getParameter("formalName");
			String dosage = request.getParameter("dosage");
			String createdAtStr = request.getParameter("created_at");
			String memo = request.getParameter("memo");
			String intakeTimeStr = request.getParameter("intake_time"); // "08:00"など

			// 日付データ変換
			Date createdAt = null;
			if (createdAtStr != null && !createdAtStr.isEmpty()) {
				createdAt = Date.valueOf(createdAtStr);
			}

			// 時刻データ変換
			Time intakeTime = null;
			if (intakeTimeStr != null && !intakeTimeStr.isEmpty()) {
				// "08:00"を"08:00:00"にする
				if (intakeTimeStr.length() == 5) {
					intakeTimeStr += ":00";
				}
				intakeTime = Time.valueOf(intakeTimeStr);
			}

			// DTOを生成
			MedicationsDto dto = new MedicationsDto(medicationId, userId, nickName, formalName, dosage, createdAt, memo,
					intakeTime);

			// どちらのボタンか判定（value属性："更新" or "削除"）
			String submit = request.getParameter("submit");
			boolean result = false;
			MedicationsDao dao = new MedicationsDao();

			if ("更新".equals(submit)) {
				// 更新ボタン押下時
				result = dao.update(dto);
				request.setAttribute("message", result ? "お薬情報を更新しました。" : "更新に失敗しました。");
			} else if ("削除".equals(submit)) {
				// 削除ボタン押下時
				result = dao.delete(dto);
				request.setAttribute("message", result ? "お薬情報を削除しました。" : "削除に失敗しました。");
			}

			// 結果は一覧画面（GET）にリダイレクト（PRGパターン推奨）
			response.sendRedirect(request.getContextPath() + "/OmoiyalinkMedMng");

		} catch (Exception e) {
			// 入力エラー・DBエラー時は元の画面にエラーメッセージ付きで戻す
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/medMng.jsp").forward(request, response);
		}
	}
}
