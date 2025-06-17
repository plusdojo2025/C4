package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MedicationLogsDao;
import dto.MedicationLogsDto;
import dto.UsersDto;

/**
 * Servlet implementation class TlkMedRegistServlet
 */
@WebServlet("/OmoiyalinkTlkMedRegistServlet")
public class TlkMedRegistServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * Default constructor.
	 */
	public TlkMedRegistServlet() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// ログインしているかチェックする
		if (checkNoneLogin(request, response)) {
			return;
		}

		// 服薬登録画面？ページにフォワードする （）
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/tlkMedRegist.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		
		//リクエストパラメータを取得する
		request.setCharacterEncoding("UTF-8");
		
		try {
			String takenTime 	=		 request.getParameter("takenTime");
			String memo			=		 request.getParameter("memo");
			String[] selectedTakenMed = request.getParameterValues("takenMed");
			
		   //データ変換
			Date  takeTime = Date.valueOf(takenTime);
			
			//ログインユーザーの取得
	        HttpSession session = request.getSession();
	        UsersDto user = (UsersDto) session.getAttribute("userId");
	        int userId = user.getUserId();
	        
	        
			for (String selected : selectedTakenMed) {
				//DTOに詰める
				MedicationLogsDto dto = new MedicationLogsDto();
				dto.setUserId(userId);
				dto.setTakenTime(takeTime);
				dto.setMemo(memo);
				dto.setTakenMed(selected);
				
				//DAOで登録
				boolean result = new MedicationLogsDao().insert(dto);
				
				// 結果をセットして画面遷移
		        if (result) {
		            request.setAttribute("message", "服薬記録を登録しました。");
		            request.getRequestDispatcher(request.getContextPath() + "/TlkMedMngServlet").forward(request, response);
		        } else {
		            request.setAttribute("message", "服薬記録を登録しました。");
		            request.getRequestDispatcher(request.getContextPath() + "/tlkMedRegist.jsp").forward(request, response);
		        };
	        

		    }} catch (Exception e) {
		        e.printStackTrace();
		        request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
		        request.getRequestDispatcher(request.getContextPath() + "/tlkMedRegist.jsp").forward(request, response);
		    }	
	    
	 
		}
	
	
}
