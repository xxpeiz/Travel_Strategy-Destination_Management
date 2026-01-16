package com.service;

import com.model.Note;
import com.tools.DbUtils;

import java.util.*;

public class NoteService {

    private DbUtils dbUtils = new DbUtils();

    public List<Note> getNotesAll() {
        String sql = "SELECT * FROM note";
        ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
        List<Note> notes = new ArrayList<>();
        for (HashMap<String, Object> map : mapList) {
                Integer id = Integer.parseInt(map.get("id").toString());
                String title = map.get("title").toString();
                String content = map.get("content").toString();
                String summary = map.get("summary") != null ? map.get("summary").toString() : "";
                String coverImage = map.get("cover_image") != null ? map.get("cover_image").toString() : "";
                Integer userId = Integer.parseInt(map.get("user_id").toString());
                Integer cityId = map.get("city_id") != null ? Integer.parseInt(map.get("city_id").toString()) : null;
                String status = map.get("status").toString();
                String createTime = map.get("create_time").toString();
                String cityname = map.get("cityname") != null ? map.get("cityname").toString() : "";
                String username = map.get("username") != null ? map.get("username").toString() : "";

                Note note = new Note(id, title, content, summary, coverImage, userId, cityId, status, createTime,cityname,username);

                notes.add(note);
        }
        return notes;
    }

    public List<Note> getLimitNotes(int limit) {
            String sql = "SELECT * FROM note WHERE status = '已通过' ORDER BY create_time DESC LIMIT " + limit;

            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
            List<Note> notes = new ArrayList<>();

            if (mapList != null) {
                for (HashMap<String, Object> map : mapList) {
                        Integer id = Integer.parseInt(map.get("id").toString());
                        String title = map.get("title").toString();
                        String content = map.get("content").toString();
                        String summary = map.get("summary") != null ? map.get("summary").toString() : "";
                        String coverImage = map.get("cover_image") != null ? map.get("cover_image").toString() : "";
                        Integer userId = Integer.parseInt(map.get("user_id").toString());
                        Integer cityId = map.get("city_id") != null ? Integer.parseInt(map.get("city_id").toString()) : null;
                        String status = map.get("status").toString();
                        String createTime = map.get("create_time").toString();
                        String cityname = map.get("cityname") != null ? map.get("cityname").toString() : "";
                        String username = map.get("username") != null ? map.get("username").toString() : "";

                        Note note = new Note(id, title, content, summary, coverImage, userId, cityId, status, createTime,cityname,username);
                        notes.add(note);
                }
            }
            return notes;
    }

    public List<Note> getNotesByCityId(Integer cityId) {
            String sql = "SELECT * FROM note WHERE city_id = " + cityId + " AND status = '已通过' ORDER BY create_time DESC";

            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
            List<Note> notes = new ArrayList<>();

            for (HashMap<String, Object> map : mapList) {
                    Integer id = Integer.parseInt(map.get("id").toString());
                    String title = map.get("title").toString();
                    String content = map.get("content").toString();
                    String summary = map.get("summary") != null ? map.get("summary").toString() : "";
                    String coverImage = map.get("cover_image") != null ? map.get("cover_image").toString() : "";
                    Integer userId = Integer.parseInt(map.get("user_id").toString());
                    String status = map.get("status").toString();
                    String createTime = map.get("create_time").toString();
                    String username = map.get("username") != null ? map.get("username").toString() : "匿名用户";
                    String cityname = map.get("cityname") != null ? map.get("cityname").toString() : "未知城市";
                    Note note = new Note(id, title, content, summary, coverImage, userId, cityId, status, createTime,cityname,username);
                    notes.add(note);
                }
            return notes;
    }

    public Note getNotesById(Integer noteId) {
            String sql = "SELECT * FROM note WHERE id = " + noteId;

            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);

