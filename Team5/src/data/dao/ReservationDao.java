package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import data.dto.CanrvDto;
import data.dto.ClientDto;
import data.dto.ReservationDto;
import oracle.db.DbConnect;

public class ReservationDao {
	DbConnect db = new DbConnect();

	public boolean getReservation(String rnum, String date) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from reservation where rnum=? and to_char(startday,'YYYY-MM-DD')=?";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rnum);
			pstmt.setString(2, date);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}

	public int insertReservation(ReservationDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		// id,pass,name,hp,email,권한(0)
		String sql = "insert into reservation values (seq_semi.nextval,?,?,?,?,?,?,?,?,?,?,1)";
		conn = db.getConnection();
		Timestamp st = Timestamp.valueOf(dto.getStartday() + " 15:00:00.0");
		Timestamp et = Timestamp.valueOf(dto.getEndday() + " 12:00:00.0");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setTimestamp(1, st);
			pstmt.setTimestamp(2, et);
			pstmt.setString(3, dto.getPcount());// 인원수
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
		return -1; // db오류
	}

	// reservation cancel
	public int CancelRequest(String resnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update reservation set can=0 where resnum=?";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, resnum);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		return -1; // �삤瑜�
	}

	// get used count
	public List<ReservationDto> getUse(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReservationDto> list = new ArrayList<ReservationDto>();
		String sql = "select * from reservation where id=?";

		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReservationDto dto = new ReservationDto();
				dto.setRnum(rs.getString("rnum"));
				dto.setPrice(rs.getString("price"));
				dto.setAdditional(rs.getString("additional"));
				dto.setStartday(rs.getString("startday"));
				dto.setEndday(rs.getString("endday"));
				dto.setCan(rs.getInt("can"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	// get used count
	public List<ReservationDto> getUse(String id, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReservationDto> list = new ArrayList<ReservationDto>();
		String sql = "select a.* from (select b.*, rownum snum from (select * from reservation where id=? order by startday desc)b)a where a.snum>=? and a.snum<=?";

		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReservationDto dto = new ReservationDto();
				dto.setResnum(rs.getString("resnum"));
				dto.setName(rs.getString("name"));
				dto.setPcount(rs.getString("pcount"));
				dto.setPrice(rs.getString("price"));
				dto.setAdditional(rs.getString("additional"));
				dto.setStartday(rs.getString("startday"));
				dto.setEndday(rs.getString("endday"));
				dto.setRnum(rs.getString("rnum"));
				dto.setCan(rs.getInt("can"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	// usecount
	public int useCount(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		String sql = "select count(*) count from reservation where id=?";

		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt("count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

	public int getMoney(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int money = 0;
		String sql = "select sum(price+additional) from reservation where id=?";

		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				money = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return money;
	}

	public String getRoomName(String rnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select rname from room where rnum=?";

		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rnum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
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

	// get all count
	public int getAllCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from reservation";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -1;
	}

	// get search count
	public int getSearchCount(String startday, String endday) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from reservation where to_char(STARTDAY,'YYYY-MM-dd') between ? and ?";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, startday);
			pstmt.setString(2, endday);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -1;
	}

	// get search count
	public int getRoomCount(String rnum, String startday, String endday) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from reservation where rnum=? and to_char(STARTDAY,'YYYY-MM-dd') between ? and ?";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rnum);
			pstmt.setString(2, startday);
			pstmt.setString(3, endday);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -1;
	}

	// get all info
	public List<ReservationDto> getAllRv(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReservationDto> list = new ArrayList<ReservationDto>();
		String sql = "select * from(select reservation.*,rownum r from reservation) where r>=? and r<=? order by startday desc";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReservationDto dto = new ReservationDto();
				dto.setRnum(rs.getString("rnum"));
				dto.setId(rs.getString("id"));
				dto.setPrice(rs.getString("price"));
				dto.setAdditional(rs.getString("additional"));
				dto.setStartday(rs.getString("startday"));
				dto.setEndday(rs.getString("endday"));
				dto.setName(rs.getString("name"));
				dto.setHp(rs.getString("hp"));
				dto.setPcount(rs.getString("pcount"));
				dto.setResnum(rs.getString("resnum"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	// get search info
	public List<ReservationDto> getSearchRv(String startday, String endday, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReservationDto> list = new ArrayList<ReservationDto>();
		String sql = "select * from(select reservation.*,rownum r from reservation where to_char(STARTDAY,'YYYY-MM-dd') between ? and ?) where r>=? and r<=? order by startday desc";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, startday);
			pstmt.setString(2, endday);
			pstmt.setInt(3, start);
			pstmt.setInt(4, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReservationDto dto = new ReservationDto();
				dto.setRnum(rs.getString("rnum"));
				dto.setId(rs.getString("id"));
				dto.setPrice(rs.getString("price"));
				dto.setAdditional(rs.getString("additional"));
				dto.setStartday(rs.getString("startday"));
				dto.setEndday(rs.getString("endday"));
				dto.setName(rs.getString("name"));
				dto.setHp(rs.getString("hp"));
				dto.setPcount(rs.getString("pcount"));
				dto.setResnum(rs.getString("resnum"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	// get search info
	public List<ReservationDto> getRoomRv(String select, String startday, String endday, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReservationDto> list = new ArrayList<ReservationDto>();
		String sql = "select * from(select reservation.*,rownum r from reservation where rnum=? and to_char(STARTDAY,'YYYY-MM-dd') between ? and ?) where r>=? and r<=? order by startday desc";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, select);
			pstmt.setString(2, startday);
			pstmt.setString(3, endday);
			pstmt.setInt(4, start);
			pstmt.setInt(5, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReservationDto dto = new ReservationDto();
				dto.setRnum(rs.getString("rnum"));
				dto.setId(rs.getString("id"));
				dto.setPrice(rs.getString("price"));
				dto.setAdditional(rs.getString("additional"));
				dto.setStartday(rs.getString("startday"));
				dto.setEndday(rs.getString("endday"));
				dto.setName(rs.getString("name"));
				dto.setHp(rs.getString("hp"));
				dto.setPcount(rs.getString("pcount"));
				dto.setResnum(rs.getString("resnum"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	// get money
	public int getAllPrice() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select sum(price+additional) from reservation";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	// get money
	public int getSearchPrice(String startday, String endday) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select sum(price+additional) from reservation where to_char(STARTDAY,'YYYY-MM-dd') between ? and ?";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, startday);
			pstmt.setString(2, endday);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public int getRoomPrice(String rnum, String startday, String endday) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select sum(price+additional) from reservation where rnum=? and to_char(STARTDAY,'YYYY-MM-dd') between ? and ?";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rnum);
			pstmt.setString(2, startday);
			pstmt.setString(3, endday);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	// get count
	public int getCancelCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from reservation where can=0";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	public List<ReservationDto> getCanRv(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReservationDto> list = new ArrayList<ReservationDto>();
		String sql = "select * from(select reservation.*,rownum r from reservation where can=0) where r>=? and r<=? order by startday desc";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReservationDto dto = new ReservationDto();
				dto.setRnum(rs.getString("rnum"));
				dto.setId(rs.getString("id"));
				dto.setPrice(rs.getString("price"));
				dto.setAdditional(rs.getString("additional"));
				dto.setStartday(rs.getString("startday"));
				dto.setEndday(rs.getString("endday"));
				dto.setName(rs.getString("name"));
				dto.setHp(rs.getString("hp"));
				dto.setPcount(rs.getString("pcount"));
				dto.setResnum(rs.getString("resnum"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public List<CanrvDto> getCancelList(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CanrvDto> list = new ArrayList<CanrvDto>();
		String sql = "select b.* from(select a.*,rownum r from (select canrv.* from canrv order by startday desc)a)b where r>=? and r<=?";
		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CanrvDto dto = new CanrvDto();
				dto.setRnum(rs.getString("rnum"));
				dto.setId(rs.getString("id"));
				dto.setPrice(rs.getString("price"));
				dto.setAdditional(rs.getString("additional"));
				dto.setStartday(rs.getString("startday"));
				dto.setEndday(rs.getString("endday"));
				dto.setName(rs.getString("name"));
				dto.setHp(rs.getString("hp"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	
	// cancel used
	public List<CanrvDto> getCancelUse(String id) {
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs= null;
	      List<CanrvDto> list=new ArrayList<CanrvDto>();
	      String sql="select * from canrv where id=? order by startday desc";
	      
	      conn=db.getConnection();
	      try {
	         pstmt=conn.prepareStatement(sql);
	         pstmt.setString(1, id);
	         rs=pstmt.executeQuery();
	         while(rs.next()) {
	            CanrvDto dto=new CanrvDto();
	            dto.setId(rs.getString("id"));
	            dto.setName(rs.getString("name"));
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
	public int insertCanrv(CanrvDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "insert into canrv values (?,?,?,?,?,?,?,?)";
		conn = db.getConnection();
		Timestamp st = Timestamp.valueOf(dto.getStartday());
		Timestamp et = Timestamp.valueOf(dto.getEndday());
		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getHp());
			pstmt.setString(4, dto.getRnum());
			pstmt.setTimestamp(5, st);
			pstmt.setTimestamp(6, et);
			pstmt.setString(7, dto.getPrice());
			pstmt.setString(8, dto.getAdditional());

			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		return -1;
	}

	public ReservationDto getRv(String resnum) {
		ReservationDto dto = new ReservationDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from reservation where resnum=?";

		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, resnum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setRnum(rs.getString("rnum"));
				dto.setId(rs.getString("id"));
				dto.setPrice(rs.getString("price"));
				dto.setAdditional(rs.getString("additional"));
				dto.setStartday(rs.getString("startday"));
				dto.setEndday(rs.getString("endday"));
				dto.setName(rs.getString("name"));
				dto.setHp(rs.getString("hp"));
				dto.setPcount(rs.getString("pcount"));
				dto.setResnum(rs.getString("resnum"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}

	public int getCanrvCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="select count(*) from canrv";
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -1;
	}
	
	public List<CanrvDto> getCancelUse() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CanrvDto> list = new ArrayList<CanrvDto>();
		String sql = "select * from canrv order by id";

		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CanrvDto dto = new CanrvDto();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
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
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}

	public int deleteRv(String resnum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from reservation where resnum=?";

		conn = db.getConnection();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, resnum);
			return pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		return -1;
	}
}
