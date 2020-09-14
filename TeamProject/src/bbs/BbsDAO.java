package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BbsDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:orcl";
			String dbID = "kosea";
			String dbPassword = "kosea2019a";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "SELECT SYSDATE FROM DUAL";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //�����ͺ��̽� ����
	}
	
	public int getNext() {
		String SQL = "SELECT num FROM bbs_tbl ORDER BY num DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // ù ��° �Խù��� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	public int write(String title, String userID, String content, String content2, String ctg) {
		String SQL = "INSERT INTO bbs_tbl VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, userID);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, 1);
			pstmt.setString(7, content2);
			pstmt.setString(8, ctg);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT * FROM bbs_tbl WHERE num < ? AND bbsPage = 1 ORDER BY num DESC) WHERE ROWNUM <= 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setNum(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setContent(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsPage(rs.getInt(6));
				bbs.setContent2(rs.getString(7));
				bbs.setCtg(rs.getString(8));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT * FROM bbs_tbl WHERE num < ? AND bbsPage = 1 ORDER BY num DESC) WHERE rownum <= 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int num) {
		String SQL = "SELECT * FROM bbs_tbl WHERE num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setNum(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setContent(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsPage(rs.getInt(6));
				bbs.setContent2(rs.getString(7));
				bbs.setCtg(rs.getString(8));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int num, String title,String content, String content2, String ctg) {
		String SQL = "UPDATE bbs_tbl SET title = ?, content = ?, content2 = ?, ctg = ? WHERE num = ?";
		System.out.println(num);
		System.out.println(title);
		System.out.println(content);
		System.out.println(content2);
		System.out.println(ctg);
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, content2);
			pstmt.setString(4, ctg);
			pstmt.setInt(5, num);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int num) {
		String SQL = "UPDATE bbs_tbl SET bbsPage = 0 WHERE num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, num);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	public Bbs getContent(String content) {
		String SQL = "SELECT content FROM bbs_tbl WHERE content = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setContent(rs.getString(1));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Bbs getContent2(String content2) {
		String SQL = "SELECT content2 FROM bbs_tbl WHERE content2 = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setContent2(rs.getString(1));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<Bbs> getListgame(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT * FROM bbs_tbl WHERE ctg = '게임' AND bbsPage = 1 ORDER BY num DESC) WHERE ROWNUM <= 10";
		ArrayList<Bbs> listgame = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/* pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); */
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setNum(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setContent(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsPage(rs.getInt(6));
				bbs.setContent2(rs.getString(7));
				bbs.setCtg(rs.getString(8));
				listgame.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listgame;
	}
	
	public ArrayList<Bbs> getListanimal(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT * FROM bbs_tbl WHERE ctg = '동물' AND bbsPage = 1 ORDER BY num DESC) WHERE ROWNUM <= 10";
		ArrayList<Bbs> listanimal = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/* pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); */
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setNum(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setContent(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsPage(rs.getInt(6));
				bbs.setContent2(rs.getString(7));
				bbs.setCtg(rs.getString(8));
				listanimal.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listanimal;
	}
	
	public ArrayList<Bbs> getListmusic(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT * FROM bbs_tbl WHERE ctg = '음악' AND bbsPage = 1 ORDER BY num DESC) WHERE ROWNUM <= 10";
		ArrayList<Bbs> listmusic = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/* pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); */
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setNum(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setContent(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsPage(rs.getInt(6));
				bbs.setContent2(rs.getString(7));
				bbs.setCtg(rs.getString(8));
				listmusic.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listmusic;
	}
	
	public ArrayList<Bbs> getListmovie(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT * FROM bbs_tbl WHERE ctg = '영화' AND bbsPage = 1 ORDER BY num DESC) WHERE ROWNUM <= 10";
		ArrayList<Bbs> listmovie = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/* pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); */
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setNum(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setContent(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsPage(rs.getInt(6));
				bbs.setContent2(rs.getString(7));
				bbs.setCtg(rs.getString(8));
				listmovie.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listmovie;
	}
	
	public ArrayList<Bbs> getListhorror(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT * FROM bbs_tbl WHERE ctg = '공포' AND bbsPage = 1 ORDER BY num DESC) WHERE ROWNUM <= 10";
		ArrayList<Bbs> listhorror = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			/* pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); */
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setNum(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setContent(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsPage(rs.getInt(6));
				bbs.setContent2(rs.getString(7));
				bbs.setCtg(rs.getString(8));
				listhorror.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listhorror;
	}
	
	public ArrayList<Bbs> getListhumor(int pageNumber) {
		String SQL = "SELECT * FROM (SELECT * FROM bbs_tbl WHERE ctg = '유머' AND bbsPage = 1 ORDER BY num DESC) WHERE ROWNUM <= 10";
		ArrayList<Bbs> listhumor = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setNum(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setContent(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsPage(rs.getInt(6));
				bbs.setContent2(rs.getString(7));
				bbs.setCtg(rs.getString(8));
				listhumor.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listhumor;
	}
	
	
}