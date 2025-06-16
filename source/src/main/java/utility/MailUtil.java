package utility;

import java.io.InputStream;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailUtil {

	/**
	 * メール送信
	 * @param recipient 送信先メール
	 * @param subject メール件名
	 * @param mailBody メール本文
	 */
	public static void sendMail(String recipient, String subject, String mailBody) {
		try {
			// プロパティファイルから認証に使用するデータを取得
			InputStream input = MailUtil.class.getClassLoader().getResourceAsStream("mail.properties");
			Properties prop = new Properties();
			prop.load(input);
			input.close();

			// 送信元のGmailアドレス
			final String username = prop.getProperty("mailaddress");
			// Gmailのアカウントのアプリパスワード
			final String password = prop.getProperty("password");

			// SMTPサーバへの認証とメールセッションの作成
			// ※メールセッション = メールの送信に関するパラメータや設定を保持
			Session session = Session.getInstance(prop, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(username, password);
				}
			});

			// メール送信準備
			Message message = new MimeMessage(session);
			// 送信元の設定
			message.setFrom(new InternetAddress(username));
			// 送信先の設定
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
			// 件名の設定
			message.setSubject(subject);
			// 本文の設定
			message.setText(mailBody);

			// メールの送信
			Transport.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
