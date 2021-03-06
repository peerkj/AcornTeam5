package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import data.dto.AnswerDto;
import oracle.db.DbConnect;

public class AnswerDao {
	DbConnect db=new DbConnect();
	
	//insert needs content,qnum
	public int insertAnswer(AnswerDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		//anum, content, writeday, qnum
		String sql="insert into answer values (seq_semi.nextval,?,sysdate,?)";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getQnum());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}	
		return -1; 
	}
	//delete need qnum
	public int deleteAnswer(String qnum) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="delete from answer where qnum=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,qnum);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		return -1;//db error
	}
	public AnswerDto getAnswer(String qnum) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from answer where qnum=?";
		AnswerDto dto =new AnswerDto();
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, qnum);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto.setAnum(rs.getString("anum"));
				dto.setContent(rs.getString("content"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setQnum(rs.getString("qnum"));
				
				return dto;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return null;
	}
}
