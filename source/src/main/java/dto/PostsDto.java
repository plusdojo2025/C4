package dto;

import java.io.Serializable;
import java.util.Date;


public class PostsDto extends CustomeTemplateDto implements Serializable {
	private int postId;
	private int userId;
	private String tag;
	private String title;
	private String content;
	private Date createdAT;
	
	public PostsDto( int userId, String tag, String title,
			String content, Date createdAT) {
		
		super();
		
		this.userId = userId;
		this.tag = tag;
		this.title = title;
		this.content = content;
		this.createdAT = createdAT;
		// TODO 自動生成されたコンストラクター・スタブ
	}
	public PostsDto() {
		this(0,"","","",new Date());
}

	public int getPostId() {
		return postId;
	}
	
	public void setPostId(int postId) {
		this.postId = postId;
	}
	

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public Date getCreatedAT() {
		return createdAT;
	}

	public void setCreatedAT(Date createdAT) {
		this.createdAT = createdAT;
	}
}
	

	