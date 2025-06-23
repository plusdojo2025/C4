package servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MedicationsDao;
import dto.MedicationsDto;
import dto.UsersDto;

/**
 * お薬新規登録画面サーブレット /OmoiyalinkMedRegist でアクセス
 */
@WebServlet("/OmoiyalinkMedRegist")
public class MedRegistServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * お薬登録画面の表示処理（GET時） ※未ログイン時はチェックして終了 ※必要に応じて「登録フォーム画面」へフォワード
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ログイン状態チェック（未ログイン時は強制リダイレクトなどをcheckNoneLoginで制御）
		if (checkNoneLogin(request, response)) {
			return;
		}
		
		// 登録フォーム（例：medRegist.jsp）へフォワード
		// ★元コードは/home.jspになっていたので「本来の登録フォーム」に変更
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/medRegist.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * お薬登録処理（POST時） 入力内容取得→DTO詰め→DAOでINSERT→結果に応じて画面遷移
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		
		// 入力フォームの値の文字化け対策
		request.setCharacterEncoding("UTF-8");

		try {
			// 入力値取得
			String nickName = request.getParameter("nickName"); // 愛称
			String formalName = request.getParameter("formalName"); // 正式名称
			String dosage = request.getParameter("dosage"); // 用量
			String createdAtStr = request.getParameter("created_at"); // 登録日
			String memo = request.getParameter("memo"); // メモ
			String intakeTimeStr = request.getParameter("intake_time"); // 例 "08:00" 服薬時間（yyyy-MM-dd形式の場合のみ）

			// 必須チェック
			if (formalName == null || formalName.isEmpty() || dosage == null || dosage.isEmpty()
					|| intakeTimeStr == null || intakeTimeStr.isEmpty()) {
				request.setAttribute("message", "薬の正式名称・用量・服薬時間は必須です。");
				request.getRequestDispatcher("/WEB-INF/jsp/medRegist.jsp").forward(request, response);
				return;

			}

			// 日付
			Date createdAt = null;
			if (createdAtStr != null && !createdAtStr.isEmpty()) {
				createdAt = Date.valueOf(createdAtStr);
			} else {
				// 未指定なら今日の日付
				createdAt = new Date(System.currentTimeMillis());
			}

			// 服薬時間（"08:00"→"08:00:00"）
			Time intakeTime = null;
			if (intakeTimeStr != null && !intakeTimeStr.isEmpty()) {
				intakeTime = Time.valueOf(intakeTimeStr + ":00");
			}

			// // --- セッションからログインユーザー情報取得 ---
			HttpSession session = request.getSession();
			UsersDto user = (UsersDto) session.getAttribute("user"); // ←loginUserやuserが推奨名
			if (user == null) {
				// 万一セッション切れ時はログイン画面へ
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = user.getUserId();

			// // DTOにデータを詰める 
			MedicationsDto dto = new MedicationsDto();
			dto.setUserId(userId);
			dto.setNickName(nickName);
			dto.setFormalName(formalName);
			dto.setDosage(dosage);
			dto.setCreatedAt(createdAt);
			dto.setMemo(memo);
			dto.setIntakeTime(intakeTime);

			// DB登録処理  INSERT
			boolean result = new MedicationsDao().insert(dto);
			
			// --- 処理結果に応じて画面遷移・メッセージセット ---
			if (result) {
				// 登録成功時：メッセージ表示し一覧画面（お薬管理）にリダイレクト
				session.setAttribute("message", "お薬を登録しました。");
				// 一覧画面サーブレットへ（リダイレクト推奨: PRGパターン）
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkMedMng");
				return;
			} else {
				// 登録失敗時：元の登録画面にエラーメッセージ付きで戻す
				request.setAttribute("message", "登録に失敗しました。");
				request.getRequestDispatcher("/WEB-INF/jsp/medRegist.jsp").forward(request, response);
			}
			}catch (Exception e) {
				// 例外時（入力値不正やDB障害等）はメッセージ付きで登録画面に戻す
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/medRegist.jsp").forward(request, response);
		}
	}
}
