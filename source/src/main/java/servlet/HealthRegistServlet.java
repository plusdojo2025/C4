package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.HealthrecordDao;
import dto.HealthrecordDto;

/**
 * 体調記録登録サーブレット GET: 体調記録フォーム表示 POST: 記録を登録し、結果に応じて画面遷移
 */
@WebServlet("/OmoiyalinkHealthRegist")
public class HealthRegistServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	// 体調登録フォームの表示（GET時）
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ログインチェック（未ログイン時は強制リダイレクト）
		if (checkNoneLogin(request, response)) {
			return;
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/healthRegist.jsp");
		dispatcher.forward(request, response);
	}

	// 体調記録登録（POST時）
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}

		request.setCharacterEncoding("UTF-8");

		try {
			// 入力値取得
			String createdAtStr = request.getParameter("createdAt");
			String temperatureStr = request.getParameter("temperature");
			String highBpStr = request.getParameter("highBp");
			String lowBpStr = request.getParameter("lowBp");
			String pulseRateStr = request.getParameter("pulseRate");
			String pulseOxStr = request.getParameter("pulseOx");
			String sleepStr = request.getParameter("sleep");
			String memo = request.getParameter("memo");

			// 必須項目チェック
			if (createdAtStr == null || createdAtStr.isEmpty() || temperatureStr == null || temperatureStr.isEmpty()) {
				request.setAttribute("message", "日付・体温は必須です。");
				request.getRequestDispatcher("/WEB-INF/jsp/healthRegist.jsp").forward(request, response);
				return;
			}

			// データ型変換・未入力対応
			Date date = Date.valueOf(createdAtStr);
			double temperature = Double.parseDouble(temperatureStr);
			Double highBp = (highBpStr == null || highBpStr.isEmpty()) ? null : Double.parseDouble(highBpStr);
			Double lowBp = (lowBpStr == null || lowBpStr.isEmpty()) ? null : Double.parseDouble(lowBpStr);
			Integer pulseRate = (pulseRateStr == null || pulseRateStr.isEmpty()) ? null
					: Integer.parseInt(pulseRateStr);
			Double pulseOx = (pulseOxStr == null || pulseOxStr.isEmpty()) ? null : Double.parseDouble(pulseOxStr);
			int sleep = (sleepStr == null || sleepStr.isEmpty()) ? 0 : Integer.parseInt(sleepStr);

			// --- 統一：セッションから「id」属性でユーザーID取得 ---
			HttpSession session = request.getSession();
			Integer userIdObj = (Integer) session.getAttribute("id");
			if (userIdObj == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = userIdObj;

			// DTOに詰める
			HealthrecordDto dto = new HealthrecordDto();
			dto.setUserId(userId);
			dto.setDate(date);
			dto.setTemperature(temperature);
			dto.setHighBp(highBp);
			dto.setLowBp(lowBp);
			dto.setPulseRate(pulseRate);
			dto.setPulseOx(pulseOx);
			dto.setSleep(sleep);
			dto.setMemo(memo);

			// DAOで登録
			boolean result = new HealthrecordDao().insert(dto);

			// 結果に応じて画面遷移
			if (result) {
				session.setAttribute("message", "本日の体調を登録しました。");
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkHealthMng");
			} else {
				request.setAttribute("message", "登録に失敗しました。");
				request.getRequestDispatcher("/WEB-INF/jsp/healthRegist.jsp").forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/healthRegist.jsp").forward(request, response);
		}
	}
}
