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
	
	public MedicationLogsDto(int log_id,int medication_id,int userId,Date taken_time,String memo, String takenMed) {
		super();
		this.logId = logId;
		this.medicationId = medicationId;
		this.userId = userId;
		this.takenTime = takenTime;
		this.takenMed = takenMed;
		this.memo = memo;
	}
	
	public MedicationLogsDto() {
		this(0,0,0,null,"","");
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

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getTakenMed() {
		return takenMed;
	}

	public void setTakenMed(String takenMed) {
		this.takenMed = takenMed;
	}

}
