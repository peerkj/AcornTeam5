package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import data.dto.ClientDto;
import data.dto.ReservationDto;
import oracle.db.DbConnect;

public class ReservationDao {
	DbConnect db=new DbConnect();
	
	public boolean getReservation(String rnum,String date) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from reservation where rnum=? and to_char(startday,'YYYY-MM-DD')=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, rnum);
			pstmt.setString(2, date);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}
	
	public int insertReservation(ReservationDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		//id,pass,name,hp,email,권한(0)
		String sql="insert into reservation values (seq_semi.nextval,?,?,?,?,?,?,?,?,?,?)";
		conn=db.getConnection();
		Timestamp st= Timestamp.valueOf(dto.getStartday()+" 15:00:00.0");
		Timestamp et= Timestamp.valueOf(dto.getEndday()+" 12:00:00.0");
		try {
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setTimestamp(1,st);
			pstmt.setTimestamp(2,et);
			pstmt.setString(3, dto.getPcount());//인원수
			pstmt.setString(4, dto.getId());
			pstmt.setString(5, dto.getRnum());
			pstmt.setString(6, dto.getName());
			pstmt.setString(7, dto.getHp());
			pstmt.setString(8, dto.getEmail());
			pstmt.setString(9, dto.getPrice());
			pstmt.setString(10, dto.getAdditional());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}	
		return -1; //db오류
	}
	
	//get used count
	public List<ReservationDto> getUse(String id) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		List<ReservationDto> list=new ArrayList<ReservationDto>();
		String sql="select * from reservation where id=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ReservationDto dto=new ReservationDto();
				dto.setRnum(rs.getString("rnum"));
				dto.setPrice(rs.getString("price"));
				dto.setAdditional(rs.getString("additional"));
				dto.setStartday(rs.getString("startday"));
			    dto.setEndday(rs.getString("endday"));  
			    list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	public int getMoney(String id) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs= null;
		int money=0;
		String sql="select sum(price+additional) from reservation where id=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				money=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return money;
	}
	
	public String getRoomName(String rnum) {
	      Connection conn=null;
	        PreparedStatement pstmt=null;
	        ResultSet rs=null;
	        String sql="select rname from room where rnum=?";
	        
	        conn=db.getConnection();
	        try {
	           pstmt=conn.prepareStatement(sql);
	           pstmt.setString(1, rnum);
	           rs=pstmt.executeQuery();
	           if(rs.next()) {
	              return rs.getString("rname");
	           }
	        } catch (SQLException e) {
	           // TODO Auto-generated catch block
	           e.printStackTrace();
	        } finally {
	           db.dbClose(rs, pstmt, conn);
	        }
	        return "0";
	   }
}
