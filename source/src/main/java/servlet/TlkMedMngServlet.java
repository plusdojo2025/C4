package servlet;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

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
 * 服薬記録管理サーブレット（一覧表示・更新・削除）
 */
@WebServlet("/OmoiyalinkTlkMedMng")
public class TlkMedMngServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 服薬記録一覧を表示（GET時）
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ログインチェック
		if (checkNoneLogin(request, response) || checkLogout(request, response)) 
			return;
	
		try {
			// セッションからユーザー情報を取得
			HttpSession session = request.getSession();
			UsersDto user = (UsersDto) session.getAttribute("user");
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = user.getUserId();

			
			 // 年月パラメータの取得（指定なければ今月）
            LocalDate now = LocalDate.now();
            int year = parseOrDefault(request.getParameter("year"), now.getYear());
            int month = parseOrDefault(request.getParameter("month"), now.getMonthValue());
			
            // このユーザーの服薬記録を検索
			MedicationLogsDao dao = new MedicationLogsDao();
			MedicationLogsDto searchDto = new MedicationLogsDto();
			searchDto.setUserId(userId);
			List<MedicationLogsDto> mlogList = dao.selectByMonth(userId, year, month);
			
			// 検索結果をリクエストスコープにセット
			request.setAttribute("mlogList", mlogList);
			request.setAttribute("year", year);
            request.setAttribute("month", month);
            
			// 一覧表示JSPへフォワード
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/tlkMedMng.jsp");
			dispatcher.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。服薬記録を取得できませんでした。");
			request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);
		}
	}
	private int parseOrDefault(String value, int defaultVal) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return defaultVal;
        }
    }

	/**
	 * 服薬記録の更新・削除（POST時） submitパラメータの値で処理を分岐する
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
			// セッションからユーザー情報を取得
			HttpSession session = request.getSession();
			UsersDto user = (UsersDto) session.getAttribute("user");
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = user.getUserId();

			// 編集対象の服薬記録IDなどパラメータ取得
			int logId = Integer.parseInt(request.getParameter("logId"));
			String takenTimeStr = request.getParameter("takenTime");
			String takenMed = request.getParameter("takenMed");
			String memo = request.getParameter("memo");
			String nickName = request.getParameter("nickname");
			String formalName = request.getParameter("formalName");
			String dosage = request.getParameter("dosage");
			int medicationId = Integer.parseInt(request.getParameter("medicationId"));

			// 日付変換（yyyy-MM-dd想定）
			Date takenTime = Date.valueOf(takenTimeStr);

			// DTO組み立て
			MedicationLogsDto dto = new MedicationLogsDto(logId, medicationId, userId, takenTime, takenMed, memo,
					nickName, formalName, dosage);

			MedicationLogsDao mDao = new MedicationLogsDao();
			String submit = request.getParameter("submit");
			boolean result = false;
			String message = "";

			// 処理分岐
			if ("更新".equals(submit)) {
				result = mDao.update(dto);
				message = result ? "服薬記録を更新しました。" : "更新に失敗しました。";
			} else if ("削除".equals(submit)) {
				result = mDao.delete(dto);
				message = result ? "服薬記録を削除しました。" : "削除に失敗しました。";
			}

			// 完了メッセージをリクエストにセット（リダイレクト推奨）
			request.getSession().setAttribute("message", message);
			response.sendRedirect(request.getContextPath() + "/OmoiyalinkTlkMedMng");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/tlkMedMng.jsp").forward(request, response);
		}
	}
}
