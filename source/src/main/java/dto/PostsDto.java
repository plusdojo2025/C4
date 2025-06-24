package dto;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class PostsDto implements Serializable {
    private int postId;        // posts.post_id
    private int userId;        // posts.user_id
    private String userName;   // users.name
    private String tag;        // posts.tag
    private String title;      // posts.title
    private String content;    // posts.content
    private Date createdAt;    // posts.created_at
    private String pref;       // posts.pref
    private String city;       // posts.city

    // 追加: いいね関連
    private boolean likedByCurrentUser;
    private List<String> likedUsers;
    private int likeCount;

    public PostsDto() {}

    // --- getter/setter ---

    public int getPostId() {
        return postId;
    }
    public void setPostId(int postId) {
        this.postId = postId;
    }

    // ↓ id名でもアクセスしたい場合はこれを追加（任意）
    public int getId() {
        return postId;
    }
    public void setId(int id) {
        this.postId = id;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
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

    public Date getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
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

    // --- いいね関連 ---
    public boolean isLikedByCurrentUser() {
        return likedByCurrentUser;
    }
    public void setLikedByCurrentUser(boolean likedByCurrentUser) {
        this.likedByCurrentUser = likedByCurrentUser;
    }

    public List<String> getLikedUsers() {
        return likedUsers;
    }
    public void setLikedUsers(List<String> likedUsers) {
        this.likedUsers = likedUsers;
    }

    public int getLikeCount() {
        return likeCount;
    }
    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }
}
