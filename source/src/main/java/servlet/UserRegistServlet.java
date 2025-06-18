package servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UsersDao;
import dto.UsersDto;
import utility.MailUtil;

@WebServlet("/OmoiyalinkUserRegistServlet")
public class UserRegistServlet extends CustomTemplateServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/jsp/userRegist.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		try {
			// フォーム値取得
			String name = request.getParameter("name");
			String pref = request.getParameter("pref");
			String city = request.getParameter("city");
			String birthDate = request.getParameter("birthdate");
			String email = request.getParameter("email");

			// 簡易バリデーション（全項目必須）
			if (name == null || name.isEmpty() || pref == null || pref.isEmpty() || city == null || city.isEmpty()
					|| birthDate == null || birthDate.isEmpty() || email == null || email.isEmpty()) {
				request.setAttribute("errorMessage", "全ての項目を入力してください。");
				request.getRequestDispatcher("/WEB-INF/jsp/userRegist.jsp").forward(request, response);
				return;
			}

			// DTOを生成（userId=0:自動採番, birthDateはint化）
			UsersDto userDto = new UsersDto(0, name, Integer.parseInt(birthDate), pref, city, email, new Date());

			// 登録
			UsersDao userDao = new UsersDao();
			boolean result = userDao.insert(userDto);

			if (result) {
				// 自動採番IDを取得
				int newUserId = userDto.getUserId();

				// メール本文を生成
				String body = String.format("おもいやリンク運営事務局です。\n\n" + "このたびは、おもいやリンクにご登録いただき、誠にありがとうございます。\n\n"
						+ "以下の内容にて、登録が完了いたしました。\n" + "ログインの際に必要な情報ですので、大切に保管してください。\n\n" + "【ログインID】%d\n"
						+ "【パスワード】ご自身の生年月日8桁（例：19600101）\n\n" + "パスワードを忘れた場合は、お手数ですが再度新規登録をお願いいたします。\n\n"
						+ "今後ともおもいやリンクをよろしくお願いいたします。\n\n" + "※このメールは送信専用です。\n" + "ご返信いただきましてもお返事できませんので、ご了承ください。\n\n"
						+ "このメールにお心当たりのない方は、muratsuchi-takuma-plusdojo2025@seplus2016.onmicrosoft.com までご連絡ください。\n\n"
						+ "CollectForce Inc.\n" + "東京都万代田区味噌町１－２－３\n" + "C4ビルディング 3F\n", newUserId);

				// メール送信（メールアドレスがto）
				MailUtil.sendMail(email, "【おもいやリンク】登録完了のお知らせ", body);

				// 登録完了後はログイン画面へリダイレクト
				response.sendRedirect("OmoiyalinkLogin");
			} else {
				// 登録失敗
				request.setAttribute("errorMessage", "登録に失敗しました。やり直してください。");
				request.getRequestDispatcher("/WEB-INF/jsp/userRegist.jsp").forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "システムエラー: " + e.getMessage());
			request.getRequestDispatcher("/WEB-INF/jsp/userRegist.jsp").forward(request, response);
		}
	}
}
