package dto;

import java.io.Serializable;
import java.util.Date;

public class MedicationLogsDto extends CustomeTemplateDto implements Serializable{
	private int logId;
	private int medicationId;
	private int userId;
	private Date takenTime;
	private String takenMed;
	private String memo;
	
	private String nickname;
	private String formalName;
	private String dosage;
	
	
	public MedicationLogsDto(int logId , int medicationId , int userId , Date takenTime ,  String takenMed ,String memo , String nickname, String formalName, String dosage) {
		this.logId = logId;
		this.medicationId = medicationId;
		this.userId = userId;
		this.takenTime = takenTime;
		this.takenMed = takenMed;
		this.memo = memo;
		this.nickname = nickname;
		this.formalName = formalName;
		this.dosage = dosage;
	}
	
	public MedicationLogsDto() {
		this(0,0,0,null,"","","","","");
	}

	public int getLogId() {
		return logId;
	}

	public void setLogId(int logId) {
		this.logId = logId;
	}

	public int getMedicationId() {
		return medicationId;
	}

	public void setMedicationId(int medicationId) {
		this.medicationId = medicationId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Date getTakenTime() {
		return takenTime;
	}

	public void setTakenTime(Date takenTime) {
		this.takenTime = takenTime;
	}

	
	public String getTakenMed() {
		return takenMed;
	}

	public void setTakenMed(String takenMed) {
		this.takenMed = takenMed;
	}
	
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getFormalName() {
		return formalName;
	}

	public void setFormalName(String formalName) {
		this.formalName = formalName;
	}

	public String getDosage() {
		return dosage;
	}

	public void setDosage(String dosage) {
		this.dosage = dosage;
	}
	
	 // 日付（yyyy-MM-dd）を返す
    public String getTakenTimeString() {
        if (takenTime == null) return "";
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(takenTime);
    }

    // 時刻（HH:mm）を返す
    public String getTakenTimeHourMin() {
        if (takenTime == null) return "";
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("HH:mm");
        return sdf.format(takenTime);
    }
}
