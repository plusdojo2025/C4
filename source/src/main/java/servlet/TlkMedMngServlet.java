package servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MedicationLogsDao;
import dto.MedicationLogsDto;
import dto.MedicationsDto;
import dto.UsersDto;

/**
 * Servlet implementation class TlkMedMngServlet
 */
@WebServlet("/TlkMedMngServlet")
public class TlkMedMngServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public TlkMedMngServlet() {
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
		// ログインページにフォワードする
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
	}

		try {	
			// 一覧表示をするために検索処理を行う
			MedicationLogsDao dao = new MedicationLogsDao();
			MedicationLogsDto searchDto = new  MedicationLogsDto(0,0,0,null,"","","","","");
			List<MedicationLogsDto> mlogList = dao.select(searchDto);

			// 検索結果をリクエストスコープに格納する
			request.setAttribute("mlogList", mlogList);

			// 結果ページにフォワードする
			RequestDispatcher dispatcher = request.getRequestDispatcher(request.getContextPath() + "/TlkmedMng.jsp");
			dispatcher.forward(request, response);
		}
		catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("message", "エラーが発生しました。服薬記録を取得できませんでした");
	        request.getRequestDispatcher(request.getContextPath() + "/HomeServlet").forward(request, response);
	    }
		// フォームから入力内容を取得する
				request.setCharacterEncoding("UTF-8");
			    try {
			        // パラメータ取得
			    	int  logId = Integer.parseInt(request.getParameter("logId"));
			    	String takenTime = request.getParameter("takenTime");
			    	String takenMed = request.getParameter("takenMed");
			    	String memo = request.getParameter("memo");
			    	String nickName = request.getParameter("nickName");
			    	String formalName = request.getParameter("formalName");
			    	String dosage = request.getParameter("dosage");

			    	

			        // データ変換
			        Date takeTime = Date.valueOf(takenTime);
			        
			        // medicationIdの取得
			        HttpSession sessionA = request.getSession();
			        MedicationsDto medication = (MedicationsDto) sessionA.getAttribute("medication_id");
			        int medicationId = medication.getMedicationId();

			        // ログインユーザーの取得
			        HttpSession session = request.getSession();
			        UsersDto user = (UsersDto) session.getAttribute("user_id");
			        int userId = user.getUserId();

					// 更新または削除を行う
			        MedicationLogsDao mDao = new MedicationLogsDao();
					if (request.getParameter("submit").equals("更新")) {
						if (mDao.update(new MedicationLogsDto(logId , medicationId, userId, takeTime , takenMed , memo , nickName, formalName, dosage))) { // 更新成功
				            request.setAttribute("message", "服薬記録を更新しました。");
				            request.getRequestDispatcher(request.getContextPath() + "/TlkMedMngServlet").forward(request, response);
						} else { // 更新失敗
				            request.setAttribute("message", "更新に失敗しました。");
				            request.getRequestDispatcher(request.getContextPath() + "/TlkMedMngServlet").forward(request, response);
						}
					} 
					else {
						if (mDao.delete(new MedicationLogsDto(logId,medicationId, userId, takeTime , takenMed , memo , nickName, formalName, dosage))) { // 削除成功
				            request.setAttribute("message", "服薬記録を削除しました");
				            request.getRequestDispatcher(request.getContextPath() + "/TlkMedMngServlet").forward(request, response);
						} else { // 削除失敗
				            request.setAttribute("message", "削除に失敗しました。");
				            request.getRequestDispatcher(request.getContextPath() + "/TlkMedMngServlet").forward(request, response);
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