            if (mapList != null && !mapList.isEmpty()) {
                HashMap<String, Object> map = mapList.get(0);

                Integer id = Integer.parseInt(map.get("id").toString());
                String title = map.get("title").toString();
                String content = map.get("content").toString();
                String summary = map.get("summary") != null ? map.get("summary").toString() : "";
                String coverImage = map.get("cover_image") != null ? map.get("cover_image").toString() : "";
                Integer userId = Integer.parseInt(map.get("user_id").toString());
                Integer cityId = Integer.parseInt(map.get("city_id").toString());
                String status = map.get("status").toString();
                String createTime = map.get("create_time").toString();
                String username = map.get("username") != null ? map.get("username").toString() : "匿名用户";
                String cityname = map.get("cityname") != null ? map.get("cityname").toString() : "未知城市";

                Note note = new Note(id, title, content, summary, coverImage, userId, cityId, status, createTime,cityname,username);
                return note;
            }
            return null;
    }

    public List<Note> getAllNotes(String status) {
        List<Note> list = new ArrayList<>();

        String sql = "SELECT * FROM note WHERE 1=1";

        if (status != null && !status.isEmpty() && !"all".equals(status)) {
            if ("pending".equals(status)) {
                sql += " AND status = '待审核'";
            } else if ("approved".equals(status)) {
                sql += " AND status = '已通过'";
            } else if ("rejected".equals(status)) {
                sql += " AND status = '已拒绝'";
            }
        }

        sql += " ORDER BY create_time DESC";

        ArrayList<HashMap<String, Object>> result = dbUtils.queryForList(sql);

        if (result != null) {
            for (HashMap<String, Object> map : result) {
                Integer id = Integer.parseInt(map.get("id").toString());
                String title = map.get("title").toString();
                String content = map.get("content").toString();
                String summary = map.get("summary") != null ? map.get("summary").toString() : "";
                String coverImage = map.get("cover_image") != null ? map.get("cover_image").toString() : "";
                Integer userId = Integer.parseInt(map.get("user_id").toString());
                Integer cityId = Integer.parseInt(map.get("city_id").toString());
                String status1 = map.get("status").toString();
                String createTime = map.get("create_time").toString();
                String username = map.get("username").toString();
                String cityname =map.get("cityname").toString();

                Note note = new Note(id, title, content, summary, coverImage, userId, cityId, status1, createTime,cityname,username);
                list.add(note);
            }
        }
        return list;
    }

    public boolean approveNote(int id) {
        String sql = "UPDATE note SET status = '已通过' WHERE id = " + id;
        int rows = dbUtils.update(sql);
        return rows > 0;
    }

    public boolean batchApproveNotes(String[] ids) {
        String idStr = String.join(",", ids);
        String sql = "UPDATE note SET status = '已通过' WHERE id IN (" + idStr + ")";
        int rows = dbUtils.update(sql);
        return rows > 0;
    }

    public boolean rejectNote(int id) {
        String sql = "UPDATE note SET status = '已拒绝' WHERE id = " + id;
        int rows = dbUtils.update(sql);
        return rows > 0;
    }

    public boolean batchRejectNotes(String[] ids) {
        String idStr = String.join(",", ids);
        String sql = "UPDATE note SET status = '已拒绝' WHERE id IN (" + idStr + ")";
        int rows = dbUtils.update(sql);
        return rows > 0;
    }

    public boolean deleteNote(int id) {
        String sql = "DELETE FROM note WHERE id = " + id;
        int rows = dbUtils.update(sql);
        return rows > 0;
    }


    public boolean publishNote(String title, String content, String summary, String coverImage,
                               Integer userId, String username, String cityname) {
        try {
            String getCityIdSql = "SELECT id FROM city WHERE name = '"+cityname+"'";
            Integer cityId =0;

            ArrayList<HashMap<String, Object>> result = dbUtils.queryForList(getCityIdSql);
            if (result != null && !result.isEmpty()) {
                cityId = (Integer) result.get(0).get("id");
            }

            String insertSql = "INSERT INTO note (title, content, summary, cover_image, user_id, city_id, status, username, cityname) " +
                    "VALUES ('"+title+"', '"+content+"', '"+summary+"', '"+coverImage+"', '"+userId+"', '"+cityId+"', '待审核','"+username+"' , '"+cityname+"')";

            int resultCount = dbUtils.update(insertSql);

            return resultCount > 0;

        } catch (Exception e) {
            System.err.println("发布游记时出错: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Note> getUserNotes(int userId) {
            String sql = "SELECT * FROM note " +
                    "WHERE user_id = " + userId + " " +
                    "ORDER BY create_time DESC";

            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
            List<Note> notes = new ArrayList<>();

            for (HashMap<String, Object> map : mapList) {
                Integer id = Integer.parseInt(map.get("id").toString());
                String title = map.get("title").toString();
                String content = map.get("content").toString();
                String summary = map.get("summary") != null ? map.get("summary").toString() : "";
                String coverImage = map.get("cover_image") != null ? map.get("cover_image").toString() : "";
                Integer noteUserId = Integer.parseInt(map.get("user_id").toString());
                Integer cityId = map.get("city_id") != null ? Integer.parseInt(map.get("city_id").toString()) : null;
                String status = map.get("status").toString();
                String createTime = map.get("create_time").toString();
                String username = map.get("username").toString();
                String cityname = map.get("cityname").toString();
                Note note = new Note(id, title, content, summary, coverImage, noteUserId, cityId, status, createTime, username, cityname);
                notes.add(note);
            }
            return notes;
    }

    public boolean checkUserLiked(int userId, int noteId) {
        try {
            String sql = "SELECT * FROM like_record WHERE user_id = " + userId + " AND note_id = " + noteId;
            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);

            if (mapList != null && !mapList.isEmpty()) {
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("检查用户点赞状态时出错: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean addLikeRecord(int userId, int noteId) {
        try {
            String sql = "INSERT INTO like_record (user_id, note_id) VALUES (" + userId + ", " + noteId + ")";
            int result = dbUtils.update(sql);
            return result > 0;
        } catch (Exception e) {
            System.err.println("添加点赞记录时出错: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeLikeRecord(int userId, int noteId) {
        try {
            String sql = "DELETE FROM like_record WHERE user_id = " + userId + " AND note_id = " + noteId;
            int result = dbUtils.update(sql);
            return result > 0;
        } catch (Exception e) {
            System.err.println("删除点赞记录时出错: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Note> getUserLikedNotes(int userId) {

            List<Note> notes = new ArrayList<>();

            String sql1 = "SELECT note_id FROM like_record WHERE user_id = " + userId + " ORDER BY id DESC";
            ArrayList<HashMap<String, Object>> likeRecords = dbUtils.queryForList(sql1);

            for (HashMap<String, Object> record : likeRecords) {
                Integer noteId = Integer.parseInt(record.get("note_id").toString());

                String sql2 = "SELECT n.*, u.username FROM note n " +
                        "LEFT JOIN user u ON n.user_id = u.id " +
                        "WHERE n.id = " + noteId;

                ArrayList<HashMap<String, Object>> noteList = dbUtils.queryForList(sql2);

                if (noteList != null && !noteList.isEmpty()) {
                    HashMap<String, Object> noteMap = noteList.get(0);

                    Integer cityId = noteMap.get("city_id") != null ? Integer.parseInt(noteMap.get("city_id").toString()) : null;
                    String cityname = "未知城市";

                    if (cityId != null) {
                        String sql3 = "SELECT name FROM city WHERE id = " + cityId;
                        ArrayList<HashMap<String, Object>> cityList = dbUtils.queryForList(sql3);
                        if (cityList != null && !cityList.isEmpty()) {
                            cityname = cityList.get(0).get("name").toString();
                        }
                    }

                    Integer id = Integer.parseInt(noteMap.get("id").toString());
                    String title = noteMap.get("title").toString();
                    String content = noteMap.get("content").toString();
                    String summary = noteMap.get("summary") != null ? noteMap.get("summary").toString() : "";
                    String coverImage = noteMap.get("cover_image") != null ? noteMap.get("cover_image").toString() : "";
                    Integer noteUserId = Integer.parseInt(noteMap.get("user_id").toString());
                    String status = noteMap.get("status").toString();
                    String createTime = noteMap.get("create_time").toString();
                    String username = noteMap.get("username") != null ? noteMap.get("username").toString() : "匿名用户";

                    Note note = new Note(id, title, content, summary, coverImage, noteUserId, cityId, status, createTime, cityname, username);
                    notes.add(note);
                }
            }
            return notes;

    }
}