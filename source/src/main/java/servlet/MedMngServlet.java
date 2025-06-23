package servlet;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MedicationsDao;
import dto.MedicationsDto;

@WebServlet("/OmoiyalinkMedMng")
public class MedMngServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	// 一覧表示
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		try {
			HttpSession session = request.getSession();
			// 推奨：UsersDto user = (UsersDto) session.getAttribute("user");
			// int userId = user.getUserId();
			Integer userId = (Integer) session.getAttribute("user_id");
			if (userId == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}

			MedicationsDao dao = new MedicationsDao();
			MedicationsDto searchDto = new MedicationsDto();
			searchDto.setUserId(userId);
			List<MedicationsDto> medicationList = dao.select(searchDto);

			request.setAttribute("cardList", medicationList);
			request.getRequestDispatcher("/WEB-INF/jsp/medMng.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。お薬情報を取得できませんでした");
			request.getRequestDispatcher("/WEB-INF/jsp/medMng.jsp").forward(request, response);
		}
	}

	// 更新・削除
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (checkNoneLogin(request, response) || checkLogout(request, response)) {
			return;
		}
		request.setCharacterEncoding("UTF-8");
		try {
			HttpSession session = request.getSession();
			Integer userId = (Integer) session.getAttribute("user_id");
			if (userId == null) {
				response.sendRedirect(request.getContextPath() + "/OmoiyalinkLogin");
				return;
			}

			int medicationId = Integer.parseInt(request.getParameter("medicationId"));
			String nickName = request.getParameter("nickName");
			String formalName = request.getParameter("formalName");
			String dosage = request.getParameter("dosage");
			String createdAtStr = request.getParameter("created_at");
			String memo = request.getParameter("memo");
			String intakeTimeStr = request.getParameter("intake_time"); // "08:00"など

			Date createdAt = null;
			if (createdAtStr != null && !createdAtStr.isEmpty()) {
				createdAt = Date.valueOf(createdAtStr);
			}

			Time intakeTime = null;
			if (intakeTimeStr != null && !intakeTimeStr.isEmpty()) {
				// "08:00"を"08:00:00"にする
				if (intakeTimeStr.length() == 5) {
					intakeTimeStr += ":00";
				}
				intakeTime = Time.valueOf(intakeTimeStr);
			}

			// DTOコンストラクタは下記のようにTime型で
			MedicationsDto dto = new MedicationsDto(medicationId, userId, nickName, formalName, dosage, createdAt, memo,
					intakeTime);

			String submit = request.getParameter("submit");
			boolean result = false;
			MedicationsDao dao = new MedicationsDao();

			if ("更新".equals(submit)) {
				result = dao.update(dto);
				request.setAttribute("message", result ? "お薬情報を更新しました。" : "更新に失敗しました。");
			} else if ("削除".equals(submit)) {
				result = dao.delete(dto);
				request.setAttribute("message", result ? "お薬情報を削除しました。" : "削除に失敗しました。");
			}

			response.sendRedirect(request.getContextPath() + "/OmoiyalinkMedMng");
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "エラーが発生しました。入力内容を確認してください。");
			request.getRequestDispatcher("/WEB-INF/jsp/medMng.jsp").forward(request, response);
		}
	}
}
