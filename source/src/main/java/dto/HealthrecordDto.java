package dto;

import java.io.Serializable;
import java.sql.Date;

public class HealthrecordDto extends CustomeTemplateDto implements Serializable {
	private int recordId;
	private int userId;
	private Date date;
	private double temperature;
	private Double highBp; // null許容
	private Double lowBp; // null許容
	private Integer pulseRate; // null許容
	private Double pulseOx; // null許容
	private int sleep;
	private String memo;

	public HealthrecordDto() {
	}

	public HealthrecordDto(int recordId, int userId, Date date, double temperature, Double highBp, Double lowBp,
			Integer pulseRate, Double pulseOx, int sleep, String memo) {
		this.recordId = recordId;
		this.userId = userId;
		this.date = date;
		this.temperature = temperature;
		this.highBp = highBp;
		this.lowBp = lowBp;
		this.pulseRate = pulseRate;
		this.pulseOx = pulseOx;
		this.sleep = sleep;
		this.memo = memo;
	}

	// ゲッタとセッタ
	public int getRecordId() {
		return recordId;
	}

	public void setRecordId(int recordId) {
		this.recordId = recordId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public double getTemperature() {
		return temperature;
	}

	public void setTemperature(double temperature) {
		this.temperature = temperature;
	}

	public Double getHighBp() {
		return highBp;
	}

	public void setHighBp(Double highBp) {
		this.highBp = highBp;
	}

	public Double getLowBp() {
		return lowBp;
	}

	public void setLowBp(Double lowBp) {
		this.lowBp = lowBp;
	}

	public Integer getPulseRate() {
		return pulseRate;
	}

	public void setPulseRate(Integer pulseRate) {
		this.pulseRate = pulseRate;
	}

	public Double getPulseOx() {
		return pulseOx;
	}

	public void setPulseOx(Double pulseOx) {
		this.pulseOx = pulseOx;
	}

	public int getSleep() {
		return sleep;
	}

	public void setSleep(int sleep) {
		this.sleep = sleep;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
}
