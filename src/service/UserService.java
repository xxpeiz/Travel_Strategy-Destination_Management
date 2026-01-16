package com.service;

import com.model.City;
import com.model.User;
import com.tools.DbUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class UserService {

    private DbUtils dbUtils = new DbUtils();

    public User queryUserByName(String username){
        String sql = "select * from user where username = '"+username+"'";
        ArrayList<HashMap<String, Object>> list = dbUtils.queryForList(sql);

        if (list.isEmpty()){
            return new User();
        }
        Integer id = Integer.parseInt(list.get(0).get("id").toString());
        String username1 = list.get(0).get("username").toString();
        String password = list.get(0).get("password").toString();
        String role = list.get(0).get("role").toString();

        return new User(id, username1, password, role);
    }

    public User login(String username, String password){
        User user = queryUserByName(username);
        if (user.getId() == null || !user.getPassword().equals(password)) {
            return null;
        }
        return user;
    }


    public boolean updateUser(int userId, String username, String password) {
            StringBuilder sql = new StringBuilder("UPDATE user SET ");
            List<String> updates = new ArrayList<>();

            if (username != null && !username.trim().isEmpty()) {
                updates.add("username = '" + username + "'");
            }

            if (password != null && !password.trim().isEmpty()) {
                updates.add("password = '" + password + "'");
            }

            if (updates.isEmpty()) {
                return false;
            }

            sql.append(String.join(", ", updates));
            sql.append(" WHERE id = ").append(userId);

            int result = dbUtils.update(sql.toString());
            return result > 0;
    }

    public User getUserById(int userId) {
            String sql = "SELECT * FROM user WHERE id = " + userId;
            ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);

            if (mapList != null && !mapList.isEmpty()) {
                HashMap<String, Object> map = mapList.get(0);
                Integer id = Integer.parseInt(map.get("id").toString());
                String username = map.get("username").toString();
                String password = map.get("password").toString();
                String role = map.get("role").toString();

                return new User(id, username, password,role);
            }
            return null;

    }

    public boolean deleteUser(int userId){
        String sql="delete from user where id='"+userId+"'";
        int result = dbUtils.update(sql);
        return result > 0;
    }

    public List<User> getAllUsers() {
        String sql = "SELECT * FROM user where role='用户'";
        ArrayList<HashMap<String, Object>> mapList = dbUtils.queryForList(sql);
        List<User> users = new ArrayList<>();
        for (HashMap<String, Object> map : mapList) {
            Integer id = Integer.parseInt(map.get("id").toString());
            String username = map.get("username").toString();
            String password = map.get("password").toString();
            String role = map.get("role").toString();

            users.add(new User(id, username, password,role));
        }
        return users;
    }

    public boolean adminUpdateUser(int userId, String username, String password) {
        StringBuilder sql = new StringBuilder("UPDATE user SET ");
        List<String> updates = new ArrayList<>();

        if (username != null && !username.trim().isEmpty()) {
            updates.add("username = '" + username + "'");
        }

        if (password != null && !password.trim().isEmpty()) {
            updates.add("password = '" + password + "'");
        }

        if (updates.isEmpty()) {
            return false;
        }

        sql.append(String.join(", ", updates));
        sql.append(" WHERE id = ").append(userId);

        int result = dbUtils.update(sql.toString());
        return result > 0;
    }
}
