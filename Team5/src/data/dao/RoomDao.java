package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import data.dto.PeakDto;
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
	
	public int updateRoom(RoomDto dto){
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="update room set rname=?,price=?,acception=? where rnum=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getRname());
			pstmt.setString(2, dto.getPrice());
			pstmt.setString(3, dto.getAcception());
			pstmt.setString(4, dto.getRnum());
			
			return pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		return -1;
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

	public Map<Integer,Double> peak(String date){

		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Map<Integer,Double> map=new HashMap<Integer,Double>();
		String sql="select to_char(startday,'DD') s,to_char(endday,'DD') e,peak_rate from peak where TO_CHAR(startday,'YYYY-MM')=?";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,date);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				int end=rs.getInt("e")-1;
				int start=rs.getInt("s");
				if(end-start==0){
					map.put(start, rs.getDouble(3));
				}else {
					for(int i=start;i<=end;i++) {
						map.put(i,rs.getDouble(3));
					}
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return map;
	}
	
	public double getRate() {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select rate from rate";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getDouble(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -1;
	}
	
	public int updateRate(Double rate) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		String sql="update rate set rate=?";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setDouble(1, rate);
			pstmt.execute();
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		return -1;
	}

	public int insertPeak(PeakDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		Timestamp st = Timestamp.valueOf(dto.getStartday()+" 00:00:00");
		Timestamp et = Timestamp.valueOf(dto.getEndday()+" 00:00:00");
		
		String sql="insert into peak values (seq_semi.nextval,?,?,?)";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setTimestamp(1, st);
			pstmt.setTimestamp(2, et);
			pstmt.setDouble(3, dto.getPeak_rate());
			pstmt.execute();
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		return -1;
	}
	
	public void deletePeak(String pnum) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="delete from peak where pnum=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pnum);
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public List<PeakDto> getPeak() {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<PeakDto> list=new ArrayList<PeakDto>();
		
		String sql="select * from peak order by startday desc";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				PeakDto dto=new PeakDto();
				dto.setPnum(rs.getString("pnum"));
				dto.setStartday(rs.getString("startday"));
				dto.setEndday(rs.getString("endday"));
				dto.setPeak_rate(rs.getDouble("peak_rate"));
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
}
