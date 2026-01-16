package com.tools;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class DbUtils {
	
	
	private static Connection conn = null;
	private static Statement stmt = null;
	private static PreparedStatement pstmt = null;
	private static ResultSet rs = null;

	private static String url = "jdbc:mysql://localhost:3308/travelweb";
	private static String user = "root";
	private static String password = "mysql";
	private static String driver = "com.mysql.jdbc.Driver";

	static {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("连接成功!");
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException e){
			e.printStackTrace();
		}
	}

	public  int update(String sql) {
		int rows = 0;
		try {
			stmt = conn.createStatement();
			rows = stmt.executeUpdate(sql);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return rows;
	}

	public ResultSet query(String sql) {
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return rs;
		
	}

	public int preUpdate(String sql,Object...obj) {
		int rows = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			for(int i = 0;i<obj.length;i++) {
				pstmt.setObject(i+1, obj[i]);
			}
			rows = pstmt.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return rows;
	}

	public ResultSet preQuery(String sql,Object...obj) {
		try {
			pstmt = conn.prepareStatement(sql);
			for(int i = 0;i<obj.length;i++) {
				pstmt.setObject(i+1, obj[i]);
			}
			rs = pstmt.executeQuery();
		}catch(SQLException e){
			e.printStackTrace();
		}
		return rs;
	}

	public ArrayList<HashMap<String,Object>> queryForList(String sql){
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData rsmd = rs.getMetaData();
			while(rs.next()) {
				HashMap<String,Object> map = new HashMap<String,Object>();
				for(int i = 1;i<=rsmd.getColumnCount(); i++) {
					String columnName =rsmd.getColumnName(i);
					Object columnValue = rs.getObject(columnName);
					map.put(columnName, columnValue);
				}
				
				list.add(map);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return list;
	}
	
	public void close() {
		
		if(rs!=null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(stmt!=null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(pstmt!=null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(conn!=null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
