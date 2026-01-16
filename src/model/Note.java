package com.model;

public class Note {
    private Integer id;
    private String title;
    private String content;
    private String summary;
    private String coverImage;
    private Integer userId;
    private Integer cityId;
    private String status;
    private String createTime;
    private String cityname;
    private String username;

    public Note(){}
    // getter和setter方法
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }

    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public Integer getCityId() { return cityId; }
    public void setCityId(Integer cityId) { this.cityId = cityId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }

    public String getCityname() {
        return cityname;
    }

    public void setCityname(String cityname) {
        this.cityname = cityname;
    }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    // 构造函数
    public Note(Integer id, String title, String content, String summary, String coverImage,
                Integer userId, Integer cityId, String status, String createTime,String cityname,String username) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.summary = summary;
        this.coverImage = coverImage;
        this.userId = userId;
        this.cityId = cityId;
        this.status = status;
        this.createTime = createTime;
        this.cityname=cityname;
        this.username=username;
    }
}