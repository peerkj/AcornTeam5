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
	
	// qna insert
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
		return -1; //db�삤瑜�
	}
	
	//start~end 寃뚯떆湲� 異쒕젰
	public List<QnaDto> getAllQnaList(int start,int end){
		List<QnaDto> list= new ArrayList<QnaDto>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql= "select a.* from (select qna.*, rownum rnum from qna order by qwriteday desc)a where rnum>=? and rnum<=?";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				QnaDto dto=new QnaDto();
				dto.setQnum(rs.getString("qnum"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSecret(rs.getString("secret"));
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
	
	//�궡媛� �벖 吏덈Ц 蹂닿린
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
				dto.setContent(rs.getString("content"));
				dto.setSecret(rs.getString("secret"));
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
	//吏덈Ц湲� �궘�젣
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
					//1�씠硫�
					sql="delete from qna where qnum=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1,qnum);
					//�꽦怨�(1)
					return pstmt.executeUpdate();
				}else {
					return 0; //鍮꾨�踰덊샇 ��由� 
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -1;//db�삤瑜�	
	}
	
	//�쟾泥� 寃뚯떆湲� �닔
	public int getTotalCount() {
		Connection conn = null;
		PreparedStatement pstmt =null;
		ResultSet rs =null;
		String sql="select count(*) count from qna";
		conn=db.getConnection();
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1; //�삤瑜�
	}
	
	//�떟蹂��뿬遺�
	public boolean getAnswer(String qnum) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from answer where qnum=?";
		boolean find=false;
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,qnum);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				find=true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return find;
	}
	
	//num에 해당하는 데이터 dto를 반환하는 메서드
	   public QnaDto getData(String num) {
	      QnaDto dto = new QnaDto();
	      Connection conn=null;
	      PreparedStatement pstmt= null;
	      ResultSet rs = null;
	      String sql="";
	      sql = "select * from qna where qnum=?";
	      conn=db.getConnection();
	      try {
	         pstmt=conn.prepareStatement(sql);
	         pstmt.setString(1, num);
	         rs= pstmt.executeQuery();
	         
	         if(rs.next()) {
	        	 dto.setQnum(rs.getString("qnum"));
	        	 dto.setSubject(rs.getString("subject"));
	        	 dto.setContent(rs.getString("content"));
	        	 dto.setSecret(rs.getString("secret"));
	        	 dto.setQwriteday(rs.getTimestamp("qwriteday"));
	        	 dto.setViewcount(rs.getString("viewcount"));
	        	 dto.setId(rs.getString("id"));
	         }
	      } catch (SQLException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      } finally {
	         db.dbClose(rs, pstmt, conn);
	      }
	      
	      return dto;
	   }
	   
	  //뷰카운트 증가 메서드
	  public void updateViewCount(String num) {
		   Connection conn=null;
		   PreparedStatement pstmt= null;
		   DbConnect db = new DbConnect();
		   String sql = "";
		   sql = "update qna set viewcount=viewcount+1 where qnum=?";
		   conn=db.getConnection();
		   try {
		      pstmt = conn.prepareStatement(sql);
		      pstmt.setString(1, num);
		      pstmt.execute();
		   } catch (SQLException e) {
		      // TODO Auto-generated catch block
		      e.printStackTrace();
		   } finally {
		      db.dbClose(pstmt, conn);
		   }
	}
}
