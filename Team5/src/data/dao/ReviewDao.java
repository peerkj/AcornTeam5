package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.ReviewDto;
import oracle.db.DbConnect;

public class ReviewDao {
   DbConnect db = new DbConnect();
   
   // review insert
   public int insertReview(ReviewDto dto) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      String img="..";
      //revnum, content,rwriteday,star,id,rum,img
      String sql="insert into review values (seq_semi.nextval,?,sysdate,?,?,?,?)";
      conn=db.getConnection();
      try {
         if(dto.getImg()!=null)
            img = dto.getImg();
         
         pstmt=conn.prepareStatement(sql);
         
         pstmt.setString(1, dto.getContent());
         pstmt.setString(2, dto.getStar());
         pstmt.setString(3, dto.getId());
         pstmt.setString(4, dto.getRnum());
         pstmt.setString(5, img);         
         
         return pstmt.executeUpdate();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } finally {
         db.dbClose(pstmt, conn);
      }   
      return -1; //db�삤瑜�
   }
   
   //좋아요 insert
   public int insertjoayo(String id, String revnum) {
      Connection conn=null;
      PreparedStatement pstmt=null;
      String sql="insert into joayo values (?,?,0)";
      conn=db.getConnection();
      try {
         pstmt=conn.prepareStatement(sql);         
         pstmt.setString(1, id);
         pstmt.setString(2, revnum);
   
         return pstmt.executeUpdate();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } finally {
         db.dbClose(pstmt, conn);
      }   
      return -1; //db�삤瑜�
   }
   
   //좋아요 확인
   public int joayocheck(String revnum, String id) {
      Connection conn = null;
      PreparedStatement pstmt =null;
      ResultSet rs =null;
      String sql="select joayocheck from joayo where revnum=? and id=?";
      conn=db.getConnection();
      
      try {
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1, revnum);
         pstmt.setString(2, id);
         rs=pstmt.executeQuery();
         if(rs.next()) {
            return rs.getInt("joayocheck");
         }
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      return -1; //�삤瑜�
   }
   
   //데이터 가져오기
   public List<ReviewDto> getAllReview(int start,int end, String rnum){
      List<ReviewDto> list= new ArrayList<ReviewDto>();
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      String sql= "select a.* from (select review.*, rownum snum from review where rnum=? order by rwriteday desc)a where snum>=? and snum<=?";
      conn=db.getConnection();
      try {
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1, rnum);
         pstmt.setInt(2,start);
         pstmt.setInt(3, end);
         rs=pstmt.executeQuery();
         while(rs.next()) {
            ReviewDto dto=new ReviewDto();
            dto.setRevnum(rs.getString("revnum"));
            dto.setContent(rs.getString("content"));
            dto.setRwriteday(rs.getTimestamp("rwriteday"));
            dto.setStar(rs.getString("star"));
            dto.setId(rs.getString("id"));
            dto.setRnum(rs.getString("rnum"));
            dto.setImg(rs.getString("img"));
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
   
   //해당 아이디가 작성한 리뷰
   public List<ReviewDto> getClientReview(String id){
      List<ReviewDto> list= new ArrayList<ReviewDto>();
      Connection conn=null;
      PreparedStatement pstmt=null;
      ResultSet rs=null;
      String sql="select * from review where id=? order by rwriteday desc";
      conn=db.getConnection();
      try {
         pstmt=conn.prepareStatement(sql);
         rs=pstmt.executeQuery();
         while(rs.next()) {
            ReviewDto dto=new ReviewDto();
            dto.setRevnum(rs.getString("revnum"));
            dto.setContent(rs.getString("content"));
            dto.setRwriteday(rs.getTimestamp("rwriteday"));
            dto.setStar(rs.getString("star"));
            dto.setId(rs.getString("id"));
            dto.setRnum(rs.getString("rnum"));
            dto.setImg(rs.getString("img"));
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
   
   public int getTotalCount(String rnum) {
      Connection conn = null;
      PreparedStatement pstmt =null;
      ResultSet rs =null;
      String sql="select count(*) count from review where rnum=?";
      conn=db.getConnection();
      
      try {
         pstmt=conn.prepareStatement(sql);
         pstmt.setString(1, rnum);
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

   //delete need revnum
      public int deleteReview(String revnum) {
         Connection conn=null;
         PreparedStatement pstmt=null;
         String sql="delete from review where revnum=?";
         
         conn=db.getConnection();
         try {
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,revnum);
            return pstmt.executeUpdate();
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         } finally {
            db.dbClose(pstmt, conn);
         }
         return -1;//db error
      }
      
   //좋아요 증가
   public void updateJoayo(String joayo, String revnum) {
         Connection conn=null;
         PreparedStatement pstmt= null;
         DbConnect db = new DbConnect();
         String sql = "";
         if(joayo.equals("1"))
            sql = "update joayo set joayocheck=1 where revnum=?";
         else
            sql = "update joayo set joayocheck=0 where revnum=?";
         
         conn=db.getConnection();
         try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, revnum);
            pstmt.execute();
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         } finally {
            db.dbClose(pstmt, conn);
         }
   }
   
   //좋아요갯수반환
   public int getJoayo(String revnum) {
         Connection conn=null;
         PreparedStatement pstmt= null;
         DbConnect db = new DbConnect();
         ResultSet rs = null;
         String sql = "select sum(joayocheck) joayosu from joayo where revnum=?";
         int joayosu=0;
         conn=db.getConnection();
         //conn=db.getConnection();
         try {
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, revnum);
            rs=pstmt.executeQuery();
            if(rs.next()) {
               joayosu= rs.getInt("joayosu");
            }
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         } finally {
            db.dbClose(rs, pstmt, conn);
         }
         
         return joayosu;
      }
   
}