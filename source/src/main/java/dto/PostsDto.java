package dto;

import java.io.Serializable;
import java.util.Date;

public class PostsDto extends CustomeTemplateDto implements Serializable {
    private int id;           // ← postId→id
    private int userId;
    private String tag;
    private String title;
    private String content;
    private Date createdAt;   // ← createdAT→createdAt
    private String pref;
    private String city;

    // コンストラクタ
    public PostsDto(int userId, String tag, String title,
            String content, Date createdAt, String pref, String city) {
        super();
        this.userId = userId;
        this.tag = tag;
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
        this.pref = pref;
        this.city = city;
    }

    public PostsDto() {
        this(0, "", "", "", new Date(), "", "");
    }

    // Getter/Setter
    public int getId() {            // ← postId→id
        return id;
    }
    public void setId(int id) {
        this.id = id;
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

    public Date getCreatedAt() {      // ← createdAT→createdAt
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
}
