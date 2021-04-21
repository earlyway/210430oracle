package common;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class db {
	public static Connection getConn() {
		DataSource ds = null;
		Connection conn = null;
		try {
			Context context = new InitialContext();// context.xml을 분석하는 객체
			// context.xml의 resource태그의 name
			ds = (DataSource) context.lookup("java:comp/env/oraDB");
			conn = ds.getConnection();// 커넥션을 받아서
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;// 커넥션을 리턴
	}

}
