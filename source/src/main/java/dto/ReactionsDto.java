package dto;

import java.io.Serializable;
import java.util.Date;

public class ReactionsDto<ReactionType> extends CustomeTemplateDto implements Serializable{
	private int reactionId;
	private int postId;
	private int userId;
	private ReactionType type;
	private Date created_at;

	public ReactionsDto() {
		// TODO 自動生成されたコンストラクター・スタブ
	}

	public ReactionsDto(int reactionId, int postId, int userId, ReactionType type, Date created_at) {
		super();
		this.reactionId = reactionId;
		this.postId = postId;
		this.userId = userId;
		this.type = type;
		this.created_at = created_at;
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
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

}
