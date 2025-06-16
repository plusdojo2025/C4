package dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class HealthrecordDto extends CustomeTemplateDto implements Serializable {
	private int recordId;
	private int userId;
	private Date date;
	private BigDecimal temperature;
	private BigDecimal highBp;
	private BigDecimal lowBp;
	private String pluseRate;
	private BigDecimal pulseOx;
	private String sleep;
	private String memo;
	
	public HealthrecordDto(int recordId, int userId, Date date, BigDecimal temperature, BigDecimal highBp,
			BigDecimal lowBp, String pluseRate, BigDecimal pulseOx, String sleep, String memo) {
		super();
		this.recordId = recordId;
		this.userId = userId;
		this.date = date;
		this.temperature = temperature;
		this.highBp = highBp;
		this.lowBp = lowBp;
		this.pluseRate = pluseRate;
		this.pulseOx = pulseOx;
		this.sleep = sleep;
		this.memo = memo;
	}

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

	public BigDecimal getTemperature() {
		return temperature;
	}

	public void setTemperature(BigDecimal temperature) {
		this.temperature = temperature;
	}

	public BigDecimal getHighBp() {
		return highBp;
	}

	public void setHighBp(BigDecimal highBp) {
		this.highBp = highBp;
	}

	public BigDecimal getLowBp() {
		return lowBp;
	}

	public void setLowBp(BigDecimal lowBp) {
		this.lowBp = lowBp;
	}

	public String getPluseRate() {
		return pluseRate;
	}

	public void setPluseRate(String pluseRate) {
		this.pluseRate = pluseRate;
	}

	public BigDecimal getPulseOx() {
		return pulseOx;
	}

	public void setPulseOx(BigDecimal pulseOx) {
		this.pulseOx = pulseOx;
	}

	public String getSleep() {
		return sleep;
	}

	public void setSleep(String sleep) {
		this.sleep = sleep;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

}
