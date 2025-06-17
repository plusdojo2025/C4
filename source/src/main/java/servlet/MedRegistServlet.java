package servlet;

import java.io.IOException;
import java.sql.Date;

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
 * Servlet implementation class MedMngServlet
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
	    	String nickName = request.getParameter("nickName");
	    	String formalName = request.getParameter("formalName");
	    	String dosage = request.getParameter("dosage");
	    	String createdAtStr = request.getParameter("created_at");
	    	String memo = request.getParameter("memo");
	    	String intakeTimeStr = request.getParameter("intake_time");
	    	

	        // データ変換
	        Date createdAt = Date.valueOf(createdAtStr);
	        Date intakeTime = Date.valueOf(intakeTimeStr);

	        // ログインユーザーの取得
	        HttpSession session = request.getSession();
	        UsersDto user = (UsersDto) session.getAttribute("userId");
	        int userId = user.getUserId();

	        // DTOに詰める
	        MedicationsDto dto = new MedicationsDto();
	        dto.setUserId(userId);
	        dto.setNickName(nickName);
	        dto.setFormalName(formalName);
	        dto.setDosage(dosage);
	        dto.setCreatedAt(createdAt);
	        dto.setIntakeTime(intakeTime);
	        dto.setMemo(memo);

	        // DAOで登録
	        boolean result = new MedicationsDao().insert(dto);

	        // 結果をセットして画面遷移
	        if (result) {
	            request.setAttribute("message", "お薬を登録しました。");
	            request.getRequestDispatcher(request.getContextPath() + "/MedMngServlet").forward(request, response);
	        } else {
	            request.setAttribute("message", "登録に失敗しました。");
	            request.getRequestDispatcher(request.getContextPath() + "/medRegist.jsp").forward(request, response);
	        };
	        

	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
	        request.getRequestDispatcher(request.getContextPath() + "/medRegist.jsp").forward(request, response);
	    }	
	    
	  }
	
}