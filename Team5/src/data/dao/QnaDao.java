package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import data.dto.QnaDto;
import oracle.db.DbConnect;

public class QnaDao {
	DbConnect db = new DbConnect();
	
	//회원가입 Insert
	public int insertQna(QnaDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		//qnum, subject,content,secret,qwriteday,viewcount,id
		String sql="insert into qna values (seq_semi.nextval,?,?,?,sysdate,0,?)";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getSecret());
			pstmt.setString(4, dto.getId());
	
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}	
		return -1; //db오류
	}
	
	//전체 질문 출력
	public List<QnaDto> getAllQnaList(){
		List<QnaDto> list= new ArrayList<QnaDto>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from client order by qwriteday desc";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				QnaDto dto=new QnaDto();
				dto.setQnum(rs.getString("qnum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("secret"));
				dto.setQwriteday(rs.getTimestamp("qwriteday"));
				dto.setViewcount(rs.getString("viewcount"));
				dto.setId(rs.getString("id"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//내가 쓴 질문 보기
	public List<QnaDto> getClientQnaList(String id){
		List<QnaDto> list= new ArrayList<QnaDto>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from client where id=? order by qwriteday desc";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				QnaDto dto=new QnaDto();
				dto.setQnum(rs.getString("qnum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("secret"));
				dto.setQwriteday(rs.getTimestamp("qwriteday"));
				dto.setViewcount(rs.getString("viewcount"));
				dto.setId(rs.getString("id"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	//질문글 삭제
	public int deleteQna(String qnum,String pass) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select count(*) result from qna q,client c where q.qnum=? and (q.id=c.id) and c.pass=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,qnum);
			pstmt.setString(2,pass);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt("result")==1) {
					//1이면
					sql="delete from qna where qnum=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1,qnum);
					//성공(1)
					return pstmt.executeUpdate();
				}else {
					return 0; //비밀번호 틀림 
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -1;//db오류	
	}

}
