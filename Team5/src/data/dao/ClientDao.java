package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import data.dto.ClientDto;
import oracle.db.DbConnect;

public class ClientDao {
	DbConnect db = new DbConnect();
	
	//아이디로 이름 얻어오기
	public String getName(String id) {
		String name="";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select name from client where id=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				name=rs.getString("name");
				return name;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return null; //X
	}
	//회원가입 Insert
	public int insertClient(ClientDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		//id,pass,name,hp,email,권한(0)
		String sql="insert into client values (?,?,?,?,?,0)";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getHp());
			pstmt.setString(5, dto.getEmail());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}	
		return -1; //db오류
	}
	
	//
	public int login(String id,String pass) {
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select pass from client where id=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("pass").equals(pass)) {
					return 1;//일치
				}else {
					return 0;//비밀번호 불일치		
				}
			}
			return -1;//아이디가 없음
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return -2;//db오류
	}
	
	public List<ClientDto> getAllClientList(){
		List<ClientDto> list= new ArrayList<ClientDto>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from client order by id";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ClientDto dto=new ClientDto();
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setHp(rs.getString("hp"));
				dto.setEmail(rs.getString("email"));
				dto.setManager(rs.getString("manager"));
				
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
	//아이디 입력하면 회원정보 출력
	public ClientDto getClientData(String id) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select * from client where id=?";
		ClientDto dto=new ClientDto();
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setHp(rs.getString("hp"));
				dto.setEmail(rs.getString("email"));
				dto.setManager(rs.getString("manager"));	
				
				return dto;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return null;//db오류 or 아이디 없음	
	}
	//삭제
	public int deleteClient(String id,String pass) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql="select count(*) result from client where id=? and pass=?";
		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt("result")==1) {
					//1이면
					sql="delete from client where id=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, id);
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
	//회원정보 수정(hp,email)
	public int updateClient(ClientDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="update client set hp=?,email=? where id=?";		
		conn=db.getConnection();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getHp());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getId());
			
			return pstmt.executeUpdate(); 

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		return -1; //오류
	}
	
	 public int isEqualId(String id)
     {
        int find=0;
        Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;
        String sql = "select count(*) from client where id=?"; 
       
        conn=db.getConnection();
        try {
           pstmt=conn.prepareStatement(sql);
           //바인딩
           pstmt.setString(1, id);
           //실행
           rs=pstmt.executeQuery();
           //조건
           if(rs.next()) {
              int n=rs.getInt(1);//해당 아이디가 있으면 1 없으면 0
              if(n==1)//있을경우 1로 변경 (초기값은 0)\
                 find=1;
           }
        } catch (SQLException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
        }finally {
           db.dbClose(rs, pstmt, conn);
        }
        return find;
     }
	 
}
