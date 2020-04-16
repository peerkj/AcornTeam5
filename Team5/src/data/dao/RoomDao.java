package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import data.dto.RoomDto;
import oracle.db.DbConnect;

public class RoomDao {
	DbConnect db=new DbConnect();
	
	public List<RoomDto> getAllRoom(){
		List<RoomDto> list= new ArrayList<RoomDto>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from room order by rnum";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				RoomDto dto= new RoomDto();
				dto.setRnum(rs.getString("rnum"));
				dto.setRname(rs.getString("rname"));
				dto.setPrice(rs.getString("price"));
				dto.setAcception(rs.getString("acception"));
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
	//rnum 얻어오는 메서드
	public List<String> getAllRnum(){
		List<String>list=new ArrayList<String>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select rnum from room order by rnum";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				list.add(rs.getString(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	//qnum에 해당하는 정보 얻기
	public RoomDto getRoom(String rnum){
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from room where rnum=?";
		RoomDto dto= new RoomDto();
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, rnum);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto.setRnum(rs.getString("rnum"));
				dto.setRname(rs.getString("rname"));
				dto.setPrice(rs.getString("price"));
				dto.setAcception(rs.getString("acception"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
	public Set<Integer> check(String rnum,String date){

		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Set<Integer> set=new HashSet<Integer>();
		String sql="select to_char(startday,'DD') s,to_char(endday,'DD') e from reservation where rnum=? and TO_CHAR(startday,'YYYY-MM')=?";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,rnum);
			pstmt.setString(2,date);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				int end=rs.getInt("e")-1;
				int start=rs.getInt("s");
				if(end-start==0){
					set.add(start);
				}else {
					for(int i=start;i<=end;i++) {
						set.add(i);
					}
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return set;
	}

}
