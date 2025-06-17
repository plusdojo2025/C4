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
 * Servlet implementation class HealthRegistServlet
 */
@WebServlet("/OmoiyalinkHealthRegist")
public class HealthRegistServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response)) {
			return;
		}
		
		// ログインページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response)) {
			return;
		}
		if (checkLogout(request, response)) {
			return;
		}
		
	// フォームから入力内容を取得する
	request.setCharacterEncoding("UTF-8");
    try {
        // パラメータ取得
        String createdAtStr = request.getParameter("createdAt");
        String temperatureStr = request.getParameter("temperature");
        String highBpStr = request.getParameter("highBp");
        String lowBpStr = request.getParameter("lowBp");
        String pulseRateStr = request.getParameter("pulseRate");
        String pulseOxStr = request.getParameter("pulseOx");
        String sleepStr = request.getParameter("sleep");
        String memo = request.getParameter("memo");

        // データ変換
        Date date = Date.valueOf(createdAtStr);
        double temperature = Double.parseDouble(temperatureStr);
        Double highBp = highBpStr.isEmpty() ? null : Double.parseDouble(highBpStr);
        Double lowBp = lowBpStr.isEmpty() ? null : Double.parseDouble(lowBpStr);
        Integer pulseRate = pulseRateStr.isEmpty() ? null : Integer.parseInt(pulseRateStr);
        Double pulseOx = pulseOxStr.isEmpty() ? null : Double.parseDouble(pulseOxStr);
        int sleep = Integer.parseInt(sleepStr);

        // ログインユーザーの取得
        HttpSession session = request.getSession();
        UsersDto user = (UsersDto) session.getAttribute("userId");
        int userId = user.getUserId();

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

        // 結果をセットして画面遷移
        if (result) {
            request.setAttribute("message", "体調を登録しました。");
            request.getRequestDispatcher(request.getContextPath() + "/HealthMngServlet").forward(request, response);
        } else {
            request.setAttribute("message", "登録に失敗しました。");
            request.getRequestDispatcher(request.getContextPath() + "/healthRegist.jsp").forward(request, response);
        };
        

    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
        request.getRequestDispatcher(request.getContextPath() + "/healthRegist.jsp").forward(request, response);
    }	}
	
}
