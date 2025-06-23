package dto;

import java.io.Serializable;
import java.util.Date;

import utility.ReactionType;

public class ReactionsDto extends CustomeTemplateDto implements Serializable{
	private int reactionId;
	private int postId;
	private int userId;
	private String name; 
	private ReactionType type;
	private Date createdAt;

	public ReactionsDto(int reactionId, int postId, int userId, String name, ReactionType type, Date createdAt) {
		super();
		this.reactionId = reactionId;
		this.postId = postId;
		this.userId = userId;
		this.name = name;
		this.type = type;
		this.createdAt = createdAt;
		this.count = 0;
	}

	public ReactionsDto() {
		this(0, 0, 0,"", null,new Date());
		
	}

	public int getReactionId() {
		return reactionId;
	}

	public void setReactionId(int reactionId) {
		this.reactionId = reactionId;
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

	public ReactionType getType() {
		return type;
	}

	public void setType(ReactionType type) {
		this.type = type;
	}

	public Date getCreated_at() {
		return createdAt;
	}

	public void setCreated_at(Date created_at) {
		this.createdAt = created_at;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	private int count;
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}

}
