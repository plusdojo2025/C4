package batch;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.Calendar;

import utility.DBUtil;
import utility.MailUtil;

public class MedicationMailBatch {

	public static void main(String[] args) {
		System.out.println("バッチ開始: " + new java.util.Date());
		// 1. DBから、全ユーザーの「本日の服薬リマインド」対象データを取得
		try (Connection conn = DBUtil.getConnection()) {
			// 薬情報とユーザーのメールをJOINで取得
			String sql = """
					SELECT
					  u.user_id,
					  u.name as user_name,
					  u.email,
					  m.formal_name,
					  m.nickname,
					  m.dosage,
					  m.intake_time
					FROM medications m
					  INNER JOIN users u ON m.user_id = u.user_id
					WHERE m.intake_time IS NOT NULL
					""";

			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				System.out.println("クエリ実行前...");
				ResultSet rs = stmt.executeQuery();
				System.out.println("クエリ実行後...");

				int rowCount = 0;
				int sendCount = 0;
				while (rs.next()) {
					rowCount++;
					System.out.println("[" + rowCount + "] レコードあり");

					String userName = rs.getString("user_name");
					String email = rs.getString("email");
					String formalName = rs.getString("formal_name");
					String nickname = rs.getString("nickname");
					String dosage = rs.getString("dosage");
					Time intakeTime = rs.getTime("intake_time");

					System.out.println(
							"  ユーザ: " + userName + " / メール: " + email + " / 薬: " + formalName + " / 時間: " + intakeTime);

					if (shouldSendNow(intakeTime)) {
						String subject = "【服薬リマインダー】お薬の時間です";
						StringBuilder body = new StringBuilder();
						body.append(userName).append("さん\n");
						body.append("本日 ").append(intakeTime.toString()).append(" は、\n");
						body.append("お薬『").append(formalName);
						if (nickname != null && !nickname.isEmpty()) {
							body.append("（").append(nickname).append("）");
						}
						body.append("』").append("（用量: ").append(dosage).append("）");
						body.append(" の服薬時間です。\n忘れずにお飲みください。");

						try {
							MailUtil.sendMail(email, subject, body.toString());
							sendCount++;
							System.out.println("送信：" + email + " 宛 " + formalName);
						} catch (Exception e) {
							System.err.println("メール送信エラー：" + email + " " + e.getMessage());
							e.printStackTrace();
						}
					} else {
						System.out.println("送信スキップ: " + email + "（時刻条件不一致）");
					}
				}
				System.out.println("取得件数: " + rowCount);
				System.out.println("送信完了: " + sendCount + "件");
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("バッチ処理でエラーが発生しました。");
		}
		System.out.println("バッチ終了: " + new java.util.Date());
	}

	/**
	 * 今が指定のintake_time±5分かどうか判定（例：09:00登録→08:55～09:05ならtrue）
	 */
	private static boolean shouldSendNow(Time intakeTime) {
		if (intakeTime == null)
			return false;
		Calendar now = Calendar.getInstance();
		Calendar target = Calendar.getInstance();
		target.set(Calendar.HOUR_OF_DAY, intakeTime.toLocalTime().getHour());
		target.set(Calendar.MINUTE, intakeTime.toLocalTime().getMinute());
		target.set(Calendar.SECOND, 0);
		target.set(Calendar.MILLISECOND, 0);

		long diffMillis = Math.abs(now.getTimeInMillis() - target.getTimeInMillis());
		return diffMillis <= (5 * 60 * 1000); // 5分（300秒）以内
	}
}
