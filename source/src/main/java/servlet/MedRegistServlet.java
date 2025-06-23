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

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response)) {
			return;
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/medRegist.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		request.setCharacterEncoding("UTF-8");

		try {
			// 入力値取得
			String nickName = request.getParameter("nickName"); // 愛称
			String formalName = request.getParameter("formalName"); // 正式名称
			String dosage = request.getParameter("dosage"); // 用量
			String createdAtStr = request.getParameter("created_at"); // 登録日
			String memo = request.getParameter("memo"); // メモ
			String intakeTimeStr = request.getParameter("intake_time"); // 例 "08:00"

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

			// セッションからユーザー取得
			HttpSession session = request.getSession();
			UsersDto user = (UsersDto) session.getAttribute("user");
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = user.getUserId();

			// DTOにセット
			MedicationsDto dto = new MedicationsDto();
			dto.setUserId(userId);
			dto.setNickName(nickName);
			dto.setFormalName(formalName);
			dto.setDosage(dosage);
			dto.setCreatedAt(createdAt);
			dto.setMemo(memo);
			dto.setIntakeTime(intakeTime);

			// INSERT
			boolean result = new MedicationsDao().insert(dto);

			if (result) {
				session.setAttribute("message", "お薬を登録しました。");
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkMedMng");
			} else {
				request.setAttribute("message", "登録に失敗しました。");
				request.getRequestDispatcher("/WEB-INF/jsp/medRegist.jsp").forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/medRegist.jsp").forward(request, response);
		}
	}
}
