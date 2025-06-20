package dto;

import java.io.Serializable;
import java.util.Date;



public class MedicationsDto extends CustomeTemplateDto  implements Serializable{
	private int medicationId;
	private int userId;
	private String nickname;
	private String formalName;
	private String dosage;
	private Date createdAt;
	private String memo;
	private Date intakeTime;


	public MedicationsDto(int medicationId, int userId, String nickname, String formalName, String dosage,
			Date createdAt, String memo, Date intakeTime) {
		super();
		this.medicationId = medicationId;
		this.userId = userId;
		this.nickname = nickname;
		this.formalName = formalName;
		this.dosage = dosage;
		this.createdAt = createdAt;
		this.memo = memo;
		this.intakeTime = intakeTime;
	}


	public MedicationsDto() {
		this(0,0,"","","",null,"",null);
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


	public String getNickname() {
		return nickname;
	}


	public void setNickName(String nickname) {
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


	public Date getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}


	public String getMemo() {
		return memo;
	}


	public void setMemo(String memo) {
		this.memo = memo;
	}


	public Date getIntakeTime() {
		return intakeTime;
	}


	public void setIntakeTime(Date intakeTime) {
		this.intakeTime = intakeTime;
	}

}
