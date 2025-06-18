package servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

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
@WebServlet("/OmoiyalinkMedMng")
public class MedMngServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		try {	
			// 一覧表示をするために検索処理を行う
			MedicationsDao dao = new MedicationsDao();
			MedicationsDto searchDto = new  MedicationsDto( 0, 0, "", "", "", null, "", null);
			List<MedicationsDto> medicationList = dao.select(searchDto);

			// 検索結果をリクエストスコープに格納する
			request.setAttribute("cardList", medicationList);

			// 結果ページにフォワードする
			RequestDispatcher dispatcher = request.getRequestDispatcher(request.getContextPath() + "/medMng.jsp");
			dispatcher.forward(request, response);
		}
		catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("message", "エラーが発生しました。お薬情報を取得できませんでした");
	        request.getRequestDispatcher(request.getContextPath() + "/HomeServlet").forward(request, response);
	    }
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
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

	        // medicationIdの取得
	        HttpSession sessionA = request.getSession();
	        MedicationsDto medication = (MedicationsDto) sessionA.getAttribute("medication_id");
	        int medicationId = medication.getMedicationId();

	        // ログインユーザーの取得
	        HttpSession session = request.getSession();
	        UsersDto user = (UsersDto) session.getAttribute("user_id");
	        int userId = user.getUserId();

			// 更新または削除を行う
	        MedicationsDao bDao = new MedicationsDao();
			if (request.getParameter("submit").equals("更新")) {
				if (bDao.update(new MedicationsDto(medicationId, userId, nickName, formalName, dosage, createdAt, memo, intakeTime))) { // 更新成功
		            request.setAttribute("message", "お薬情報を更新しました。");
		            request.getRequestDispatcher(request.getContextPath() + "/MedMngServlet").forward(request, response);
				} else { // 更新失敗
		            request.setAttribute("message", "更新に失敗しました。");
		            request.getRequestDispatcher(request.getContextPath() + "/MedMngServlet").forward(request, response);
				}
			} 
			else {
				if (bDao.delete(new MedicationsDto(medicationId, userId, nickName, formalName, dosage, createdAt, memo, intakeTime))) { // 削除成功
		            request.setAttribute("message", "お薬情報を削除しました");
		            request.getRequestDispatcher(request.getContextPath() + "/MedMngServlet").forward(request, response);
				} else { // 削除失敗
		            request.setAttribute("message", "削除に失敗しました。");
		            request.getRequestDispatcher(request.getContextPath() + "/MedMngServlet").forward(request, response);
				}
			}
		}
			catch (Exception e) {
		        e.printStackTrace();
		        request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
		        request.getRequestDispatcher(request.getContextPath() + "/MedMngServlet").forward(request, response);
		    }
	}
}