package dto;

import java.io.Serializable;
import java.util.Date;

public class UsersDto extends CustomeTemplateDto implements Serializable {
	private int userId;
	private String name;
	private int birthDate;
	private String pref;
	private String city;
	private String email;
	private Date createdAt;
	
	public UsersDto(int userId, String name, int birthDate, String pref, String city, String email, Date createdAt) {
		super();
		this.userId = userId;
		this.name = name;
		this.birthDate = birthDate;
		this.pref = pref;
		this.city = city;
		this.email = email;
		this.createdAt = createdAt;
	}

	public UsersDto() {
		this(0,"",0,"","","",new Date());
		
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(int birthDate) {
		this.birthDate = birthDate;
	}

	public String getPref() {
		return pref;
	}

	public void setPref(String pref) {
		this.pref = pref;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

}
