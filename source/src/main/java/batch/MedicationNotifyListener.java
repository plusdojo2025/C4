package batch;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import dao.MedicationsDao;
import dao.UsersDao;
import dto.MedicationsDto;
import dto.UsersDto;
import utility.MailUtil;

@WebListener
public class MedicationNotifyListener implements ServletContextListener {
    private ScheduledExecutorService scheduler;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduler = Executors.newSingleThreadScheduledExecutor();
        // 1分おきにジョブを回す
        scheduler.scheduleAtFixedRate(() -> {
            try {
                checkAndSendMedicationNotifications();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }, 10, 60, TimeUnit.SECONDS); // 初回10秒後, 以降60秒毎
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (scheduler != null) {
            scheduler.shutdownNow();
        }
    }

    // --- メール通知処理のメイン ---
    private void checkAndSendMedicationNotifications() {
        // 現在時刻を取得
        Date now = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(now);
        cal.set(Calendar.SECOND, 0); // 秒未満は無視
        cal.set(Calendar.MILLISECOND, 0);
        Date roundedNow = cal.getTime();

        // DAOで「今通知すべき服薬」を検索（例: intakeTimeが今のレコード）
        List<MedicationsDto> list = new MedicationsDao().findByIntakeTime(roundedNow);

        for (MedicationsDto med : list) {
            // ユーザー取得
            UsersDto user = new UsersDao().findById(med.getUserId());
            if (user == null) continue;
            // メール送信
            String body = String.format(
                "%sさん\n服薬のお時間です！\n薬: %s（%s）\n用量: %s\n時刻: %tF %tR\n",
                user.getName(), med.getNickName(), med.getFormalName(), med.getDosage(), med.getIntakeTime(), med.getIntakeTime()
            );
            MailUtil.sendMail(user.getEmail(), "【おもいやリンク】服薬のお知らせ", body);
        }
    }
}
