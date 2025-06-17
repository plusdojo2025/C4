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

	/**
	 * Default constructor.
	 */
	public UserRegistServlet() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * GETリクエスト：登録フォームへフォワード
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/jsp/userRegist.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		/**
		 * POSTリクエスト：フォーム送信後の登録処理
		 */
		try {

			// フォームからのパラメータ取得
			String userId = request.getParameter("userid");
			String name = request.getParameter("name");
			String pref = request.getParameter("pref");
			String city = request.getParameter("city");
			String birthDate = request.getParameter("birthdate");
			String email = request.getParameter("email");
			UsersDao myUserDao = new UsersDao();
			UsersDto myUserDto = new UsersDto(Integer.parseInt(userId), name, Integer.parseInt(birthDate), pref, city,
					email, new Date());

			myUserDao.insert(myUserDto);

			// 登録後はログイン画面へリダイレクト（メール内容は仮）
			MailUtil.sendMail("muratsuchi-takuma-plusdojo2025@seplus2016.onmicrosoft.com", "【おもいやリンク】登録完了のお知らせ", """
おもいやリンク運営事務局です。

このたびは、おもいやリンクにご登録いただき、誠にありがとうございます。

以下の内容にて、登録が完了いたしました。
ログインの際に必要な情報ですので、大切に保管してください。

ID：1
パスワード：生年月日（1960年1月1日は「19600101」）です。

パスワードを忘れた場合は、お手数ですが再度新規登録をお願いいたします。

今後ともおもいやリンクをよろしくお願いいたします。

※このメールは送信専用です。
ご返信いただきましてもお返事できませんので、ご了承ください。

このメールにお心当たりのない方は、muratsuchi-takuma-plusdojo2025@seplus2016.onmicrosoft.com までご連絡ください。

CollectForce.Inc
東京都万代田区味噌町１－２－３
C4ビルディング 3F
					""");
			response.sendRedirect("/WEB-INF/jsp/login.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", e.getMessage());
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}
}
