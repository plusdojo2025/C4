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
import dto.UsersDto;

/**
 * 体調記録登録サーブレット GET: 体調記録フォーム表示 POST: 記録を登録し、結果に応じて遷移
 */
@WebServlet("/OmoiyalinkHealthRegist")
public class HealthRegistServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 体調登録フォームの表示（GET時）
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ログインチェック（未ログインならリダイレクト）
		if (checkNoneLogin(request, response)) {
			return;
		}

		// 体調登録画面（/WEB-INF/jsp/healthRegist.jsp）にフォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/healthRegist.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * 体調記録登録（POST時） 入力内容取得→DTO詰め→DAOでINSERT→結果に応じて画面遷移
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
			String createdAtStr = request.getParameter("createdAt");
			String temperatureStr = request.getParameter("temperature");
			String highBpStr = request.getParameter("highBp");
			String lowBpStr = request.getParameter("lowBp");
			String pulseRateStr = request.getParameter("pulseRate");
			String pulseOxStr = request.getParameter("pulseOx");
			String sleepStr = request.getParameter("sleep");
			String memo = request.getParameter("memo");

			// --- データ型変換・未入力対応 ---
			Date date = Date.valueOf(createdAtStr);
			double temperature = Double.parseDouble(temperatureStr);
			Double highBp = (highBpStr == null || highBpStr.isEmpty()) ? null : Double.parseDouble(highBpStr);
			Double lowBp = (lowBpStr == null || lowBpStr.isEmpty()) ? null : Double.parseDouble(lowBpStr);
			Integer pulseRate = (pulseRateStr == null || pulseRateStr.isEmpty()) ? null
					: Integer.parseInt(pulseRateStr);
			Double pulseOx = (pulseOxStr == null || pulseOxStr.isEmpty()) ? null : Double.parseDouble(pulseOxStr);
			int sleep = Integer.parseInt(sleepStr);

			// --- セッションからユーザー情報を取得（DTO型で統一推奨）---
			HttpSession session = request.getSession();
			UsersDto user = (UsersDto) session.getAttribute("user"); // "user"や"loginUser"で統一推奨
			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}
			int userId = user.getUserId();

			// --- DTOに詰める ---
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

			// --- DAOで登録 ---
			boolean result = new HealthrecordDao().insert(dto);

			// --- 結果をセットして画面遷移 ---
			if (result) {
				// PRGパターン推奨（リダイレクトして一覧へ）
				request.getSession().setAttribute("message", "本日の体調を登録しました。");
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
